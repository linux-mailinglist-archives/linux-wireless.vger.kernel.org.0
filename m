Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE91DFCB8
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 05:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEXDlS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 23:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgEXDlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 23:41:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89587C061A0E
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 20:41:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f4so6968153pgi.10
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eMD4gjKr8w7ES8m7Hmp8yAct3lfQLGVQ1XuSFyG9tI=;
        b=O6IKWbPRvbAPxRcZ+pceLqhRgfqs87MXSJ6uuLtp1cm3lCA5/rz+OrsPJrmeHhA9af
         l6XPcNfWnet7iJXQVymQoZ/m7/rRlU+Q9ZTMKR/Mr52qnCP890Cor16tlVlwM2Mhl4Cy
         ClzvVVNWDGgir2UeztTbfiVsQT/luk9dLaLupZn9cnwOuAEA8pqeRHIAjPznpSajY6nu
         dfdCK4zRPXsppVab2u+vSlKEk4XX0/4z3t/hLgb/PBPGGJ1c06b1gz99+rMRh8gxKJlY
         ch9U9xG+++fzwUa66Fc+fglm7JJQtILd4pT+m2yjqcpBlibzuahUd+xQXi/7gRRgeGWv
         4JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eMD4gjKr8w7ES8m7Hmp8yAct3lfQLGVQ1XuSFyG9tI=;
        b=Z+ABvGQ3+qgZTYQHkifCjb3sYThSc6toLqUmg40Ti5l7iaxyO/gccikJgMRxo4GZVO
         SwPW9EutNmbydeQjwL10nQdtI7syl1fps8wYj/sfcFujdO8j9mcaq4xdzVTPSPR3DSEu
         6oEWfVkm/PsiAHWfAl/tMRHLi/Kqfa9F/y2qrTCM5WzbmF7mG4VbbU+EgReYjiDQuWop
         qRmPWTZdyamWqpUyiNIfg1ECJPsD1Y9qTZ1W9lMoJuhOdjJSE4lHVHTQq7ylywnORE8p
         sD2hqgUnLjBj5Qd4Ank4tihf3ChKqnY1CdyK753gysjgpzI3ExLFfRXfd3o2TX3aNJTz
         3wBA==
X-Gm-Message-State: AOAM533i4h5ftBujgH/iPSDZOXwr5iUbuS0dctGMu8wGS/IFmkwGAD+C
        VYUFvr+a5kAwQvms/CNhxT8RIZgE
X-Google-Smtp-Source: ABdhPJyCQWddL3N25pvS87265x5l2BRfUe1I2MLdXuJSd3WNUb8aDwvdmru8Rh5S08G+rwg0DYNdEw==
X-Received: by 2002:a62:4e91:: with SMTP id c139mr11294084pfb.285.1590291676735;
        Sat, 23 May 2020 20:41:16 -0700 (PDT)
Received: from P65xSA.lan ([128.199.164.101])
        by smtp.gmail.com with ESMTPSA id 25sm9753421pjk.50.2020.05.23.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 20:41:15 -0700 (PDT)
From:   DENG Qingfang <dqfext@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, kvalo@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
        matthias.bgg@gmail.com, royluo@google.com, ryder.lee@mediatek.com
Subject: [PATCH v2] mt76: mt7615: add support for MT7611N
Date:   Sun, 24 May 2020 11:41:10 +0800
Message-Id: <20200524034110.22576-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7611N is basically the same as MT7615N, except it only supports 5GHz
It is used by some TP-Link and Mercury wireless routers

Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
v1 -> v2:
make is_mt7615(&dev->mt76) return true for mt7611

 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 6a5ae047c63b..edac37e7847b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -111,6 +111,12 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 		return;
 	}
 
+	if (is_mt7611(&dev->mt76)) {
+		/* 5GHz only */
+		dev->mt76.cap.has_5ghz = true;
+		return;
+	}
+
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
 			eeprom[MT_EE_WIFI_CONF]);
 	switch (val) {
@@ -310,6 +316,7 @@ static void mt7615_cal_free_data(struct mt7615_dev *dev)
 		mt7622_apply_cal_free_data(dev);
 		break;
 	case 0x7615:
+	case 0x7611:
 		mt7615_apply_cal_free_data(dev);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index ebdfca64b079..4ce8b379a147 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -411,7 +411,7 @@ static inline bool is_mt7622(struct mt76_dev *dev)
 
 static inline bool is_mt7615(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7615;
+	return mt76_chip(dev) == 0x7615 || mt76_chip(dev) == 0x7611;
 }
 
 static inline bool is_mt7663(struct mt76_dev *dev)
@@ -419,6 +419,11 @@ static inline bool is_mt7663(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7663;
 }
 
+static inline bool is_mt7611(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7611;
+}
+
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 88ff14564521..b09d08d0dac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -14,6 +14,7 @@
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
 	{ PCI_DEVICE(0x14c3, 0x7663) },
+	{ PCI_DEVICE(0x14c3, 0x7611) },
 	{ },
 };
 
-- 
2.26.2

