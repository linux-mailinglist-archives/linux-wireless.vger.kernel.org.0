Return-Path: <linux-wireless+bounces-10584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26593E914
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1051C20D97
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF375B669;
	Sun, 28 Jul 2024 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hf5EeC7l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCA5EE8D
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195554; cv=none; b=jOyhmzvMW//r/I+q7qM8ozRdxH/rA41kcxSSlDGfS4MU3WApEe4b1rnxg1mjVIZFJJJ9H6KIFCQ8CcqHDvBzjegmxPSimCiM8eo5YXjJc2Cy0VGaev4q9P/y+ZUqzKFCccFFMi0CPJabZNVNIxiOv4kjaDvjywUqvfA7WPrWNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195554; c=relaxed/simple;
	bh=hHKPOO3mhalLN+qc7ljl3GdqZtzmcdfz+qb2jJ/ZaPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFyiScBNIR65z4NcHMvYLutDq7x2EZy14NStZAGpXi/k2pij7o7EIn7ToCETANKKZhIelPy4YMHXKCvIv31urZLzFHLv+jiOqxCPH37Umde3PvxMg/TPR13pGx4REBZMIL3NCeUdrcsAVqaKScgQyjm4NP90eirfUwgVlIz8ZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hf5EeC7l; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d7a544e7so199547285a.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722195552; x=1722800352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5zBWRpPGDFSkwAShu8LkI8XZ339iVmlmtPtJJcytiM=;
        b=hf5EeC7l/EWGTAfZyjynLVC8pa35HZ17ADJoXZ02OTRT/1ZM17UXQevupZrfWdJnB9
         eE3Oq36bZsdwnmD+piuXAHmGiymtBPr7mfXHZ82NZvCyFcj/xczohkyqb5kMIdGsF3uW
         5qMBLhAmx4Zyo6l1Dpj95wV9kQNQnzHtNJe70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195552; x=1722800352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5zBWRpPGDFSkwAShu8LkI8XZ339iVmlmtPtJJcytiM=;
        b=kmeSPchy0rBEYQAW7k6QH1qJqvNaigPj2rgnongmheoHGkPrSYrXqijLyR8fuD+nps
         RWmAqqe/BElUqsLtfnVfHRnfjd8Sd44NGJdl2EgCCKX1pnwqPzP0qDWRdx4EBG+I5VsY
         kjydrQ7SCyLipRJaXK2HRCxU/+znJjW6JTufmBuKp8a5nOVgb1eb9yoCDUdfuTMpkgKr
         X7Ml2IoWlXE8f3t6qQA9hMdVmK+Jz1fEbXZePUlrSkDJ/LyvkqZrTwDNSZfjXdjsSTQ/
         arrr/pbJoB8bLTxGsHHRxbwe7aRtfw64GOd164zV/ryTn5VbSshbY3IthA0c/5rXgku3
         NjEQ==
X-Gm-Message-State: AOJu0YyRdGOODfHU5Vf4PNjlHpuH/vllNkBih65bL8S20cdOdE7pV6Ac
	6qErFXF9sD0+pwC5cIMrrfxRwTthIAyOEEoRsRHLMBDyEvck2RR5d4BMN2G7tQ==
X-Google-Smtp-Source: AGHT+IEat6PVvtVQ/kcrQiaarVvxMwnGLM0jGF4DJMsJ075AoEdJeIF+cUBUyVKh+LyE23ez2WNmEg==
X-Received: by 2002:a05:6214:76f:b0:6b2:b5c1:72dc with SMTP id 6a1803df08f44-6bb55af6183mr66480796d6.54.1722195552055;
        Sun, 28 Jul 2024 12:39:12 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa950a3sm45062016d6.90.2024.07.28.12.39.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:39:11 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT v2] wifi: brcmfmac: add flag for random seed during firmware download
Date: Sun, 28 Jul 2024 21:39:04 +0200
Message-Id: <20240728193904.35820-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
V2:
 - fix the patch so it compiles :-(

Hi Jacobe,

Here is a quick patch introducing driver data table with the flag for the
random seed. So for the 43752 you would add:

@@ -2710,6 +2712,7 @@ static const struct pci_device_id
brcmf_pcie_devid_table[] = {
 BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
+ BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
 BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
 BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),

Please test if this works for you. If functional you may add this patch as
is in your series. Would also like to hear from the Apple chip users if this
approach works for them as well.

Regards,
Arend
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 49 ++++++++++++++++---
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e9..e93359b20748 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -353,6 +353,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1715,14 +1716,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2394,6 +2395,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2472,9 +2504,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2660,14 +2693,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2695,9 +2728,9 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };

base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
-- 
2.32.0


