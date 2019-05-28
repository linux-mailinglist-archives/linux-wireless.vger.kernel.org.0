Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA02C011
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfE1H2k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 03:28:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54333 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfE1H2k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 03:28:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so1601419wml.4
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GpSBsODp2MZzupWmxiWG2rlbj1YiaJPnBFpLzOQgoyY=;
        b=YgucwKIZX1UE1WfssD9TqyBKMIrpDf//lere6oFVDxVezhh2xB+8qjAy+6LH9nfts0
         p8Rfvui3ePeenfoCAdJ96ry9AYqTmmYaGbm9illkxTZrs3OaypRUKhKGcvATSz+V6Lpk
         +SrRcQbLO63ECfgTdZQpHB51QnWPIaGZOpQRT1NblxpcGqEfZ2X4JIFwJqOSFCFLuuKX
         RNnDLOPYRLAUyFoiRfGU2r0Yuu20nqfOEn5PdIB4qI5ww+z9IrlncNPGl7Udu/fp2QcG
         gbERpkOiq8BWEumMBuDBvcZJw5e1EG+Nu7UI3az0HYZtJrQKPsjGmMCJ0c6fscz60uOo
         di5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GpSBsODp2MZzupWmxiWG2rlbj1YiaJPnBFpLzOQgoyY=;
        b=QVECnP71xhtmmkvChr2lHnJdhEixXLk7zmPIgX7rL+bxQ/whT85GdWBh5YPGVlS21H
         xGxDYip9JOtP+Lpbj84xd27O0V7m4licF4Srnc+ulNzX0BKa9l7BGklQqKA++7kpf8lU
         q5EEKngRyuN/jj0lT6MVWOtYwtFM+JC1BirixCViUGiKUK6WSwj9sErrJebPn5BPDm1+
         hyCH18EvoiuHYYBp/SJdBdDv5PlHI/zIRAFY77MYQwHkfnUZAGfeEAYyzbkpttdKmghS
         1AOcJhNegXOJ3daI+hPvsG2ESGstrLmr7RSY3HI/4QRIufov0dOKP3noVqWX61qL0FnV
         gYWQ==
X-Gm-Message-State: APjAAAWnoI8RmaSaQn9bj/OdARhdjBfFPGbmgb1oPoClVzLXrCq7FlCC
        8r4CYHBKfX4mVTQTg24iGdSHIA==
X-Google-Smtp-Source: APXvYqy12UfaUS5mbo0Y2745MTxlfpHoHQP85wM8t4/l/jc/5PTM3zmyxz5kGSt7xn77D50DtoivxA==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr1934385wmj.108.1559028516296;
        Tue, 28 May 2019 00:28:36 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 95sm7091070wrk.70.2019.05.28.00.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 00:28:35 -0700 (PDT)
Subject: Re: brcmfmac support for BCM4359 sdio on arm64
To:     Christian Hewitt <christianshewitt@gmail.com>,
        arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <9B1E511E-A6F7-4907-953B-537EC7F75EEE@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6381bf98-ea67-4bcf-8f36-8b6d29076eee@baylibre.com>
Date:   Tue, 28 May 2019 09:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9B1E511E-A6F7-4907-953B-537EC7F75EEE@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 28/05/2019 09:19, Christian Hewitt wrote:
> Hello Arend,
> 
> Last October Christoph Müllner reported BCM4359 SDIO issues here: https://www.spinics.net/lists/linux-wireless/msg178783.html but the investigation stalled after the needs/timescale of his project forced a change to an alternate (working) module.

Following Mullner's thread, this is what I collected with various fixes found on other repos :
===========><===================================================
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d2f788d88668..aa434b787953 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -971,6 +971,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_4373),
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 927d62b3d41b..21e947fb1537 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -681,7 +681,6 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_43569_CHIP_ID:
 	case BRCM_CC_43570_CHIP_ID:
 	case BRCM_CC_4358_CHIP_ID:
-	case BRCM_CC_4359_CHIP_ID:
 	case BRCM_CC_43602_CHIP_ID:
 	case BRCM_CC_4371_CHIP_ID:
 		return 0x180000;
@@ -691,6 +690,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4366_CHIP_ID:
 	case BRCM_CC_43664_CHIP_ID:
 		return 0x200000;
+	case BRCM_CC_4359_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
 	default:
@@ -1339,6 +1339,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 	switch (pub->chip) {
 	case BRCM_CC_4354_CHIP_ID:
 	case BRCM_CC_4356_CHIP_ID:
+	case BRCM_CC_4359_CHIP_ID:
 	case BRCM_CC_4345_CHIP_ID:
 		/* explicitly check SR engine enable bit */
 		pmu_cc3_mask = BIT(2);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index a907d7b065fa..cf90a87bda60 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -617,6 +617,7 @@ BRCMF_FW_DEF(43430A1, "brcmfmac43430-sdio");
 BRCMF_FW_DEF(43455, "brcmfmac43455-sdio");
 BRCMF_FW_DEF(4354, "brcmfmac4354-sdio");
 BRCMF_FW_DEF(4356, "brcmfmac4356-sdio");
+BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
 BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");

 static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
@@ -637,6 +638,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4345_CHIP_ID, 0xFFFFFFC0, 43455),
 	BRCMF_FW_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
+	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373)
 };

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 4224902a8e22..00e3f624baf2 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -41,6 +41,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_4354		0x4354
 #define SDIO_DEVICE_ID_BROADCOM_4356		0x4356
+#define SDIO_DEVICE_ID_BROADCOM_4359		0x4359
 #define SDIO_DEVICE_ID_CYPRESS_4373		0x4373

 #define SDIO_VENDOR_ID_INTEL			0x0089
===========><===================================================

But the driver stalls, without any errors.
I haven't activated debug traces in the brcmfmac driver to investigate further.

Neil

> 
> BCM4359 is also being used in an increasing number of Amlogic devices the Kodi focussed distro LibreELEC supports. I’m one of the maintainers for the distro and I’d like to assist/resume the investigation.
> 
> To recap: using changes from Wright Feng that can be found here https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/0050-brcmfmac-Add-support-for-BCM4359-SDIO-chipset.patch results in the BCM4359 device being identified but firmware loading fails:
> 
> [    8.557929] brcmfmac: F1 signature read @0x18000000=0x17294359
> [    8.562087] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4359-sdio for chip BCM4359/9
> [    8.775655] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> [    8.775667] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading 2048 membytes at 0x0025f0c0
> [    8.775670] brcmfmac: brcmf_sdio_download_firmware: dongle nvram file download failed
> 
> See: http://ix.io/1KfY for the full dmesg output on 5.1-rc1 kernel including a splat that may or may not be related/relevant. I am using the firmware and nvram files from https://github.com/LibreELEC/brcmfmac_sdio-firmware which match files found in several other github and public repo locations. The firmware/nvram are reported working in Android. 
> 
> BCMDHD is also reported working with the last few commits here: https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/integ-5.1-bcmdhd but LibreELEC needs to support many different boards (with many different SDIO modules) from a single OS image, so BCMDHD is not the solution we need.
> 
> One additional patch I spotted mentioning BCM4359 (also from Wright Feng) was https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/0073-non-upstream-reset-two-D11-cores-if-chip-has-two-D11.patch but it makes no difference (the dmesg log above is with this patch applied).
> 
> I’m happy building test kernels but I don’t write code so I can be fed patches and can provide logs/output as long as the instructions are fairly explicit. I’ve also CC’d LibreELEC colleague and linux-amlogic maintainer Neil Armstrong who has vastly superior skills to myself and can assist. NB: If direct access to hardware would help progress things I can easily organise remote access or get board samples shipped.
> 
> How to resume things again?
> 
> Christian
> 

