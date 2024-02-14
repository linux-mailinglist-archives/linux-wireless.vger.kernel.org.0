Return-Path: <linux-wireless+bounces-3587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E1854B35
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32807B213F5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 14:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFD1524CA;
	Wed, 14 Feb 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="sHSn/v46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A845C15
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920249; cv=none; b=cYToW+tbyQH+Ca1MmOSiOWscbJG4h7j2zHrdAXDkn6BEKcUandYMgIKK9a7nSquYV+B/rKUQD3gn1AkazpHmatp6oIT9ark5I6wQSGv6V/sdhONq6eGJiMi73nZgn9tU18grx851lTc5xKigWQjCqdYTRGZ2vdunTqkNl1cOKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920249; c=relaxed/simple;
	bh=kKI5nDHznsvepT7WX3hKw0v1bt52p6U4Vm34fGClZtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJxpIOnJ5LTkQQYQAKEG7x28V+eQassEjVJxwndtObZ6e9CQ50mTSQqFj746HsG6dNO/HRFjr0EDYKOrqkE1dJYQWVxFC7hLxXbK7c0oHpoBQZ54KC7zUrJGNRn5DaiNldZFCE5ScN964TG5kDIr4JFTef1sIKWe8xcqqzwn6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=sHSn/v46; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1707920239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUsO+IzRJ5+2bOn6TgFrFIgxHQIR2wb0vuBdLhpxUdI=;
	b=sHSn/v46EYiEniftvRMf+ygjBfZUDonOOnp8yXl2pR0fghGLjRYP5BKSucLu16jkYFSeSy
	7EInFSYSV7TntobV6/Eunz9vLjVR5aejY/+Q1B3FTSQI8lpx33h4lfmIbbZ8+zPSxBnQiC
	p1g1jLJve1KtG6vfY7MuSj/RXL1NUas=
From: Sven Eckelmann <sven@narfation.org>
To: ath12k@lists.infradead.org, Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
 Ganesh Babu Jothiram <quic_gjothira@quicinc.com>,
 Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject:
 Re: [PATCH v3 12/13] wifi: ath12k: Read board id to support split-PHY QCN9274
Date: Wed, 14 Feb 2024 15:17:11 +0100
Message-ID: <23399810.6Emhk5qWAg@ripper>
In-Reply-To: <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
References:
 <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2595327.Lt9SDvczpP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2595327.Lt9SDvczpP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Feb 2024 15:17:11 +0100
Message-ID: <23399810.6Emhk5qWAg@ripper>
In-Reply-To: <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0

On Monday, 29 January 2024 07:57:23 CET Raj Kumar Bhagat wrote:
> diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
> index fbcf40c97792..5be4b2d4a19d 100644
> --- a/drivers/net/wireless/ath/ath12k/fw.c
> +++ b/drivers/net/wireless/ath/ath12k/fw.c
> @@ -119,6 +119,13 @@ static int ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
[...]
> +		case ATH12K_FW_IE_AMSS_DUALMAC_IMAGE:
> +			ath12k_dbg(ab, ATH12K_DBG_BOOT,
> +				   "found dualmac fw image ie (%zd B)\n",
> +				   ie_len);
> +			ab->fw.amss_dualmac_data = data;
> +			ab->fw.amss_dualmac_len = ie_len;
> +			break;
>  		default:
>  			ath12k_warn(ab, "Unknown FW IE: %u\n", ie_id);
>  			break;

> @@ -371,16 +375,43 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
[...]
> +	if (dualmac) {
> +		if (ab->fw.amss_dualmac_data && ab->fw.amss_dualmac_len > 0) {
> +			/* use MHI firmware file from firmware-N.bin */
> +			mhi_ctrl->fw_data = ab->fw.amss_dualmac_data;
> +			mhi_ctrl->fw_sz = ab->fw.amss_dualmac_len;
> +		} else {
> +			ath12k_warn(ab, "dualmac firmware IE not present in firmware-N.bin\n");
> +			ret = -ENOENT;
> +			goto free_controller;
> +		}

I saw this now already multiple times that the source code was referencing the 
firmware-N.bin (like we had with ath10k). But they aren't published anywhere. 
I can't find a single one at:

* https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k
* https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath12k
* https://github.com/kvalo/ath11k-firmware
* https://github.com/quic/upstream-wifi-fw

So I find it odd that the new code now seems to depend on it without actually 
providing these files anywhere.

Might be good to have these soon in linux-firmware.git.

Kind regards,
	Sven
--nextPart2595327.Lt9SDvczpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXMy2gACgkQXYcKB8Em
e0b/fBAApivgxL1eB/xBoiFI5KRag3uRnne7oFJYEr/cWtmYKmTkQtGRMjymqbJY
qH24K2itQRxTbZtuJmz0YMAKT1wGleuy4bKDVtDrprDsDesvuaFV81tt6fBllIbb
9Kk0JlbVTcV9rvjciEHO6mvjuajTgh6dmXS1XgYwOER3wZijLOf+GEon7XmDUOaz
tdAS6dtmVPo+uXsKNpEAImV91n45aTF01xY3pXOGEWWVIKPqi5eJgIG4w8zLJa1b
Jao/ACKGRKGSxHKrJJWQ3YTim62eK595PLyj949U725oxClqg4N96uY3qElyNk1q
iYrUtcsvOwMHSMVVRXQunznD3isXNprC7M0mX45spmUGXTAmxLP2y6CCiSQXEyXo
wjczNbhHoFZlSKLi8/hY0zvFwn3Ep+0oegKNBhjZMgUj8yiwHvIKeGkR667c4PEb
lUJ4FZA08gDHEp0r4li0LXcf7Sz1qa4QIo+brX+UVFXU67aMoI/wPY153gteQLmf
xx8AHegi9P+SavuZ3Dc321/icQQdFugjF7L2msvRHmqaFvBSYFfqpxVxhbXz5kPX
OcbT9TuT2Ne0GZcISxBp7uqYaW67dwY/EYwgmhfIgiJ6RXNgW935ROiBiHsu86ZD
jo3JB5cxvSe0XL0XGhVOs8WZPkBMYlqusS9ZfwQEnZGxjqjTK+E=
=Ic38
-----END PGP SIGNATURE-----

--nextPart2595327.Lt9SDvczpP--




