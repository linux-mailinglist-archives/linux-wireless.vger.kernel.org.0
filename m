Return-Path: <linux-wireless+bounces-25696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C314B0B988
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426DE1896B59
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B723774;
	Mon, 21 Jul 2025 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh7m85pT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49883C30
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057224; cv=none; b=U8R33chgRqWzgZSy5+rDgQfm7/5C9QfMpc3K0xSrG24b7ReZJC9VtQEcJNrFEaqhg6KHvrFsOCHce06Q5jOsM7Y6DZWpnWkzMPqH6dZPD4qt7PGcMeqWRn2ZyvanIpTcWKwcgMk6OCr8lyQSEZB3AiBxvPuZ5kZ1TNd0OY6PZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057224; c=relaxed/simple;
	bh=G4Z1qLbCu92dN0sSwQpuS3xhR3pe2itFPIUzcac4hKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjqT10+bEAGrhP8Zvv8W6WyZZXXQ0qdelcAvnaAQSdQIN9ej274UZ52H3DeTBtUVrGPPg8n6fDsTpSR4Sy0rLZ36WLVzI8cKNGNPlb0TEKBRJGw2Dn3T3F5dYoX5U+N0V+wJRaGhEk4bLvw/v7Y7YPcrOj0MSl//D4+hKHoyrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh7m85pT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2261991b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057216; x=1753662016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3c/KYzRNChQqEUjoSGCNlBf+tZ4SyZeQaj56qfrD88=;
        b=Fh7m85pTqGGFeyEIts1KZPCpTWGkbbSZN8y/sDAdVnZjGF+VR21/36MU+vW95YFIwk
         1NDrH5+pccGyOmDUEQWP+6Pd9SlcKXASMsD4gX+8f/6xgOveAFViuerUUghNN3AGbeWO
         UuH5QSDWRHFiKV36f7dNmhjxECuxq99bYS5RHq78Cn8Hipbuky8BCCJ3ooIfBGEwLytV
         5oXeV2iSrVvQbJre4PsxScLXp/wfxun2bF8fTjMIBOghb3YKeH9YUGxUfSXD8i4AnK+F
         FZKHbxdSdKLSt1VPc4dhKVbmGN137xDUm9ImxLNaclQJuK9+cm4Lig2GB/xBb9MV9CuU
         82eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057216; x=1753662016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3c/KYzRNChQqEUjoSGCNlBf+tZ4SyZeQaj56qfrD88=;
        b=jf1/MpYp79lKWGKOZH3gHg/F+9i5Cx0q74DGNX6MItRiTQ+17pzpiEmFdAMDUOlkBN
         RUaxMGXrCh/sJat48ihY1JuiKV0kCwDdVylhzRrl9kIXsaiF1jCOWwtnNkxSmL6tYUIp
         0YizlROpVQ3K+nkYMmPd3yRpiFia3DDZtLJN2fjvVz1Tqk1ZVCv6egdKvw+b45QEi9fy
         pUZZA2esS6PmKZTG8uW6OK+7fRnRaVZEwxcLgUTL9mO0V6bZuOPx3+mdHfx6JKXUgqnm
         Su/TBC9XDmTPaO8+O2LTN5cgUmBVwv721xEXddov+JosPIgddo81E1sr2mf0LDtQWt6E
         DUxA==
X-Gm-Message-State: AOJu0YwSDK0FaixxSjYAmQu5Nxd62mSguSKxsT0Odr8kzlyjJmrKuFbK
	b3Vfvzxj/CNkZEYBpCp1AQ8HuuFh+KkLbhS/XfLIshy+kHKg0+tRU2vnR7hRkGQH
X-Gm-Gg: ASbGncu4Q3ajsc+eOGZORkcBnYbRII5xNcDMH8V1UTDzOEVKowfk2gEVcUqeZKqvIP6
	Php552W8SjS7aX9Px/hfg6gphB/fImxOc0p9xLNFTj/fATNy+/hAiTiHJHeSYhrAtqdnZUrxrUh
	KJBMcoVN2QHqtrFj98li9gOv8XnCpwfqZeIo/zDFOFR8J2u7Mp7crStzDoROkIqFlnve2DVootn
	lZMBk6sW5BQxKdt/t/0ormy+OGB3mZblcBZOmrkLxu0SQIiZU1TcA8fqaVhO7W8UfUQIh1jHFgC
	5qXKU8uQJb8STzkNbeqcxy4abRjMwwRBIUDprjJNMuuuU9ri9Bwt9twQlMxSeOO94ILmjh+KvNl
	MFdaFUMj+TNxQwit4LouuBbQYn0QBjriGoitZzl134++TTADCVHxZNfLpbmOkg07kP0zd6n8cs+
	w=
X-Google-Smtp-Source: AGHT+IF9nMPRApYTsB85ewXmdOJm2lo24F0NA+JC2kxsCRWAf0+hnnB5D5dxm4qRPQIofhDI24lHKA==
X-Received: by 2002:a05:6a00:140f:b0:748:fe3a:49f2 with SMTP id d2e1a72fcca58-75725084f4emr25915612b3a.21.1753057214303;
        Sun, 20 Jul 2025 17:20:14 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:13 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [PATCH 1/5] copy mt7921 to use as mt7902 baseline
Date: Sun, 20 Jul 2025 17:19:01 -0700
Message-Id: <20250721001905.11614-2-tnguy3333@gmail.com>
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

copy and rename the mt7921 driver to use as the starting point for the mt7902

Signed-off-by: tnguy3333 <tnguy3333@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7902/Kconfig |   37 +
 .../wireless/mediatek/mt76/mt7902/Makefile    |   12 +
 .../wireless/mediatek/mt76/mt7902/debugfs.c   |  296 +++
 .../net/wireless/mediatek/mt76/mt7902/init.c  |  348 ++++
 .../net/wireless/mediatek/mt76/mt7902/mac.c   |  866 +++++++++
 .../net/wireless/mediatek/mt76/mt7902/main.c  | 1589 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7902/mcu.c   | 1492 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7902/mcu.h   |  120 ++
 .../wireless/mediatek/mt76/mt7902/mt7902.h    |  338 ++++
 .../net/wireless/mediatek/mt76/mt7902/pci.c   |  585 ++++++
 .../wireless/mediatek/mt76/mt7902/pci_mac.c   |  129 ++
 .../wireless/mediatek/mt76/mt7902/pci_mcu.c   |   63 +
 .../net/wireless/mediatek/mt76/mt7902/regs.h  |   81 +
 .../net/wireless/mediatek/mt76/mt7902/sdio.c  |  331 ++++
 .../wireless/mediatek/mt76/mt7902/sdio_mac.c  |  141 ++
 .../wireless/mediatek/mt76/mt7902/sdio_mcu.c  |  175 ++
 .../wireless/mediatek/mt76/mt7902/testmode.c  |  196 ++
 .../net/wireless/mediatek/mt76/mt7902/usb.c   |  345 ++++
 18 files changed, 7144 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/testmode.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/usb.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7902/Kconfig
new file mode 100644
index 000000000..3ce547e46
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: ISC
+config MT7902_COMMON
+	tristate
+	select MT792x_LIB
+	select WANT_DEV_COREDUMP
+
+config MT7902E
+	tristate "MediaTek MT7902E (PCIe) support"
+	select MT7902_COMMON
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7902E 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
+
+config MT7902S
+	tristate "MediaTek MT7902S (SDIO) support"
+	select MT76_SDIO
+	select MT7902_COMMON
+	depends on MAC80211
+	depends on MMC
+	help
+	  This adds support for MT7902S 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
+
+config MT7902U
+	tristate "MediaTek MT7902U (USB) support"
+	select MT792x_USB
+	select MT7902_COMMON
+	depends on MAC80211
+	depends on USB
+	help
+	  This adds support for MT7902U 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/Makefile b/drivers/net/wireless/mediatek/mt76/mt7902/Makefile
new file mode 100644
index 000000000..ffd05e9b9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+
+obj-$(CONFIG_MT7902_COMMON) += mt7902-common.o
+obj-$(CONFIG_MT7902E) += mt7902e.o
+obj-$(CONFIG_MT7902S) += mt7902s.o
+obj-$(CONFIG_MT7902U) += mt7902u.o
+
+mt7902-common-y := mac.o mcu.o main.o init.o debugfs.o
+mt7902-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
+mt7902e-y := pci.o pci_mac.o pci_mcu.o
+mt7902s-y := sdio.o sdio_mac.o sdio_mcu.o
+mt7902u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c
new file mode 100644
index 000000000..323e3b7af
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7902.h"
+
+static int
+mt7902_reg_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+
+	mt792x_mutex_acquire(dev);
+	mt76_wr(dev, dev->mt76.debugfs_reg, val);
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7902_reg_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	mt792x_mutex_acquire(dev);
+	*val = mt76_rr(dev, dev->mt76.debugfs_reg);
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt7902_reg_get, mt7902_reg_set,
+			 "0x%08llx\n");
+static int
+mt7902_fw_debug_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+
+	mt792x_mutex_acquire(dev);
+
+	dev->fw_debug = (u8)val;
+	mt7902_mcu_fw_log_2_host(dev, dev->fw_debug);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7902_fw_debug_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->fw_debug;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7902_fw_debug_get,
+			 mt7902_fw_debug_set, "%lld\n");
+
+DEFINE_SHOW_ATTRIBUTE(mt792x_tx_stats);
+
+static void
+mt7902_seq_puts_array(struct seq_file *file, const char *str,
+		      s8 *val, int len)
+{
+	int i;
+
+	seq_printf(file, "%-16s:", str);
+	for (i = 0; i < len; i++)
+		if (val[i] == 127)
+			seq_printf(file, " %6s", "N.A");
+		else
+			seq_printf(file, " %6d", val[i]);
+	seq_puts(file, "\n");
+}
+
+#define mt7902_print_txpwr_entry(prefix, rate)				\
+({									\
+	mt7902_seq_puts_array(s, #prefix " (user)",			\
+			      txpwr.data[TXPWR_USER].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_USER].rate)); \
+	mt7902_seq_puts_array(s, #prefix " (eeprom)",			\
+			      txpwr.data[TXPWR_EEPROM].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_EEPROM].rate)); \
+	mt7902_seq_puts_array(s, #prefix " (tmac)",			\
+			      txpwr.data[TXPWR_MAC].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_MAC].rate));	\
+})
+
+static int
+mt7902_txpwr(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
+	struct mt7902_txpwr txpwr;
+	int ret;
+
+	mt792x_mutex_acquire(dev);
+	ret = mt7902_get_txpwr_info(dev, &txpwr);
+	mt792x_mutex_release(dev);
+
+	if (ret)
+		return ret;
+
+	seq_printf(s, "Tx power table (channel %d)\n", txpwr.ch);
+	seq_printf(s, "%-16s  %6s %6s %6s %6s\n",
+		   " ", "1m", "2m", "5m", "11m");
+	mt7902_print_txpwr_entry(CCK, cck);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "6m", "9m", "12m", "18m", "24m", "36m",
+		   "48m", "54m");
+	mt7902_print_txpwr_entry(OFDM, ofdm);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7");
+	mt7902_print_txpwr_entry(HT20, ht20);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs32");
+	mt7902_print_txpwr_entry(HT40, ht40);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11");
+	mt7902_print_txpwr_entry(VHT20, vht20);
+	mt7902_print_txpwr_entry(VHT40, vht40);
+	mt7902_print_txpwr_entry(VHT80, vht80);
+	mt7902_print_txpwr_entry(VHT160, vht160);
+	mt7902_print_txpwr_entry(HE26, he26);
+	mt7902_print_txpwr_entry(HE52, he52);
+	mt7902_print_txpwr_entry(HE106, he106);
+	mt7902_print_txpwr_entry(HE242, he242);
+	mt7902_print_txpwr_entry(HE484, he484);
+	mt7902_print_txpwr_entry(HE996, he996);
+	mt7902_print_txpwr_entry(HE996x2, he996x2);
+
+	return 0;
+}
+
+static int
+mt7902_pm_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (val == pm->enable_user)
+		goto out;
+
+	if (!pm->enable_user) {
+		pm->stats.last_wake_event = jiffies;
+		pm->stats.last_doze_event = jiffies;
+	}
+	/* make sure the chip is awake here and ps_work is scheduled
+	 * just at end of the this routine.
+	 */
+	pm->enable = false;
+	mt76_connac_pm_wake(&dev->mphy, pm);
+
+	pm->enable_user = val;
+	mt7902_set_runtime_pm(dev);
+	mt76_connac_power_save_sched(&dev->mphy, pm);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7902_pm_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->pm.enable_user;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7902_pm_get, mt7902_pm_set, "%lld\n");
+
+static int
+mt7902_deep_sleep_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(dev->mphy.hw->conf.flags & IEEE80211_CONF_MONITOR);
+	bool enable = !!val;
+
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+	if (pm->ds_enable_user == enable)
+		goto out;
+
+	pm->ds_enable_user = enable;
+	pm->ds_enable = enable && !monitor;
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+out:
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7902_deep_sleep_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->pm.ds_enable_user;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, mt7902_deep_sleep_get,
+			 mt7902_deep_sleep_set, "%lld\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt792x_pm_idle_timeout_get,
+			 mt792x_pm_idle_timeout_set, "%lld\n");
+
+static int mt7902_chip_reset(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	int ret = 0;
+
+	switch (val) {
+	case 1:
+		/* Reset wifisys directly. */
+		mt792x_reset(&dev->mt76);
+		break;
+	default:
+		/* Collect the core dump before reset wifisys. */
+		mt792x_mutex_acquire(dev);
+		ret = mt76_connac_mcu_chip_config(&dev->mt76);
+		mt792x_mutex_release(dev);
+		break;
+	}
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7902_chip_reset, "%lld\n");
+
+static int
+mt7902s_sched_quota_read(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	seq_printf(s, "pse_data_quota\t%d\n", sdio->sched.pse_data_quota);
+	seq_printf(s, "ple_data_quota\t%d\n", sdio->sched.ple_data_quota);
+	seq_printf(s, "pse_mcu_quota\t%d\n", sdio->sched.pse_mcu_quota);
+	seq_printf(s, "sched_deficit\t%d\n", sdio->sched.deficit);
+
+	return 0;
+}
+
+int mt7902_init_debugfs(struct mt792x_dev *dev)
+{
+	struct dentry *dir;
+
+	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
+	if (!dir)
+		return -ENOMEM;
+
+	if (mt76_is_mmio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt792x_queues_read);
+	else
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt76_queues_read);
+
+	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
+				    mt792x_queues_acq);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
+				    mt7902_txpwr);
+	debugfs_create_file("tx_stats", 0400, dir, dev, &mt792x_tx_stats_fops);
+	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
+	debugfs_create_file("idle-timeout", 0600, dir, dev,
+			    &fops_pm_idle_timeout);
+	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
+				    mt792x_pm_stats);
+	debugfs_create_file("deep-sleep", 0600, dir, dev, &fops_ds);
+	if (mt76_is_sdio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "sched-quota", dir,
+					    mt7902s_sched_quota_read);
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/init.c b/drivers/net/wireless/mediatek/mt76/mt7902/init.c
new file mode 100644
index 000000000..7ad140e3a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/init.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
+#include <linux/firmware.h>
+#include "mt7902.h"
+#include "../mt76_connac2_mac.h"
+#include "mcu.h"
+
+static ssize_t mt7902_thermal_temp_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	switch (to_sensor_dev_attr(attr)->index) {
+	case 0: {
+		struct mt792x_phy *phy = dev_get_drvdata(dev);
+		struct mt792x_dev *mdev = phy->dev;
+		int temperature;
+
+		mt792x_mutex_acquire(mdev);
+		temperature = mt7902_mcu_get_temperature(phy);
+		mt792x_mutex_release(mdev);
+
+		if (temperature < 0)
+			return temperature;
+		/* display in millidegree Celsius */
+		return sprintf(buf, "%u\n", temperature * 1000);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7902_thermal_temp, 0);
+
+static struct attribute *mt7902_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mt7902_hwmon);
+
+static int mt7902_thermal_init(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct device *hwmon;
+	const char *name;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7902_%s",
+			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
+
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
+						       mt7902_hwmon_groups);
+	return PTR_ERR_OR_ZERO(hwmon);
+}
+
+static void
+mt7902_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
+{
+#define IS_UNII_INVALID(idx, sfreq, efreq) \
+	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct device_node *np, *band_np;
+	struct ieee80211_channel *ch;
+	int i, cfreq;
+
+	np = mt76_find_power_limits_node(mdev);
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	band_np = np ? of_get_child_by_name(np, "txpower-5g") : NULL;
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+			continue;
+		}
+
+		/* UNII-4 */
+		if (IS_UNII_INVALID(0, 5845, 5925))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	band_np = np ? of_get_child_by_name(np, "txpower-6g") : NULL;
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+			continue;
+		}
+
+		/* UNII-5/6/7/8 */
+		if (IS_UNII_INVALID(1, 5925, 6425) ||
+		    IS_UNII_INVALID(2, 6425, 6525) ||
+		    IS_UNII_INVALID(3, 6525, 6875) ||
+		    IS_UNII_INVALID(4, 6875, 7125))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+}
+
+void mt7902_regd_update(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_hw *hw = mdev->hw;
+	struct wiphy *wiphy = hw->wiphy;
+
+	mt7902_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7902_regd_channel_update(wiphy, dev);
+	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt7902_set_tx_sar_pwr(hw, NULL);
+}
+EXPORT_SYMBOL_GPL(mt7902_regd_update);
+
+static void
+mt7902_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+	dev->country_ie_env = request->country_ie_env;
+
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
+			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+		else
+			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
+	if (pm->suspended)
+		return;
+
+	dev->regd_in_progress = true;
+
+	mt792x_mutex_acquire(dev);
+	mt7902_regd_update(dev);
+	mt792x_mutex_release(dev);
+
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
+}
+
+int mt7902_mac_init(struct mt792x_dev *dev)
+{
+	int i;
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
+	/* enable hardware de-agg */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+	/* enable hardware rx header translation */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
+
+	for (i = 0; i < MT792x_WTBL_SIZE; i++)
+		mt7902_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt792x_mac_init_band(dev, i);
+
+	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
+}
+EXPORT_SYMBOL_GPL(mt7902_mac_init);
+
+static int __mt7902_init_hardware(struct mt792x_dev *dev)
+{
+	int ret;
+
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	ret = mt792x_mcu_init(dev);
+	if (ret)
+		goto out;
+
+	mt76_eeprom_override(&dev->mphy);
+
+	ret = mt7902_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	ret = mt7902_mac_init(dev);
+out:
+	return ret;
+}
+
+static int mt7902_init_hardware(struct mt792x_dev *dev)
+{
+	int ret, i;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	for (i = 0; i < MT792x_MCU_INIT_RETRY_COUNT; i++) {
+		ret = __mt7902_init_hardware(dev);
+		if (!ret)
+			break;
+
+		mt792x_init_reset(dev);
+	}
+
+	if (i == MT792x_MCU_INIT_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "hardware init failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mt7902_init_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      init_work);
+	int ret;
+
+	ret = mt7902_init_hardware(dev);
+	if (ret)
+		return;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7902_set_stream_he_caps(&dev->phy);
+	mt792x_config_mac_addr_list(dev);
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret) {
+		dev_err(dev->mt76.dev, "register device failed\n");
+		return;
+	}
+
+	ret = mt7902_init_debugfs(dev);
+	if (ret) {
+		dev_err(dev->mt76.dev, "register debugfs failed\n");
+		return;
+	}
+
+	ret = mt7902_thermal_init(&dev->phy);
+	if (ret) {
+		dev_err(dev->mt76.dev, "thermal init failed\n");
+		return;
+	}
+
+	/* we support chip reset now */
+	dev->hw_init_done = true;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+}
+
+int mt7902_register_device(struct mt792x_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.tx_worker.fn = mt792x_tx_worker;
+
+	INIT_DELAYED_WORK(&dev->pm.ps_work, mt792x_pm_power_save_work);
+	INIT_WORK(&dev->pm.wake_work, mt792x_pm_wake_work);
+	spin_lock_init(&dev->pm.wake.lock);
+	mutex_init(&dev->pm.mutex);
+	init_waitqueue_head(&dev->pm.wait);
+	init_waitqueue_head(&dev->wait);
+	if (mt76_is_sdio(&dev->mt76))
+		init_waitqueue_head(&dev->mt76.sdio.wait);
+	spin_lock_init(&dev->pm.txq_lock);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt792x_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7902_scan_work);
+	INIT_DELAYED_WORK(&dev->coredump.work, mt7902_coredump_work);
+#if IS_ENABLED(CONFIG_IPV6)
+	INIT_WORK(&dev->ipv6_ns_work, mt7902_set_ipv6_ns_work);
+	skb_queue_head_init(&dev->ipv6_ns_list);
+#endif
+	skb_queue_head_init(&dev->phy.scan_event_list);
+	skb_queue_head_init(&dev->coredump.msg_list);
+
+	INIT_WORK(&dev->reset_work, mt7902_mac_reset_work);
+	INIT_WORK(&dev->init_work, mt7902_init_work);
+
+	INIT_WORK(&dev->phy.roc_work, mt7902_roc_work);
+	timer_setup(&dev->phy.roc_timer, mt792x_roc_timer, 0);
+	init_waitqueue_head(&dev->phy.roc_wait);
+
+	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
+	dev->pm.stats.last_wake_event = jiffies;
+	dev->pm.stats.last_doze_event = jiffies;
+	if (!mt76_is_usb(&dev->mt76)) {
+		dev->pm.enable_user = true;
+		dev->pm.enable = true;
+		dev->pm.ds_enable_user = true;
+		dev->pm.ds_enable = true;
+	}
+
+	if (!mt76_is_mmio(&dev->mt76))
+		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+
+	mt792x_init_acpi_sar(dev);
+
+	ret = mt792x_init_wcid(dev);
+	if (ret)
+		return ret;
+
+	ret = mt792x_init_wiphy(hw);
+	if (ret)
+		return ret;
+
+	hw->wiphy->reg_notifier = mt7902_regd_notifier;
+	dev->mphy.sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+	if (is_mt7922(&dev->mt76))
+		dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+			IEEE80211_VHT_CAP_SHORT_GI_160;
+
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
+
+	queue_work(system_wq, &dev->init_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7902_register_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mac.c b/drivers/net/wireless/mediatek/mt76/mt7902/mac.c
new file mode 100644
index 000000000..d36b3c480
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mac.c
@@ -0,0 +1,866 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/devcoredump.h>
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7902.h"
+#include "../dma.h"
+#include "../mt76_connac2_mac.h"
+#include "mcu.h"
+
+#define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
+#define MT_WTBL_TXRX_RATE_G2_HE		24
+#define MT_WTBL_TXRX_RATE_G2		12
+
+#define MT_WTBL_AC0_CTT_OFFSET		20
+
+bool mt7902_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+static u32 mt7902_mac_wtbl_lmac_addr(int idx, u8 offset)
+{
+	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
+}
+
+static void mt7902_mac_sta_poll(struct mt792x_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt792x_sta *msta;
+	struct mt792x_link_sta *mlink;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	struct rate_info *rate;
+	s8 rssi[4];
+	int i;
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	while (true) {
+		bool clear = false;
+		u32 addr, val;
+		u16 idx;
+		u8 bw;
+
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->mt76.sta_poll_lock);
+			break;
+		}
+		mlink = list_first_entry(&sta_poll_list,
+					 struct mt792x_link_sta,
+					 wcid.poll_list);
+		msta = container_of(mlink, struct mt792x_sta, deflink);
+		list_del_init(&mlink->wcid.poll_list);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+		idx = mlink->wcid.idx;
+		addr = mt7902_mac_wtbl_lmac_addr(idx, MT_WTBL_AC0_CTT_OFFSET);
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = mlink->airtime_ac[i];
+			u32 rx_last = mlink->airtime_ac[i + 4];
+
+			mlink->airtime_ac[i] = mt76_rr(dev, addr);
+			mlink->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = mlink->airtime_ac[i] - tx_last;
+			rx_time[i] = mlink->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7902_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
+		}
+
+		if (!mlink->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt76_connac_lmac_mapping(i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+						       rx_cur);
+		}
+
+		/* We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &mlink->wcid.rate;
+		addr = mt7902_mac_wtbl_lmac_addr(idx,
+						 MT_WTBL_TXRX_CAP_RATE_OFFSET);
+		val = mt76_rr(dev, addr);
+
+		switch (rate->bw) {
+		case RATE_INFO_BW_160:
+			bw = IEEE80211_STA_RX_BW_160;
+			break;
+		case RATE_INFO_BW_80:
+			bw = IEEE80211_STA_RX_BW_80;
+			break;
+		case RATE_INFO_BW_40:
+			bw = IEEE80211_STA_RX_BW_40;
+			break;
+		default:
+			bw = IEEE80211_STA_RX_BW_20;
+			break;
+		}
+
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			u8 offs = MT_WTBL_TXRX_RATE_G2_HE + 2 * bw;
+
+			rate->he_gi = (val & (0x3 << offs)) >> offs;
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val & BIT(MT_WTBL_TXRX_RATE_G2 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
+
+		/* get signal strength of resp frames (CTS/BA/ACK) */
+		addr = mt7902_mac_wtbl_lmac_addr(idx, 30);
+		val = mt76_rr(dev, addr);
+
+		rssi[0] = to_rssi(GENMASK(7, 0), val);
+		rssi[1] = to_rssi(GENMASK(15, 8), val);
+		rssi[2] = to_rssi(GENMASK(23, 16), val);
+		rssi[3] = to_rssi(GENMASK(31, 14), val);
+
+		mlink->ack_signal =
+			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
+
+		ewma_avg_signal_add(&mlink->avg_ack_signal, -mlink->ack_signal);
+	}
+}
+
+static int
+mt7902_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	bool hdr_trans, unicast, insert_ccmp_hdr = false;
+	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
+	u16 hdr_gap;
+	__le32 *rxv = NULL, *rxd = (__le32 *)skb->data;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt792x_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	u32 csum_status = *(u32 *)skb->cb;
+	u32 rxd0 = le32_to_cpu(rxd[0]);
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
+	struct mt792x_sta *msta = NULL;
+	struct mt792x_link_sta *mlink;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
+	u8 mode = 0;
+	int i, idx;
+
+	memset(status, 0, sizeof(*status));
+
+	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX)
+		return -EINVAL;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
+		return -EINVAL;
+
+	/* ICV error or CCMP/BIP/WPI MIC error */
+	if (rxd1 & MT_RXD1_NORMAL_ICV_ERR)
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+
+	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt792x_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
+		msta = container_of(mlink, struct mt792x_sta, deflink);
+		mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
+	}
+
+	mt792x_get_status_freq_info(status, chfreq);
+
+	switch (status->band) {
+	case NL80211_BAND_5GHZ:
+		sband = &mphy->sband_5g.sband;
+		break;
+	case NL80211_BAND_6GHZ:
+		sband = &mphy->sband_6g.sband;
+		break;
+	default:
+		sband = &mphy->sband_2g.sband;
+		break;
+	}
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 6;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
+		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
+		qos_ctl = FIELD_GET(MT_RXD8_QOS_CTL, v2);
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->timestamp = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->timestamp) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->timestamp;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v0, v1;
+		int ret;
+
+		rxv = rxd;
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v0 = le32_to_cpu(rxv[0]);
+		v1 = le32_to_cpu(rxv[1]);
+
+		if (v0 & MT_PRXV_HT_AD_CODE)
+			status->enc_flags |= RX_ENC_FLAG_LDPC;
+
+		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
+						    rxv, &mode);
+		if (ret < 0)
+			return ret;
+
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			rxd += 6;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+
+			rxv = rxd;
+			/* Monitor mode would use RCPI described in GROUP 5
+			 * instead.
+			 */
+			v1 = le32_to_cpu(rxv[0]);
+
+			rxd += 12;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+		}
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		status->signal = -128;
+		for (i = 0; i < hweight8(mphy->antenna_mask); i++) {
+			if (!(status->chains & BIT(i)) ||
+			    status->chain_signal[i] >= 0)
+				continue;
+
+			status->signal = max(status->signal,
+					     status->chain_signal[i]);
+		}
+	}
+
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+	}
+
+	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
+	if (hdr_trans && ieee80211_has_morefrags(fc)) {
+		struct ieee80211_vif *vif;
+		int err;
+
+		if (!msta || !msta->vif)
+			return -EINVAL;
+
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		err = mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);
+		if (err)
+			return err;
+
+		hdr_trans = false;
+	} else {
+		skb_pull(skb, hdr_gap);
+		if (!hdr_trans && status->amsdu) {
+			memmove(skb->data + 2, skb->data,
+				ieee80211_get_hdrlen_from_skb(skb));
+			skb_pull(skb, 2);
+		}
+	}
+
+	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr;
+
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
+
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag |= RX_FLAG_8023;
+	}
+
+	mt792x_mac_assoc_rssi(dev, skb);
+
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
+		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
+
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
+		return 0;
+
+	status->aggr = unicast && !ieee80211_is_qos_nullfunc(fc);
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
+	status->qos_ctl = qos_ctl;
+
+	return 0;
+}
+
+void mt7902_mac_add_txs(struct mt792x_dev *dev, void *data)
+{
+	struct mt792x_link_sta *mlink;
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u8 pid;
+
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+		return;
+
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT792x_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = mt76_wcid_ptr(dev, wcidx);
+	if (!wcid)
+		goto out;
+
+	mlink = container_of(wcid, struct mt792x_link_sta, wcid);
+
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
+	if (!wcid->sta)
+		goto out;
+
+	mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
+
+out:
+	rcu_read_unlock();
+}
+
+static void mt7902_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
+{
+	struct mt76_connac_tx_free *free = data;
+	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid = NULL;
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
+	LIST_HEAD(free_list);
+	bool wake = false;
+	u8 i, count;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+
+	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
+	if (WARN_ON_ONCE((void *)&tx_info[count] > end))
+		return;
+
+	for (i = 0; i < count; i++) {
+		u32 msdu, info = le32_to_cpu(tx_info[i]);
+		u8 stat;
+
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		if (info & MT_TX_FREE_PAIR) {
+			struct mt792x_link_sta *mlink;
+			u16 idx;
+
+			count++;
+			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			wcid = mt76_wcid_ptr(dev, idx);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			mlink = container_of(wcid, struct mt792x_link_sta, wcid);
+			mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
+			continue;
+		}
+
+		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
+
+		if (wcid) {
+			wcid->stats.tx_retries +=
+				FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+			wcid->stats.tx_failed += !!stat;
+		}
+
+		txwi = mt76_token_release(mdev, msdu, &wake);
+		if (!txwi)
+			continue;
+
+		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
+	}
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+
+	rcu_read_lock();
+	mt7902_mac_sta_poll(dev);
+	rcu_read_unlock();
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+}
+
+bool mt7902_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		/* PKT_TYPE_TXRX_NOTIFY can be received only by mmio devices */
+		mt7902_mac_tx_free(dev, data, len); /* mmio */
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7902_mac_add_txs(dev, rxd);
+		return false;
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7902_rx_check);
+
+void mt7902_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb, u32 *info)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
+	enum rx_pkt_type type;
+	u16 flag;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	flag = le32_get_bits(rxd[0], MT_RXD0_PKT_FLAG);
+
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		/* PKT_TYPE_TXRX_NOTIFY can be received only by mmio devices */
+		mt7902_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7902_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7902_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_NORMAL_MCU:
+	case PKT_TYPE_NORMAL:
+		if (!mt7902_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7902_queue_rx_skb);
+
+static void
+mt7902_vif_connect_iter(void *priv, u8 *mac,
+			struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mvif->phy->dev;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_disconnect(vif, true);
+
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+				    &mvif->bss_conf.mt76,
+				    &mvif->sta.deflink.wcid, true);
+	mt7902_mcu_set_tx(dev, vif);
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
+					    true, NULL);
+		mt7902_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_NONE);
+		mt7902_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	}
+}
+
+/* system error recovery */
+void mt7902_mac_reset_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      reset_work);
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, ret;
+
+	dev_dbg(dev->mt76.dev, "chip reset\n");
+	set_bit(MT76_RESET, &dev->mphy.state);
+	dev->hw_full_reset = true;
+	ieee80211_stop_queues(hw);
+
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	for (i = 0; i < 10; i++) {
+		mutex_lock(&dev->mt76.mutex);
+		ret = mt792x_dev_reset(dev);
+		mutex_unlock(&dev->mt76.mutex);
+
+		if (!ret)
+			break;
+	}
+
+	if (i == 10)
+		dev_err(dev->mt76.dev, "chip reset failed\n");
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &dev->mphy.state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(dev->mphy.hw, &info);
+	}
+
+	dev->hw_full_reset = false;
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	pm->suspended = false;
+	ieee80211_wake_queues(hw);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7902_vif_connect_iter, NULL);
+	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
+}
+
+void mt7902_coredump_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev;
+	char *dump, *data;
+
+	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
+						coredump.work.work);
+
+	if (time_is_after_jiffies(dev->coredump.last_activity +
+				  4 * MT76_CONNAC_COREDUMP_TIMEOUT)) {
+		queue_delayed_work(dev->mt76.wq, &dev->coredump.work,
+				   MT76_CONNAC_COREDUMP_TIMEOUT);
+		return;
+	}
+
+	dump = vzalloc(MT76_CONNAC_COREDUMP_SZ);
+	data = dump;
+
+	while (true) {
+		struct sk_buff *skb;
+
+		spin_lock_bh(&dev->mt76.lock);
+		skb = __skb_dequeue(&dev->coredump.msg_list);
+		spin_unlock_bh(&dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+			dev_kfree_skb(skb);
+			continue;
+		}
+
+		memcpy(data, skb->data, skb->len);
+		data += skb->len;
+
+		dev_kfree_skb(skb);
+	}
+
+	if (dump)
+		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
+			      GFP_KERNEL);
+
+	mt792x_reset(&dev->mt76);
+}
+
+/* usb_sdio */
+static void
+mt7902_usb_sdio_write_txwi(struct mt792x_dev *dev, struct mt76_wcid *wcid,
+			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
+			   struct ieee80211_key_conf *key, int pid,
+			   struct sk_buff *skb)
+{
+	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
+
+	memset(txwi, 0, MT_SDIO_TXD_SIZE);
+	mt76_connac2_mac_write_txwi(&dev->mt76, txwi, skb, wcid, key, pid, qid, 0);
+	skb_push(skb, MT_SDIO_TXD_SIZE);
+}
+
+int mt7902_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct sk_buff *skb = tx_info->skb;
+	int err, pad, pktid, type;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->deflink.last_txs = jiffies;
+		}
+	}
+
+	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	mt7902_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
+
+	type = mt76_is_sdio(mdev) ? MT7902_SDIO_DATA : 0;
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, type);
+	pad = round_up(skb->len, 4) - skb->len;
+	if (mt76_is_usb(mdev))
+		pad += 4;
+
+	err = mt76_skb_adjust_pad(skb, pad);
+	if (err)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pktid);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7902_usb_sdio_tx_prepare_skb);
+
+void mt7902_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e)
+{
+	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
+	unsigned int headroom = MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+	u16 idx;
+
+	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	wcid = __mt76_wcid_ptr(mdev, idx);
+	sta = wcid_to_sta(wcid);
+
+	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt76_connac2_tx_check_aggr(sta, txwi);
+
+	skb_pull(e->skb, headroom);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt7902_usb_sdio_tx_complete_skb);
+
+bool mt7902_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+
+	mt792x_mutex_acquire(dev);
+	mt7902_mac_sta_poll(dev);
+	mt792x_mutex_release(dev);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mt7902_usb_sdio_tx_status_data);
+
+#if IS_ENABLED(CONFIG_IPV6)
+void mt7902_set_ipv6_ns_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      ipv6_ns_work);
+	struct sk_buff *skb;
+	int ret = 0;
+
+	do {
+		skb = skb_dequeue(&dev->ipv6_ns_list);
+
+		if (!skb)
+			break;
+
+		mt792x_mutex_acquire(dev);
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_UNI_CMD(OFFLOAD), true);
+		mt792x_mutex_release(dev);
+
+	} while (!ret);
+
+	if (ret)
+		skb_queue_purge(&dev->ipv6_ns_list);
+}
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/main.c b/drivers/net/wireless/mediatek/mt76/mt7902/main.c
new file mode 100644
index 000000000..841b3309a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/main.c
@@ -0,0 +1,1589 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <net/ipv6.h>
+#include "mt7902.h"
+#include "mcu.h"
+
+static int
+mt7902_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0;
+	int nss = hweight8(phy->mt76->chainmask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+			IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			}
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[4] |=
+				IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+				IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+			he_cap_elem->phy_cap_info[5] |=
+				IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+				IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+				he_cap_elem->phy_cap_info[8] |=
+					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
+			}
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		if (is_mt7922(phy->mt76->dev)) {
+			he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+			he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		}
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+					       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			struct ieee80211_supported_band *sband =
+				&phy->mt76->sband_5g.sband;
+			struct ieee80211_sta_vht_cap *vht_cap = &sband->vht_cap;
+			struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
+			u32 exp;
+			u16 cap;
+
+			cap = u16_encode_bits(ht_cap->ampdu_density,
+					IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+			exp = u32_get_bits(vht_cap->cap,
+				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+			exp = u32_get_bits(vht_cap->cap,
+					   IEEE80211_VHT_CAP_MAX_MPDU_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+			if (vht_cap->cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
+			if (vht_cap->cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7902_set_stream_he_caps(struct mt792x_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7902_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		_ieee80211_set_sband_iftype_data(band, data, n);
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7902_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		_ieee80211_set_sband_iftype_data(band, data, n);
+
+		if (phy->mt76->cap.has_6ghz) {
+			data = phy->iftype[NL80211_BAND_6GHZ];
+			n = mt7902_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+			band = &phy->mt76->sband_6g.sband;
+			_ieee80211_set_sband_iftype_data(band, data, n);
+		}
+	}
+}
+
+int __mt7902_start(struct mt792x_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	int err;
+
+	err = mt76_connac_mcu_set_mac_enable(mphy->dev, 0, true, false);
+	if (err)
+		return err;
+
+	err = mt76_connac_mcu_set_channel_domain(mphy);
+	if (err)
+		return err;
+
+	err = mt7902_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
+	if (err)
+		return err;
+
+	err = mt7902_set_tx_sar_pwr(mphy->hw, NULL);
+	if (err)
+		return err;
+
+	mt792x_mac_reset_counters(phy);
+	set_bit(MT76_STATE_RUNNING, &mphy->state);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT792x_WATCHDOG_TIME);
+	if (mt76_is_mmio(mphy->dev)) {
+		err = mt7902_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_LED_CTRL_ENABLE);
+		if (err)
+			return err;
+
+		err = mt7902_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_ON_LED);
+		if (err)
+			return err;
+	}
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN) {
+		mt7902_mcu_wf_rf_pin_ctrl(phy, WF_RF_PIN_INIT);
+		wiphy_rfkill_start_polling(mphy->hw->wiphy);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__mt7902_start);
+
+static int mt7902_start(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int err;
+
+	mt792x_mutex_acquire(phy->dev);
+	err = __mt7902_start(phy);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static void mt7902_stop(struct ieee80211_hw *hw, bool suspend)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	if (mt76_is_mmio(&dev->mt76)) {
+		mt792x_mutex_acquire(dev);
+		err = mt7902_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
+		mt792x_mutex_release(dev);
+		if (err)
+			return;
+	}
+
+	mt792x_stop(hw, false);
+}
+
+static int
+mt7902_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt76_txq *mtxq;
+	int idx, ret = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	mvif->bss_conf.mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->bss_conf.mt76.idx >= MT792x_MAX_INTERFACES) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
+	mvif->phy = phy;
+	mvif->bss_conf.vif = mvif;
+	mvif->bss_conf.mt76.band_idx = 0;
+	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->bss_conf.mt76,
+					  &mvif->sta.deflink.wcid, true);
+	if (ret)
+		goto out;
+
+	dev->mt76.vif_mask |= BIT_ULL(mvif->bss_conf.mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->bss_conf.mt76.omac_idx);
+
+	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
+
+	INIT_LIST_HEAD(&mvif->sta.deflink.wcid.poll_list);
+	mvif->sta.deflink.wcid.idx = idx;
+	mvif->sta.deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&mvif->sta.deflink.wcid, mvif->bss_conf.mt76.band_idx);
+
+	mt7902_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ewma_rssi_init(&mvif->bss_conf.rssi);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.deflink.wcid);
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = idx;
+	}
+
+	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
+		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+
+	INIT_WORK(&mvif->csa_work, mt7902_csa_work);
+	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
+out:
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static void mt7902_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = priv;
+
+	mt7902_mcu_abort_roc(phy, mvif, phy->roc_token_id);
+}
+
+void mt7902_roc_abort_sync(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	timer_delete_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7902_roc_iter, (void *)phy);
+}
+EXPORT_SYMBOL_GPL(mt7902_roc_abort_sync);
+
+void mt7902_roc_work(struct work_struct *work)
+{
+	struct mt792x_phy *phy;
+
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	mt792x_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7902_roc_iter, phy);
+	mt792x_mutex_release(phy->dev);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+static int mt7902_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
+{
+	int err = 0;
+
+	timer_delete_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+
+	mt792x_mutex_acquire(phy->dev);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		err = mt7902_mcu_abort_roc(phy, vif, phy->roc_token_id);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7902_set_roc(struct mt792x_phy *phy,
+			  struct mt792x_vif *vif,
+			  struct ieee80211_channel *chan,
+			  int duration,
+			  enum mt7902_roc_req type)
+{
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7902_mcu_set_roc(phy, vif, chan, duration, type,
+				 ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
+		mt7902_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7902_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int err;
+
+	mt792x_mutex_acquire(phy->dev);
+	err = mt7902_set_roc(phy, mvif, chan, duration, MT7902_ROC_REQ_ROC);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7902_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	return mt7902_abort_roc(phy, mvif);
+}
+
+int mt7902_set_channel(struct mt76_phy *mphy)
+{
+	struct mt792x_phy *phy = mphy->priv;
+	struct mt792x_dev *dev = phy->dev;
+	int ret;
+
+	mt76_connac_pm_wake(mphy, &dev->pm);
+	ret = mt7902_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
+	if (ret)
+		goto out;
+
+	mt792x_mac_set_timeing(phy);
+	mt792x_mac_reset_counters(phy);
+	phy->noise = 0;
+
+out:
+	mt76_connac_power_save_sched(mphy, &dev->pm);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT792x_WATCHDOG_TIME);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7902_set_channel);
+
+static int mt7902_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct mt76_wcid *wcid = &msta->deflink.wcid;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	int idx = key->keyidx, err = 0;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		wcid_keyidx = &wcid->hw_key_idx2;
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (!mvif->wep_sta)
+			return -EOPNOTSUPP;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mt792x_mutex_acquire(dev);
+
+	if (cmd == SET_KEY) {
+		*wcid_keyidx = idx;
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+
+		/* For security issue we don't trigger the key deletion when
+		 * reassociating. But we should trigger the deletion process
+		 * to avoid using incorrect cipher after disconnection,
+		 */
+		if (vif->type != NL80211_IFTYPE_STATION || vif->cfg.assoc)
+			goto out;
+	}
+
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
+	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->deflink.bip,
+				      key, MCU_UNI_CMD(STA_REC_UPDATE),
+				      &msta->deflink.wcid, cmd);
+	if (err)
+		goto out;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
+	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
+		err = mt76_connac_mcu_add_key(&dev->mt76, vif,
+					      &mvif->wep_sta->deflink.bip,
+					      key, MCU_UNI_CMD(STA_REC_UPDATE),
+					      &mvif->wep_sta->deflink.wcid, cmd);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7902_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	bool pm_enable = dev->pm.enable;
+	int err;
+
+	err = mt7902_mcu_set_beacon_filter(dev, vif, pm_enable);
+	if (err < 0)
+		return;
+
+	if (pm_enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
+	}
+}
+
+static void
+mt7902_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	mt7902_mcu_set_sniffer(dev, vif, monitor);
+	pm->enable = pm->enable_user && !monitor;
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+
+	if (monitor)
+		mt7902_mcu_set_beacon_filter(dev, vif, false);
+}
+
+void mt7902_set_runtime_pm(struct mt792x_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	pm->enable = pm->enable_user && !monitor;
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7902_pm_interface_iter, dev);
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+}
+
+static int mt7902_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ret = mt76_update_channel(phy->mt76);
+		if (ret)
+			return ret;
+	}
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+		ret = mt7902_set_tx_sar_pwr(hw, NULL);
+		if (ret)
+			goto out;
+	}
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		ieee80211_iterate_active_interfaces(hw,
+						    IEEE80211_IFACE_ITER_RESUME_ALL,
+						    mt7902_sniffer_interface_iter, dev);
+	}
+
+out:
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static void mt7902_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+#define MT7902_FILTER_FCSFAIL    BIT(2)
+#define MT7902_FILTER_CONTROL    BIT(5)
+#define MT7902_FILTER_OTHER_BSS  BIT(6)
+#define MT7902_FILTER_ENABLE     BIT(31)
+
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u32 flags = MT7902_FILTER_ENABLE;
+
+#define MT7902_FILTER(_fif, _type) do {			\
+		if (*total_flags & (_fif))		\
+			flags |= MT7902_FILTER_##_type;	\
+	} while (0)
+
+	MT7902_FILTER(FIF_FCSFAIL, FCSFAIL);
+	MT7902_FILTER(FIF_CONTROL, CONTROL);
+	MT7902_FILTER(FIF_OTHER_BSS, OTHER_BSS);
+
+	mt792x_mutex_acquire(dev);
+	mt7902_mcu_set_rxfilter(dev, flags, 0, 0);
+	mt792x_mutex_release(dev);
+
+	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
+}
+
+static void mt7902_bss_info_changed(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *info,
+				    u64 changed)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt792x_mac_set_timeing(phy);
+		}
+	}
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED))
+		mt7902_mcu_uni_add_beacon_offload(dev, hw, vif,
+						  info->enable_beacon);
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7902_mcu_set_tx(dev, vif);
+
+	if (changed & BSS_CHANGED_PS)
+		mt7902_mcu_uni_bss_ps(dev, vif);
+
+	if (changed & BSS_CHANGED_CQM)
+		mt7902_mcu_set_rssimonitor(dev, vif);
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7902_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
+		mt7902_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76,
+						  info);
+	}
+
+	mt792x_mutex_release(dev);
+}
+
+static void
+mt7902_calc_vif_num(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	u32 *num = priv;
+
+	if (!priv)
+		return;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		*num += 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7902_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mvif->phy;
+	struct mt792x_dev *dev = phy->dev;
+	u32 valid_vif_num = 0;
+
+	ieee80211_iterate_active_interfaces(mt76_hw(dev),
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7902_calc_vif_num, &valid_vif_num);
+
+	if (valid_vif_num > 1) {
+		phy->power_type = MT_AP_DEFAULT;
+		goto out;
+	}
+
+	if (!is_add)
+		vif->bss_conf.power_type = IEEE80211_REG_UNSET_AP;
+
+	switch (vif->bss_conf.power_type) {
+	case IEEE80211_REG_SP_AP:
+		phy->power_type = MT_AP_SP;
+		break;
+	case IEEE80211_REG_VLP_AP:
+		phy->power_type = MT_AP_VLP;
+		break;
+	case IEEE80211_REG_LPI_AP:
+		phy->power_type = MT_AP_LPI;
+		break;
+	case IEEE80211_REG_UNSET_AP:
+		phy->power_type = MT_AP_UNSET;
+		break;
+	default:
+		phy->power_type = MT_AP_DEFAULT;
+		break;
+	}
+
+out:
+	mt7902_mcu_set_clc(dev, dev->mt76.alpha2, dev->country_ie_env);
+}
+
+int mt7902_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	int ret, idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	INIT_LIST_HEAD(&msta->deflink.wcid.poll_list);
+	msta->vif = mvif;
+	msta->deflink.wcid.sta = 1;
+	msta->deflink.wcid.idx = idx;
+	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->deflink.last_txs = jiffies;
+	msta->deflink.sta = msta;
+
+	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	if (ret)
+		return ret;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mvif->wep_sta = msta;
+
+	mt7902_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ret = mt7902_mcu_sta_update(dev, sta, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+	if (ret)
+		return ret;
+
+	mt7902_regd_set_6ghz_power_type(vif, true);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7902_mac_sta_add);
+
+int mt7902_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	if (ev != MT76_STA_EVENT_ASSOC)
+	    return 0;
+
+	mt792x_mutex_acquire(dev);
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.deflink.wcid,
+					    true, mvif->bss_conf.mt76.ctx);
+
+	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
+
+	mt7902_mac_wtbl_update(dev, msta->deflink.wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	memset(msta->deflink.airtime_ac, 0, sizeof(msta->deflink.airtime_ac));
+
+	mt7902_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7902_mac_sta_event);
+
+void mt7902_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+	mt7902_roc_abort_sync(dev);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
+	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+
+	mt7902_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
+	mt7902_mac_wtbl_update(dev, msta->deflink.wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mvif->wep_sta = NULL;
+		ewma_rssi_init(&mvif->bss_conf.rssi);
+		if (!sta->tdls)
+			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
+						    &mvif->sta.deflink.wcid, false,
+						    mvif->bss_conf.mt76.ctx);
+	}
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	if (!list_empty(&msta->deflink.wcid.poll_list))
+		list_del_init(&msta->deflink.wcid.poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mt7902_regd_set_6ghz_power_type(vif, false);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+}
+EXPORT_SYMBOL_GPL(mt7902_mac_sta_remove);
+
+static int mt7902_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7902_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mt792x_mutex_acquire(dev);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
+				   params->buf_size);
+		mt7902_mcu_uni_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
+		mt7902_mcu_uni_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		mt7902_mcu_uni_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+		mt7902_mcu_uni_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->deflink.wcid.ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+		mt7902_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static int mt7902_sta_state(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    enum ieee80211_sta_state old_state,
+			    enum ieee80211_sta_state new_state)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (dev->pm.ds_enable) {
+		mt792x_mutex_acquire(dev);
+		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
+		mt792x_mutex_release(dev);
+	}
+
+	return mt76_sta_state(hw, vif, sta, old_state, new_state);
+}
+
+void mt7902_scan_work(struct work_struct *work)
+{
+	struct mt792x_phy *phy;
+
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
+						scan_work.work);
+
+	while (true) {
+		struct mt76_connac2_mcu_rxd *rxd;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		} else if (test_and_clear_bit(MT76_HW_SCANNING,
+					      &phy->mt76->state)) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			ieee80211_scan_completed(phy->mt76->hw, &info);
+		}
+		dev_kfree_skb(skb);
+	}
+}
+
+static int
+mt7902_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7902_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+
+	mt792x_mutex_acquire(dev);
+	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7902_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_sched_scan_request *req,
+			struct ieee80211_scan_ies *ies)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
+	if (err < 0)
+		goto out;
+
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7902_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7902_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		return -EINVAL;
+
+	mt792x_mutex_acquire(dev);
+
+	phy->mt76->antenna_mask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7902_set_stream_he_caps(phy);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mt7902_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt792x_mutex_acquire(dev);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7902_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int mt7902_resume(struct ieee80211_hw *hw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt76_connac_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT792x_WATCHDOG_TIME);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static void mt7902_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
+	mt792x_mutex_release(dev);
+}
+#endif /* CONFIG_PM */
+
+static void mt7902_sta_set_decap_offload(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (!msta->deflink.wcid.sta)
+		return;
+
+	mt792x_mutex_acquire(dev);
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
+
+	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->deflink.wcid,
+					     MCU_UNI_CMD(STA_REC_UPDATE));
+
+	mt792x_mutex_release(dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void mt7902_ipv6_addr_change(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct inet6_dev *idev)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct inet6_ifaddr *ifa;
+	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
+	struct sk_buff *skb;
+	u8 i, idx = 0;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.mode = 2,  /* update */
+			.option = 1, /* update only */
+		},
+	};
+
+	read_lock_bh(&idev->lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		if (ifa->flags & IFA_F_TENTATIVE)
+			continue;
+		ns_addrs[idx] = ifa->addr;
+		if (++idx >= IEEE80211_BSS_ARP_ADDR_LIST_LEN)
+			break;
+	}
+	read_unlock_bh(&idev->lock);
+
+	if (!idx)
+		return;
+
+	req_hdr.arpns.ips_num = idx;
+	req_hdr.arpns.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)
+					+ idx * sizeof(struct in6_addr));
+	skb = __mt76_mcu_msg_alloc(&dev->mt76, &req_hdr,
+			sizeof(req_hdr) + idx * sizeof(struct in6_addr),
+			sizeof(req_hdr), GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	for (i = 0; i < idx; i++)
+		skb_put_data(skb, &ns_addrs[i].in6_u, sizeof(struct in6_addr));
+
+	skb_queue_tail(&dev->ipv6_ns_list, skb);
+
+	ieee80211_queue_work(dev->mt76.hw, &dev->ipv6_ns_work);
+}
+#endif
+
+int mt7902_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *mphy = hw->priv;
+
+	if (sar) {
+		int err = mt76_init_sar_power(hw, sar);
+
+		if (err)
+			return err;
+	}
+	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
+
+	return mt76_connac_mcu_set_rate_txpower(mphy);
+}
+
+static int mt7902_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt7902_mcu_set_clc(dev, dev->mt76.alpha2,
+				 dev->country_ie_env);
+	if (err < 0)
+		goto out;
+
+	err = mt7902_set_tx_sar_pwr(hw, sar);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7902_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt7902_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7902_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.deflink.wcid,
+					  true, mvif->bss_conf.mt76.ctx);
+	if (err)
+		goto out;
+
+	err = mt7902_mcu_set_bss_pm(dev, vif, true);
+	if (err)
+		goto out;
+
+	err = mt7902_mcu_sta_update(dev, NULL, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7902_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7902_mcu_set_bss_pm(dev, vif, false);
+	if (err)
+		goto out;
+
+	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.deflink.wcid, false,
+				    mvif->bss_conf.mt76.ctx);
+
+out:
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7902_add_chanctx(struct ieee80211_hw *hw,
+		   struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	dev->new_ctx = ctx;
+	return 0;
+}
+
+static void
+mt7902_remove_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (dev->new_ctx == ctx)
+		dev->new_ctx = NULL;
+}
+
+static void
+mt7902_change_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx,
+		      u32 changed)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct ieee80211_vif *vif;
+	struct mt792x_vif *mvif;
+
+	if (!mctx->bss_conf)
+		return;
+
+	mvif = container_of(mctx->bss_conf, struct mt792x_vif, bss_conf);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	mt792x_mutex_acquire(phy->dev);
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		mt7902_mcu_config_sniffer(mvif, ctx);
+	else
+		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+	mt792x_mutex_release(phy->dev);
+}
+
+static void mt7902_mgd_prepare_tx(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_prep_tx_info *info)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u16 duration = info->duration ? info->duration :
+		       jiffies_to_msecs(HZ);
+
+	mt792x_mutex_acquire(dev);
+	mt7902_set_roc(mvif->phy, mvif, mvif->bss_conf.mt76.ctx->def.chan, duration,
+		       MT7902_ROC_REQ_JOIN);
+	mt792x_mutex_release(dev);
+}
+
+static void mt7902_mgd_complete_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_prep_tx_info *info)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	mt7902_abort_roc(mvif->phy, mvif);
+}
+
+static int mt7902_switch_vif_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_vif_chanctx_switch *vifs,
+				     int n_vifs,
+				     enum ieee80211_chanctx_switch_mode mode)
+{
+	return mt792x_assign_vif_chanctx(hw, vifs->vif, vifs->link_conf,
+					 vifs->new_ctx);
+}
+
+void mt7902_csa_work(struct work_struct *work)
+{
+	struct mt792x_vif *mvif;
+	struct mt792x_dev *dev;
+	struct ieee80211_vif *vif;
+	int ret;
+
+	mvif = (struct mt792x_vif *)container_of(work, struct mt792x_vif,
+						csa_work);
+	dev = mvif->phy->dev;
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	mt792x_mutex_acquire(dev);
+	ret = mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76,
+					    dev->new_ctx);
+	mt792x_mutex_release(dev);
+
+	ieee80211_chswitch_done(vif, !ret, 0);
+}
+
+static int mt7902_pre_channel_switch(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_channel_switch *chsw)
+{
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return -EOPNOTSUPP;
+
+	/* Avoid beacon loss due to the CAC(Channel Availability Check) time
+	 * of the AP.
+	 */
+	if (!cfg80211_chandef_usable(hw->wiphy, &chsw->chandef,
+				     IEEE80211_CHAN_RADAR))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void mt7902_channel_switch(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval = vif->bss_conf.beacon_int;
+
+	mvif->csa_timer.expires = TU_TO_EXP_TIME(beacon_interval * chsw->count);
+	add_timer(&mvif->csa_timer);
+}
+
+static void mt7902_abort_channel_switch(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	timer_delete_sync(&mvif->csa_timer);
+	cancel_work_sync(&mvif->csa_work);
+}
+
+static void mt7902_channel_switch_rx_beacon(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval = vif->bss_conf.beacon_int;
+
+	if (cfg80211_chandef_identical(&chsw->chandef,
+				       &dev->new_ctx->def) &&
+				       chsw->count) {
+		mod_timer(&mvif->csa_timer,
+			  TU_TO_EXP_TIME(beacon_interval * chsw->count));
+	}
+}
+
+static void mt7902_rfkill_poll(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(phy->dev);
+	ret = mt7902_mcu_wf_rf_pin_ctrl(phy, WF_RF_PIN_POLL);
+	mt792x_mutex_release(phy->dev);
+
+	wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);
+}
+
+const struct ieee80211_ops mt7902_ops = {
+	.tx = mt792x_tx,
+	.start = mt7902_start,
+	.stop = mt7902_stop,
+	.add_interface = mt7902_add_interface,
+	.remove_interface = mt792x_remove_interface,
+	.config = mt7902_config,
+	.conf_tx = mt792x_conf_tx,
+	.configure_filter = mt7902_configure_filter,
+	.bss_info_changed = mt7902_bss_info_changed,
+	.start_ap = mt7902_start_ap,
+	.stop_ap = mt7902_stop_ap,
+	.sta_state = mt7902_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.set_key = mt7902_set_key,
+	.sta_set_decap_offload = mt7902_sta_set_decap_offload,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = mt7902_ipv6_addr_change,
+#endif /* CONFIG_IPV6 */
+	.ampdu_action = mt7902_ampdu_action,
+	.set_rts_threshold = mt7902_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.channel_switch_beacon = mt7902_channel_switch_beacon,
+	.get_txpower = mt76_get_txpower,
+	.get_stats = mt792x_get_stats,
+	.get_et_sset_count = mt792x_get_et_sset_count,
+	.get_et_strings = mt792x_get_et_strings,
+	.get_et_stats = mt792x_get_et_stats,
+	.get_tsf = mt792x_get_tsf,
+	.set_tsf = mt792x_set_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7902_set_antenna,
+	.set_coverage_class = mt792x_set_coverage_class,
+	.hw_scan = mt7902_hw_scan,
+	.cancel_hw_scan = mt7902_cancel_hw_scan,
+	.sta_statistics = mt792x_sta_statistics,
+	.sched_scan_start = mt7902_start_sched_scan,
+	.sched_scan_stop = mt7902_stop_sched_scan,
+	CFG80211_TESTMODE_CMD(mt7902_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt7902_testmode_dump)
+#ifdef CONFIG_PM
+	.suspend = mt7902_suspend,
+	.resume = mt7902_resume,
+	.set_wakeup = mt792x_set_wakeup,
+	.set_rekey_data = mt7902_set_rekey_data,
+#endif /* CONFIG_PM */
+	.flush = mt792x_flush,
+	.set_sar_specs = mt7902_set_sar_specs,
+	.rfkill_poll = mt7902_rfkill_poll,
+	.remain_on_channel = mt7902_remain_on_channel,
+	.cancel_remain_on_channel = mt7902_cancel_remain_on_channel,
+	.add_chanctx = mt7902_add_chanctx,
+	.remove_chanctx = mt7902_remove_chanctx,
+	.change_chanctx = mt7902_change_chanctx,
+	.assign_vif_chanctx = mt792x_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
+	.mgd_prepare_tx = mt7902_mgd_prepare_tx,
+	.mgd_complete_tx = mt7902_mgd_complete_tx,
+	.switch_vif_chanctx = mt7902_switch_vif_chanctx,
+	.pre_channel_switch = mt7902_pre_channel_switch,
+	.channel_switch = mt7902_channel_switch,
+	.abort_channel_switch = mt7902_abort_channel_switch,
+	.channel_switch_rx_beacon = mt7902_channel_switch_rx_beacon,
+};
+EXPORT_SYMBOL_GPL(mt7902_ops);
+
+MODULE_DESCRIPTION("MediaTek MT7902 core driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
new file mode 100644
index 000000000..dfb1b9ef9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
@@ -0,0 +1,1492 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include "mt7902.h"
+#include "mcu.h"
+#include "../mt76_connac2_mac.h"
+#include "../mt792x_trace.h"
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+static bool mt7902_disable_clc;
+module_param_named(disable_clc, mt7902_disable_clc, bool, 0644);
+MODULE_PARM_DESC(disable_clc, "disable CLC support");
+
+int mt7902_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq)
+{
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
+			cmd, seq);
+		mt792x_reset(mdev);
+
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
+	    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
+		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		   cmd == MCU_UNI_CMD(OFFLOAD) ||
+		   cmd == MCU_UNI_CMD(SUSPEND)) {
+		struct mt76_connac_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt76_connac_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		/* skip invalid event */
+		if (mcu_cmd != event->cid)
+			ret = -EAGAIN;
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
+		struct mt76_connac_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt76_connac_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+	} else if (cmd == MCU_EXT_CMD(WF_RF_PIN_CTRL)) {
+		struct mt7902_wf_rf_pin_ctrl_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7902_wf_rf_pin_ctrl_event *)skb->data;
+		ret = (int)event->result;
+	} else {
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7902_mcu_parse_response);
+
+static int mt7902_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
+{
+	struct mt7902_mcu_eeprom_info *res, req = {
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7902_EEPROM_BLOCK_SIZE)),
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7902_mcu_eeprom_info *)skb->data;
+	*val = res->data[offset % MT7902_EEPROM_BLOCK_SIZE];
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int
+mt7902_mcu_set_ipv6_ns_filter(struct mt76_dev *dev,
+			      struct ieee80211_vif *vif, bool suspend)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
+				 true);
+}
+
+void mt7902_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (IS_ENABLED(CONFIG_IPV6)) {
+		struct mt76_phy *phy = priv;
+
+		mt7902_mcu_set_ipv6_ns_filter(phy->dev, vif,
+					      !test_bit(MT76_STATE_RUNNING,
+					      &phy->state));
+	}
+
+	mt76_connac_mcu_set_suspend_iter(priv, mac, vif);
+}
+
+#endif /* CONFIG_PM */
+
+static void
+mt7902_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7902_roc_grant_tlv *grant;
+	struct mt76_connac2_mcu_rxd *rxd;
+	int duration;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	grant = (struct mt7902_roc_grant_tlv *)(rxd->tlv + 4);
+
+	/* should never happen */
+	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
+
+	if (grant->reqtype == MT7902_ROC_REQ_ROC)
+		ieee80211_ready_on_channel(dev->mt76.phy.hw);
+
+	dev->phy.roc_grant = true;
+	wake_up(&dev->phy.roc_wait);
+	duration = le32_to_cpu(grant->max_interval);
+	mod_timer(&dev->phy.roc_timer,
+		  jiffies + msecs_to_jiffies(duration));
+}
+
+static void
+mt7902_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt792x_phy *phy = mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT792x_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7902_mcu_connection_loss_iter(void *priv, u8 *mac,
+				struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_connac_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER) ||
+	    vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
+static void
+mt7902_mcu_connection_loss_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac_beacon_loss_event *event;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt76_connac_beacon_loss_event *)skb->data;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7902_mcu_connection_loss_iter, event);
+}
+
+static void
+mt7902_mcu_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7902_debug_msg {
+		__le16 id;
+		u8 type;
+		u8 flag;
+		__le32 value;
+		__le16 len;
+		u8 content[512];
+	} __packed * msg;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	msg = (struct mt7902_debug_msg *)skb->data;
+
+	if (msg->type == 3) { /* fw log */
+		u16 len = min_t(u16, le16_to_cpu(msg->len), 512);
+		int i;
+
+		for (i = 0 ; i < len; i++) {
+			if (!msg->content[i])
+				msg->content[i] = ' ';
+		}
+		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", len, msg->content);
+	}
+}
+
+static void
+mt7902_mcu_low_power_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7902_mcu_lp_event {
+		u8 state;
+		u8 reserved[3];
+	} __packed * event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt7902_mcu_lp_event *)skb->data;
+
+	trace_lp_event(dev, event->state);
+}
+
+static void
+mt7902_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7902_mcu_tx_done_event *event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt7902_mcu_tx_done_event *)skb->data;
+
+	mt7902_mac_add_txs(dev, event->txs);
+}
+
+static void
+mt7902_mcu_rssi_monitor_iter(void *priv, u8 *mac,
+			     struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt76_connac_rssi_notify_event *event = priv;
+	enum nl80211_cqm_rssi_threshold_event nl_event;
+	s32 rssi = le32_to_cpu(event->rssi[mvif->bss_conf.mt76.idx]);
+
+	if (!rssi)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
+		return;
+
+	if (rssi > vif->bss_conf.cqm_rssi_thold)
+		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
+	else
+		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
+
+	ieee80211_cqm_rssi_notify(vif, nl_event, rssi, GFP_KERNEL);
+}
+
+static void
+mt7902_mcu_rssi_monitor_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac_rssi_notify_event *event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt76_connac_rssi_notify_event *)skb->data;
+
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+						   IEEE80211_IFACE_ITER_RESUME_ALL,
+						   mt7902_mcu_rssi_monitor_iter, event);
+}
+
+static void
+mt7902_mcu_rx_unsolicited_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	switch (rxd->eid) {
+	case MCU_EVENT_BSS_BEACON_LOSS:
+		mt7902_mcu_connection_loss_event(dev, skb);
+		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
+	case MCU_EVENT_SCAN_DONE:
+		mt7902_mcu_scan_event(dev, skb);
+		return;
+	case MCU_EVENT_DBG_MSG:
+		mt7902_mcu_debug_msg_event(dev, skb);
+		break;
+	case MCU_EVENT_COREDUMP:
+		dev->fw_assert = true;
+		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
+					       &dev->coredump);
+		return;
+	case MCU_EVENT_LP_INFO:
+		mt7902_mcu_low_power_event(dev, skb);
+		break;
+	case MCU_EVENT_TX_DONE:
+		mt7902_mcu_tx_done_event(dev, skb);
+		break;
+	case MCU_EVENT_RSSI_NOTIFY:
+		mt7902_mcu_rssi_monitor_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+static void
+mt7902_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
+				    struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_UNI_EVENT_ROC:
+		mt7902_mcu_uni_roc_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7902_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	if (skb_linearize(skb))
+		return;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+
+	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
+		mt7902_mcu_uni_rx_unsolicited_event(dev, skb);
+		return;
+	}
+
+	if (rxd->eid == 0x6) {
+		mt76_mcu_rx_event(&dev->mt76, skb);
+		return;
+	}
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
+	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_RSSI_NOTIFY ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_TX_DONE ||
+	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    rxd->eid == MCU_EVENT_COREDUMP ||
+	    rxd->eid == MCU_EVENT_LP_INFO ||
+	    !rxd->seq)
+		mt7902_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+/** starec & wtbl **/
+int mt7902_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
+
+	if (enable && !params->amsdu)
+		msta->deflink.wcid.amsdu = false;
+
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->bss_conf.mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
+				      enable, true);
+}
+
+int mt7902_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
+
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->bss_conf.mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
+				      enable, false);
+}
+
+static int mt7902_load_clc(struct mt792x_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct mt76_connac2_fw_region *region;
+	const struct mt7902_clc *clc;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt792x_phy *phy = &dev->phy;
+	const struct firmware *fw;
+	int ret, i, len, offset = 0;
+	u8 *clc_base = NULL, hw_encap = 0;
+
+	dev->phy.clc_chan_conf = 0xff;
+	if (mt7902_disable_clc ||
+	    mt76_is_usb(&dev->mt76))
+		return 0;
+
+	if (mt76_is_mmio(&dev->mt76)) {
+		ret = mt7902_mcu_read_eeprom(dev, MT_EE_HW_TYPE, &hw_encap);
+		if (ret)
+			return ret;
+		hw_encap = u8_get_bits(hw_encap, MT_EE_HW_TYPE_ENCAP);
+	}
+
+	ret = request_firmware(&fw, fw_name, mdev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(mdev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	for (i = 0; i < hdr->n_region; i++) {
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		len = le32_to_cpu(region->len);
+
+		/* check if we have valid buffer size */
+		if (offset + len > fw->size) {
+			dev_err(mdev->dev, "Invalid firmware region\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if ((region->feature_set & FW_FEATURE_NON_DL) &&
+		    region->type == FW_TYPE_CLC) {
+			clc_base = (u8 *)(fw->data + offset);
+			break;
+		}
+		offset += len;
+	}
+
+	if (!clc_base)
+		goto out;
+
+	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
+		clc = (const struct mt7902_clc *)(clc_base + offset);
+
+		/* do not init buf again if chip reset triggered */
+		if (phy->clc[clc->idx])
+			continue;
+
+		/* header content sanity */
+		if (clc->idx == MT7902_CLC_POWER &&
+		    u8_get_bits(clc->type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
+			continue;
+
+		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
+						  le32_to_cpu(clc->len),
+						  GFP_KERNEL);
+
+		if (!phy->clc[clc->idx]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = mt7902_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void mt7902_mcu_parse_tx_resource(struct mt76_dev *dev,
+					 struct sk_buff *skb)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7902_tx_resource {
+		__le32 version;
+		__le32 pse_data_quota;
+		__le32 pse_mcu_quota;
+		__le32 ple_data_quota;
+		__le32 ple_mcu_quota;
+		__le16 pse_page_size;
+		__le16 ple_page_size;
+		u8 pp_padding;
+		u8 pad[3];
+	} __packed * tx_res;
+
+	tx_res = (struct mt7902_tx_resource *)skb->data;
+	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
+	sdio->pse_mcu_quota_max = le32_to_cpu(tx_res->pse_mcu_quota);
+	/* The mcu quota usage of this function itself must be taken into consideration */
+	sdio->sched.pse_mcu_quota =
+		sdio->sched.pse_mcu_quota ? sdio->pse_mcu_quota_max : sdio->pse_mcu_quota_max - 1;
+	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
+	sdio->sched.pse_page_size = le16_to_cpu(tx_res->pse_page_size);
+	sdio->sched.deficit = tx_res->pp_padding;
+}
+
+static void mt7902_mcu_parse_phy_cap(struct mt76_dev *dev,
+				     struct sk_buff *skb)
+{
+	struct mt7902_phy_cap {
+		u8 ht;
+		u8 vht;
+		u8 _5g;
+		u8 max_bw;
+		u8 nss;
+		u8 dbdc;
+		u8 tx_ldpc;
+		u8 rx_ldpc;
+		u8 tx_stbc;
+		u8 rx_stbc;
+		u8 hw_path;
+		u8 he;
+	} __packed * cap;
+
+	enum {
+		WF0_24G,
+		WF0_5G
+	};
+
+	cap = (struct mt7902_phy_cap *)skb->data;
+
+	dev->phy.antenna_mask = BIT(cap->nss) - 1;
+	dev->phy.chainmask = dev->phy.antenna_mask;
+	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
+	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+}
+
+static int mt7902_mcu_get_nic_capability(struct mt792x_phy *mphy)
+{
+	struct mt76_connac_cap_hdr {
+		__le16 n_element;
+		u8 rsv[2];
+	} __packed * hdr;
+	struct sk_buff *skb;
+	struct mt76_phy *phy = mphy->mt76;
+	int ret, i;
+
+	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CE_CMD(GET_NIC_CAPAB),
+					NULL, 0, true, &skb);
+	if (ret)
+		return ret;
+
+	hdr = (struct mt76_connac_cap_hdr *)skb->data;
+	if (skb->len < sizeof(*hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	skb_pull(skb, sizeof(*hdr));
+
+	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
+		struct tlv_hdr {
+			__le32 type;
+			__le32 len;
+		} __packed * tlv = (struct tlv_hdr *)skb->data;
+		int len;
+
+		if (skb->len < sizeof(*tlv))
+			break;
+
+		skb_pull(skb, sizeof(*tlv));
+
+		len = le32_to_cpu(tlv->len);
+		if (skb->len < len)
+			break;
+
+		switch (le32_to_cpu(tlv->type)) {
+		case MT_NIC_CAP_6G:
+			phy->cap.has_6ghz = skb->data[0];
+			break;
+		case MT_NIC_CAP_MAC_ADDR:
+			memcpy(phy->macaddr, (void *)skb->data, ETH_ALEN);
+			break;
+		case MT_NIC_CAP_PHY:
+			mt7902_mcu_parse_phy_cap(phy->dev, skb);
+			break;
+		case MT_NIC_CAP_TX_RESOURCE:
+			if (mt76_is_sdio(phy->dev))
+				mt7902_mcu_parse_tx_resource(phy->dev,
+							     skb);
+			break;
+		case MT_NIC_CAP_CHIP_CAP:
+			memcpy(&mphy->chip_cap, (void *)skb->data, sizeof(u64));
+			break;
+		default:
+			break;
+		}
+		skb_pull(skb, len);
+	}
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+int mt7902_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(FWLOG_2_HOST),
+				 &data, sizeof(data), false);
+}
+
+int mt7902_run_firmware(struct mt792x_dev *dev)
+{
+	int err;
+
+	err = mt792x_load_firmware(dev);
+	if (err)
+		return err;
+
+	err = mt7902_mcu_get_nic_capability(&dev->phy);
+	if (err)
+		return err;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	err = mt7902_load_clc(dev, mt792x_ram_name(dev));
+	if (err)
+		return err;
+
+	return mt7902_mcu_fw_log_2_host(dev, 1);
+}
+EXPORT_SYMBOL_GPL(mt7902_run_firmware);
+
+int mt7902_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value)
+{
+	struct {
+		u8 ctrlid;
+		u8 rsv[3];
+	} __packed req = {
+		.ctrlid = value,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ID_RADIO_ON_OFF_CTRL),
+				&req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt7902_mcu_radio_led_ctrl);
+
+int mt7902_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct edca {
+		__le16 cw_min;
+		__le16 cw_max;
+		__le16 txop;
+		__le16 aifs;
+		u8 guardtime;
+		u8 acm;
+	} __packed;
+	struct mt7902_mcu_tx {
+		struct edca edca[IEEE80211_NUM_ACS];
+		u8 bss_idx;
+		u8 qos;
+		u8 wmm_idx;
+		u8 pad;
+	} __packed req = {
+		.bss_idx = mvif->bss_conf.mt76.idx,
+		.qos = vif->bss_conf.qos,
+		.wmm_idx = mvif->bss_conf.mt76.wmm_idx,
+	};
+	struct mu_edca {
+		u8 cw_min;
+		u8 cw_max;
+		u8 aifsn;
+		u8 acm;
+		u8 timer;
+		u8 padding[3];
+	};
+	struct mt7902_mcu_mu_tx {
+		u8 ver;
+		u8 pad0;
+		__le16 len;
+		u8 bss_idx;
+		u8 qos;
+		u8 wmm_idx;
+		u8 pad1;
+		struct mu_edca edca[IEEE80211_NUM_ACS];
+		u8 pad3[32];
+	} __packed req_mu = {
+		.bss_idx = mvif->bss_conf.mt76.idx,
+		.qos = vif->bss_conf.qos,
+		.wmm_idx = mvif->bss_conf.mt76.wmm_idx,
+	};
+	static const int to_aci[] = { 1, 0, 2, 3 };
+	int ac, ret;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->bss_conf.queue_params[ac];
+		struct edca *e = &req.edca[to_aci[ac]];
+
+		e->aifs = cpu_to_le16(q->aifs);
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = cpu_to_le16(q->cw_min);
+		else
+			e->cw_min = cpu_to_le16(5);
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(q->cw_max);
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_EDCA_PARMS), &req,
+				sizeof(req), false);
+	if (ret)
+		return ret;
+
+	if (!vif->bss_conf.he_support)
+		return 0;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_he_mu_edca_param_ac_rec *q;
+		struct mu_edca *e;
+
+		if (!mvif->bss_conf.queue_params[ac].mu_edca)
+			break;
+
+		q = &mvif->bss_conf.queue_params[ac].mu_edca_param_rec;
+		e = &(req_mu.edca[to_aci[ac]]);
+
+		e->cw_min = q->ecw_min_max & 0xf;
+		e->cw_max = (q->ecw_min_max & 0xf0) >> 4;
+		e->aifsn = q->aifsn;
+		e->timer = q->mu_edca_timer;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_MU_EDCA_PARMS),
+				 &req_mu, sizeof(req_mu), false);
+}
+
+int mt7902_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7902_roc_req type, u8 token_id)
+{
+	int center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 control_channel;
+			u8 sco;
+			u8 band;
+			u8 bw;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw_from_ap;
+			u8 center_chan_from_ap;
+			u8 center_chan2_from_ap;
+			u8 reqtype;
+			__le32 maxinterval;
+			u8 dbdcband;
+			u8 rsv[3];
+		} __packed roc;
+	} __packed req = {
+		.roc = {
+			.tag = cpu_to_le16(UNI_ROC_ACQUIRE),
+			.len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.tokenid = token_id,
+			.reqtype = type,
+			.maxinterval = cpu_to_le32(duration),
+			.bss_idx = vif->bss_conf.mt76.idx,
+			.control_channel = chan->hw_value,
+			.bw = CMD_CBW_20MHZ,
+			.bw_from_ap = CMD_CBW_20MHZ,
+			.center_chan = center_ch,
+			.center_chan_from_ap = center_ch,
+			.dbdcband = 0xff, /* auto */
+		},
+	};
+
+	if (chan->hw_value < center_ch)
+		req.roc.sco = 1; /* SCA */
+	else if (chan->hw_value > center_ch)
+		req.roc.sco = 3; /* SCB */
+
+	switch (chan->band) {
+	case NL80211_BAND_6GHZ:
+		req.roc.band = 3;
+		break;
+	case NL80211_BAND_5GHZ:
+		req.roc.band = 2;
+		break;
+	default:
+		req.roc.band = 1;
+		break;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7902_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+			 u8 token_id)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_abort_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 dbdcband;
+			u8 rsv[5];
+		} __packed abort;
+	} __packed req = {
+		.abort = {
+			.tag = cpu_to_le16(UNI_ROC_ABORT),
+			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
+			.tokenid = token_id,
+			.bss_idx = vif->bss_conf.mt76.idx,
+			.dbdcband = 0xff, /* auto*/
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7902_mcu_set_chan_info(struct mt792x_phy *phy, int cmd)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	struct {
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_streams_num;
+		u8 rx_streams;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[57];
+	} __packed req = {
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt76_connac_chan_bw(chandef),
+		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
+		.rx_streams = phy->mt76->antenna_mask,
+		.band_idx = phy != &dev->phy,
+	};
+
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		req.channel_band = 2;
+	else
+		req.channel_band = chandef->chan->band;
+
+	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
+	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (phy->mt76->offchannel)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if (!cfg80211_reg_can_beacon(dev->mt76.hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (cmd == MCU_EXT_CMD(CHANNEL_SWITCH))
+		req.rx_streams = hweight8(req.rx_streams);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
+int mt7902_mcu_set_eeprom(struct mt792x_dev *dev)
+{
+	struct req_hdr {
+		u8 buffer_mode;
+		u8 format;
+		__le16 len;
+	} __packed req = {
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EFUSE_BUFFER_MODE),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7902_mcu_set_eeprom);
+
+int mt7902_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct ps_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 ps_state; /* 0: device awake
+				      * 1: static power save
+				      * 2: dynamic power saving
+				      * 3: enter TWT power saving
+				      * 4: leave TWT power saving
+				      */
+			u8 pad[3];
+		} __packed ps;
+	} __packed ps_req = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.ps = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
+			.len = cpu_to_le16(sizeof(struct ps_tlv)),
+			.ps_state = vif->cfg.ps ? 2 : 0,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &ps_req, sizeof(ps_req), true);
+}
+
+static int
+mt7902_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			 bool enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcnft_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 pad;
+		} __packed bcnft;
+	} __packed bcnft_req = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.bcnft = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
+			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &bcnft_req, sizeof(bcnft_req), true);
+}
+
+int
+mt7902_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+		      bool enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 dtim_period;
+		__le16 aid;
+		__le16 bcn_interval;
+		__le16 atim_window;
+		u8 uapsd;
+		u8 bmc_delivered_ac;
+		u8 bmc_triggered_ac;
+		u8 pad;
+	} req = {
+		.bss_idx = mvif->bss_conf.mt76.idx,
+		.aid = cpu_to_le16(vif->cfg.aid),
+		.dtim_period = vif->bss_conf.dtim_period,
+		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+	};
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} req_hdr = {
+		.bss_idx = mvif->bss_conf.mt76.idx,
+	};
+	int err;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
+}
+
+int mt7902_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->bss_conf.rssi);
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = enable,
+		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
+		.state = state,
+		.offload_fw = true,
+		.rcpi = to_rcpi(rssi),
+	};
+	struct mt792x_sta *msta;
+
+	msta = sta ? (struct mt792x_sta *)sta->drv_priv : NULL;
+	info.wcid = msta ? &msta->deflink.wcid : &mvif->sta.deflink.wcid;
+	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+
+	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
+}
+
+int mt7902_mcu_set_beacon_filter(struct mt792x_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+#define MT7902_FIF_BIT_CLR		BIT(1)
+#define MT7902_FIF_BIT_SET		BIT(0)
+	int err;
+
+	if (enable) {
+		err = mt7902_mcu_uni_bss_bcnft(dev, vif, true);
+		if (err)
+			return err;
+
+		err = mt7902_mcu_set_rxfilter(dev, 0,
+					      MT7902_FIF_BIT_SET,
+					      MT_WF_RFCR_DROP_OTHER_BEACON);
+		if (err)
+			return err;
+
+		return 0;
+	}
+
+	err = mt7902_mcu_set_bss_pm(dev, vif, false);
+	if (err)
+		return err;
+
+	err = mt7902_mcu_set_rxfilter(dev, 0,
+				      MT7902_FIF_BIT_CLR,
+				      MT_WF_RFCR_DROP_OTHER_BEACON);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mt7902_get_txpwr_info(struct mt792x_dev *dev, struct mt7902_txpwr *txpwr)
+{
+	struct mt7902_txpwr_event *event;
+	struct mt7902_txpwr_req req = {
+		.dbdc_idx = 0,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(GET_TXPWR),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	event = (struct mt7902_txpwr_event *)skb->data;
+	WARN_ON(skb->len != le16_to_cpu(event->len));
+	memcpy(txpwr, &event->txpwr, sizeof(event->txpwr));
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7902_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			   bool enable)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct sniffer_enable_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 enable;
+			u8 pad[3];
+		} __packed enable;
+	} req = {
+		.hdr = {
+			.band_idx = mvif->band_idx,
+		},
+		.enable = {
+			.tag = cpu_to_le16(0),
+			.len = cpu_to_le16(sizeof(struct sniffer_enable_tlv)),
+			.enable = enable,
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
+				 true);
+}
+
+int mt7902_mcu_config_sniffer(struct mt792x_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = &ctx->def;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	static const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	static const u8 ch_width[] = {
+		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
+		[NL80211_CHAN_WIDTH_20] = 0,
+		[NL80211_CHAN_WIDTH_40] = 0,
+		[NL80211_CHAN_WIDTH_80] = 1,
+		[NL80211_CHAN_WIDTH_160] = 2,
+		[NL80211_CHAN_WIDTH_80P80] = 3,
+		[NL80211_CHAN_WIDTH_5] = 4,
+		[NL80211_CHAN_WIDTH_10] = 5,
+		[NL80211_CHAN_WIDTH_320] = 6,
+	};
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct config_tlv {
+			__le16 tag;
+			__le16 len;
+			u16 aid;
+			u8 ch_band;
+			u8 bw;
+			u8 control_ch;
+			u8 sco;
+			u8 center_ch;
+			u8 center_ch2;
+			u8 drop_err;
+			u8 pad[3];
+		} __packed tlv;
+	} __packed req = {
+		.hdr = {
+			.band_idx = vif->bss_conf.mt76.band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(1),
+			.len = cpu_to_le16(sizeof(req.tlv)),
+			.control_ch = chandef->chan->hw_value,
+			.center_ch = ieee80211_frequency_to_channel(freq1),
+			.drop_err = 1,
+		},
+	};
+	if (chandef->chan->band < ARRAY_SIZE(ch_band))
+		req.tlv.ch_band = ch_band[chandef->chan->band];
+	if (chandef->width < ARRAY_SIZE(ch_width))
+		req.tlv.bw = ch_width[chandef->width];
+
+	if (freq2)
+		req.tlv.center_ch2 = ieee80211_frequency_to_channel(freq2);
+
+	if (req.tlv.control_ch < req.tlv.center_ch)
+		req.tlv.sco = 1; /* SCA */
+	else if (req.tlv.control_ch > req.tlv.center_ch)
+		req.tlv.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(vif->phy->mt76->dev, MCU_UNI_CMD(SNIFFER),
+				 &req, sizeof(req), true);
+}
+
+int
+mt7902_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcn_content_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 tim_ie_pos;
+			__le16 csa_ie_pos;
+			__le16 bcc_ie_pos;
+			/* 0: disable beacon offload
+			 * 1: enable beacon offload
+			 * 2: update probe respond offload
+			 */
+			u8 enable;
+			/* 0: legacy format (TXD + payload)
+			 * 1: only cap field IE
+			 */
+			u8 type;
+			__le16 pkt_len;
+			u8 pkt[512];
+		} __packed beacon_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.beacon_tlv = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
+			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
+			.enable = enable,
+		},
+	};
+	struct sk_buff *skb;
+
+	/* support enable/update process only
+	 * disable flow would be handled in bss stop handler automatically
+	 */
+	if (!enable)
+		return -EOPNOTSUPP;
+
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs, 0);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > 512 - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	mt76_connac2_mac_write_txwi(&dev->mt76, (__le32 *)(req.beacon_tlv.pkt),
+				    skb, wcid, NULL, 0, 0, BSS_CHANGED_BEACON);
+	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
+	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+
+	if (offs.cntdwn_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
+		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
+	}
+	dev_kfree_skb(skb);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &req, sizeof(req), true);
+}
+
+static
+int __mt7902_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+			 enum environment_cap env_cap,
+			 struct mt7902_clc *clc,
+			 u8 idx)
+{
+#define CLC_CAP_EVT_EN BIT(0)
+#define CLC_CAP_DTS_EN BIT(1)
+	struct sk_buff *skb, *ret_skb = NULL;
+	struct {
+		u8 ver;
+		u8 pad0;
+		__le16 len;
+		u8 idx;
+		u8 env;
+		u8 acpi_conf;
+		u8 cap;
+		u8 alpha2[2];
+		u8 type[2];
+		u8 env_6g;
+		u8 mtcl_conf;
+		u8 rsvd[62];
+	} __packed req = {
+		.ver = 1,
+		.idx = idx,
+		.env = env_cap,
+		.env_6g = dev->phy.power_type,
+		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
+		.mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
+	};
+	int ret, valid_cnt = 0;
+	u32 buf_len = 0;
+	u8 *pos;
+
+	if (!clc)
+		return 0;
+
+	if (dev->phy.chip_cap & MT792x_CHIP_CAP_CLC_EVT_EN)
+		req.cap |= CLC_CAP_EVT_EN;
+	if (mt76_find_power_limits_node(&dev->mt76))
+		req.cap |= CLC_CAP_DTS_EN;
+
+	buf_len = le32_to_cpu(clc->len) - sizeof(*clc);
+	pos = clc->data;
+	while (buf_len > 16) {
+		struct mt7902_clc_rule *rule = (struct mt7902_clc_rule *)pos;
+		u16 len = le16_to_cpu(rule->len);
+		u16 offset = len + sizeof(*rule);
+
+		pos += offset;
+		buf_len -= offset;
+		if (rule->alpha2[0] != alpha2[0] ||
+		    rule->alpha2[1] != alpha2[1])
+			continue;
+
+		memcpy(req.alpha2, rule->alpha2, 2);
+		memcpy(req.type, rule->type, 2);
+
+		req.len = cpu_to_le16(sizeof(req) + len);
+		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
+					   le16_to_cpu(req.len),
+					   sizeof(req), GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+		skb_put_data(skb, rule->data, len);
+
+		ret = mt76_mcu_skb_send_and_get_msg(&dev->mt76, skb,
+						    MCU_CE_CMD(SET_CLC),
+						    !!(req.cap & CLC_CAP_EVT_EN),
+						    &ret_skb);
+		if (ret < 0)
+			return ret;
+
+		if (ret_skb) {
+			struct mt7902_clc_info_tlv *info;
+
+			info = (struct mt7902_clc_info_tlv *)(ret_skb->data + 4);
+			dev->phy.clc_chan_conf = info->chan_conf;
+			dev_kfree_skb(ret_skb);
+		}
+
+		valid_cnt++;
+	}
+
+	if (!valid_cnt)
+		return -ENOENT;
+
+	return 0;
+}
+
+int mt7902_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap)
+{
+	struct mt792x_phy *phy = (struct mt792x_phy *)&dev->phy;
+	int i, ret;
+
+	/* submit all clc config */
+	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		ret = __mt7902_mcu_set_clc(dev, alpha2, env_cap,
+					   phy->clc[i], i);
+
+		/* If no country found, set "00" as default */
+		if (ret == -ENOENT)
+			ret = __mt7902_mcu_set_clc(dev, "00",
+						   ENVIRON_INDOOR,
+						   phy->clc[i], i);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+int mt7902_mcu_get_temperature(struct mt792x_phy *phy)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		u8 ctrl_id;
+		u8 action;
+		u8 band_idx;
+		u8 rsv[5];
+	} req = {
+		.ctrl_id = THERMAL_SENSOR_TEMP_QUERY,
+		.band_idx = phy->mt76->band_idx,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
+				 sizeof(req), true);
+}
+
+int mt7902_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy, u8 action)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		u8 action;
+		u8 value;
+	} req = {
+		.action = action,
+		.value = 0,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(WF_RF_PIN_CTRL), &req,
+				 sizeof(req), action ? true : false);
+}
+
+int mt7902_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map)
+{
+	struct {
+		u8 rsv[4];
+		u8 mode;
+		u8 rsv2[3];
+		__le32 fif;
+		__le32 bit_map; /* bit_* for bitmap update */
+		u8 bit_op;
+		u8 pad[51];
+	} __packed data = {
+		.mode = fif ? 1 : 2,
+		.fif = cpu_to_le32(fif),
+		.bit_map = cpu_to_le32(bit_map),
+		.bit_op = bit_op,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_RX_FILTER),
+				 &data, sizeof(data), false);
+}
+
+int mt7902_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		u8 enable;
+		s8 cqm_rssi_high;
+		s8 cqm_rssi_low;
+		u8 bss_idx;
+		u16 duration;
+		u8 rsv2[2];
+	} __packed data = {
+		.enable = vif->cfg.assoc,
+		.cqm_rssi_high = vif->bss_conf.cqm_rssi_thold + vif->bss_conf.cqm_rssi_hyst,
+		.cqm_rssi_low = vif->bss_conf.cqm_rssi_thold - vif->bss_conf.cqm_rssi_hyst,
+		.bss_idx = mvif->bss_conf.mt76.idx,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(RSSI_MONITOR),
+				 &data, sizeof(data), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.h
new file mode 100644
index 000000000..3f503e4bd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7902_MCU_H
+#define __MT7902_MCU_H
+
+#include "../mt76_connac_mcu.h"
+
+struct mt7902_mcu_tx_done_event {
+	u8 pid;
+	u8 status;
+	__le16 seq;
+
+	u8 wlan_idx;
+	u8 tx_cnt;
+	__le16 tx_rate;
+
+	u8 flag;
+	u8 tid;
+	u8 rsp_rate;
+	u8 mcs;
+
+	u8 bw;
+	u8 tx_pwr;
+	u8 reason;
+	u8 rsv0[1];
+
+	__le32 delay;
+	__le32 timestamp;
+	__le32 applied_flag;
+	u8 txs[28];
+
+	u8 rsv1[32];
+} __packed;
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_RATE_REPORT = 0x87,
+};
+
+struct mt7902_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[MT7902_EEPROM_BLOCK_SIZE];
+} __packed;
+
+#define MT_RA_RATE_NSS			GENMASK(8, 6)
+#define MT_RA_RATE_MCS			GENMASK(3, 0)
+#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
+#define MT_RA_RATE_DCM_EN		BIT(4)
+#define MT_RA_RATE_BW			GENMASK(14, 13)
+
+enum {
+	MT_EBF = BIT(0),	/* explicit beamforming */
+	MT_IBF = BIT(1)		/* implicit beamforming */
+};
+
+struct mt7902_mcu_ant_id_config {
+	u8 ant_id[4];
+} __packed;
+
+struct mt7902_txpwr_req {
+	u8 ver;
+	u8 action;
+	__le16 len;
+	u8 dbdc_idx;
+	u8 rsv[3];
+} __packed;
+
+struct mt7902_txpwr_event {
+	u8 ver;
+	u8 action;
+	__le16 len;
+	struct mt7902_txpwr txpwr;
+} __packed;
+
+struct mt7902_wf_rf_pin_ctrl_event {
+	u8 result;
+	u8 value;
+} __packed;
+
+enum {
+	TM_SWITCH_MODE,
+	TM_SET_AT_CMD,
+	TM_QUERY_AT_CMD,
+};
+
+enum {
+	MT7902_TM_NORMAL,
+	MT7902_TM_TESTMODE,
+	MT7902_TM_ICAP,
+	MT7902_TM_ICAP_OVERLAP,
+	MT7902_TM_WIFISPECTRUM,
+};
+
+struct mt7902_rftest_cmd {
+	u8 action;
+	u8 rsv[3];
+	__le32 param0;
+	__le32 param1;
+} __packed;
+
+struct mt7902_rftest_evt {
+	__le32 param0;
+	__le32 param1;
+} __packed;
+
+struct mt7902_clc_info_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 chan_conf; /* BIT(0) : Enable UNII-4
+		       * BIT(1) : Enable UNII-5
+		       * BIT(2) : Enable UNII-6
+		       * BIT(3) : Enable UNII-7
+		       * BIT(4) : Enable UNII-8
+		       */
+	u8 rsv[63];
+} __packed;
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
new file mode 100644
index 000000000..03beb683b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7902_H
+#define __MT7902_H
+
+#include "../mt792x.h"
+#include "regs.h"
+
+#define MT7902_TX_RING_SIZE		2048
+#define MT7902_TX_MCU_RING_SIZE		256
+#define MT7902_TX_FWDL_RING_SIZE	128
+
+#define MT7902_RX_RING_SIZE		1536
+#define MT7902_RX_MCU_RING_SIZE		8
+#define MT7902_RX_MCU_WA_RING_SIZE	512
+
+#define MT7902_EEPROM_SIZE		3584
+#define MT7902_TOKEN_SIZE		8192
+
+#define MT7902_EEPROM_BLOCK_SIZE	16
+
+#define MT7902_SKU_RATE_NUM		161
+#define MT7902_SKU_MAX_DELTA_IDX	MT7902_SKU_RATE_NUM
+#define MT7902_SKU_TABLE_SIZE		(MT7902_SKU_RATE_NUM + 1)
+
+#define MCU_UNI_EVENT_ROC  0x27
+#define MCU_UNI_EVENT_CLC  0x80
+
+#define EXT_CMD_RADIO_LED_CTRL_ENABLE   0x1
+#define EXT_CMD_RADIO_ON_LED            0x2
+#define EXT_CMD_RADIO_OFF_LED           0x3
+
+#define WF_RF_PIN_INIT		0x0
+#define WF_RF_PIN_POLL		0x1
+
+enum {
+	UNI_ROC_ACQUIRE,
+	UNI_ROC_ABORT,
+	UNI_ROC_NUM
+};
+
+enum mt7902_roc_req {
+	MT7902_ROC_REQ_JOIN,
+	MT7902_ROC_REQ_ROC,
+	MT7902_ROC_REQ_NUM
+};
+
+enum {
+	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_TAG_NUM
+};
+
+struct mt7902_realease_info {
+	__le16 len;
+	u8 pad_len;
+	u8 tag;
+} __packed;
+
+struct mt7902_fw_features {
+	u8 segment;
+	u8 data;
+	u8 rsv[14];
+} __packed;
+
+struct mt7902_roc_grant_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 status;
+	u8 primarychannel;
+	u8 rfsco;
+	u8 rfband;
+	u8 channelwidth;
+	u8 centerfreqseg1;
+	u8 centerfreqseg2;
+	u8 reqtype;
+	u8 dbdcband;
+	u8 rsv[1];
+	__le32 max_interval;
+} __packed;
+
+enum mt7902_sdio_pkt_type {
+	MT7902_SDIO_TXD,
+	MT7902_SDIO_DATA,
+	MT7902_SDIO_CMD,
+	MT7902_SDIO_FWDL,
+};
+
+struct mt7902_sdio_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[16];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len0[16];
+		u16 len1[128];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
+#define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rcpi(rssi)			(2 * (rssi) + 220)
+
+enum mt7902_txq_id {
+	MT7902_TXQ_BAND0,
+	MT7902_TXQ_BAND1,
+	MT7902_TXQ_FWDL = 16,
+	MT7902_TXQ_MCU_WM,
+};
+
+enum mt7902_rxq_id {
+	MT7902_RXQ_BAND0 = 0,
+	MT7902_RXQ_BAND1,
+	MT7902_RXQ_MCU_WM = 0,
+};
+
+enum {
+	MT7902_CLC_POWER,
+	MT7902_CLC_CHAN,
+	MT7902_CLC_MAX_NUM,
+};
+
+struct mt7902_clc_rule {
+	u8 alpha2[2];
+	u8 type[2];
+	__le16 len;
+	u8 data[];
+} __packed;
+
+struct mt7902_clc {
+	__le32 len;
+	u8 idx;
+	u8 ver;
+	u8 nr_country;
+	u8 type;
+	u8 rsv[8];
+	u8 data[];
+} __packed;
+
+enum mt7902_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_WIFI_CONF =	0x07c,
+	MT_EE_HW_TYPE =		0x55b,
+	__MT_EE_MAX =		0x9ff
+};
+
+#define MT_EE_HW_TYPE_ENCAP			BIT(0)
+
+enum {
+	TXPWR_USER,
+	TXPWR_EEPROM,
+	TXPWR_MAC,
+	TXPWR_MAX_NUM,
+};
+
+struct mt7902_txpwr {
+	u8 ch;
+	u8 rsv[3];
+	struct {
+		u8 ch;
+		u8 cck[4];
+		u8 ofdm[8];
+		u8 ht20[8];
+		u8 ht40[9];
+		u8 vht20[12];
+		u8 vht40[12];
+		u8 vht80[12];
+		u8 vht160[12];
+		u8 he26[12];
+		u8 he52[12];
+		u8 he106[12];
+		u8 he242[12];
+		u8 he484[12];
+		u8 he996[12];
+		u8 he996x2[12];
+	} data[TXPWR_MAX_NUM];
+};
+
+extern const struct ieee80211_ops mt7902_ops;
+
+u32 mt7902_reg_map(struct mt792x_dev *dev, u32 addr);
+
+int __mt7902_start(struct mt792x_phy *phy);
+int mt7902_register_device(struct mt792x_dev *dev);
+void mt7902_unregister_device(struct mt792x_dev *dev);
+int mt7902_run_firmware(struct mt792x_dev *dev);
+int mt7902_set_channel(struct mt76_phy *mphy);
+int mt7902_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
+int mt7902_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state);
+int mt7902_mcu_set_chan_info(struct mt792x_phy *phy, int cmd);
+int mt7902_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7902_mcu_set_eeprom(struct mt792x_dev *dev);
+int mt7902_mcu_get_rx_rate(struct mt792x_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7902_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl);
+void mt7902_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
+int mt7902_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map);
+int mt7902_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value);
+int mt7902_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy, u8 action);
+
+static inline u32
+mt7902_reg_map_l1(struct mt792x_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static inline u32
+mt7902_l1_rr(struct mt792x_dev *dev, u32 addr)
+{
+	return mt76_rr(dev, mt7902_reg_map_l1(dev, addr));
+}
+
+static inline void
+mt7902_l1_wr(struct mt792x_dev *dev, u32 addr, u32 val)
+{
+	mt76_wr(dev, mt7902_reg_map_l1(dev, addr), val);
+}
+
+static inline u32
+mt7902_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	val |= mt7902_l1_rr(dev, addr) & ~mask;
+	mt7902_l1_wr(dev, addr, val);
+
+	return val;
+}
+
+#define mt7902_l1_set(dev, addr, val)	mt7902_l1_rmw(dev, addr, 0, val)
+#define mt7902_l1_clear(dev, addr, val)	mt7902_l1_rmw(dev, addr, val, 0)
+
+void mt7902_regd_update(struct mt792x_dev *dev);
+int mt7902_mac_init(struct mt792x_dev *dev);
+bool mt7902_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
+int mt7902_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+int mt7902_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
+void mt7902_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7902_mac_reset_work(struct work_struct *work);
+int mt7902e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info);
+
+bool mt7902_rx_check(struct mt76_dev *mdev, void *data, int len);
+void mt7902_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb, u32 *info);
+void mt7902_stats_work(struct work_struct *work);
+void mt7902_set_stream_he_caps(struct mt792x_phy *phy);
+int mt7902_init_debugfs(struct mt792x_dev *dev);
+
+int mt7902_mcu_set_beacon_filter(struct mt792x_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable);
+int mt7902_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7902_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7902_scan_work(struct work_struct *work);
+void mt7902_roc_work(struct work_struct *work);
+void mt7902_csa_work(struct work_struct *work);
+int mt7902_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+void mt7902_coredump_work(struct work_struct *work);
+int mt7902_get_txpwr_info(struct mt792x_dev *dev, struct mt7902_txpwr *txpwr);
+int mt7902_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len);
+int mt7902_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len);
+int mt7902_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq);
+
+int mt7902e_driver_own(struct mt792x_dev *dev);
+int mt7902e_mac_reset(struct mt792x_dev *dev);
+int mt7902e_mcu_init(struct mt792x_dev *dev);
+int mt7902s_wfsys_reset(struct mt792x_dev *dev);
+int mt7902s_mac_reset(struct mt792x_dev *dev);
+int mt7902s_init_reset(struct mt792x_dev *dev);
+
+int mt7902s_mcu_init(struct mt792x_dev *dev);
+int mt7902s_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt7902s_mcu_fw_pmctrl(struct mt792x_dev *dev);
+void mt7902_mac_add_txs(struct mt792x_dev *dev, void *data);
+void mt7902_set_runtime_pm(struct mt792x_dev *dev);
+void mt7902_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
+void mt7902_set_ipv6_ns_work(struct work_struct *work);
+
+int mt7902_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			   bool enable);
+int mt7902_mcu_config_sniffer(struct mt792x_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx);
+int mt7902_mcu_get_temperature(struct mt792x_phy *phy);
+
+int mt7902_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info);
+void mt7902_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e);
+bool mt7902_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
+
+/* usb */
+int mt7902_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      bool enable);
+int mt7902_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar);
+
+int mt7902_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap);
+int mt7902_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7902_roc_req type, u8 token_id);
+int mt7902_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+			 u8 token_id);
+void mt7902_roc_abort_sync(struct mt792x_dev *dev);
+int mt7902_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/pci.c b/drivers/net/wireless/mediatek/mt76/mt7902/pci.c
new file mode 100644
index 000000000..84fa2a8de
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/pci.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+
+#include "mt7902.h"
+#include "../mt76_connac2_mac.h"
+#include "../dma.h"
+#include "mcu.h"
+
+static const struct pci_device_id mt7902_pci_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
+		.driver_data = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ITTIM, 0x7922),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
+		.driver_data = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7920),
+		.driver_data = (kernel_ulong_t)MT7920_FIRMWARE_WM },
+	{ },
+};
+
+static bool mt7902_disable_aspm;
+module_param_named(disable_aspm, mt7902_disable_aspm, bool, 0644);
+MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
+
+static int mt7902e_init_reset(struct mt792x_dev *dev)
+{
+	return mt792x_wpdma_reset(dev, true);
+}
+
+static void mt7902e_unregister_device(struct mt792x_dev *dev)
+{
+	int i;
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (dev->phy.chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN)
+		wiphy_rfkill_stop_polling(hw->wiphy);
+
+	cancel_work_sync(&dev->init_work);
+	mt76_unregister_device(&dev->mt76);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+	cancel_work_sync(&dev->reset_work);
+
+	mt76_connac2_tx_token_put(&dev->mt76);
+	__mt792x_mcu_drv_pmctrl(dev);
+	mt792x_dma_cleanup(dev);
+	mt792x_wfsys_reset(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	tasklet_disable(&dev->mt76.irq_tasklet);
+}
+
+static u32 __mt7902_reg_addr(struct mt792x_dev *dev, u32 addr)
+{
+	static const struct mt76_connac_reg_map fixed_map[] = {
+		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+		{ 0x820ed000, 0x24800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820e4000, 0x21000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e7000, 0x21e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820eb000, 0x24200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820e2000, 0x20800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e5000, 0x21400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
+		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+		{ 0x54000000, 0x02000, 0x01000 }, /* WFDMA PCIE0 MCU DMA0 */
+		{ 0x55000000, 0x03000, 0x01000 }, /* WFDMA PCIE0 MCU DMA1 */
+		{ 0x58000000, 0x06000, 0x01000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+		{ 0x59000000, 0x07000, 0x01000 }, /* WFDMA PCIE1 MCU DMA1 */
+		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+		{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
+		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+		{ 0x820c0000, 0x08000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+		{ 0x820c8000, 0x0c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+		{ 0x820cc000, 0x0e000, 0x01000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820cd000, 0x0f000, 0x01000 }, /* WF_MDP_TOP */
+		{ 0x74030000, 0x10000, 0x10000 }, /* PCIE_MAC_IREG */
+		{ 0x820ce000, 0x21c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+		{ 0x820cf000, 0x22000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
+		{ 0x820e0000, 0x20000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+		{ 0x820e1000, 0x20400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+		{ 0x820e9000, 0x23400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+		{ 0x820ea000, 0x24000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+		{ 0x820ec000, 0x24600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+		{ 0x820f0000, 0xa0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+		{ 0x820f1000, 0xa0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+		{ 0x820f2000, 0xa0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+		{ 0x820f3000, 0xa0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+		{ 0x820f4000, 0xa1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+		{ 0x820f5000, 0xa1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+		{ 0x820f7000, 0xa1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+		{ 0x820f9000, 0xa3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+		{ 0x820fa000, 0xa4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+		{ 0x820fb000, 0xa4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+		{ 0x820fc000, 0xa4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+		{ 0x820fd000, 0xa4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	};
+	int i;
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+		u32 ofs;
+
+		if (addr < fixed_map[i].phys)
+			continue;
+
+		ofs = addr - fixed_map[i].phys;
+		if (ofs > fixed_map[i].size)
+			continue;
+
+		return fixed_map[i].maps + ofs;
+	}
+
+	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
+	    (addr >= 0x70000000 && addr < 0x78000000) ||
+	    (addr >= 0x7c000000 && addr < 0x7c400000))
+		return mt7902_reg_map_l1(dev, addr);
+
+	dev_err(dev->mt76.dev, "Access currently unsupported address %08x\n",
+		addr);
+
+	return 0;
+}
+
+static u32 mt7902_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	u32 addr = __mt7902_reg_addr(dev, offset);
+
+	return dev->bus_ops->rr(mdev, addr);
+}
+
+static void mt7902_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	u32 addr = __mt7902_reg_addr(dev, offset);
+
+	dev->bus_ops->wr(mdev, addr, val);
+}
+
+static u32 mt7902_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	u32 addr = __mt7902_reg_addr(dev, offset);
+
+	return dev->bus_ops->rmw(mdev, addr, mask, val);
+}
+
+static int mt7902_dma_init(struct mt792x_dev *dev)
+{
+	int ret;
+
+	mt76_dma_attach(&dev->mt76);
+
+	ret = mt792x_dma_disable(dev, true);
+	if (ret)
+		return ret;
+
+	/* init tx queue */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7902_TXQ_BAND0,
+					 MT7902_TX_RING_SIZE,
+					 MT_TX_RING_BASE, NULL, 0);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7902_TXQ_MCU_WM,
+				  MT7902_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7902_TXQ_FWDL,
+				  MT7902_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* event from WM before firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT7902_RXQ_MCU_WM,
+			       MT7902_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* Change mcu queue after firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7902_RXQ_MCU_WM,
+			       MT7902_RX_MCU_WA_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
+	if (ret)
+		return ret;
+
+	/* rx data */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7902_RXQ_BAND0, MT7902_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev, mt792x_poll_rx);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt792x_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	return mt792x_dma_enable(dev);
+}
+
+static int mt7902_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7902_TOKEN_SIZE,
+		.tx_prepare_skb = mt7902e_tx_prepare_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
+		.rx_check = mt7902_rx_check,
+		.rx_skb = mt7902_queue_rx_skb,
+		.rx_poll_complete = mt792x_rx_poll_complete,
+		.sta_add = mt7902_mac_sta_add,
+		.sta_event = mt7902_mac_sta_event,
+		.sta_remove = mt7902_mac_sta_remove,
+		.update_survey = mt792x_update_channel,
+		.set_channel = mt7902_set_channel,
+	};
+	static const struct mt792x_hif_ops mt7902_pcie_ops = {
+		.init_reset = mt7902e_init_reset,
+		.reset = mt7902e_mac_reset,
+		.mcu_init = mt7902e_mcu_init,
+		.drv_own = mt792xe_mcu_drv_pmctrl,
+		.fw_own = mt792xe_mcu_fw_pmctrl,
+	};
+	static const struct mt792x_irq_map irq_map = {
+		.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+		.tx = {
+			.all_complete_mask = MT_INT_TX_DONE_ALL,
+			.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+		},
+		.rx = {
+			.data_complete_mask = MT_INT_RX_DONE_DATA,
+			.wm_complete_mask = MT_INT_RX_DONE_WM,
+			.wm2_complete_mask = MT_INT_RX_DONE_WM2,
+		},
+	};
+	struct ieee80211_ops *ops;
+	struct mt76_bus_ops *bus_ops;
+	struct mt792x_dev *dev;
+	struct mt76_dev *mdev;
+	u16 cmd, chipid;
+	u8 features;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (!(cmd & PCI_COMMAND_MEMORY)) {
+		cmd |= PCI_COMMAND_MEMORY;
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto err_free_pci_vec;
+
+	if (mt7902_disable_aspm)
+		mt76_pci_disable_aspm(pdev);
+
+	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7902_ops,
+				      (void *)id->driver_data, &features);
+	if (!ops) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	pci_set_drvdata(pdev, mdev);
+
+	dev = container_of(mdev, struct mt792x_dev, mt76);
+	dev->fw_features = features;
+	dev->hif_ops = &mt7902_pcie_ops;
+	dev->irq_map = &irq_map;
+	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops) {
+		ret = -ENOMEM;
+		goto err_free_dev;
+	}
+
+	bus_ops->rr = mt7902_rr;
+	bus_ops->wr = mt7902_wr;
+	bus_ops->rmw = mt7902_rmw;
+	dev->mt76.bus = bus_ops;
+
+	if (!mt7902_disable_aspm && mt76_pci_aspm_supported(pdev))
+		dev->aspm_supported = true;
+
+	ret = mt792xe_mcu_fw_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = __mt792xe_mcu_drv_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
+	chipid = mt7902_l1_rr(dev, MT_HW_CHIPID);
+	if (chipid == 0x7961 && (mt7902_l1_rr(dev, MT_HW_BOUND) & BIT(7)))
+		chipid = 0x7920;
+	mdev->rev = (chipid << 16) |
+		    (mt7902_l1_rr(dev, MT_HW_REV) & 0xff);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	ret = mt792x_wfsys_reset(dev);
+	if (ret)
+		goto err_free_dev;
+
+	mt76_wr(dev, irq_map.host_irq_enable, 0);
+
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	ret = devm_request_irq(mdev->dev, pdev->irq, mt792x_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = mt7902_dma_init(dev);
+	if (ret)
+		goto err_free_irq;
+
+	ret = mt7902_register_device(dev);
+	if (ret)
+		goto err_free_irq;
+
+	if (of_property_read_bool(dev->mt76.dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev->mt76.dev, true);
+
+	return 0;
+
+err_free_irq:
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+err_free_dev:
+	mt76_free_device(&dev->mt76);
+err_free_pci_vec:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void mt7902_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+
+	if (of_property_read_bool(dev->mt76.dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev->mt76.dev, false);
+
+	mt7902e_unregister_device(dev);
+	set_bit(MT76_REMOVED, &mdev->phy.state);
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	mt76_free_device(&dev->mt76);
+	pci_free_irq_vectors(pdev);
+}
+
+static int mt7902_pci_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err;
+
+	pm->suspended = true;
+	flush_work(&dev->reset_work);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt7902_roc_abort_sync(dev);
+
+	err = mt792x_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto restore_suspend;
+
+	wait_event_timeout(dev->wait,
+			   !dev->regd_in_progress, 5 * HZ);
+
+	err = mt7902_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
+	if (err < 0)
+		goto restore_suspend;
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true, true);
+	if (err)
+		goto restore_suspend;
+
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
+
+	napi_disable(&mdev->tx_napi);
+	mt76_worker_disable(&mdev->tx_worker);
+
+	mt76_for_each_q_rx(mdev, i) {
+		napi_disable(&mdev->napi[i]);
+	}
+
+	/* wait until dma is idle  */
+	mt76_poll(dev, MT_WFDMA0_GLO_CFG,
+		  MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+		  MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000);
+
+	/* put dma disabled */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	/* disable interrupt */
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	synchronize_irq(pdev->irq);
+	tasklet_kill(&mdev->irq_tasklet);
+
+	err = mt792x_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_napi;
+
+	return 0;
+
+restore_napi:
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
+	mt76_connac_mcu_set_hif_suspend(mdev, false, true);
+
+restore_suspend:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+
+static int mt7902_pci_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err;
+
+	err = mt792x_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto failed;
+
+	mt792x_wpdma_reinit_cond(dev);
+
+	/* enable interrupt */
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_connac_irq_enable(&dev->mt76,
+			       dev->irq_map->tx.all_complete_mask |
+			       MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
+
+	/* put dma enabled */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	mt76_worker_enable(&mdev->tx_worker);
+
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_schedule(&mdev->napi[i]);
+	}
+	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
+
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
+	if (err < 0)
+		goto failed;
+
+	mt7902_regd_update(dev);
+	err = mt7902_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+
+static void mt7902_pci_shutdown(struct pci_dev *pdev)
+{
+	mt7902_pci_remove(pdev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mt7902_pm_ops, mt7902_pci_suspend, mt7902_pci_resume);
+
+static struct pci_driver mt7902_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7902_pci_device_table,
+	.probe		= mt7902_pci_probe,
+	.remove		= mt7902_pci_remove,
+	.shutdown	= mt7902_pci_shutdown,
+	.driver.pm	= pm_sleep_ptr(&mt7902_pm_ops),
+};
+
+module_pci_driver(mt7902_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, mt7902_pci_device_table);
+MODULE_FIRMWARE(MT7920_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7920_ROM_PATCH);
+MODULE_FIRMWARE(MT7902_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7902_ROM_PATCH);
+MODULE_FIRMWARE(MT7922_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7922_ROM_PATCH);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_DESCRIPTION("MediaTek MT7902E (PCIe) wireless driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c
new file mode 100644
index 000000000..e5ac52838
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include "mt7902.h"
+#include "../dma.h"
+#include "../mt76_connac2_mac.h"
+
+int mt7902e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_connac_hw_txp *txp;
+	struct mt76_txwi_cache *t;
+	int id, pid;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
+
+	if (sta) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->deflink.last_txs = jiffies;
+		}
+	}
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	mt76_connac2_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
+				    pid, qid, 0);
+
+	txp = (struct mt76_connac_hw_txp *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
+	mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
+
+	tx_info->skb = NULL;
+
+	return 0;
+}
+
+int mt7902e_mac_reset(struct mt792x_dev *dev)
+{
+	int i, err;
+
+	mt792xe_mcu_drv_pmctrl(dev);
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76_txq_schedule_all(&dev->mphy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mt76_connac2_tx_token_put(&dev->mt76);
+	idr_init(&dev->mt76.token);
+
+	mt792x_wpdma_reset(dev, true);
+
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+	}
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_schedule(&dev->mt76.napi[i]);
+	}
+	local_bh_enable();
+
+	dev->fw_assert = false;
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	mt76_wr(dev, dev->irq_map->host_irq_enable,
+		dev->irq_map->tx.all_complete_mask |
+		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	err = mt7902e_driver_own(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7902_start(&dev->phy);
+out:
+
+	napi_enable(&dev->mt76.tx_napi);
+	local_bh_disable();
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c
new file mode 100644
index 000000000..9bf33f41c
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include "mt7902.h"
+#include "mcu.h"
+
+int mt7902e_driver_own(struct mt792x_dev *dev)
+{
+	u32 reg = mt7902_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
+			    0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int
+mt7902_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *seq)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	int ret;
+
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	mdev->mcu.timeout = 3 * HZ;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		txq = MT_MCUQ_FWDL;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
+int mt7902e_mcu_init(struct mt792x_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7902_mcu_ops = {
+		.headroom = sizeof(struct mt76_connac2_mcu_txd),
+		.mcu_skb_send_msg = mt7902_mcu_send_message,
+		.mcu_parse_response = mt7902_mcu_parse_response,
+	};
+	int err;
+
+	dev->mt76.mcu_ops = &mt7902_mcu_ops;
+
+	err = mt7902e_driver_own(dev);
+	if (err)
+		return err;
+
+	mt76_rmw_field(dev, MT_PCIE_MAC_PM, MT_PCIE_MAC_PM_L0S_DIS, 1);
+
+	err = mt7902_run_firmware(dev);
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/regs.h b/drivers/net/wireless/mediatek/mt76/mt7902/regs.h
new file mode 100644
index 000000000..52f07d50e
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/regs.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7902_REGS_H
+#define __MT7902_REGS_H
+
+#include "../mt792x_regs.h"
+
+#define MT_MDP_BASE			0x820cd000
+#define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR0			MT_MDP(0x000)
+#define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+#define MT_MDP_DCR0_RX_HDR_TRANS_EN	BIT(19)
+
+#define MT_MDP_DCR1			MT_MDP(0x004)
+#define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
+
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
+#define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
+#define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
+
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
+#define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
+#define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
+#define MT_MDP_TO_HIF			0
+#define MT_MDP_TO_WM			1
+
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
+#define HOST_TX_DONE_INT_ENA8		BIT(12)
+#define HOST_TX_DONE_INT_ENA9		BIT(13)
+#define HOST_TX_DONE_INT_ENA10		BIT(14)
+#define HOST_TX_DONE_INT_ENA11		BIT(15)
+#define HOST_TX_DONE_INT_ENA12		BIT(16)
+#define HOST_TX_DONE_INT_ENA13		BIT(17)
+#define HOST_TX_DONE_INT_ENA14		BIT(18)
+#define HOST_RX_DONE_INT_ENA4		BIT(22)
+#define HOST_RX_DONE_INT_ENA5		BIT(23)
+#define HOST_TX_DONE_INT_ENA16		BIT(26)
+#define HOST_TX_DONE_INT_ENA17		BIT(27)
+
+/* WFDMA interrupt */
+#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA4
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
+					 MT_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+#define MT_INT_TX_DONE_MCU_WM		HOST_TX_DONE_INT_ENA17
+#define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
+#define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_BAND0 |	\
+					GENMASK(18, 4))
+
+#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x520)
+
+#define MT_INFRA_CFG_BASE		0xfe000
+#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+
+#define MT_HIF_REMAP_L1			MT_INFRA(0x24c)
+#define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1		0x40000
+
+#define MT_WFSYS_SW_RST_B		0x18000140
+
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7902/sdio.c
new file mode 100644
index 000000000..4596658d2
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/sdio.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "mt7902.h"
+#include "../sdio.h"
+#include "../mt76_connac2_mac.h"
+#include "mcu.h"
+
+static const struct sdio_device_id mt7902s_table[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901),
+		.driver_data = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	{ }	/* Terminating entry */
+};
+
+static void mt7902s_txrx_worker(struct mt76_worker *w)
+{
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
+	}
+
+	mt76s_txrx_worker(sdio);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
+
+static void mt7902s_unregister_device(struct mt792x_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	cancel_work_sync(&dev->init_work);
+	mt76_unregister_device(&dev->mt76);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt76s_deinit(&dev->mt76);
+	mt7902s_wfsys_reset(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76_free_device(&dev->mt76);
+}
+
+static int mt7902s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7902_sdio_intr *irq_data = sdio->intr_data;
+	int i, err;
+
+	sdio_claim_host(sdio->func);
+	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	sdio_release_host(sdio->func);
+
+	if (err < 0)
+		return err;
+
+	if (irq_data->rx.num[0] > 16 ||
+	    irq_data->rx.num[1] > 128)
+		return -EINVAL;
+
+	intr->isr = irq_data->isr;
+	intr->rec_mb = irq_data->rec_mb;
+	intr->tx.wtqcr = irq_data->tx.wtqcr;
+	intr->rx.num = irq_data->rx.num;
+	for (i = 0; i < 2 ; i++) {
+		if (!i)
+			intr->rx.len[0] = irq_data->rx.len0;
+		else
+			intr->rx.len[1] = irq_data->rx.len1;
+	}
+
+	return 0;
+}
+
+static int mt7902s_probe(struct sdio_func *func,
+			 const struct sdio_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_SDIO_TXD_SIZE,
+		.drv_flags = MT_DRV_AMSDU_OFFLOAD,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7902_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7902_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7902_usb_sdio_tx_status_data,
+		.rx_skb = mt7902_queue_rx_skb,
+		.rx_check = mt7902_rx_check,
+		.sta_add = mt7902_mac_sta_add,
+		.sta_event = mt7902_mac_sta_event,
+		.sta_remove = mt7902_mac_sta_remove,
+		.update_survey = mt792x_update_channel,
+		.set_channel = mt7902_set_channel,
+	};
+	static const struct mt76_bus_ops mt7902s_ops = {
+		.rr = mt76s_rr,
+		.rmw = mt76s_rmw,
+		.wr = mt76s_wr,
+		.write_copy = mt76s_write_copy,
+		.read_copy = mt76s_read_copy,
+		.wr_rp = mt76s_wr_rp,
+		.rd_rp = mt76s_rd_rp,
+		.type = MT76_BUS_SDIO,
+	};
+	static const struct mt792x_hif_ops mt7902_sdio_ops = {
+		.init_reset = mt7902s_init_reset,
+		.reset = mt7902s_mac_reset,
+		.mcu_init = mt7902s_mcu_init,
+		.drv_own = mt7902s_mcu_drv_pmctrl,
+		.fw_own = mt7902s_mcu_fw_pmctrl,
+	};
+	struct ieee80211_ops *ops;
+	struct mt792x_dev *dev;
+	struct mt76_dev *mdev;
+	u8 features;
+	int ret;
+
+	ops = mt792x_get_mac80211_ops(&func->dev, &mt7902_ops,
+				      (void *)id->driver_data, &features);
+	if (!ops)
+		return -ENOMEM;
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt792x_dev, mt76);
+	dev->fw_features = features;
+	dev->hif_ops = &mt7902_sdio_ops;
+	sdio_set_drvdata(func, dev);
+
+	ret = mt76s_init(mdev, func, &mt7902s_ops);
+	if (ret < 0)
+		goto error;
+
+	ret = mt76s_hw_init(mdev, func, MT76_CONNAC2_SDIO);
+	if (ret)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mdev->sdio.parse_irq = mt7902s_parse_intr;
+	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
+					    sizeof(struct mt7902_sdio_intr),
+					    GFP_KERNEL);
+	if (!mdev->sdio.intr_data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MCU);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_tx(mdev);
+	if (ret)
+		goto error;
+
+	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
+				mt7902s_txrx_worker, "sdio-txrx");
+	if (ret)
+		goto error;
+
+	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
+
+	ret = mt7902_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mt76s_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7902s_remove(struct sdio_func *func)
+{
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
+
+	mt7902s_unregister_device(dev);
+}
+
+static int mt7902s_suspend(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	int err;
+
+	pm->suspended = true;
+	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+
+	flush_work(&dev->reset_work);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt7902_roc_abort_sync(dev);
+
+	err = mt792x_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto restore_suspend;
+
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(mdev, true);
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&mdev->tx_worker);
+	mt76_worker_disable(&mdev->sdio.status_worker);
+	mt76_worker_disable(&mdev->sdio.stat_worker);
+	clear_bit(MT76_READING_STATS, &dev->mphy.state);
+	mt76_tx_status_check(mdev, true);
+
+	mt76_worker_schedule(&mdev->sdio.txrx_worker);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+
+	/* It is supposed that SDIO bus is idle at the point */
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true, true);
+	if (err)
+		goto restore_worker;
+
+	mt76_worker_disable(&mdev->sdio.txrx_worker);
+	mt76_worker_disable(&mdev->sdio.net_worker);
+
+	err = mt792x_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_txrx_worker;
+
+	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+
+	return 0;
+
+restore_txrx_worker:
+	mt76_worker_enable(&mdev->sdio.net_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_connac_mcu_set_hif_suspend(mdev, false, true);
+
+restore_worker:
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.stat_worker);
+
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+restore_suspend:
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+
+static int mt7902s_resume(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	int err;
+
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+
+	err = mt792x_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto failed;
+
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.net_worker);
+	mt76_worker_enable(&mdev->sdio.stat_worker);
+
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+
+MODULE_DEVICE_TABLE(sdio, mt7902s_table);
+MODULE_FIRMWARE(MT7902_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7902_ROM_PATCH);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mt7902s_pm_ops, mt7902s_suspend, mt7902s_resume);
+
+static struct sdio_driver mt7902s_driver = {
+	.name		= KBUILD_MODNAME,
+	.probe		= mt7902s_probe,
+	.remove		= mt7902s_remove,
+	.id_table	= mt7902s_table,
+	.drv.pm		= pm_sleep_ptr(&mt7902s_pm_ops),
+};
+module_sdio_driver(mt7902s_driver);
+MODULE_DESCRIPTION("MediaTek MT7902S (SDIO) wireless driver");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c
new file mode 100644
index 000000000..26bae33d7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include <linux/iopoll.h>
+#include <linux/mmc/sdio_func.h>
+#include "mt7902.h"
+#include "../mt76_connac2_mac.h"
+#include "../sdio.h"
+
+static void mt7902s_enable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static void mt7902s_disable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static u32 mt7902s_read_whcr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHCR, NULL);
+}
+
+int mt7902s_wfsys_reset(struct mt792x_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 val, status;
+
+	mt7902s_mcu_drv_pmctrl(dev);
+
+	sdio_claim_host(sdio->func);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	msleep(50);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_SDIO_WF_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	usleep_range(1000, 2000);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val |= WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	readx_poll_timeout(mt7902s_read_whcr, &dev->mt76, status,
+			   status & WF_RST_DONE, 50000, 2000000);
+
+	sdio_release_host(sdio->func);
+
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	/* activate mt7902s again */
+	mt7902s_mcu_drv_pmctrl(dev);
+	mt76_clear(dev, MT_CONN_STATUS, MT_WIFI_PATCH_DL_STATE);
+	mt7902s_mcu_fw_pmctrl(dev);
+	mt7902s_mcu_drv_pmctrl(dev);
+
+	return 0;
+}
+
+int mt7902s_init_reset(struct mt792x_dev *dev)
+{
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+
+	mt7902s_disable_irq(&dev->mt76);
+	mt7902s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7902s_enable_irq(&dev->mt76);
+
+	return 0;
+}
+
+int mt7902s_mac_reset(struct mt792x_dev *dev)
+{
+	int err;
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_disable(&dev->mt76.sdio.status_worker);
+	mt76_worker_disable(&dev->mt76.sdio.net_worker);
+	mt76_worker_disable(&dev->mt76.sdio.stat_worker);
+
+	mt7902s_disable_irq(&dev->mt76);
+	mt7902s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_enable(&dev->mt76.sdio.status_worker);
+	mt76_worker_enable(&dev->mt76.sdio.net_worker);
+	mt76_worker_enable(&dev->mt76.sdio.stat_worker);
+
+	dev->fw_assert = false;
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7902s_enable_irq(&dev->mt76);
+
+	err = mt7902_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7902_start(&dev->phy);
+out:
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c
new file mode 100644
index 000000000..7301d7961
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include <linux/kernel.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/module.h>
+#include <linux/iopoll.h>
+
+#include "mt7902.h"
+#include "../sdio.h"
+#include "../mt76_connac2_mac.h"
+#include "mcu.h"
+#include "regs.h"
+
+static int
+mt7902s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, int *seq)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	enum mt7902_sdio_pkt_type type = MT7902_SDIO_CMD;
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	int ret, pad;
+
+	/* We just return in case firmware assertion to avoid blocking the
+	 * common workqueue to run, for example, the coredump work might be
+	 * blocked by mt792x_mac_work that is excuting register access via sdio
+	 * bus.
+	 */
+	if (dev->fw_assert)
+		return -EBUSY;
+
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	mdev->mcu.timeout = 3 * HZ;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		type = MT7902_SDIO_FWDL;
+
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, type);
+	pad = round_up(skb->len, 4) - skb->len;
+	__skb_put_zero(skb, pad);
+
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+	if (ret)
+		return ret;
+
+	mt76_queue_kick(dev, mdev->q_mcu[txq]);
+
+	return ret;
+}
+
+static u32 mt7902s_read_rm3r(struct mt792x_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	return sdio_readl(sdio->func, MCR_D2HRM3R, NULL);
+}
+
+static u32 mt7902s_clear_rm3r_drv_own(struct mt792x_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 val;
+
+	val = sdio_readl(sdio->func, MCR_D2HRM3R, NULL);
+	if (val)
+		sdio_writel(sdio->func, H2D_SW_INT_CLEAR_MAILBOX_ACK,
+			    MCR_WSICR, NULL);
+
+	return val;
+}
+
+int mt7902s_mcu_init(struct mt792x_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7902s_mcu_ops = {
+		.headroom = MT_SDIO_HDR_SIZE +
+			    sizeof(struct mt76_connac2_mcu_txd),
+		.tailroom = MT_SDIO_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7902s_mcu_send_message,
+		.mcu_parse_response = mt7902_mcu_parse_response,
+		.mcu_rr = mt76_connac_mcu_reg_rr,
+		.mcu_wr = mt76_connac_mcu_reg_wr,
+	};
+	int ret;
+
+	mt7902s_mcu_drv_pmctrl(dev);
+
+	dev->mt76.mcu_ops = &mt7902s_mcu_ops;
+
+	ret = mt7902_run_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	return 0;
+}
+
+int mt7902s_mcu_drv_pmctrl(struct mt792x_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	u32 status;
+	int err;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
+
+	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+
+	if (!err && test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+		err = readx_poll_timeout(mt7902s_read_rm3r, dev, status,
+					 status & D2HRM3R_IS_DRIVER_OWN,
+					 2000, 1000000);
+
+	sdio_release_host(func);
+
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "driver own failed\n");
+		return -EIO;
+	}
+
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
+
+	return 0;
+}
+
+int mt7902s_mcu_fw_pmctrl(struct mt792x_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	u32 status;
+	int err;
+
+	sdio_claim_host(func);
+
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+		err = readx_poll_timeout(mt7902s_clear_rm3r_drv_own,
+					 dev, status,
+					 !(status & D2HRM3R_IS_DRIVER_OWN),
+					 2000, 1000000);
+		if (err < 0) {
+			dev_err(dev->mt76.dev, "mailbox ACK not cleared\n");
+			goto out;
+		}
+	}
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
+
+	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
+				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
+out:
+	sdio_release_host(func);
+
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "firmware own failed\n");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		return -EIO;
+	}
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7902/testmode.c
new file mode 100644
index 000000000..ab0dbbeb0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/testmode.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: ISC
+
+#include "mt7902.h"
+#include "mcu.h"
+
+enum mt7902_testmode_attr {
+	MT7902_TM_ATTR_UNSPEC,
+	MT7902_TM_ATTR_SET,
+	MT7902_TM_ATTR_QUERY,
+	MT7902_TM_ATTR_RSP,
+
+	/* keep last */
+	NUM_MT7902_TM_ATTRS,
+	MT7902_TM_ATTR_MAX = NUM_MT7902_TM_ATTRS - 1,
+};
+
+struct mt7902_tm_cmd {
+	u8 action;
+	u32 param0;
+	u32 param1;
+};
+
+struct mt7902_tm_evt {
+	u32 param0;
+	u32 param1;
+};
+
+static const struct nla_policy mt7902_tm_policy[NUM_MT7902_TM_ATTRS] = {
+	[MT7902_TM_ATTR_SET] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7902_tm_cmd)),
+	[MT7902_TM_ATTR_QUERY] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7902_tm_cmd)),
+};
+
+static int
+mt7902_tm_set(struct mt792x_dev *dev, struct mt7902_tm_cmd *req)
+{
+	struct mt7902_rftest_cmd cmd = {
+		.action = req->action,
+		.param0 = cpu_to_le32(req->param0),
+		.param1 = cpu_to_le32(req->param1),
+	};
+	bool testmode = false, normal = false;
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_phy *phy = &dev->mphy;
+	int ret = -ENOTCONN;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (req->action == TM_SWITCH_MODE) {
+		if (req->param0 == MT7902_TM_NORMAL)
+			normal = true;
+		else
+			testmode = true;
+	}
+
+	if (testmode) {
+		/* Make sure testmode running on full power mode */
+		pm->enable = false;
+		cancel_delayed_work_sync(&pm->ps_work);
+		cancel_work_sync(&pm->wake_work);
+		__mt792x_mcu_drv_pmctrl(dev);
+
+		phy->test.state = MT76_TM_STATE_ON;
+	}
+
+	if (!mt76_testmode_enabled(phy))
+		goto out;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL), &cmd,
+				sizeof(cmd), false);
+	if (ret)
+		goto out;
+
+	if (normal) {
+		/* Switch back to the normal world */
+		phy->test.state = MT76_TM_STATE_OFF;
+		pm->enable = true;
+	}
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7902_tm_query(struct mt792x_dev *dev, struct mt7902_tm_cmd *req,
+		struct mt7902_tm_evt *evt_resp)
+{
+	struct mt7902_rftest_cmd cmd = {
+		.action = req->action,
+		.param0 = cpu_to_le32(req->param0),
+		.param1 = cpu_to_le32(req->param1),
+	};
+	struct mt7902_rftest_evt *evt;
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL),
+					&cmd, sizeof(cmd), true, &skb);
+	if (ret)
+		goto out;
+
+	evt = (struct mt7902_rftest_evt *)skb->data;
+	evt_resp->param0 = le32_to_cpu(evt->param0);
+	evt_resp->param1 = le32_to_cpu(evt->param1);
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+int mt7902_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt792x_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return -ENOTCONN;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7902_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7902_TM_ATTR_MAX,
+						  data, mt7902_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7902_TM_ATTR_SET];
+		if (data)
+			return mt7902_tm_set(phy->dev, nla_data(data));
+	}
+
+	return -EINVAL;
+}
+
+int mt7902_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt792x_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR) ||
+	    !mt76_testmode_enabled(mphy))
+		return -ENOTCONN;
+
+	if (cb->args[2]++ > 0)
+		return -ENOENT;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7902_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7902_TM_ATTR_MAX,
+						  data, mt7902_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7902_TM_ATTR_QUERY];
+		if (data) {
+			struct mt7902_tm_evt evt_resp;
+
+			err = mt7902_tm_query(phy->dev, nla_data(data),
+					      &evt_resp);
+			if (err)
+				return err;
+
+			return nla_put(msg, MT7902_TM_ATTR_RSP,
+				       sizeof(evt_resp), &evt_resp);
+		}
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/usb.c b/drivers/net/wireless/mediatek/mt76/mt7902/usb.c
new file mode 100644
index 000000000..0ba7495be
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/usb.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2022 MediaTek Inc.
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "mt7902.h"
+#include "mcu.h"
+#include "../mt76_connac2_mac.h"
+
+static const struct usb_device_id mt7902u_device_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	/* Comfast CF-952AX */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6211, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	/* Netgear, Inc. [A8000,AXE3000] */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	/* TP-Link TXE50UH */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7902_FIRMWARE_WM },
+	{ },
+};
+
+static int
+mt7902u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, int *seq)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	u32 pad, ep;
+	int ret;
+
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	mdev->mcu.timeout = 3 * HZ;
+
+	if (cmd != MCU_CMD(FW_SCATTER))
+		ep = MT_EP_OUT_INBAND_CMD;
+	else
+		ep = MT_EP_OUT_AC_BE;
+
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, 0);
+	pad = round_up(skb->len, 4) + 4 - skb->len;
+	__skb_put_zero(skb, pad);
+
+	ret = mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
+			     1000, ep);
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+static int mt7902u_mcu_init(struct mt792x_dev *dev)
+{
+	static const struct mt76_mcu_ops mcu_ops = {
+		.headroom = MT_SDIO_HDR_SIZE +
+			    sizeof(struct mt76_connac2_mcu_txd),
+		.tailroom = MT_USB_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7902u_mcu_send_message,
+		.mcu_parse_response = mt7902_mcu_parse_response,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mcu_ops;
+
+	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+	ret = mt7902_run_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	return 0;
+}
+
+static int mt7902u_mac_reset(struct mt792x_dev *dev)
+{
+	int err;
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76u_stop_rx(&dev->mt76);
+	mt76u_stop_tx(&dev->mt76);
+
+	mt792xu_wfsys_reset(dev);
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err)
+		goto out;
+
+	err = mt792xu_mcu_power_on(dev);
+	if (err)
+		goto out;
+
+	err = mt792xu_dma_init(dev, false);
+	if (err)
+		goto out;
+
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	err = mt7902_run_firmware(dev);
+	if (err)
+		goto out;
+
+	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	err = mt7902_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7902_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7902_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
+
+static int mt7902u_probe(struct usb_interface *usb_intf,
+			 const struct usb_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_SDIO_TXD_SIZE,
+		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7902_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7902_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7902_usb_sdio_tx_status_data,
+		.rx_skb = mt7902_queue_rx_skb,
+		.rx_check = mt7902_rx_check,
+		.sta_add = mt7902_mac_sta_add,
+		.sta_event = mt7902_mac_sta_event,
+		.sta_remove = mt7902_mac_sta_remove,
+		.update_survey = mt792x_update_channel,
+		.set_channel = mt7902_set_channel,
+	};
+	static const struct mt792x_hif_ops hif_ops = {
+		.mcu_init = mt7902u_mcu_init,
+		.init_reset = mt792xu_init_reset,
+		.reset = mt7902u_mac_reset,
+	};
+	static struct mt76_bus_ops bus_ops = {
+		.rr = mt792xu_rr,
+		.wr = mt792xu_wr,
+		.rmw = mt792xu_rmw,
+		.read_copy = mt76u_read_copy,
+		.write_copy = mt792xu_copy,
+		.type = MT76_BUS_USB,
+	};
+	struct usb_device *udev = interface_to_usbdev(usb_intf);
+	struct ieee80211_ops *ops;
+	struct ieee80211_hw *hw;
+	struct mt792x_dev *dev;
+	struct mt76_dev *mdev;
+	u8 features;
+	int ret;
+
+	ops = mt792x_get_mac80211_ops(&usb_intf->dev, &mt7902_ops,
+				      (void *)id->driver_info, &features);
+	if (!ops)
+		return -ENOMEM;
+
+	ops->stop = mt792xu_stop;
+	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt792x_dev, mt76);
+	dev->fw_features = features;
+	dev->hif_ops = &hif_ops;
+
+	udev = usb_get_dev(udev);
+	usb_reset_device(udev);
+
+	usb_set_intfdata(usb_intf, dev);
+
+	ret = __mt76u_init(mdev, usb_intf, &bus_ops);
+	if (ret < 0)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	if (mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY)) {
+		ret = mt792xu_wfsys_reset(dev);
+		if (ret)
+			goto error;
+	}
+
+	ret = mt792xu_mcu_power_on(dev);
+	if (ret)
+		goto error;
+
+	ret = mt76u_alloc_mcu_queue(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt76u_alloc_queues(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt792xu_dma_init(dev, false);
+	if (ret)
+		goto error;
+
+	hw = mt76_hw(dev);
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = mdev->usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
+
+	ret = mt7902_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mt76u_queues_deinit(&dev->mt76);
+
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int mt7902u_suspend(struct usb_interface *intf, pm_message_t state)
+{
+	struct mt792x_dev *dev = usb_get_intfdata(intf);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	pm->suspended = true;
+	flush_work(&dev->reset_work);
+
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, true);
+	if (err)
+		goto failed;
+
+	mt76u_stop_rx(&dev->mt76);
+	mt76u_stop_tx(&dev->mt76);
+
+	return 0;
+
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+
+static int mt7902u_resume(struct usb_interface *intf)
+{
+	struct mt792x_dev *dev = usb_get_intfdata(intf);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool reinit = true;
+	int err, i;
+
+	for (i = 0; i < 10; i++) {
+		u32 val = mt76_rr(dev, MT_WF_SW_DEF_CR_USB_MCU_EVENT);
+
+		if (!(val & MT_WF_SW_SER_TRIGGER_SUSPEND)) {
+			reinit = false;
+			break;
+		}
+		if (val & MT_WF_SW_SER_DONE_SUSPEND) {
+			mt76_wr(dev, MT_WF_SW_DEF_CR_USB_MCU_EVENT, 0);
+			break;
+		}
+
+		msleep(20);
+	}
+
+	if (reinit || mt792x_dma_need_reinit(dev)) {
+		err = mt792xu_dma_init(dev, true);
+		if (err)
+			goto failed;
+	}
+
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err < 0)
+		goto failed;
+
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false, true);
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt792x_reset(&dev->mt76);
+
+	return err;
+}
+#endif /* CONFIG_PM */
+
+MODULE_DEVICE_TABLE(usb, mt7902u_device_table);
+MODULE_FIRMWARE(MT7902_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7902_ROM_PATCH);
+
+static struct usb_driver mt7902u_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7902u_device_table,
+	.probe		= mt7902u_probe,
+	.disconnect	= mt792xu_disconnect,
+#ifdef CONFIG_PM
+	.suspend	= mt7902u_suspend,
+	.resume		= mt7902u_resume,
+	.reset_resume	= mt7902u_resume,
+#endif /* CONFIG_PM */
+	.soft_unbind	= 1,
+	.disable_hub_initiated_lpm = 1,
+};
+module_usb_driver(mt7902u_driver);
+
+MODULE_DESCRIPTION("MediaTek MT7902U (USB) wireless driver");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


