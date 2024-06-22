Return-Path: <linux-wireless+bounces-9449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47507913123
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75971F222E6
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E0A5F;
	Sat, 22 Jun 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="dh+pZiJO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752027E2;
	Sat, 22 Jun 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719015763; cv=none; b=O4NbfSWG0fpnmu+QGnw9T5roos3YJEUULCYOLXAlfd3FOlMLe7j9GKH6cQRW07ukt0zzZCyTqOd4w4VWu4DHepdbWdPrXyG7JJBoeaQdWPc0uD4pJ6IDfQRjc5fl8rxye6TmdqgEhhtlyp9yEA5MV3ndHLFTNC+Fah2M+C7Vi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719015763; c=relaxed/simple;
	bh=En/fn5XzRu8qqC+N8HlyBSRi6I96WhnRYtmMy55Q0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6faQhxoUxwZnTctjM7aLON42s9NVnngkeAzxAjwmaITR5YQocHjjxPvosAUVGtzjSiE78QrVCV5FVqM7LhOJOVlIRKvUlKk3zG0oO/FLvDShCNUkxAlorDmPi6fqMNLNa/9yErtLpnioz5sgWUcUnmHkbeJrvL1ejjgTkxGJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=dh+pZiJO; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1719015750; bh=En/fn5XzRu8qqC+N8HlyBSRi6I96WhnRYtmMy55Q0T4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=dh+pZiJO6J7C8WZbaASR9rKURRAU4kMsRx64Pqih9eBS3je8rfX9h5xQpntWM83l8
	 vSt8w9EDKNDaTotaldRde6toHwH0uhmJ6Jw/VcmX1EuNHQ/ZNYrMGXPqYx6/CZo62P
	 HQTynxBU87v7Rb3vOj+hBnFmQU2KaSQow7lj1bTU=
Date: Sat, 22 Jun 2024 02:22:29 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, duoming@zju.edu.cn, 
	bhelgaas@google.com, minipli@grsecurity.net, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, nick@khadas.com, 
	efectn@protonmail.com, jagan@edgeble.ai, dsimic@manjaro.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] net: wireless: brcmfmac: Add support for AP6275P
Message-ID: <fro2xcwsnvbxmpszny6g2p36z4zwoq4kegmpvww4twxir5piez@a3c2nbwitmab>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jacobe Zang <jacobe.zang@wesion.com>, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai, dsimic@manjaro.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-4-jacobe.zang@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620020015.4021696-4-jacobe.zang@wesion.com>

On Thu, Jun 20, 2024 at 10:00:15AM GMT, Jacobe Zang wrote:
> This module features BCM43752A2 chipset. The firmware requires
> randomness seeding, so enabled it.

Any reason to strip info about origin of the patch, my SoB and
present this work as your own?

Original patch here https://megous.com/git/linux/commit/?h=ap6275p-6.10&id=1a99573bc8ed412e60e1969c0b29d53a0e5782e0

regards,
	o.

> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 5 ++++-
>  .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index f241e1757d7e3..add317731126c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>  BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>  BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
>  BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>  
>  /* firmware config files */
>  MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -105,6 +106,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>  	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>  	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>  	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>  	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
>  	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
>  	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
> @@ -1721,7 +1723,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>  		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
>  		brcmf_fw_nvram_free(nvram);
>  
> -		if (devinfo->otp.valid) {
> +		if (devinfo->otp.valid || devinfo->ci->chip == BRCM_CC_43752_CHIP_ID) {
>  			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
>  			struct brcmf_random_seed_footer footer = {
>  				.length = cpu_to_le32(rand_len),
> @@ -2710,6 +2712,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 44684bf1b9acc..c1e22c589d85e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -52,6 +52,7 @@
>  #define BRCM_CC_43664_CHIP_ID		43664
>  #define BRCM_CC_43666_CHIP_ID		43666
>  #define BRCM_CC_4371_CHIP_ID		0x4371
> +#define BRCM_CC_43752_CHIP_ID		43752
>  #define BRCM_CC_4377_CHIP_ID		0x4377
>  #define BRCM_CC_4378_CHIP_ID		0x4378
>  #define BRCM_CC_4387_CHIP_ID		0x4387
> @@ -94,6 +95,7 @@
>  #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>  #define BRCM_PCIE_4371_DEVICE_ID	0x440d
>  #define BRCM_PCIE_43596_DEVICE_ID	0x4415
> +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
>  #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>  #define BRCM_PCIE_4378_DEVICE_ID	0x4425
>  #define BRCM_PCIE_4387_DEVICE_ID	0x4433
> -- 
> 2.34.1
> 

