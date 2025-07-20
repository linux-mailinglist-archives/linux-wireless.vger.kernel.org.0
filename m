Return-Path: <linux-wireless+bounces-25687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B32B0B67C
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C5B3BD953
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB0218593;
	Sun, 20 Jul 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EMJqk1A8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5E20D4E1
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022457; cv=none; b=t+v5wfDSBTAxTX/2i32Z3eD0VuXyOf7EaX5BZECZ1vL7HWR6FQKYh7N1uPDZO5BloKTV20L29X7u6C9eg8um1BV1NDcMTn+MjBUFQhw6j8aCV2ZYKzFEBbBVCKY3JjMzZBoBmlM7rjWCRm2m0IyWAd8VgK8i1uTSAjOdPzTKp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022457; c=relaxed/simple;
	bh=PNyrUBTh3IeoDHLkWclKIc7/yRnlXsHrRLGJ0vynsBY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ABucH+2Ka0mWV5pCyCheVrbWlnDQRGq9BWK64bB/BLR9uT7oqSO60RMS+vM+C3pxbx0TeXVfLlHpO/uQZ2Pk11YFnSTJrGyUlM0Mdabjjuf9cSoLtNsoIqP3kEYmttv+ZRwOD1pqCc9CS8TwSxz/0o9Frhmi2FNPyO3/mkwxHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EMJqk1A8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso605919166b.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753022454; x=1753627254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBMzMOSZ7lo/+P2xe4rb3wvuseKwsx8Sup3mujmz6Pk=;
        b=EMJqk1A8wjqoelpZMoqiggLiSgrbhbm2AQVh1z+ape/iR2xvKtvc//sE8LDwR6q1PP
         0Jd9IXh4+ATUghKqyqdYXYue7AckyEMGo4BI2MXAVI6MCaHYlcKlV0si9UjC920nkcUm
         V5R4/xb/EL+aVtt/DjjVyEdW0WYYacyofKbpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753022454; x=1753627254;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBMzMOSZ7lo/+P2xe4rb3wvuseKwsx8Sup3mujmz6Pk=;
        b=IrvyPfJ3TXeVI3gIqyy5esbNAwM7Ef0l1oZHK0d06rG04z0lq6/fSLtfood5jadcJ2
         KRP/cdiDttViwgpaxuR862uo229sfZF/VaI01CeQhu609TwtVG+/++iGAOEgbud45Ecg
         ArFGFGjZOHOxLUtIhU8HzjFBa3XB+Tu8rg5x7Pv+Wp/J3A84Vp2dMsbah/FRwvDkelJJ
         YGBlK0Tjz7QGzdC24W9TR99yKulHU3kA5g5iPGkNuMQOzLZzL9T8WKo9qk6SzyzZnFGM
         9M2fmcc9gMTSO0e/41hVyPxg98M4hIxQHXbgfgQYJ/6MB8ZOmds+RBwZlrtCQ8PkPaaC
         CiHQ==
X-Gm-Message-State: AOJu0Yzijo8Grhjfr/skrYfMvcm0UoVEHogfq9kczWkHgaBFbDZB44Ju
	8cyB+YeAl/h4BSGBjFITkgjJFVVhG9j790TopFMpni1ze74jPlNJl9W0CWXO+uRMVQ==
X-Gm-Gg: ASbGncv8Kwpvx/15+OOflcwjzCQvFDE0SmQ84AbMd6g3gqXJbLcssah4Ldd18w/aNrJ
	02qgo5BFbHSgvFxQ/V29ylrAjdsZVDOLLdyzSfvXy5gvcIsfrXS3Br2/b/2f/fBDm4jxsQqs50y
	FKFktKdx1zWhQJc2TUhH2xz067U5Qe08CEDypOIOLOrDwJ1f/evOiuv1nL+5MmDRZlEoBpWF6pP
	KsedkBlOqijRmXR758uMvDWTlabtpKiORVi1xfPJg6Gsp90nA7CBoL//8vELWkDT/UL9lqsy4CS
	oULXXWLDxYjz4kw/zv0m/59O7WG4+cPPqwGyXeFN38M+Vgy1/VGthFLtcCFy8GZFxZW0TnpRG6V
	epZ74XFOZyb5ACdp3R5shrA4ETiDRY6uxd33tCNafMQjj7kmCX99XYhqMfGqd
X-Google-Smtp-Source: AGHT+IHXLSbeFQd9moOjeqXx6dt4OA+hOWV2frgiDQ0KIJ0dndnzZzbLEWC0BTdJGjy2EYutG8pWbA==
X-Received: by 2002:a17:906:c10d:b0:ae0:68a8:bd6a with SMTP id a640c23a62f3a-aec6a4e282emr954066266b.15.1753022453836;
        Sun, 20 Jul 2025 07:40:53 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a0basm499204966b.19.2025.07.20.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 07:40:53 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Ian Lin <ian.lin@infineon.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <carter.chen@infineon.com>, <double.lo@infineon.com>, <vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Date: Sun, 20 Jul 2025 16:40:51 +0200
Message-ID: <1982847cd38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250624093453.7264-1-ian.lin@infineon.com>
References: <20250624093453.7264-1-ian.lin@infineon.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: support CYW54591 PCIE device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 24, 2025 11:36:19 AM Ian Lin <ian.lin@infineon.com> wrote:

> From: Double Lo <double.lo@cypress.com>
>
> CYW54591 is a variant of BCM4355 silicon with the same chipid. In the
> chipid-fwname mapping table, apply chiprev 13 to identify CYW54591.
> Skip reading OTP process for CYW chip since it contains vendor specific
> information which is not common for cypress.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Double Lo <double.lo@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
> .../broadcom/brcm80211/brcmfmac/pcie.c        | 21 ++++++++++++++-----
> .../broadcom/brcm80211/include/brcm_hw_ids.h  |  1 +
> 2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 9747928a3650..6327f4eca500 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
> BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
> BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
> BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
> +BRCMF_FW_CLM_DEF(54591, "brcmfmac54591-pcie");
>
> /* firmware config files */
> MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -88,6 +89,7 @@ static const struct brcmf_firmware_mapping 
> brcmf_pcie_fwnames[] = {
>  BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
>  BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
>  BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x000007FF, 4355),
> + BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x00002000, 54591),
>  BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFF800, 4355C1), /* rev ID 12/C2 
>  seen */
>  BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
>  BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
> @@ -2522,10 +2524,19 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct 
> pci_device_id *id)
>  if (ret)
>  goto fail_bus;
>
> - ret = brcmf_pcie_read_otp(devinfo);
> - if (ret) {
> - brcmf_err(bus, "failed to parse OTP\n");
> - goto fail_brcmf;
> + /* otp read operation */
> + switch (bus->fwvid) {
> + case BRCMF_FWVENDOR_WCC:
> + case BRCMF_FWVENDOR_BCA:
> + ret = brcmf_pcie_read_otp(devinfo);
> + if (ret) {
> + brcmf_err(bus, "failed to parse OTP\n");
> + goto fail_brcmf;
> + }
> + break;
> + case BRCMF_FWVENDOR_CYW:
> + default:
> + break;
>  }
>
> #ifdef DEBUG
> @@ -2740,7 +2751,7 @@ static const struct pci_device_id 
> brcmf_pcie_devid_table[] = {
>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
>  BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
> -
> + BRCMF_PCIE_DEVICE(CY_PCIE_54591_DEVICE_ID, CYW),
>  { /* end: all zeroes */ }
> };
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h 
> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index c1e22c589d85..5195c6c1a5b5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -99,6 +99,7 @@
> #define BRCM_PCIE_4377_DEVICE_ID 0x4488
> #define BRCM_PCIE_4378_DEVICE_ID 0x4425
> #define BRCM_PCIE_4387_DEVICE_ID 0x4433
> +#define CY_PCIE_54591_DEVICE_ID 0x4417
>
> /* brcmsmac IDs */
> #define BCM4313_D11N2G_ID 0x4727 /* 4313 802.11n 2.4G device */
> --
> 2.25.0




