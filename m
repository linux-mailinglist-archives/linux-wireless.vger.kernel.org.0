Return-Path: <linux-wireless+bounces-1810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BF82BEED
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93612B23E06
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC816166C;
	Fri, 12 Jan 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=warmcat.com header.i=@warmcat.com header.b="kx05ZW2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209E60ED4
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=warmcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=warmcat.com
Received: from mx.warmcat.com (host31-53-12-158.range31-53.btcentralplus.com [31.53.12.158])
	by mog.warmcat.com (Postfix) with ESMTPSA id E2239135628;
	Fri, 12 Jan 2024 11:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com E2239135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
	s=default; t=1705057344;
	bh=JuQ1sSvh7OG6lC6nIrovbQg0SIslU1ACh18diXHdyhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kx05ZW2hQXo5I99MwoEUtaI02liWv0GmYsE0fh3zFpyMzNbAicuuG29ayXD4xm7MS
	 e4UfHmsKRkiDMwMQSGj49DtFxktWy8AjODsQMZ00ir8yY04gwSu3XGzdL7Lj0uTd1p
	 GnbcZmkkeqhgfxuYJjndZ1cU57uH3ZwQVqNiH07M=
Received: from [10.199.0.166] (unknown [10.199.0.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	by mx.warmcat.com (Postfix) with ESMTPSA id ECF4624B33;
	Fri, 12 Jan 2024 11:02:23 +0000 (UTC)
Message-ID: <61e48428-0e04-4a06-8a55-85862a41a98b@warmcat.com>
Date: Fri, 12 Jan 2024 11:02:23 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SparkLAN WNFB-265AXI (AP6275P) / bcm43752 pcie on mainline
 brcmfmac
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
 "wiagn233@outlook.com" <wiagn233@outlook.com>
References: <c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com>
From: Andy Green <andy@warmcat.com>
In-Reply-To: <c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/12/24 10:46, Marcel Ziswiler wrote:
> Hi guys
> 
> I stumbled over this thread from a little over a year ago [1].
> 
> I lately tried my take at this, however, initially even on latest linux-next it did not even recognise my card.
> 
> 0000:01:00.0 Network controller: Broadcom Inc. and subsidiaries Device 449d (rev 02)
> 
> Once I added that PCI device ID to drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c the driver at least
> picked it up:
> 
> [   27.712436] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
> [   27.826371] brcmfmac 0000:01:00.0: brcmf_pcie_probe: failed to parse OTP
> [   27.833126] brcmfmac: brcmf_pcie_probe: failed 14e4:449d
> [   27.838498] brcmfmac: probe of 0000:01:00.0 failed with error -22
> 
> Looks like it needs more information but I am unsure to what exactly to add where. Last I got the following
> (git diff at the very end):
> 
> [  412.947747] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
> [  413.059831] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43752-pcie for chip BCM43752/2
> [  413.096587] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfmac43752-pcie.txcap_blob failed with
> error -2
> [  419.211343] brcmfmac 0000:01:00.0: brcmf_pcie_download_fw_nvram: FW failed to initialize
> [  419.219481] brcmfmac 0000:01:00.0: brcmf_pcie_setup: Dongle setup failed
> [  419.226214] ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or crashed
> 
> Not sure what exact firmware I would need to use. From SparkLAN I got the following:
> 
> Archive:  FW_AP6275P_101_v2.zip
>    Length      Date    Time    Name
> ---------  ---------- -----   ----
>      80602  07-01-2021 15:01   FW_AP6275P_101_v2/BCM4362A2_001.003.006.1012.1017.hcd
>      30993  11-12-2021 20:16   FW_AP6275P_101_v2/clm_bcm43752a2_pcie_ag.blob
>     936074  07-13-2022 14:28   FW_AP6275P_101_v2/fw_bcm43752a2_pcie_ag.bin
>       7458  01-10-2022 12:11   FW_AP6275P_101_v2/nvram_ap6275p.txt
>       7808  08-30-2022 15:53   FW_AP6275P_101_v2/nvram_ap6275p_m2.txt
>       8576  02-25-2021 14:51   FW_AP6275P_101_v2/nvram_ap6275p_mp.txt
>        673  04-21-2023 16:32   FW_AP6275P_101_v2/ReadMe.txt
> ---------                     -------
>    1072184                     7 files
> 
> Did anybody ever progress on getting this to work?

I did get RK3588 EVB and the customer board using the same module to 
work well using the OOT driver supplied with the 5.10-basis BSP. 
Unfortunately I no longer have access to the patches so this is from memory.

It needed various incremental mods including an upgrade of its use of 
the firmware API to the modern one so it could initialize the module at all.

After it could come alive but fail in operation, the final problem with 
it I traced where it choked in the driver, it turned out to happen quite 
early and simply... something that was expected to have been set by the 
80211 stack else it would bail - it had its own comment explaining that 
this was why it would get into trouble otherwise on 5.10 - was simply no 
longer set with later 80211 from mainline and always bailed there. 
Removing the check got it working well.

Making the mainline driver support it would have been much better, but 
since the firmware is newer than the existing driver, without 
@broadcom.com help that's a hiding to nothing.  Patching the OOT driver, 
it's out of scope to send it here when I did have access to it.

> Any help would be much appreciated. Thanks!

Sorry that's not as useful as it could be, but the OOT path can be made 
to work is the news.

-Andy

> [1] https://lore.kernel.org/all/2db80338-c92d-b006-c281-dab943029168@warmcat.com/T
> 
> Cheers
> 
> Marcel
> 
> ---
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 80220685f5e4..b596762a1cd2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
>   BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
>   BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>   BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>   BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>   BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>   BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
> @@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>   	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>   	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>   	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>   	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
> @@ -2062,6 +2064,8 @@ static int brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
>   		words = 0x170;
>   		break;
>   	case BRCM_CC_4387_CHIP_ID:
> +//brcmf_pcie_probe: failed to parse OTP
> +//	case BRCM_CC_43752_CHIP_ID:
>   		coreid = BCMA_CORE_GCI;
>   		base = 0x113c;
>   		words = 0x170;
> @@ -2694,6 +2698,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID, BCA),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 44684bf1b9ac..b97b4c640d1b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -59,6 +59,7 @@
>   #define CY_CC_43012_CHIP_ID		43012
>   #define CY_CC_43439_CHIP_ID		43439
>   #define CY_CC_43752_CHIP_ID		43752
> +#define BRCM_CC_43752_CHIP_ID		43752
>   
>   /* USB Device IDs */
>   #define BRCM_USB_43143_DEVICE_ID	0xbd1e
> @@ -93,6 +94,7 @@
>   #define BRCM_PCIE_4366_2G_DEVICE_ID	0x43c4
>   #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>   #define BRCM_PCIE_4371_DEVICE_ID	0x440d
> +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
>   #define BRCM_PCIE_43596_DEVICE_ID	0x4415
>   #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>   #define BRCM_PCIE_4378_DEVICE_ID	0x4425
> 

