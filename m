Return-Path: <linux-wireless+bounces-12860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2D978E67
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 08:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A49286DC6
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E93CF65;
	Sat, 14 Sep 2024 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SZAe1Q0P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685741805E
	for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726295109; cv=none; b=boBdOW0ldpCkNP+VjaMG8gHQE++KWh+5PWPKhGi6YzqdmdsekkgIX8dmNn7BmicM7NH3tgpB/lmPmE/Wrkpml+HuPNlK66SJ5JR8oylN9VyFyrUWxQoTpYL4TPEl6ScC92DD/u0FthSYvDeVkA9V5Cex69zYiPLKCygQufHtfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726295109; c=relaxed/simple;
	bh=X4poh1/JZdw4tAaW1KnC8TieReWBAoHsjNt8GRITKcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCBirV/XgJqis4/OP+fWthGlL/NylMFh4IcWsQURYbqcTvSqG6E3+vaF8wf3qRiEh3ZVZSAH5ECwXz0ZHeizw3lKAwH1uZx4XZGkoeKxZvewnOvRTnTpcNTY3Ey1zDtVhlpYuKXNPnKdZk4+V0adyOGyTNvROrEjFHc1wRvxBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SZAe1Q0P; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-457ce5fda1aso23705281cf.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726295106; x=1726899906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0WEFcx/QRmZ6v9lVinSe01ZfFL/4WUXSRaJewYVgktA=;
        b=SZAe1Q0Pv5Es51+2tevsapFmlDlqYUYt5MSOPtduSt60+I+mK8+95W9rlubsqIqcHF
         dCLWbHphHppYh9zv+EyswxA5Svu5zoJAMdNrCPlL/NOyHgUsNj6XxRoObGy5FPjnE7M0
         tKz6WEZse8flsnau1z+7RGDDFlCZk2A4GizX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726295106; x=1726899906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WEFcx/QRmZ6v9lVinSe01ZfFL/4WUXSRaJewYVgktA=;
        b=Y/jKBP57EVXvtVJ+2qU4A6O/c0+7yVbLki/dus7UlAb8UGbtyb11GFpTrt1Ij3tU9a
         rMFtZZ0kyaCYSVMghF/+bM1Ji7qtJ/vb4So3BUPWipDaxHhemDpggFxfPr6drozyJEvR
         n43KCWS8PaxMzoA6wY1TKyo3zOBGrwVd+pG3fTjP5JWtjAqpOqzVypfLDboTtP0V0xLV
         9C6brqahx4pTabdc6+jMSyqIv3cmw5+ga+ACVo544by++AGI05QnwDtLwfSxMWfF3Xea
         0OflrjYIEnx5zlX/hPhGnHHRg9QDf50JOON2ByXiw1YCKa/riNWMHcMb33iD7Y9qP4sQ
         LMdA==
X-Forwarded-Encrypted: i=1; AJvYcCUNkM5pVE8J2no0mt31mx/C4JUdi8wbprNCWRg/aZy8h6fwuk2S1WmXw/ay09yJK1bs645DWlXnFqG45OEyVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3rxyQkEOvjdizkJIDhsvYbNvifpsry+lPGvVubSEwPc+L7wY
	XT6mddzk/YA/9tOblZjyHou5CoQbCI3bGoXS9uFZxQ8t0rz9XJCAbaSPrR3CUQ==
X-Google-Smtp-Source: AGHT+IG9WFPwEWjPMfpj/vvmJ+gV+Ef++SVq0BMpDRmQ+Di4yyNstUCHgV7HI9uFdlDcibNE+QKD8g==
X-Received: by 2002:a05:622a:5a85:b0:458:534f:fa06 with SMTP id d75a77b69052e-4586042d376mr166566331cf.50.1726295105991;
        Fri, 13 Sep 2024 23:25:05 -0700 (PDT)
Received: from [10.229.42.215] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad1f649sm4121371cf.81.2024.09.13.23.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 23:25:05 -0700 (PDT)
Message-ID: <5691c7f8-561f-4c1c-bf36-6fd8276f9b49@broadcom.com>
Date: Sat, 14 Sep 2024 08:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: brcmfmac: add support for TRX firmware
 download
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Double Lo <Double.Lo@infineon.com>, Duoming Zhou <duoming@zju.edu.cn>,
 Erick Archer <erick.archer@outlook.com>, Kalle Valo <kvalo@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
References: <20240909203133.74777-1-marex@denx.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240909203133.74777-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/2024 10:31 PM, Marek Vasut wrote:
> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> Add support to download TRX firmware for PCIe and SDIO.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>

The sob tag is a certification by that person so strictly speaking you 
can not add this line. Don't know what is best here. I will leave it to 
Kalle to decide.

> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
> ---
> NOTE: This is downstream upport from
>        https://github.com/Infineon/ifx-wireless-drivers/
>        branch RTM/v5.15.58-Indrik / tag release-v5.15.58-2024_0514
> - ba34bf4816f9 ("brcmfmac: add support for TRX firmware download")
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
> V2: Include SoB line from Chung-Hsien with both cypress and infineon address
> ---
>   .../broadcom/brcm80211/brcmfmac/pcie.c        | 12 +++++-
>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 20 +++++++---
>   .../broadcom/brcm80211/brcmfmac/trxhdr.h      | 38 +++++++++++++++++++
>   3 files changed, 63 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index ce482a3877e90..058a742d17eda 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -42,6 +42,7 @@
>   #include "chip.h"
>   #include "core.h"
>   #include "common.h"
> +#include "trxhdr.h"

Maybe the definitions can simply be put in firmware.h as it is closely 
related.

>   
>   enum brcmf_pcie_state {
> @@ -1684,6 +1685,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   					u32 nvram_len)
>   {
>   	struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
> +	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
> +	u32 fw_size;
>   	u32 sharedram_addr;
>   	u32 sharedram_addr_written;
>   	u32 loop_counter;
> @@ -1697,8 +1700,13 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   		return err;
>   
>   	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
> -	memcpy_toio(devinfo->tcm + devinfo->ci->rambase,
> -		    (void *)fw->data, fw->size);
> +	address = devinfo->ci->rambase;
> +	fw_size = fw->size;
> +	if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
> +		address -= sizeof(struct trx_header_le);
> +		fw_size = le32_to_cpu(trx->len);

trx->len needs to be validated against fw->size and return an error, eg. 
-EINVAL, if it fails.

> +	}
> +	memcpy_toio(devinfo->tcm + address, (void *)fw->data, fw_size);
>   
>   	resetintr = get_unaligned_le32(fw->data);
>   	release_firmware(fw);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 1461dc453ac22..08881e366cae2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -35,6 +35,7 @@
>   #include "core.h"
>   #include "common.h"
>   #include "bcdc.h"
> +#include "trxhdr.h"
>   
>   #define DCMD_RESP_TIMEOUT	msecs_to_jiffies(2500)
>   #define CTL_DONE_TIMEOUT	msecs_to_jiffies(2500)
> @@ -3346,17 +3347,26 @@ brcmf_sdio_verifymemory(struct brcmf_sdio_dev *sdiodev, u32 ram_addr,
>   static int brcmf_sdio_download_code_file(struct brcmf_sdio *bus,
>   					 const struct firmware *fw)
>   {
> +	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
> +	u32 fw_size;
> +	u32 address;
>   	int err;
>   
>   	brcmf_dbg(TRACE, "Enter\n");
>   
> -	err = brcmf_sdiod_ramrw(bus->sdiodev, true, bus->ci->rambase,
> -				(u8 *)fw->data, fw->size);
> +	address = bus->ci->rambase;
> +	fw_size = fw->size;
> +	if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
> +		address -= sizeof(struct trx_header_le);
> +		fw_size = le32_to_cpu(trx->len);

same here.

> +	}
> +	err = brcmf_sdiod_ramrw(bus->sdiodev, true, address,
> +				(u8 *)fw->data, fw_size);
>   	if (err)
>   		brcmf_err("error %d on writing %d membytes at 0x%08x\n",
> -			  err, (int)fw->size, bus->ci->rambase);
> -	else if (!brcmf_sdio_verifymemory(bus->sdiodev, bus->ci->rambase,
> -					  (u8 *)fw->data, fw->size))
> +			  err, (int)fw_size, address);
> +	else if (!brcmf_sdio_verifymemory(bus->sdiodev, address,
> +					  (u8 *)fw->data, fw_size))
>   		err = -EIO;
>   
>   	return err;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h
> new file mode 100644
> index 0000000000000..0411c7c7ffb99
> --- /dev/null
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h
> @@ -0,0 +1,38 @@

[...]

> +struct trx_header_le {
> +	__le32 magic;		/* "HDR0" */
> +	__le32 len;		/* Length of file including header */
> +	__le32 crc32;		/* CRC from flag_version to end of file */
> +	__le32 flag_version;	/* 0:15 flags, 16:31 version */

Let's make this two separate __le16 fields as the comment does.

> +	__le32 offsets[TRX_MAX_OFFSET];	/* Offsets of partitions */
> +};
> +
> +#endif /* BRCMFMAC_TRXHDR_H */


