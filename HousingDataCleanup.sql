	SELECT *
	FROM PortfolioProject..NashvilleHousing


	-- Converting SaleDate to standard date format 
	SELECT CONVERT(Date, SaleDate)
	FROM PortfolioProject..NashvilleHousing

	ALTER TABLE NashvilleHousing
	ADD SaleDateChanged Date;

	UPDATE NashvilleHousing
	SET SaleDateChanged = CONVERT(Date, SaleDate)

	-- Checking for null values in PropertyAddress column
	SELECT *
	FROM PortfolioProject..NashvilleHousing
	WHERE PropertyAddress IS NULL
	ORDER BY ParcelID

	-- Populating empty PropertyAddress rows with addresses sharing the same ParcelID
	SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM PortfolioProject..NashvilleHousing AS a
	JOIN PortfolioProject..NashvilleHousing AS b
	on a.ParcelID = b.ParcelId
	AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL 

	UPDATE a
	SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM PortfolioProject..NashvilleHousing AS a
	JOIN PortfolioProject..NashvilleHousing AS b
	on a.ParcelID = b.ParcelId
	AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL 

	-- Splitting PropertyAddress into Address and City columns

	SELECT PropertyAddress 
	FROM PortfolioProject..NashvilleHousing

	SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ),
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))
	FROM PortfolioProject..NashVilleHousing

	ALTER TABLE NashvilleHousing
	ADD StreetAddress nvarchar(255);

	UPDATE NashvilleHousing
	SET StreetAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

	ALTER TABLE NashvilleHousing
	ADD City nvarchar(255);

	UPDATE NashvilleHousing
	SET Address = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

	-- Splitting OwnerAddress into StreetAddress, City, State with PARSENAME 

	SELECT	PARSENAME(REPLACE(OwnerAddress, ',','.'),3),
			PARSENAME(REPLACE(OwnerAddress, ',','.'),2),
			PARSENAME(REPLACE(OwnerAddress, ',','.'),1)
	FROM PortfolioProject..NashvilleHousing
	WHERE OwnerAddress IS NOT NULL 

	ALTER TABLE NashvilleHousing
	ADD OwnerStreetAddress nvarchar(255);

	UPDATE NashvilleHousing
	SET OwnerStreetAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3)

	ALTER TABLE NashvilleHousing
	ADD OwnerCity nvarchar(255);

	UPDATE NashvilleHousing
	SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',','.'),2)

	ALTER TABLE NashvilleHousing
	ADD OwnerState nvarchar(255);

	UPDATE NashvilleHousing
	SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',','.'),1)

	-- Changing all Y and N values in SoldAsVacant to Yes and No 

	SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
	FROM PortfolioProject..NashvilleHousing
	GROUP BY SoldAsVacant 
	ORDER BY 2

	SELECT SoldAsVacant, 
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END 
	FROM PortfolioProject..NashvilleHousing

	UPDATE NashvilleHousing
	SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END 


	-- Removing duplicates 
	
	WITH RowNumCTE AS ( 
	SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY UniqueID
					) AS row_num
	FROM PortfolioProject..NashvilleHousing
	)
	DELETE
	FROM RowNumCTE
	WHERE row_num > 1

	-- Delete unwanted columns 

	SELECT *
	FROM PortfolioProject..NashvilleHousing
	
	ALTER TABLE PortfolioProject..NashvilleHousing
	DROP COLUMN PropertyAddress, OwnerAddress, SaleDate, Address


