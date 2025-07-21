Return-Path: <linux-wireless+bounces-25693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E799AB0B985
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D137A839E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47A13B284;
	Mon, 21 Jul 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcVZCEF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8735953
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057219; cv=none; b=Ci/8fhvkTg9ghFDiN9lgx43uul3Ittv+bI1XfFuxOpgV6018D8NdbEDzL39ax1Qs9pDrO3gX7z8OecIm9T2HrkeBlbs98ZvzCVfO5SJmwNtVd+hcbcQP6XSoabIKCqEnNahbzKZ2IZgdQl8AqoxVe9GzpOAyRIqwvtDKuK9GUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057219; c=relaxed/simple;
	bh=RVCflc28HrDj2hLiRMK1P7IWUwXasSMRQYZdeIGk0xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTkaAm4MAxeHYOpfI8kXHKFYIZ4stnrTrZ+opUvHGMU+FQQvfVGeTiKv7SQK23NBeKKEMkXjCUU5gt+3xlhGnAUfGUpAxKYO3VgkMkrfm54goSmacPjFoDgoeUZ06ZcJyLOBBvxXBLlKR1hXjXNRKqRxflLqI/rVfNhYXwU/14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcVZCEF/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749248d06faso3182848b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057217; x=1753662017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdixPCCcgmOdZQlUhugTbfg4GUBbj2RcLvD/k2RXy+4=;
        b=QcVZCEF/KCdB1XKH+hXGydW9aPMnFZOcE0IhdeAhB+503b2Fq95Yv/uIUbHJ8xu/6Y
         pzqGp6IS/EsfB1p0+nkftOUcVjr4AtYhJL6tzfgKz/UG7K0DyTZ/uaXK+YvDI67DJryJ
         NNa27wDPwhUMzFUC9PK/YA7junkEG+Lb0YNczqyJk6518jL9gVSPpoOK6A8wCsKR5Glo
         +2NsxUaJwOQBXTehXFvVKmeWjJ3r4iKDD/cpBW1Plf5Y5MotcLRbO6vOvcnVXoXqXqCl
         5XR9uQMhK2hBr9Frs1wKAdIwVUt6bZ8s3YIR8qmAuQMdKdc3KE4/QBABDRp3EDf/c5ef
         pPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057217; x=1753662017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdixPCCcgmOdZQlUhugTbfg4GUBbj2RcLvD/k2RXy+4=;
        b=tC3GgsvoNWYipatOBu88lq3N7YVnl7fFKHXe96jFiq0cxuDAxYwHMdq9/1N5fGxO0N
         +WrJ/zlr6JqZK1ob8uZIoUHVmxdXRpvcMgliG2UIwx7GmMyJVAalqT093x9SQMBAKrNZ
         vOAe5gcwCvV8CQHP9eCI9lglmagSehaIau0hBU+63BrEwDrxkJKFXsrHpeVnmgFfGTyB
         eDHQQwt6X4vQKQgQi2hteJ46k8N0jwULdHD13912Nio7oglvPq4h3TQeRc5Mtg1yMxZy
         GmUuQ0FfXWZAgEYYcM8UPq9dKJBBp71kPGQJt79I5kpBD3+oeIRWF5hnx68ru25vChhX
         OiCg==
X-Gm-Message-State: AOJu0YzFUFnyTj/bMR7StnaA3IaoaaWtVeDLejFNqD/8xq3+HYMSvsSC
	P4cfGaPN+dWI6A1amKmraBaO3FCtWeahH/yR0Mam0vR/U2/9TPy2KKirwtIztYCc
X-Gm-Gg: ASbGncsU1WJdKF76hKwdj14XnxNVJEbxywiyfJiBF3+/I9Dp6oCtoWy3IjAwBKSFQ7Y
	sdU+W4lV5EUKMua897rlXfeoZv+jGg91iGduiLGHquMiM+0c5TAsg82h5Gd+/n/7ceZQ41aAzIU
	s0xaW6LDsfWv9Vnbl8L/h5mJt0z1p2txbNufyYIEFEr21R+KieKQMRej/QwlDmpCp9JAcPwdFih
	3lMWznbdDqxhFiULi85IULhjTGV166vuz58bTqg963evHgbzDUjyU/PluAmgfXo8Yzo+6Gxd5YF
	ZMm42k91rpUDCUsAYmo7VS4rDAnKBftwoQb6i7/4tOXIrywmIoO4fRP0ZDSzrdfVZFRaeWYuhRn
	WzcpvI63T73sGxvOwm3yYkVgg8CBcqZtAt+I3Ojuk1Aj1eW1GPQjAIbVtNrI+UDQMRlNUTLWe4a
	w=
X-Google-Smtp-Source: AGHT+IEk/a0GlAgk2VUIjrRpOu/a/POuT1Bk36XkD0J8yT8oryxvw3ScjYZqQWlV5H59DsefvJnfVQ==
X-Received: by 2002:a05:6a00:985:b0:749:b41:2976 with SMTP id d2e1a72fcca58-75848c18a0emr22853122b3a.3.1753057216990;
        Sun, 20 Jul 2025 17:20:16 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:16 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [PATCH 3/5] fix dma register and add firmware ready check
Date: Sun, 20 Jul 2025 17:19:03 -0700
Message-Id: <20250721001905.11614-4-tnguy3333@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721001905.11614-1-tnguy3333@gmail.com>
References: <20250721001905.11614-1-tnguy3333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

correct DMA registers and poll for firmware state, to fix "failed to get patch semaphore" timeout

Signed-off-by: tnguy3333 <tnguy3333@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7902/mcu.c   | 62 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7902/mt7902.h    |  6 +-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
index dfb1b9ef9..677c2c165 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
@@ -634,11 +634,71 @@ int mt7902_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 				 &data, sizeof(data), false);
 }
 
+int mt7902_firmware_state(struct mt792x_dev *dev, bool wa)
+{
+	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE,
+			       wa ? FW_STATE_RDY : FW_STATE_FW_DOWNLOAD);
+
+	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
+			    state, 1000)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+int mt7902_load_firmware(struct mt792x_dev *dev)
+{
+	int ret;
+    
+    /* make sure fw is download state */
+	if (mt7902_firmware_state(dev, false)) {
+		/* restart firmware once */
+		mt76_connac_mcu_restart(&dev->mt76);
+		ret = mt7902_firmware_state(dev, false);
+		if (ret) {
+			dev_err(dev->mt76.dev,
+				"Firmware is not ready for download\n");
+			return ret;
+		}
+	}
+
+	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
+	if (ret)
+		return ret;
+
+	if (mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt792x_mcu_fw_pmctrl(dev);
+		if (!ret)
+			ret = __mt792x_mcu_drv_pmctrl(dev);
+	}
+
+	ret = mt76_connac2_load_ram(&dev->mt76, mt792x_ram_name(dev), NULL);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+#ifdef CONFIG_PM
+	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
+#endif /* CONFIG_PM */
+
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
 int mt7902_run_firmware(struct mt792x_dev *dev)
 {
 	int err;
 
-	err = mt792x_load_firmware(dev);
+	err = mt7902_load_firmware(dev);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
index 03beb683b..debd18034 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
@@ -107,8 +107,8 @@ struct mt7902_sdio_intr {
 enum mt7902_txq_id {
 	MT7902_TXQ_BAND0,
 	MT7902_TXQ_BAND1,
-	MT7902_TXQ_FWDL = 16,
-	MT7902_TXQ_MCU_WM,
+	MT7902_TXQ_MCU_WM = 15,
+	MT7902_TXQ_FWDL,
 };
 
 enum mt7902_rxq_id {
@@ -188,6 +188,8 @@ u32 mt7902_reg_map(struct mt792x_dev *dev, u32 addr);
 int __mt7902_start(struct mt792x_phy *phy);
 int mt7902_register_device(struct mt792x_dev *dev);
 void mt7902_unregister_device(struct mt792x_dev *dev);
+int mt7902_firmware_state(struct mt792x_dev *dev, bool wa);
+int mt7902_load_firmware(struct mt792x_dev *dev);
 int mt7902_run_firmware(struct mt792x_dev *dev);
 int mt7902_set_channel(struct mt76_phy *mphy);
 int mt7902_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
-- 
2.39.5


