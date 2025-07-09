Return-Path: <linux-wireless+bounces-25105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551CAFF073
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DEE1893D56
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FB233735;
	Wed,  9 Jul 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="JyhvfKvj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013F22D9E3
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084420; cv=none; b=tQG6TTUiqqHxfNW1MlcuAM/DWm5qrJPctnA3hhGqnIe5H6u6J1eZm+umhSmBzQp6qH2D4yRRsrIOQLCevFD+7aStFLDHae3qlQ7sH0QCu8R+PfReyukC9IzTDYV4tmGXZNl+8T8NHGl6hAStdwL54JrSyhGReCO3pOrNHA/emVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084420; c=relaxed/simple;
	bh=Y65IPzrTjU0AqnvI0CNIqhEC3xB9i/ubsdg2rBLOo7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YckXqO409V1H0NMu/4l6dc7i5IdnsDqCAAWRyXfiMb6dhLWhT6PlH5sL+u5N82nFi65fWFpxR9x2XuN8g+ws01lY1ayYuqfJ/N2QfvioSBL7OUXHzLb9ULbFUF4aOxQtpDRVK/cI7dpYf0T6V8nUkI1UZwsboYWJTC6WmGMlQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=JyhvfKvj; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1752084417; x=1783620417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y65IPzrTjU0AqnvI0CNIqhEC3xB9i/ubsdg2rBLOo7c=;
  b=JyhvfKvjSVcY7ShROKFS3ETCKyVJWDcxpohoAd9TZ5X7jYlRIn2bDfLL
   XljT71cJ0sRCFr/CRBzknmLrtmi474sVDxdJgnRE49LkUtrMud2aYzwNN
   L7KL9tZXoNcTT0TOnf35O6h9iU6fmvODwoIbtG6IkctCwrtgZQR9jr1tq
   U=;
X-CSE-ConnectionGUID: ifJ5MLjKT7qasCL7s+slPw==
X-CSE-MsgGUID: JH/x/pu2Qj24WenTpUfY5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="57243977"
X-IronPort-AV: E=Sophos;i="6.16,298,1744063200"; 
   d="scan'208";a="57243977"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:06:49 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 20:06:48 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 20:06:46 +0200
Date: Wed, 9 Jul 2025 23:36:30 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Fabio Estevam <festevam@gmail.com>
CC: <kvalo@kernel.org>, <arend.vanspriel@broadcom.com>,
	<linux-wireless@vger.kernel.org>, <mgonzalez@freebox.fr>, Johannes Berg
	<johannes@sipsolutions.net>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: Re: [PATCH] wifi: brcmfmac: Add support for the SDIO 43751 device
Message-ID: <aG6vptRgLtUeRz7n@ISCN5CG14747PP.infineon.com>
References: <20250702040228.2452348-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702040228.2452348-1-festevam@gmail.com>
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

On 07/02, Fabio Estevam wrote:
> Add the SDIO ID and firmware matching for the SDIO 43751 device.
> 
> Based on the previous work from Marc Gonzalez <mgonzalez@freebox.fr>.
> 
> Tested on an i.MX6DL board connected to an AP6398SV chip with the
> brcmfmac43752-sdio.bin firmware taken from:
> 
> https://source.puri.sm/Librem5/firmware-brcm43752-nonfree
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     | 1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 2 ++
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       | 3 +++
>  drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>  include/linux/mmc/sdio_ids.h                                  | 1 +
>  5 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 6bc107476a2a..982b560a516a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -998,6 +998,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
>  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
>  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
> +	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751, CYW),

Infineon/Cypress is not the vendor for this 43751 chip and so has not released
any firmware binary for it. Kindly fix the firmware vendor ID here, as it is not
appropriate to introduce this WLAN chip with firmware vendor ID as "CYW".

We would suggest you to find who is the actual vendor for this WLAN chip and use
the respective firmware vendor ID here.

>  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),

Also we are not the vendor for the other chip 43752 which is already listed here
with CYW firmware vendor ID. We will send a patch to remove 43752 from the list of
Infineon/Cypress supported WLAN chips.

>  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
>  	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 2ef92ef25517..f0f39fb68f82 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -738,6 +738,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
>  	case BRCM_CC_4364_CHIP_ID:
>  	case CY_CC_4373_CHIP_ID:
>  		return 0x160000;
> +	case CY_CC_43751_CHIP_ID:
>  	case CY_CC_43752_CHIP_ID:
>  	case BRCM_CC_4377_CHIP_ID:
>  		return 0x170000;
> @@ -1450,6 +1451,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
>  		reg = chip->ops->read32(chip->ctx, addr);
>  		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
>  	case BRCM_CC_4359_CHIP_ID:
> +	case CY_CC_43751_CHIP_ID:
c>  	case CY_CC_43752_CHIP_ID:
>  	case CY_CC_43012_CHIP_ID:
>  		addr = CORE_CC_REG(pmu->base, retention_ctl);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index cf26ab15ee0c..49b8b4ce0c6c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -657,6 +657,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>  	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
>  	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
>  	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
> +	BRCMF_FW_ENTRY(CY_CC_43751_CHIP_ID, 0xFFFFFFFF, 43752),
>  	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
>  };
>  
> @@ -3425,6 +3426,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
>  static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
>  {
>  	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
> +	    bus->ci->chip == CY_CC_43751_CHIP_ID ||
>  	    bus->ci->chip == CY_CC_43752_CHIP_ID)
>  		return true;
>  	else
> @@ -4276,6 +4278,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
>  
>  		switch (sdiod->func1->device) {
>  		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
> +		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751:
>  		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
>  			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
>  				  CY_4373_F2_WATERMARK);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index c1e22c589d85..8975db60ac23 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -59,6 +59,7 @@
>  #define CY_CC_4373_CHIP_ID		0x4373
>  #define CY_CC_43012_CHIP_ID		43012
>  #define CY_CC_43439_CHIP_ID		43439
> +#define CY_CC_43751_CHIP_ID		43751
>  #define CY_CC_43752_CHIP_ID		43752
>  
>  /* USB Device IDs */
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7cddfdac2f57..bc94e373566b 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -76,6 +76,7 @@
>  #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
>  #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
>  #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
> +#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751	0xaae7
>  #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
>  
>  #define SDIO_VENDOR_ID_CYPRESS			0x04b4
> -- 
> 2.34.1

