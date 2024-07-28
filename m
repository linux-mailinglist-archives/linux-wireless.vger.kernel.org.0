Return-Path: <linux-wireless+bounces-10582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E093E901
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2EB20B19
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805055D477;
	Sun, 28 Jul 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="adyyaQnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B7548E1
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722194407; cv=none; b=La383Qcj5I0mgK3WdOvX9whMUtqPqpzg0ntLWVbhgozboNnUN2s/AyAgwB+0GirT0zqM/dITM6CT212Qd8MTlbwroitwgVjf5CBVDZg0PJMG7Wc9z0iINodOtoF/uUEIsX8cklenb1qoqRy5W5UCAukDopvSx0Rz89Bev3sdBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722194407; c=relaxed/simple;
	bh=4uhY9QSQluC5veWCW52nvxW9Ot67YhwpDfMQ6BtF4yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jlTvIZRoBlcj/xxeqPbGc09BMf50+UX+3PEkwbKXUuICdcZoCC8brFtw9oJjdYmHkaGjHncHB7XE4TXJRJWk1MoBSO3beN+ybBZUPK1m0vVo5+n7Qv908nOLfa2nWmskxqZ36+02NXhC0mm88lUN3Ft0KCMttjsIgzvTs2a+37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=adyyaQnf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6659e81bc68so13892707b3.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722194405; x=1722799205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaGvHaFDYqYYE38Od9dSfPqzalwpWmJRDN4xycskOcI=;
        b=adyyaQnfqPfIWW4JuwRPC62rUq5kKjd63WISchn0Njv+jY1NKGcWTQ9WVmcIgHgel6
         GQ3U8QGa8NtS/G8LuVwiAXYlyeMfA+pIZbaF6XxkYKKIGtHs9v7MtLIvntIa04VtWw7W
         aKwxYLgoAPSeZ6qmyzOB0/Fhu868nDVo+f+jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722194405; x=1722799205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaGvHaFDYqYYE38Od9dSfPqzalwpWmJRDN4xycskOcI=;
        b=llGsMssqXt+yUYVUV+npVK/ItwN0roE9f2geuGTCwNV9FahnsEh66xg79SvA/v1YCi
         +mgRxPPR8w6/Frqr+JXzZZwcDC9lrUtryzK36BGZGnTabHDRol1DZUgiHvjXRqDzFx88
         UPNUgyA+cVPi14OfDGtnUGkk2F4Euk75aDmEr70L0ocDXn50cyjeQ5yxnD0DfiwvCydr
         Ps6Z4/5uUzTlXkGMHajRl7IqRXfbNgk5NHxOrhg0UwFto5tpNJa0iMINrh8eJZDkFy17
         70LxiBISfv6gCCv0pwNMn7H9bhV3ndDdepKhKqrcmiwm1HR0UmI8wjnnpygtiRcxyjMo
         Hqxw==
X-Gm-Message-State: AOJu0Yz+DmAaG3QfaRDeO/R0q5Sd+qoU9WzbtiVE2PNVWTYl0CkvYJbI
	+lT2/UEd4DxIoJOCqg35zE6VpyIPnSIetomVFNFxY0NI3ZljSlQ6v04IQJwAQzF3n6kUYYDE5CH
	05tPp
X-Google-Smtp-Source: AGHT+IGC+6oypx4TeffXuzG/FKm36auS3sNNPU3SD6oSXQaE6mJoCppHpHGPsMywWnJjX4fmii6hpQ==
X-Received: by 2002:a81:a20d:0:b0:65b:cdab:2678 with SMTP id 00721157ae682-67a06a0d11cmr66592917b3.15.1722194404599;
        Sun, 28 Jul 2024 12:20:04 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead822039sm5618882b3a.110.2024.07.28.12.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:20:04 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT] wifi: brcmfmac: add flag for random seed during firmware download
Date: Sun, 28 Jul 2024 21:18:45 +0200
Message-Id: <20240728191845.12577-1-arend.vanspriel@broadcom.com>
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
is in your series. Would also like to here from the Apple chip users if this
approach works for them as well.

Regards,
Arend
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 47 ++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e9..0ccbe2e77a0d 100644
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
+	}
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
@@ -2667,7 +2700,7 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
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


