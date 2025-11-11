Return-Path: <linux-wireless+bounces-28820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B91C4B345
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867D93B291F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91E347BCA;
	Tue, 11 Nov 2025 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hArzYEjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E922BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827934; cv=none; b=D4iZivUwQcK1TUL42Tv1EhCB5LuWBFaQBOaIAJMZmbZclrUULKqDe/Hg4HoOHjrGqHmg7CGJkwGGuWvH6PWVm0/K9IHYcZNWvx7T8Koy9nE2c10BqxY465b248H/iXogysnsL6JSPjQxxdY0zw9Y2vSo+gOoZemmwm2rGmwwQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827934; c=relaxed/simple;
	bh=P86ppDDtlS30LQ8ji3urP2v9u6zXg19iomYduiUeZ5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDLowXZ0KJHTC1CBTLOqtaQ/NF1rAxxKyybZIRnIuph9QpF1z1q0TQTG0TdwZSTN3xBJDQ7Vn4FgjfGLQJcPsKjOFxkzQ5/TwdJHpqBe/0ZsNcJuacGvjKeuQMZ/uz0LwuarhKxLNSb0cgzlYHrSq5jdqmmziRQK+lzzUB0zGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hArzYEjE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2PU6Q02921530, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827930; bh=gMi/y05S8GnSB6Ft03nFW7aNEiES/TGD317JTFthhuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hArzYEjEo14uV1R6POxurmf/G2RBd8SpAXruZc3Yb+IoF9V82HdeBfZUWkNqKSIUh
	 +x9IHTj+N6vi1pSupolV8weriFNc6ZxONXJz0LtuXXzfuokjP70W3BAXqEZWJ4N6gv
	 8I266JBCqo9vvUxWgAE+DJzeHRcqYS1GanhzFSBzqTXd/uz3bpT82MlZBrZDfzz89n
	 4wLuIQcdF5Ldk/XwyzZuvjLglIbCeZIbpf2LiYyHmA5DfGW3pl6ekKlXBx1wcrH7A3
	 svFnVJMKQdkxvuKAz4nXa33ffO/gVaovQmpMV4kY5GKLSkgnv8D0wiBXpuypSUIAKc
	 gX3Se9jMTuDYw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2PU6Q02921530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:30 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 1/8] wifi: rtw89: pci: add to read PCI configuration space from common code
Date: Tue, 11 Nov 2025 10:24:45 +0800
Message-ID: <20251111022452.28093-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Normally only access PCI device in pci.c. However for debug purpose,
a set of registers predefined in firmware element including PCI
configuration space should be read for diagnosis.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  2 --
 drivers/net/wireless/realtek/rtw89/pci.c  | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 71eb7078a0dc..e6584462f6c0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -39,6 +39,8 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RFREG_MASK 0xfffff
 #define INV_RF_DATA 0xffffffff
 #define BYPASS_CR_DATA 0xbabecafe
+#define RTW89_R32_EA 0xEAEAEAEA
+#define RTW89_R32_DEAD 0xDEADBEEF
 
 #define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
 #define RTW89_TRACK_PS_WORK_PERIOD msecs_to_jiffies(100)
@@ -3674,6 +3676,8 @@ struct rtw89_hci_ops {
 	void (*write16)(struct rtw89_dev *rtwdev, u32 addr, u16 data);
 	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
+	u32 (*read32_pci_cfg)(struct rtw89_dev *rtwdev, u32 addr);
+
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
 	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
@@ -6658,6 +6662,15 @@ rtw89_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	mutex_unlock(&rtwdev->rf_mutex);
 }
 
+static inline u32 rtw89_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
+{
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE ||
+	    !rtwdev->hci.ops->read32_pci_cfg)
+		return RTW89_R32_EA;
+
+	return rtwdev->hci.ops->read32_pci_cfg(rtwdev, addr);
+}
+
 static inline struct ieee80211_txq *rtw89_txq_to_txq(struct rtw89_txq *rtwtxq)
 {
 	void *p = rtwtxq;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 868413335f6c..3cc97fd0c0ec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -581,8 +581,6 @@ enum rtw89_mac_bf_rrsc_rate {
 	RTW89_MAC_BF_RRSC_MAX = 32
 };
 
-#define RTW89_R32_EA		0xEAEAEAEA
-#define RTW89_R32_DEAD		0xDEADBEEF
 #define MAC_REG_POOL_COUNT	10
 #define ACCESS_CMAC(_addr) \
 	({typeof(_addr) __addr = (_addr); \
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b1985193a18f..a66fcdb0293b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2064,6 +2064,20 @@ static void rtw89_pci_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
 	writel(data, rtwpci->mmap + addr);
 }
 
+static u32 rtw89_pci_ops_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u32 value;
+	int ret;
+
+	ret = pci_read_config_dword(pdev, addr, &value);
+	if (ret)
+		return RTW89_R32_EA;
+
+	return value;
+}
+
 static void rtw89_pci_ctrl_dma_trx(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -4683,6 +4697,8 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.write16	= rtw89_pci_ops_write16,
 	.write32	= rtw89_pci_ops_write32,
 
+	.read32_pci_cfg	= rtw89_pci_ops_read32_pci_cfg,
+
 	.mac_pre_init	= rtw89_pci_ops_mac_pre_init,
 	.mac_pre_deinit	= rtw89_pci_ops_mac_pre_deinit,
 	.mac_post_init	= rtw89_pci_ops_mac_post_init,
-- 
2.25.1


