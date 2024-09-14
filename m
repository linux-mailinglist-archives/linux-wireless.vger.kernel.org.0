Return-Path: <linux-wireless+bounces-12863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79179790B2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8682F2847A7
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95313D251;
	Sat, 14 Sep 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Smj87XJH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C81758E
	for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726315470; cv=none; b=q+maszHlwuuwTrwaMgtxiPIOQ5/DT6RlKuGDxp7+TMtt2EfXZcYRdTJfhnMx77CNyl9Rsi/gAAgIB86adtGsoMy/Sr55OEx4bGZ7ai010Cx+VSB479Xwk3j2nASgQD+V7uRvfReDedoL8Gc2/Ytm+Wqnd+F0mO++jutUzblalWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726315470; c=relaxed/simple;
	bh=L4e+6Yz0EakeSFnS/dbPab8oMwJRdEV/NHtRmpOCJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMT9Ps6+Qc7IO6qY9jJ9MWWFgZHlj4GXkUi5tYyUxjvZw5Of8PTfYW712qDmu0GcJvdxCRk6Yh/AxcwcmZ/K1mpoDmEzqH6Bvh0gXtuTQs4IARG6a/1mVluMB+IfyrfC3454cwoSnv9tZor2ipltAsRLEMmeJIwptg3Gykyr1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Smj87XJH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d82b0ebd51so624105a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726315467; x=1726920267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oSGNWZvY704B4IwUyKIUrys+eWFhnyWNcwlhcCVVQeA=;
        b=Smj87XJH1iptNQoIosv+Jnv8ciJMltasgJUJPJvJqWnNq7zPb9G23d1wfNtP3t+kMi
         QW+QtuhH5JfjX8SVKwzPwnv55S2RWzMmkZkarSNPBYVibBgwLaJKz6hivQaW4msCCgfz
         dY+7cmzOLevoYYAFMcLH1EYcj2hpYmSk5+n7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726315467; x=1726920267;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSGNWZvY704B4IwUyKIUrys+eWFhnyWNcwlhcCVVQeA=;
        b=iskFdF+jX/7gcsQmNtS8qQ013kvV+DsJ55xq4lZor/a7mY9AOHDWxVctPEjtQc/P3m
         mfn5SCaTsXmSn18RIU5/VKOWHR5L4+B2olvwWcQmV0fQSMDch8B48kpLR9tTGunwMRZr
         Q49H020HV2sGscFpszes0znMASDl+SWjUNuNfRvN5CE9kJz6zLzVnPrQDVKQPlyXsdNx
         johUf3Rc4UFtNMgYMyisVo6UJrzjaJiIOjmJMUPAGXyZTZaUPgdkIURY6TLj72ec93AQ
         puHcqgMfvLr77YMemTDg4m686Es3JQk4jvTCWU2MSJF++ak7BMd2H/PRXXEQD5s/G0U5
         sQeg==
X-Forwarded-Encrypted: i=1; AJvYcCWcj7v7DKXbRW5T8+g18tAyenXTqrNHX4YfCs6jSNJpXLnAlV0FGQRxLAX8mzi697m0B090cK6lsn5WVoNlXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBm17BTpTTnpDoch0ZAzmU9q4GUTfBL3uvLr/XJ7LPIECfJLT
	Oo/Tv6ic7KDf7DY5rl+j6FsooDfQU8dcGwbw96IxLaFT8EQxMbR7X9YVfev72A==
X-Google-Smtp-Source: AGHT+IH/Ey6ZEsKHQ4WHunC0ybPAVtF3dkkevxDRPRklkr+TgtDVl0vLUj5Rq69QGt+KDWEjDt3FfQ==
X-Received: by 2002:a17:90a:e7cb:b0:2d8:7561:db6a with SMTP id 98e67ed59e1d1-2dbb9e207a2mr8777273a91.22.1726315466815;
        Sat, 14 Sep 2024 05:04:26 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd271fcsm1356939a91.28.2024.09.14.05.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 05:04:26 -0700 (PDT)
Message-ID: <9af687c7-8e7b-40dd-8772-9d8d926622c1@broadcom.com>
Date: Sat, 14 Sep 2024 14:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: brcmfmac: add support for CYW55572 PCIe
 chipset
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Carter Chen <carter.chen@infineon.com>, Owen Huang
 <Owen.Huang@infineon.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Double Lo <Double.Lo@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev
References: <20240909203133.74777-1-marex@denx.de>
 <20240909203133.74777-2-marex@denx.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240909203133.74777-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/2024 10:31 PM, Marek Vasut wrote:
> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> CYW55572 is a 2x2 dual-band 802.11a/b/g/n/ac/ax chipset with 20/40/80MHz
> channel support. It is a WLAN+BT combo device with WLAN secure boot support.
> The CYW55572 used to be labeled CYW55560.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>

Same remark here as in the first patch of this series.

> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Carter Chen <carter.chen@infineon.com>
> Signed-off-by: Owen Huang <Owen.Huang@infineon.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
> ---
> NOTE: This is squashed from downstream upports from
>        https://github.com/Infineon/ifx-wireless-drivers/
>        branch RTM/v5.15.58-Indrik / tag release-v5.15.58-2024_0514
> - 8a41d39f6290 ("brcmfmac: add Cypress PCIe vendor ID")
> - 12f74eba2569 ("brcmfmac: add support for CYW55560 PCIe chipset")
> - ea4e4056a3f8 ("brcmfmac: update firmware loading name for CY5557x")
> - ee322201fe11 ("brcmfmac: use SR core id to decide SR capability for CY55572")
> - 0a47ed7f3678 ("brcmfmac: Fix invalid RAM address warning for PCIE platforms")

This patch is a bit large and covering multiple concepts. At least the 
bootloader handshake implementation is worth a separate patch I would 
say. I skipped the related stuff for now.

> ---
> Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: "Rafał Miłecki" <zajec5@gmail.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Carter Chen <carter.chen@infineon.com>
> Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Cc: Double Lo <Double.Lo@infineon.com>
> Cc: Duoming Zhou <duoming@zju.edu.cn>
> Cc: Erick Archer <erick.archer@outlook.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Mathias Krause <minipli@grsecurity.net>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Owen Huang <Owen.Huang@infineon.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: brcm80211@lists.linux.dev
> Cc: linux-wireless@vger.kernel.org
> ---
> V2: - Fix up build warnings related to use of u32 instead of __le32
>      - Include SoB line from Chung-Hsien with both cypress and infineon address
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |   6 +
>   .../broadcom/brcm80211/brcmfmac/chip.c        | 214 +++++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/chip.h        |  34 +++
>   .../broadcom/brcm80211/brcmfmac/firmware.c    |  15 +-
>   .../broadcom/brcm80211/brcmfmac/firmware.h    |   8 +-
>   .../broadcom/brcm80211/brcmfmac/pcie.c        | 192 +++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  27 ++-
>   .../broadcom/brcm80211/include/brcm_hw_ids.h  |   3 +
>   .../broadcom/brcm80211/include/brcmu_utils.h  |  13 ++
>   include/linux/bcma/bcma.h                     |   1 +
>   include/linux/mmc/sdio_ids.h                  |   1 +
>   11 files changed, 497 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index d35262335eaf7..ae89d73eefb87 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -46,6 +46,8 @@
>   #define SDIO_4373_FUNC2_BLOCKSIZE	256
>   #define SDIO_435X_FUNC2_BLOCKSIZE	256
>   #define SDIO_4329_FUNC2_BLOCKSIZE	128
> +#define SDIO_CYW55572_FUNC2_BLOCKSIZE	256
> +
>   /* Maximum milliseconds to wait for F2 to come up */
>   #define SDIO_WAIT_F2RDY	3000
>   
> @@ -917,6 +919,9 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
>   	case SDIO_DEVICE_ID_BROADCOM_4329:
>   		f2_blksz = SDIO_4329_FUNC2_BLOCKSIZE;
>   		break;
> +	case SDIO_DEVICE_ID_CYPRESS_55572:
> +		f2_blksz = SDIO_CYW55572_FUNC2_BLOCKSIZE;
> +		break;
>   	default:
>   		break;
>   	}
> @@ -996,6 +1001,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
>   	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
> +	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_55572, CYW),
>   	{ /* end: all zeroes */ }
>   };
>   MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 2ef92ef25517e..c5188a31c9efb 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -216,6 +216,32 @@ struct sbsocramregs {
>   #define	ARMCR4_BSZ_MULT		8192
>   #define	ARMCR4_BLK_1K_MASK	0x200
>   
> +/* CYW55572 dedicated space and RAM base */
> +#define CYW55572_TCAM_SIZE	0x800
> +#define CYW55572_TRXHDR_SIZE	0x2b4

Please use sizeof(struct trxhdr_le) instead of hard value 0x2b4 (they 
are the same).

> +#define CYW55572_RAM_BASE	(0x370000 + \
> +				 CYW55572_TCAM_SIZE + CYW55572_TRXHDR_SIZE)
> +
> +#define BRCMF_BLHS_POLL_INTERVAL			10	/* msec */
> +#define BRCMF_BLHS_D2H_READY_TIMEOUT			100	/* msec */
> +#define BRCMF_BLHS_D2H_TRXHDR_PARSE_DONE_TIMEOUT	50	/* msec */
> +#define BRCMF_BLHS_D2H_VALDN_DONE_TIMEOUT		250	/* msec */
> +
> +/* Bootloader handshake flags - dongle to host */
> +#define BRCMF_BLHS_D2H_START			BIT(0)
> +#define BRCMF_BLHS_D2H_READY			BIT(1)
> +#define BRCMF_BLHS_D2H_STEADY			BIT(2)
> +#define BRCMF_BLHS_D2H_TRXHDR_PARSE_DONE	BIT(3)
> +#define BRCMF_BLHS_D2H_VALDN_START		BIT(4)
> +#define BRCMF_BLHS_D2H_VALDN_RESULT		BIT(5)
> +#define BRCMF_BLHS_D2H_VALDN_DONE		BIT(6)
> +
> +/* Bootloader handshake flags - host to dongle */
> +#define BRCMF_BLHS_H2D_DL_FW_START		BIT(0)
> +#define BRCMF_BLHS_H2D_DL_FW_DONE		BIT(1)
> +#define BRCMF_BLHS_H2D_DL_NVRAM_DONE		BIT(2)
> +#define BRCMF_BLHS_H2D_BL_RESET_ON_ERROR	BIT(3)
> +
>   struct brcmf_core_priv {
>   	struct brcmf_core pub;
>   	u32 wrapbase;
> @@ -501,6 +527,21 @@ char *brcmf_chip_name(u32 id, u32 rev, char *buf, uint len)
>   	return buf;
>   }
>   
> +static bool brcmf_chip_find_coreid(struct brcmf_chip_priv *ci, u16 coreid)

No need for this function. Simply use brcmf_chip_get_core().

> +{
> +	struct brcmf_core_priv *core;
> +
> +	list_for_each_entry(core, &ci->cores, list) {
> +		brcmf_dbg(TRACE, " core 0x%x:%-2d base 0x%08x wrap 0x%08x\n",
> +			  core->pub.id, core->pub.rev, core->pub.base,
> +			  core->wrapbase);
> +		if (core->pub.id == coreid)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static struct brcmf_core *brcmf_chip_add_core(struct brcmf_chip_priv *ci,
>   					      u16 coreid, u32 base,
>   					      u32 wrapbase)
> @@ -745,6 +786,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
>   		return 0x352000;
>   	case BRCM_CC_4387_CHIP_ID:
>   		return 0x740000;
> +	case CY_CC_55572_CHIP_ID:
> +		return CYW55572_RAM_BASE;
>   	default:
>   		brcmf_err("unknown chip: %s\n", ci->pub.name);
>   		break;
> @@ -763,6 +806,9 @@ int brcmf_chip_get_raminfo(struct brcmf_chip *pub)
>   	if (mem) {
>   		mem_core = container_of(mem, struct brcmf_core_priv, pub);
>   		ci->pub.ramsize = brcmf_chip_tcm_ramsize(mem_core);
> +		if (ci->pub.chip == CY_CC_55572_CHIP_ID)
> +			ci->pub.ramsize -= (CYW55572_TCAM_SIZE +
> +					    CYW55572_TRXHDR_SIZE);

Please move this to the end of the function just before the debug print 
and use switch statement instead.

>   		ci->pub.rambase = brcmf_chip_tcm_rambase(ci);
>   		if (ci->pub.rambase == INVALID_RAMBASE) {
>   			brcmf_err("RAM base not provided with ARM CR4 core\n");
> @@ -942,7 +988,8 @@ int brcmf_chip_dmp_erom_scan(struct brcmf_chip_priv *ci)
>   		/* need core with ports */
>   		if (nmw + nsw == 0 &&
>   		    id != BCMA_CORE_PMU &&
> -		    id != BCMA_CORE_GCI)
> +		    id != BCMA_CORE_GCI &&
> +			id != BCMA_CORE_SR)

indentation wrong(?)
>   			continue;
>   
>   		/* try to obtain register address info */
> @@ -966,6 +1013,144 @@ u32 brcmf_chip_enum_base(u16 devid)
>   	return SI_ENUM_BASE_DEFAULT;
>   }

[...] as mentioned skipped blhs stuff for now.

>   static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
>   {
>   	struct brcmf_core *core;
> @@ -1123,6 +1308,7 @@ struct brcmf_chip *brcmf_chip_attach(void *ctx, u16 devid,
>   				     const struct brcmf_buscore_ops *ops)
>   {
>   	struct brcmf_chip_priv *chip;
> +	struct brcmf_blhs *blhs;
>   	int err = 0;
>   
>   	if (WARN_ON(!ops->read32))
> @@ -1150,6 +1336,26 @@ struct brcmf_chip *brcmf_chip_attach(void *ctx, u16 devid,
>   	if (err < 0)
>   		goto fail;
>   
> +	blhs = NULL;
> +	if (chip->ops->blhs_attach) {
> +		err = chip->ops->blhs_attach(chip->ctx, &blhs,
> +					     BRCMF_BLHS_D2H_READY,
> +					     BRCMF_BLHS_D2H_READY_TIMEOUT,
> +					     BRCMF_BLHS_POLL_INTERVAL);
> +		if (err < 0)
> +			goto fail;
> +
> +		if (blhs) {
> +			blhs->init = brcmf_blhs_init;
> +			blhs->prep_fwdl = brcmf_blhs_prep_fw_download;
> +			blhs->post_fwdl = brcmf_blhs_post_fw_download;
> +			blhs->post_nvramdl = brcmf_blhs_post_nvram_download;
> +			blhs->chk_validation = brcmf_blhs_chk_validation;
> +			blhs->post_wdreset = brcmf_blhs_post_watchdog_reset;
> +		}
> +	}
> +	chip->pub.blhs = blhs;
> +
>   	err = brcmf_chip_recognition(chip);
>   	if (err < 0)
>   		goto fail;
> @@ -1176,6 +1382,7 @@ void brcmf_chip_detach(struct brcmf_chip *pub)
>   		list_del(&core->list);
>   		kfree(core);
>   	}
> +	kfree(pub->blhs);
>   	kfree(chip);
>   }
>   
> @@ -1309,7 +1516,8 @@ brcmf_chip_cr4_set_passive(struct brcmf_chip_priv *chip)
>   	int i;
>   	struct brcmf_core *core;
>   
> -	brcmf_chip_disable_arm(chip, BCMA_CORE_ARM_CR4);
> +	if (!chip->pub.blhs)
> +		brcmf_chip_disable_arm(chip, BCMA_CORE_ARM_CR4);
>   
>   	/* Disable the cores only and let the firmware enable them.
>   	 * Releasing reset ourselves breaks BCM4387 in weird ways.
> @@ -1456,6 +1664,8 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
>   		reg = chip->ops->read32(chip->ctx, addr);
>   		return (reg & (PMU_RCTL_MACPHY_DISABLE_MASK |
>   			       PMU_RCTL_LOGIC_DISABLE_MASK)) == 0;
> +	case CY_CC_55572_CHIP_ID:
> +		return brcmf_chip_find_coreid(chip, BCMA_CORE_SR);

Simply use !!brcmf_chip_get_core(chip, BCMA_CORE_SR) here although I am 
surprised the presence is sufficient here. I would suggest reading 
control0 register (offset 0x4):

sr = brcmf_chip_get_core(chip, BCMA_CORE_SR);
if (sr) {
	reg = chip->ops->read32(chip->ctx, sr->base + 0x4);
	return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
}
return false;

>   	default:
>   		addr = CORE_CC_REG(pmu->base, pmucapabilities_ext);
>   		reg = chip->ops->read32(chip->ctx, addr);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
> index d69f101f58344..0a00fb9d7632e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
> @@ -10,6 +10,8 @@
>   #define CORE_CC_REG(base, field) \
>   		(base + offsetof(struct chipcregs, field))
>   
> +struct brcmf_blhs;
> +

Just put the struct brcmf_blhs here and drop the forward declaration.

>   /**
>    * struct brcmf_chip - chip level information.
>    *
> @@ -24,6 +26,7 @@
>    * @ramsize: amount of RAM on chip including retention.
>    * @srsize: amount of retention RAM on chip.
>    * @name: string representation of the chip identifier.
> + * @blhs: bootlooder handshake handle.
>    */
>   struct brcmf_chip {
>   	u32 chip;
> @@ -37,6 +40,7 @@ struct brcmf_chip {
>   	u32 ramsize;
>   	u32 srsize;
>   	char name[12];
> +	struct brcmf_blhs *blhs;
>   };
>   
>   /**
> @@ -61,6 +65,7 @@ struct brcmf_core {
>    * @setup: bus-specific core setup.
>    * @active: chip becomes active.
>    *	The callback should use the provided @rstvec when non-zero.
> + * @blhs_attach: attach bootloader handshake handle
>    */
>   struct brcmf_buscore_ops {
>   	u32 (*read32)(void *ctx, u32 addr);
> @@ -69,6 +74,35 @@ struct brcmf_buscore_ops {
>   	int (*reset)(void *ctx, struct brcmf_chip *chip);
>   	int (*setup)(void *ctx, struct brcmf_chip *chip);
>   	void (*activate)(void *ctx, struct brcmf_chip *chip, u32 rstvec);
> +	int (*blhs_attach)(void *ctx, struct brcmf_blhs **blhs, u32 flag,
> +			   uint timeout, uint interval);
> +};
> +
> +/**
> + * struct brcmf_blhs - bootloader handshake handle related information.
> + *
> + * @d2h: offset of dongle to host register for the handshake.
> + * @h2d: offset of host to dongle register for the handshake.
> + * @init: bootloader handshake initialization.
> + * @prep_fwdl: handshake before firmware download.
> + * @post_fwdl: handshake after firmware download.
> + * @post_nvramdl: handshake after nvram download.
> + * @chk_validation: handshake for firmware validation check.
> + * @post_wdreset: handshake after watchdog reset.
> + * @read: read value with register offset for the handshake.
> + * @write: write value with register offset for the handshake.
> + */
> +struct brcmf_blhs {
> +	u32 d2h;
> +	u32 h2d;
> +	void (*init)(struct brcmf_chip *pub);
> +	int (*prep_fwdl)(struct brcmf_chip *pub);
> +	int (*post_fwdl)(struct brcmf_chip *pub);
> +	void (*post_nvramdl)(struct brcmf_chip *pub);
> +	int (*chk_validation)(struct brcmf_chip *pub);
> +	int (*post_wdreset)(struct brcmf_chip *pub);
> +	u32 (*read)(void *ctx, u32 addr);
> +	void (*write)(void *ctx, u32 addr, u32 value);
>   };
>   
>   int brcmf_chip_get_raminfo(struct brcmf_chip *pub);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index 83f8ed7d00f96..1d5be3ce51ccf 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -527,7 +527,8 @@ static void brcmf_fw_free_request(struct brcmf_fw_request *req)
>   	int i;
>   
>   	for (i = 0, item = &req->items[0]; i < req->n_items; i++, item++) {
> -		if (item->type == BRCMF_FW_TYPE_BINARY)
> +		if (item->type == BRCMF_FW_TYPE_BINARY ||
> +		    item->type == BRCMF_FW_TYPE_TRXSE)
>   			release_firmware(item->binary);
>   		else if (item->type == BRCMF_FW_TYPE_NVRAM)
>   			brcmf_fw_nvram_free(item->nv_data.data);
> @@ -599,6 +600,7 @@ static int brcmf_fw_complete_request(const struct firmware *fw,
>   		ret = brcmf_fw_request_nvram_done(fw, fwctx);
>   		break;
>   	case BRCMF_FW_TYPE_BINARY:
> +	case BRCMF_FW_TYPE_TRXSE:
>   		if (fw)
>   			cur->binary = fw;
>   		else
> @@ -672,8 +674,19 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>   static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
>   {
>   	struct brcmf_fw *fwctx = ctx;
> +	struct brcmf_fw_item *cur = &fwctx->req->items[fwctx->curpos];
> +	char alt_path[BRCMF_FW_NAME_LEN];
>   	int ret;
>   
> +	if (!fw && cur->type == BRCMF_FW_TYPE_TRXSE) {
> +		strscpy(alt_path, cur->path, BRCMF_FW_NAME_LEN);
> +		/* strip 'se' from .trxse at the end */
> +		alt_path[strlen(alt_path) - 2] = 0;
> +		ret = request_firmware(&fw, alt_path, fwctx->dev);

What is the reason for stripping the 'se'. Just keep it.

> +		if (!ret)
> +			cur->path = alt_path;
> +	}
> +
>   	ret = brcmf_fw_complete_request(fw, fwctx);
>   
>   	while (ret == 0 && ++fwctx->curpos < fwctx->req->n_items) {
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> index 4002d326fd21b..ab709babd649a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> @@ -41,6 +41,11 @@ static const char BRCM_ ## fw_name ## _FIRMWARE_BASENAME[] = \
>   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH fw_base ".bin"); \
>   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH fw_base ".clm_blob")
>   
> +#define CY_FW_TRXSE_DEF(fw_name, fw_base) \
> +static const char BRCM_ ## fw_name ## _FIRMWARE_BASENAME[] = \
> +	BRCMF_FW_DEFAULT_PATH fw_base; \
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH fw_base ".trxse")
> +
>   #define BRCMF_FW_ENTRY(chipid, mask, name) \
>   	{ chipid, mask, BRCM_ ## name ## _FIRMWARE_BASENAME }
>   
> @@ -48,7 +53,8 @@ void brcmf_fw_nvram_free(void *nvram);
>   
>   enum brcmf_fw_type {
>   	BRCMF_FW_TYPE_BINARY,
> -	BRCMF_FW_TYPE_NVRAM
> +	BRCMF_FW_TYPE_NVRAM,
> +	BRCMF_FW_TYPE_TRXSE
>   };
>   
>   struct brcmf_fw_item {
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 058a742d17eda..15b045ab477ca 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>   BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>   BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
>   BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
> +CY_FW_TRXSE_DEF(55572, "cyfmac55572-pcie");
>   
>   /* firmware config files */
>   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -109,6 +110,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4387_CHIP_ID, 0xFFFFFFFF, 4387C2), /* revision ID 7 */
> +	BRCMF_FW_ENTRY(CY_CC_55572_CHIP_ID, 0xFFFFFFFF, 55572),

What chip revisions did you come across? We can keep the revmask as 
above for now, but I would like to know what is out there.

>   };
>   
>   #define BRCMF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
> @@ -121,7 +123,8 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>   #define	BRCMF_PCIE_BAR0_WRAPPERBASE		0x70
>   
>   #define BRCMF_PCIE_BAR0_WRAPBASE_DMP_OFFSET	0x1000
> -#define BRCMF_PCIE_BARO_PCIE_ENUM_OFFSET	0x2000
> +#define BRCMF_PCIE_BAR0_PCIE_ENUM_OFFSET	0x2000
> +#define BRCMF_CYW55572_PCIE_BAR0_PCIE_ENUM_OFFSET	0x3000
>   
>   #define BRCMF_PCIE_ARMCR4REG_BANKIDX		0x40
>   #define BRCMF_PCIE_ARMCR4REG_BANKPDA		0x4C
> @@ -139,6 +142,8 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>   #define BRCMF_PCIE_PCIE2REG_CONFIGDATA		0x124
>   #define BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0	0x140
>   #define BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1	0x144
> +#define BRCMF_PCIE_PCIE2REG_DAR_D2H_MSG_0	0xA80
> +#define BRCMF_PCIE_PCIE2REG_DAR_H2D_MSG_0	0xA90
>   
>   #define BRCMF_PCIE_64_PCIE2REG_INTMASK		0xC14
>   #define BRCMF_PCIE_64_PCIE2REG_MAILBOXINT	0xC30
> @@ -271,18 +276,32 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>   #define BRCMF_PCIE_CFGREG_MSI_ADDR_L		0x5C
>   #define BRCMF_PCIE_CFGREG_MSI_ADDR_H		0x60
>   #define BRCMF_PCIE_CFGREG_MSI_DATA		0x64
> +#define BRCMF_PCIE_CFGREG_REVID			0x6C
>   #define BRCMF_PCIE_CFGREG_LINK_STATUS_CTRL	0xBC
>   #define BRCMF_PCIE_CFGREG_LINK_STATUS_CTRL2	0xDC
>   #define BRCMF_PCIE_CFGREG_RBAR_CTRL		0x228
>   #define BRCMF_PCIE_CFGREG_PML1_SUB_CTRL1	0x248
>   #define BRCMF_PCIE_CFGREG_REG_BAR2_CONFIG	0x4E0
>   #define BRCMF_PCIE_CFGREG_REG_BAR3_CONFIG	0x4F4
> +#define BRCMF_PCIE_CFGREG_REVID_SECURE_MODE	BIT(31)
>   #define BRCMF_PCIE_LINK_STATUS_CTRL_ASPM_ENAB	3
>   
>   /* Magic number at a magic location to find RAM size */
>   #define BRCMF_RAMSIZE_MAGIC			0x534d4152	/* SMAR */
>   #define BRCMF_RAMSIZE_OFFSET			0x6c
>   
> +#define BRCMF_ENTROPY_SEED_LEN		64u
> +#define BRCMF_ENTROPY_NONCE_LEN		16u
> +#define BRCMF_ENTROPY_HOST_LEN		(BRCMF_ENTROPY_SEED_LEN + \
> +					 BRCMF_ENTROPY_NONCE_LEN)
> +#define BRCMF_NVRAM_OFFSET_TCM		4u
> +#define BRCMF_NVRAM_COMPRS_FACTOR	4u
> +#define BRCMF_NVRAM_RNG_SIGNATURE	0xFEEDC0DEu
> +
> +struct brcmf_rand_metadata {
> +	__le32 signature;
> +	__le32 count;
> +};
>   
>   struct brcmf_pcie_console {
>   	u32 base_addr;
> @@ -679,9 +698,15 @@ static void brcmf_pcie_reset_device(struct brcmf_pciedev_info *devinfo)
>   			       val);
>   
>   	/* Watchdog reset */
> +	if (devinfo->ci->blhs)
> +		devinfo->ci->blhs->init(devinfo->ci);
>   	brcmf_pcie_select_core(devinfo, BCMA_CORE_CHIPCOMMON);
>   	WRITECC32(devinfo, watchdog, 4);
>   	msleep(100);
> +	if (devinfo->ci->blhs)
> +		if (devinfo->ci->blhs->post_wdreset(devinfo->ci))
> +			return;

use single if statement and-ing the two conditions.

> +
>   
>   	/* Restore ASPM */
>   	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
> @@ -722,6 +747,9 @@ static void brcmf_pcie_attach(struct brcmf_pciedev_info *devinfo)
>   
>   static int brcmf_pcie_enter_download_state(struct brcmf_pciedev_info *devinfo)
>   {
> +	struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
> +	int err = 0;
> +
>   	if (devinfo->ci->chip == BRCM_CC_43602_CHIP_ID) {
>   		brcmf_pcie_select_core(devinfo, BCMA_CORE_ARM_CR4);
>   		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_ARMCR4REG_BANKIDX,
> @@ -733,7 +761,14 @@ static int brcmf_pcie_enter_download_state(struct brcmf_pciedev_info *devinfo)
>   		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_ARMCR4REG_BANKPDA,
>   				       0);
>   	}
> -	return 0;
> +
> +	if (devinfo->ci->blhs) {
> +		err = devinfo->ci->blhs->prep_fwdl(devinfo->ci);
> +		if (err)
> +			brcmf_err(bus, "FW download preparation failed");
> +	}
> +
> +	return err;
>   }
>   
>   
> @@ -747,8 +782,13 @@ static int brcmf_pcie_exit_download_state(struct brcmf_pciedev_info *devinfo,
>   		brcmf_chip_resetcore(core, 0, 0, 0);
>   	}
>   
> -	if (!brcmf_chip_set_active(devinfo->ci, resetintr))
> -		return -EIO;
> +	if (devinfo->ci->blhs) {
> +		devinfo->ci->blhs->post_nvramdl(devinfo->ci);
> +	} else {
> +		if (!brcmf_chip_set_active(devinfo->ci, resetintr))
> +			return -EIO;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1608,6 +1648,27 @@ brcmf_pcie_adjust_ramsize(struct brcmf_pciedev_info *devinfo, u8 *data,
>   }
>   
>   
> +static void
> +brcmf_pcie_write_rand(struct brcmf_pciedev_info *devinfo, u32 nvram_csm)

I mentioned in v1 that there is already a (probably incompatible) 
mechinism for providing random seed to firmware. Prefer to explore 
possible reuse or at least align code flow if possible.

> +{
> +	struct brcmf_rand_metadata rand_data;
> +	u8 rand_buf[BRCMF_ENTROPY_HOST_LEN];
> +	u32 count = BRCMF_ENTROPY_HOST_LEN;
> +	u32 address;
> +
> +	address = devinfo->ci->rambase +
> +		  (devinfo->ci->ramsize - BRCMF_NVRAM_OFFSET_TCM) -
> +		  ((nvram_csm & 0xffff) * BRCMF_NVRAM_COMPRS_FACTOR) -
> +		  sizeof(rand_data);
> +	memset(rand_buf, 0, BRCMF_ENTROPY_HOST_LEN);
> +	rand_data.signature = cpu_to_le32(BRCMF_NVRAM_RNG_SIGNATURE);
> +	rand_data.count = cpu_to_le32(count);
> +	memcpy_toio(devinfo->tcm + address, &rand_data, sizeof(rand_data));
> +	address -= count;
> +	get_random_bytes(rand_buf, count);
> +	memcpy_toio(devinfo->tcm + address, rand_buf, count);
> +}
> +
>   static int
>   brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_info *devinfo,
>   			       u32 sharedram_addr)
> @@ -1693,6 +1754,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   	int err;
>   	u32 address;
>   	u32 resetintr;
> +	u32 nvram_lenw;
> +	u32 nvram_csm;
>   
>   	brcmf_dbg(PCIE, "Halt ARM.\n");
>   	err = brcmf_pcie_enter_download_state(devinfo);
> @@ -1711,16 +1774,40 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   	resetintr = get_unaligned_le32(fw->data);
>   	release_firmware(fw);
>   
> -	/* reset last 4 bytes of RAM address. to be used for shared
> -	 * area. This identifies when FW is running
> -	 */
> -	brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
> +	if (devinfo->ci->blhs) {
> +		err = devinfo->ci->blhs->post_fwdl(devinfo->ci);
> +		if (err) {
> +			brcmf_err(bus, "FW download failed, err=%d\n", err);
> +			return err;
> +		}
> +
> +		err = devinfo->ci->blhs->chk_validation(devinfo->ci);
> +		if (err) {
> +			brcmf_err(bus, "FW valication failed, err=%d\n", err);

typo

> +			return err;
> +		}
> +	} else {
> +		/* reset last 4 bytes of RAM address. to be used for shared
> +		 * area. This identifies when FW is running
> +		 */
> +		brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
> +	}
>   
>   	if (nvram) {
>   		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
>   		address = devinfo->ci->rambase + devinfo->ci->ramsize -
>   			  nvram_len;
> +
> +		if (devinfo->ci->blhs)
> +			address -= 4;
>   		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
> +
> +		/* Convert nvram_len to words to determine the length token */
> +		nvram_lenw = nvram_len / 4;
> +		/* subtract word used to store the token itself on non-blhs devices */
> +		if (!devinfo->ci->blhs)
> +			nvram_lenw -= 1;
> +		nvram_csm = (~nvram_lenw << 16) | (nvram_lenw & 0x0000FFFF);
>   		brcmf_fw_nvram_free(nvram);
>   
>   		if (devinfo->otp.valid) {
> @@ -1743,10 +1830,20 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   			brcmf_pcie_provide_random_bytes(devinfo, address);
>   		}
>   	} else {
> +		nvram_csm = 0;
>   		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
>   			  devinfo->nvram_name);
>   	}
>   
> +	if (devinfo->ci->chip == CY_CC_55572_CHIP_ID) {
> +		/* Write the length token to the last word of RAM address */
> +		brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4,
> +				       (u32)cpu_to_le32(nvram_csm));
> +
> +		/* Write random numbers to TCM for randomizing heap address */
> +		brcmf_pcie_write_rand(devinfo, nvram_csm);
> +	}
> +
>   	sharedram_addr_written = brcmf_pcie_read_ram32(devinfo,
>   						       devinfo->ci->ramsize -
>   						       4);
> @@ -1837,6 +1934,21 @@ static void brcmf_pcie_release_resource(struct brcmf_pciedev_info *devinfo)
>   	pci_disable_device(devinfo->pdev);
>   }
>   
> +static u32 brcmf_pcie_buscore_blhs_read(void *ctx, u32 reg_offset)
> +{
> +	struct brcmf_pciedev_info *devinfo = (struct brcmf_pciedev_info *)ctx;
> +
> +	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
> +	return brcmf_pcie_read_reg32(devinfo, reg_offset);
> +}
> +
> +static void brcmf_pcie_buscore_blhs_write(void *ctx, u32 reg_offset, u32 value)
> +{
> +	struct brcmf_pciedev_info *devinfo = (struct brcmf_pciedev_info *)ctx;
> +
> +	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
> +	brcmf_pcie_write_reg32(devinfo, reg_offset, value);
> +}
>   
>   static u32 brcmf_pcie_buscore_prep_addr(const struct pci_dev *pdev, u32 addr)
>   {
> @@ -1907,12 +2019,63 @@ static void brcmf_pcie_buscore_activate(void *ctx, struct brcmf_chip *chip,
>   }
>   
>   
> +static int brcmf_pcie_buscore_blhs_attach(void *ctx, struct brcmf_blhs **blhs,
> +					  u32 flag, uint timeout, uint interval)
> +{
> +	struct brcmf_pciedev_info *devinfo = (struct brcmf_pciedev_info *)ctx;
> +	struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
> +	struct brcmf_blhs *blhsh;
> +	u32 regdata;
> +	u32 pcie_enum;
> +	u32 addr;
> +
> +	if (devinfo->pdev->vendor != CY_PCIE_VENDOR_ID_CYPRESS)
> +		return 0;
> +
> +	pci_read_config_dword(devinfo->pdev, BRCMF_PCIE_CFGREG_REVID, &regdata);
> +	if (regdata & BRCMF_PCIE_CFGREG_REVID_SECURE_MODE) {
> +		blhsh = kzalloc(sizeof(*blhsh), GFP_KERNEL);
> +		if (!blhsh)
> +			return -ENOMEM;
> +
> +		blhsh->d2h = BRCMF_PCIE_PCIE2REG_DAR_D2H_MSG_0;
> +		blhsh->h2d = BRCMF_PCIE_PCIE2REG_DAR_H2D_MSG_0;
> +		blhsh->read = brcmf_pcie_buscore_blhs_read;
> +		blhsh->write = brcmf_pcie_buscore_blhs_write;
> +
> +		/* Host indication for bootloarder to start the init */
> +		if (devinfo->pdev->device == CY_PCIE_55572_DEVICE_ID)
> +			pcie_enum = BRCMF_CYW55572_PCIE_BAR0_PCIE_ENUM_OFFSET;
> +		else
> +			pcie_enum = BRCMF_PCIE_BAR0_PCIE_ENUM_OFFSET;
> +
> +		pci_read_config_dword(devinfo->pdev, PCI_BASE_ADDRESS_0,
> +				      &regdata);
> +		addr = regdata + pcie_enum + blhsh->h2d;
> +		brcmf_pcie_buscore_write32(ctx, addr, 0);
> +
> +		addr = regdata + pcie_enum + blhsh->d2h;
> +		SPINWAIT_MS((brcmf_pcie_buscore_read32(ctx, addr) & flag) == 0,
> +			    timeout, interval);
> +		regdata = brcmf_pcie_buscore_read32(ctx, addr);
> +		if (!(regdata & flag)) {
> +			brcmf_err(bus, "Timeout waiting for bootloader ready\n");
> +			kfree(blhsh);
> +			return -EPERM;
> +		}
> +		*blhs = blhsh;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct brcmf_buscore_ops brcmf_pcie_buscore_ops = {
>   	.prepare = brcmf_pcie_buscoreprep,
>   	.reset = brcmf_pcie_buscore_reset,
>   	.activate = brcmf_pcie_buscore_activate,
>   	.read32 = brcmf_pcie_buscore_read32,
>   	.write32 = brcmf_pcie_buscore_write32,
> +	.blhs_attach = brcmf_pcie_buscore_blhs_attach,
>   };
>   
>   #define BRCMF_OTP_SYS_VENDOR	0x15
> @@ -2243,6 +2406,9 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_info *devinfo)
>   		{ ".txcap_blob", devinfo->txcap_name },
>   	};
>   
> +	if (devinfo->ci->blhs)
> +		fwnames[BRCMF_PCIE_FW_CODE].extension = ".trxse";
> +
>   	fwreq = brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev,
>   				       brcmf_pcie_fwnames,
>   				       ARRAY_SIZE(brcmf_pcie_fwnames),
> @@ -2250,7 +2416,10 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_info *devinfo)
>   	if (!fwreq)
>   		return NULL;
>   
> -	fwreq->items[BRCMF_PCIE_FW_CODE].type = BRCMF_FW_TYPE_BINARY;
> +	if (devinfo->ci->blhs)
> +		fwreq->items[BRCMF_PCIE_FW_CODE].type = BRCMF_FW_TYPE_TRXSE;
> +	else
> +		fwreq->items[BRCMF_PCIE_FW_CODE].type = BRCMF_FW_TYPE_BINARY;
>   	fwreq->items[BRCMF_PCIE_FW_NVRAM].type = BRCMF_FW_TYPE_NVRAM;
>   	fwreq->items[BRCMF_PCIE_FW_NVRAM].flags = BRCMF_FW_REQF_OPTIONAL;
>   	fwreq->items[BRCMF_PCIE_FW_CLM].type = BRCMF_FW_TYPE_BINARY;
> @@ -2678,6 +2847,9 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
>   		BRCMF_FWVENDOR_ ## fw_vend \
>   	}
>   
> +#define BRCMF_PCIE_DEVICE_CY(dev_id)	{ CY_PCIE_VENDOR_ID_CYPRESS, dev_id,\
> +	PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0 }
> +
>   static const struct pci_device_id brcmf_pcie_devid_table[] = {
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
> @@ -2706,7 +2878,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
> -
> +	BRCMF_PCIE_DEVICE_CY(CY_PCIE_55572_DEVICE_ID),
>   	{ /* end: all zeroes */ }
>   };
>   
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 08881e366cae2..3bb03de1c2d29 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -59,6 +59,10 @@
>   #define CY_435X_F2_WATERMARK	0x40
>   #define CY_435X_F1_MESBUSYCTRL	(CY_435X_F2_WATERMARK | \
>   				 SBSDIO_MESBUSYCTRL_ENAB)
> +#define CYW55572_F2_WATERMARK	0x40
> +#define CYW55572_MES_WATERMARK	0x40
> +#define CYW55572_F1_MESBUSYCTRL	(CYW55572_MES_WATERMARK | \
> +				 SBSDIO_MESBUSYCTRL_ENAB)
>   
>   #ifdef DEBUG
>   
> @@ -626,6 +630,7 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
>   BRCMF_FW_CLM_DEF(4373, "brcmfmac4373-sdio");
>   BRCMF_FW_CLM_DEF(43012, "brcmfmac43012-sdio");
>   BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-sdio");
> +CY_FW_TRXSE_DEF(55572, "cyfmac55572-sdio");
>   
>   /* firmware config files */
>   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.txt");
> @@ -658,7 +663,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>   	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
>   	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
>   	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
> -	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
> +	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
> +	BRCMF_FW_ENTRY(CY_CC_55572_CHIP_ID, 0xFFFFFFFF, 55572)
>   };
>   
>   #define TXCTL_CREDITS	2
> @@ -719,7 +725,8 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
>   	 * fail. Thereby just bailing out immediately after clearing KSO
>   	 * bit, to avoid polling of KSO bit.
>   	 */
> -	if (!on && bus->ci->chip == CY_CC_43012_CHIP_ID)
> +	if (!on && (bus->ci->chip == CY_CC_43012_CHIP_ID ||
> +		    bus->ci->chip == CY_CC_55572_CHIP_ID))
>   		return err;
>   
>   	if (on) {
> @@ -3435,7 +3442,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
>   static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
>   {
>   	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
> -	    bus->ci->chip == CY_CC_43752_CHIP_ID)
> +	    bus->ci->chip == CY_CC_43752_CHIP_ID ||
> +	    bus->ci->chip == CY_CC_55572_CHIP_ID)
>   		return true;
>   	else
>   		return false;
> @@ -4352,6 +4360,19 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
>   			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
>   					   CY_435X_F1_MESBUSYCTRL, &err);
>   			break;
> +		case SDIO_DEVICE_ID_CYPRESS_55572:
> +			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
> +				  CYW55572_F2_WATERMARK);
> +			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
> +					   CYW55572_F2_WATERMARK, &err);
> +			devctl = brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
> +						   &err);
> +			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
> +			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
> +					   &err);
> +			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
> +					   CYW55572_F1_MESBUSYCTRL, &err);
> +			break;
>   		default:
>   			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
>   					   DEFAULT_F2_WATERMARK, &err);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 44684bf1b9acc..fc1757c505312 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -14,6 +14,7 @@
>   #define BRCM_USB_VENDOR_ID_LINKSYS	0x13b1
>   #define CY_USB_VENDOR_ID_CYPRESS	0x04b4
>   #define BRCM_PCIE_VENDOR_ID_BROADCOM	PCI_VENDOR_ID_BROADCOM
> +#define CY_PCIE_VENDOR_ID_CYPRESS	0x12be

Looked up this vendor id and it is registered to Anchor Chips Inc. which 
apparently was acquired by Cypress in 1999. Maybe good to add a 
definition in include/linux/pci_ids for this, but not sure whether to 
call it PCI_VENDOR_ID_CYPRESS or PCI_VENDOR_ID_INFINEON. 
PCI_VENDOR_ID_ANCHOR_CHIPS seems a bit stale to choose.

>   /* Chipcommon Core Chip IDs */
>   #define BRCM_CC_43143_CHIP_ID		43143
> @@ -59,6 +60,7 @@
>   #define CY_CC_43012_CHIP_ID		43012
>   #define CY_CC_43439_CHIP_ID		43439
>   #define CY_CC_43752_CHIP_ID		43752
> +#define CY_CC_55572_CHIP_ID		0xd908
>   
>   /* USB Device IDs */
>   #define BRCM_USB_43143_DEVICE_ID	0xbd1e
> @@ -97,6 +99,7 @@
>   #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>   #define BRCM_PCIE_4378_DEVICE_ID	0x4425
>   #define BRCM_PCIE_4387_DEVICE_ID	0x4433
> +#define CY_PCIE_55572_DEVICE_ID		0xbd31
>   
>   /* brcmsmac IDs */
>   #define BCM4313_D11N2G_ID	0x4727	/* 4313 802.11n 2.4G device */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
> index 9465323286673..48791ac87496d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
> @@ -21,6 +21,19 @@
>   	} \
>   }
>   
> +/* Spin at most 'ms' milliseconds with polling interval 'interval' milliseconds
> + * while 'exp' is true. Caller should explicitly test 'exp' when this completes
> + * and take appropriate error action if 'exp' is still true.
> + */
> +#define SPINWAIT_MS(exp, ms, interval) { \
> +	typeof(interval) interval_ = (interval); \
> +	uint countdown = (ms) + (interval_ - 1U); \
> +	while ((exp) && (countdown >= interval_)) { \
> +		msleep(interval_); \
> +		countdown -= interval_; \
> +	} \
> +}

Don't like this construct and it seems unnecessary. wait_event() and/or 
friends can probably do the trick. The exp/condition usage in 
wait_event() is also bit more intuitive.

>   /* osl multi-precedence packet queue */
>   #define PKTQ_LEN_DEFAULT        128	/* Max 128 packets */
>   #define PKTQ_MAX_PREC           16	/* Maximum precedence levels */
> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
> index 60b94b944e9f1..fe1cb2aeaef38 100644
> --- a/include/linux/bcma/bcma.h
> +++ b/include/linux/bcma/bcma.h
> @@ -154,6 +154,7 @@ struct bcma_host_ops {
>   #define BCMA_CORE_USB30_DEV		0x83D
>   #define BCMA_CORE_ARM_CR4		0x83E
>   #define BCMA_CORE_GCI			0x840
> +#define BCMA_CORE_SR			0x841
>   #define BCMA_CORE_CMEM			0x846	/* CNDS DDR2/3 memory controller */
>   #define BCMA_CORE_ARM_CA7		0x847
>   #define BCMA_CORE_SYS_MEM		0x849
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7cddfdac2f576..8ba3f25217a21 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -80,6 +80,7 @@
>   
>   #define SDIO_VENDOR_ID_CYPRESS			0x04b4
>   #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
> +#define SDIO_DEVICE_ID_CYPRESS_55572		0xbd31
>   
>   #define SDIO_VENDOR_ID_MARVELL			0x02df
>   #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103


