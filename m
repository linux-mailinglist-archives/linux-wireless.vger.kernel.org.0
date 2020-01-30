Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F33B14DD18
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgA3Orc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:32 -0500
Received: from nbd.name ([46.4.11.11]:57428 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgA3OrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OdlrI33Ci7s+Vz4HFH/UWnXNQ5ECY+loeEYRx7fVtaM=; b=txnYJVymhkRkDIJ+HeDxi90fV4
        2AjxjiL06qF1iASeU1iHgWGobbZcb9izrnLC4DjR56rtWCLGMNge3/aX2OiKgU7MtqGsXKDFyxWz/
        BMegmgLP6JMUld1s9Hx4sEIL/ACPAMEoHVAsM1KYAXvmMb9Dx0RmKZPuD8vq8yvvDM8U=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6F-0001VL-Kd
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EBBAB7AE468B; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] mt76: mt7615: split up firmware loading functions
Date:   Thu, 30 Jan 2020 15:47:07 +0100
Message-Id: <20200130144718.14298-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for adding MT7622 support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index cb1de4e1efd0..097d3fc365f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -345,7 +345,7 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 	return 0;
 }
 
-static int mt7615_load_patch(struct mt7615_dev *dev)
+static int mt7615_load_patch(struct mt7615_dev *dev, const char *name)
 {
 	const struct mt7615_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
@@ -362,7 +362,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, MT7615_ROM_PATCH, dev->mt76.dev);
+	ret = request_firmware(&fw, name, dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -458,13 +458,13 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 	return 0;
 }
 
-static int mt7615_load_ram(struct mt7615_dev *dev)
+static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 {
 	const struct mt7615_fw_trailer *hdr;
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, MT7615_FIRMWARE_N9, dev->mt76.dev);
+	ret = request_firmware(&fw, name, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -491,9 +491,18 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 		goto out;
 	}
 
+out:
 	release_firmware(fw);
+	return ret;
+}
+
+static int mt7615_load_cr4(struct mt7615_dev *dev, const char *name)
+{
+	const struct mt7615_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
 
-	ret = request_firmware(&fw, MT7615_FIRMWARE_CR4, dev->mt76.dev);
+	ret = request_firmware(&fw, name, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -529,6 +538,17 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 	return ret;
 }
 
+static int mt7615_load_ram(struct mt7615_dev *dev)
+{
+	int ret;
+
+	ret = mt7615_load_n9(dev, MT7615_FIRMWARE_N9);
+	if (ret)
+		return ret;
+
+	return mt7615_load_cr4(dev, MT7615_FIRMWARE_CR4);
+}
+
 static int mt7615_load_firmware(struct mt7615_dev *dev)
 {
 	int ret;
@@ -541,7 +561,7 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	ret = mt7615_load_patch(dev);
+	ret = mt7615_load_patch(dev, MT7615_ROM_PATCH);
 	if (ret)
 		return ret;
 
-- 
2.24.0

