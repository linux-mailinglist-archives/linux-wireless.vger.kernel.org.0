Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83B55B7F6F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiINDdA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiINDc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:32:56 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD85AA24
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663126375; x=1694662375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JuZx8DbYHaBtlIHKF8qGaC+5yOtpysp2iLMAexRPrSQ=;
  b=hOhMCz+eInqcs/nW7i+0izz3RGolcXvHk/soIj+v7GbH2zBZ9Tz7+ngM
   9PcuRvMQGi7dJsfT/b2WPfAUoF/UYHK70tV7NSa/+vYjMsLolD034o8gi
   DyHkQiVlfP9bKh/mq34QsZet69HkhWbtDilDafmannXXHmedqvnsS7Zmu
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="141111522"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="141111522"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:31:49 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:31:49 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 05:31:48 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 14 Sep 2022 05:31:48 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="258419691"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="258419691"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 14 Sep 2022 05:31:48 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Sep 2022
 22:31:46 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 22A48100367;
        Tue, 13 Sep 2022 22:31:46 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 1FE1B980794; Tue, 13 Sep 2022 22:31:46 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 4/5] brcmfmac: add 54591 PCIE device
Date:   Tue, 13 Sep 2022 22:31:01 -0500
Message-ID: <20220914033102.27893-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220914033102.27893-1-ian.lin@infineon.com>
References: <20220914033102.27893-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

Support 54591 PCIE device.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 22 +++++++++++++++++--
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 1c54274ff626..61744dbbab84 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -60,6 +60,7 @@ BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
 BRCMF_FW_DEF(4355, "brcmfmac89459-pcie");
+BRCMF_FW_DEF(54591, "brcmfmac54591-pcie");
 
 /* firmware config files */
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
@@ -89,6 +90,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
 	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
+	BRCMF_FW_ENTRY(CY_CC_54591_CHIP_ID, 0xFFFFFFFF, 54591),
 };
 
 #define BRCMF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
@@ -1388,12 +1390,21 @@ static
 int brcmf_pcie_get_fwname(struct device *dev, const char *ext, u8 *fw_name)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct brcmf_pciedev_info *devinfo = buspub->devinfo;
 	struct brcmf_fw_request *fwreq;
 	struct brcmf_fw_name fwnames[] = {
 		{ ext, fw_name },
 	};
+	u32 chip;
 
-	fwreq = brcmf_fw_alloc_request(bus_if->chip, bus_if->chiprev,
+	if (devinfo->ci->chip == CY_CC_89459_CHIP_ID &&
+	    devinfo->pdev->device == CY_PCIE_54591_DEVICE_ID)
+		chip = CY_CC_54591_CHIP_ID;
+	else
+		chip = bus_if->chip;
+
+	fwreq = brcmf_fw_alloc_request(chip, bus_if->chiprev,
 				       brcmf_pcie_fwnames,
 				       ARRAY_SIZE(brcmf_pcie_fwnames),
 				       fwnames, ARRAY_SIZE(fwnames));
@@ -1833,8 +1844,14 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_info *devinfo)
 		{ ".bin", devinfo->fw_name },
 		{ ".txt", devinfo->nvram_name },
 	};
+	u32 chip;
 
-	fwreq = brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev,
+	if (devinfo->ci->chip == CY_CC_89459_CHIP_ID &&
+	    devinfo->pdev->device == CY_PCIE_54591_DEVICE_ID)
+		chip = CY_CC_54591_CHIP_ID;
+	else
+		chip = devinfo->ci->chip;
+	fwreq = brcmf_fw_alloc_request(chip, devinfo->ci->chiprev,
 				       brcmf_pcie_fwnames,
 				       ARRAY_SIZE(brcmf_pcie_fwnames),
 				       fwnames, ARRAY_SIZE(fwnames));
@@ -2109,6 +2126,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(CY_PCIE_89459_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(CY_PCIE_89459_RAW_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(CY_PCIE_54591_DEVICE_ID),
 	{ /* end: all zeroes */ }
 };
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index e9e7f8dd65e3..32e9107e40b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -55,6 +55,7 @@
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43752_CHIP_ID		43752
 #define CY_CC_89459_CHIP_ID		0x4355
+#define CY_CC_54591_CHIP_ID		0x54591
 
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
@@ -90,6 +91,7 @@
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define CY_PCIE_89459_DEVICE_ID         0x4415
 #define CY_PCIE_89459_RAW_DEVICE_ID     0x4355
+#define CY_PCIE_54591_DEVICE_ID         0x4417
 
 /* brcmsmac IDs */
 #define BCM4313_D11N2G_ID	0x4727	/* 4313 802.11n 2.4G device */
-- 
2.25.0

