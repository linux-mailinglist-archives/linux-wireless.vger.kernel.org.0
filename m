Return-Path: <linux-wireless+bounces-11169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279894CB23
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E19F1C22A79
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBD17335E;
	Fri,  9 Aug 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kVFlya1i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83781741FB
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188064; cv=none; b=hZfnXagke74AViQ9iUmVGt5+jPVfcC1LvOjIt1CBaQv2HtLuHIYIAGxPz+uRXum/3wQaGDZB8CAmFQabR6PncGVjJdlxURZhkh4a0BSLk/b446wPZU2tkmAQp2sTnJy0i5rbJhBMmtT6v4ufrGnRlFZKr44KSzwlzLMNOZY5o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188064; c=relaxed/simple;
	bh=Vl+MpHF0ZTMXVupMmdNre+A1x8D8sFmLib1+y4j2Mc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUyJDytkaPXi4Mcioad/uEFfaFlLC+DYpV/6wv6my9/ZL6+gihWaME1u05WUIZTBcMDGeZewIqmOnh425Ad7HUFUyGMOdVGdzeAqHTyPOIQ8TxOQllDGJx3DkzsHsdG6qF0Tq6i0m+hcwY+l7DZm+Ge7p+eCVl+jlgs7p652mwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kVFlya1i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797L0mU4514090, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188060; bh=Vl+MpHF0ZTMXVupMmdNre+A1x8D8sFmLib1+y4j2Mc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kVFlya1iMs+evcLJLdSAJ/52TH04RVwQbkD5+3kJcZLdtYEeUgw+ICEGiIfuLeT5V
	 /oG8nKI0jmSvBu2J2PVd6/IYgmo7GxfWfvHpuF2NhlHM2PCvILZjvIlXzgZZsS7zV9
	 4yZm2RlzK7HrAplNx+1EbqVdI409ugZgsZ13OgdqIzWty4UFcKCBqfJnvQ4qJoIv/H
	 h0ioQ/YFIqcnVO5NJNBfArM/U6lPYbckRoGhv0eeEyEyXpMJh9jiCkDqq/l38/yFwf
	 1n3nn/8Fza5QuutNK5K9KGlksEhIdqPXGI1IUg15iewW5YkYa90zfqpgvvJr8KMc+K
	 y4It/R7DLi4Hw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797L0mU4514090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:21:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:21:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 6/6] wifi: rtw89: debugfs: support multiple adapters debugging
Date: Fri, 9 Aug 2024 15:20:12 +0800
Message-ID: <20240809072012.84152-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The rtw89 uses debugfs to access registers and driver states. To get
a range of registers, the range value is set and stored to a variable, and
get the set of register values by the stored range. However, the variable
is a static global variable, which multiple adapters will be a problem,
so move the variable to adapter context rtw89_dev.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |   2 +
 drivers/net/wireless/realtek/rtw89/core.h  |   3 +
 drivers/net/wireless/realtek/rtw89/debug.c | 156 ++++++++++-----------
 drivers/net/wireless/realtek/rtw89/debug.h |   2 +
 4 files changed, 82 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7b28f2c2a08e..885c759e694a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4767,6 +4767,8 @@ EXPORT_SYMBOL(rtw89_core_register);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev)
 {
 	rtw89_core_unregister_hw(rtwdev);
+
+	rtw89_debugfs_deinit(rtwdev);
 }
 EXPORT_SYMBOL(rtw89_core_unregister);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3edb2f4372e4..c4702882367e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -21,6 +21,7 @@ struct rtw89_efuse_block_cfg;
 struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
+struct rtw89_debugfs;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -5529,6 +5530,8 @@ struct rtw89_dev {
 	struct napi_struct napi;
 	int napi_budget_countdown;
 
+	struct rtw89_debugfs *debugfs;
+
 	/* HCI related data, keep last */
 	u8 priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index bb65b814585a..a456bc02701a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -52,6 +52,27 @@ struct rtw89_debugfs_priv {
 	};
 };
 
+struct rtw89_debugfs {
+	struct rtw89_debugfs_priv read_reg;
+	struct rtw89_debugfs_priv write_reg;
+	struct rtw89_debugfs_priv read_rf;
+	struct rtw89_debugfs_priv write_rf;
+	struct rtw89_debugfs_priv rf_reg_dump;
+	struct rtw89_debugfs_priv txpwr_table;
+	struct rtw89_debugfs_priv mac_reg_dump;
+	struct rtw89_debugfs_priv mac_mem_dump;
+	struct rtw89_debugfs_priv mac_dbg_port_dump;
+	struct rtw89_debugfs_priv send_h2c;
+	struct rtw89_debugfs_priv early_h2c;
+	struct rtw89_debugfs_priv fw_crash;
+	struct rtw89_debugfs_priv btc_info;
+	struct rtw89_debugfs_priv btc_manual;
+	struct rtw89_debugfs_priv fw_log_manual;
+	struct rtw89_debugfs_priv phy_info;
+	struct rtw89_debugfs_priv stations;
+	struct rtw89_debugfs_priv disable_dm;
+};
+
 static const u16 rtw89_rate_info_bw_to_mhz_map[] = {
 	[RATE_INFO_BW_20] = 20,
 	[RATE_INFO_BW_40] = 40,
@@ -3463,9 +3484,9 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw89_debug_fw_log_manual_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_fw_log_manual_set(struct file *filp,
+						  const char __user *user_buf,
+						  size_t count, loff_t *loff)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
@@ -3854,92 +3875,55 @@ rtw89_debug_priv_disable_dm_set(struct file *filp, const char __user *user_buf,
 	return count;
 }
 
-static struct rtw89_debugfs_priv rtw89_debug_priv_read_reg = {
-	.cb_read = rtw89_debug_priv_read_reg_get,
-	.cb_write = rtw89_debug_priv_read_reg_select,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_write_reg = {
-	.cb_write = rtw89_debug_priv_write_reg_set,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_read_rf = {
-	.cb_read = rtw89_debug_priv_read_rf_get,
-	.cb_write = rtw89_debug_priv_read_rf_select,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_write_rf = {
-	.cb_write = rtw89_debug_priv_write_rf_set,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_rf_reg_dump = {
-	.cb_read = rtw89_debug_priv_rf_reg_dump_get,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_txpwr_table = {
-	.cb_read = rtw89_debug_priv_txpwr_table_get,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_mac_reg_dump = {
-	.cb_read = rtw89_debug_priv_mac_reg_dump_get,
-	.cb_write = rtw89_debug_priv_mac_reg_dump_select,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_mac_mem_dump = {
-	.cb_read = rtw89_debug_priv_mac_mem_dump_get,
-	.cb_write = rtw89_debug_priv_mac_mem_dump_select,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_mac_dbg_port_dump = {
-	.cb_read = rtw89_debug_priv_mac_dbg_port_dump_get,
-	.cb_write = rtw89_debug_priv_mac_dbg_port_dump_select,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_send_h2c = {
-	.cb_write = rtw89_debug_priv_send_h2c_set,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_early_h2c = {
-	.cb_read = rtw89_debug_priv_early_h2c_get,
-	.cb_write = rtw89_debug_priv_early_h2c_set,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_fw_crash = {
-	.cb_read = rtw89_debug_priv_fw_crash_get,
-	.cb_write = rtw89_debug_priv_fw_crash_set,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_btc_info = {
-	.cb_read = rtw89_debug_priv_btc_info_get,
-};
-
-static struct rtw89_debugfs_priv rtw89_debug_priv_btc_manual = {
-	.cb_write = rtw89_debug_priv_btc_manual_set,
-};
+#define rtw89_debug_priv_get(name)				\
+{								\
+	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+}
 
-static struct rtw89_debugfs_priv rtw89_debug_priv_fw_log_manual = {
-	.cb_write = rtw89_debug_fw_log_manual_set,
-};
+#define rtw89_debug_priv_set(name)				\
+{								\
+	.cb_write = rtw89_debug_priv_ ##name## _set,		\
+}
 
-static struct rtw89_debugfs_priv rtw89_debug_priv_phy_info = {
-	.cb_read = rtw89_debug_priv_phy_info_get,
-};
+#define rtw89_debug_priv_select_and_get(name)			\
+{								\
+	.cb_write = rtw89_debug_priv_ ##name## _select,		\
+	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+}
 
-static struct rtw89_debugfs_priv rtw89_debug_priv_stations = {
-	.cb_read = rtw89_debug_priv_stations_get,
-};
+#define rtw89_debug_priv_set_and_get(name)			\
+{								\
+	.cb_write = rtw89_debug_priv_ ##name## _set,		\
+	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+}
 
-static struct rtw89_debugfs_priv rtw89_debug_priv_disable_dm = {
-	.cb_read = rtw89_debug_priv_disable_dm_get,
-	.cb_write = rtw89_debug_priv_disable_dm_set,
+static const struct rtw89_debugfs rtw89_debugfs_templ = {
+	.read_reg = rtw89_debug_priv_select_and_get(read_reg),
+	.write_reg = rtw89_debug_priv_set(write_reg),
+	.read_rf = rtw89_debug_priv_select_and_get(read_rf),
+	.write_rf = rtw89_debug_priv_set(write_rf),
+	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump),
+	.txpwr_table = rtw89_debug_priv_get(txpwr_table),
+	.mac_reg_dump = rtw89_debug_priv_select_and_get(mac_reg_dump),
+	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump),
+	.mac_dbg_port_dump = rtw89_debug_priv_select_and_get(mac_dbg_port_dump),
+	.send_h2c = rtw89_debug_priv_set(send_h2c),
+	.early_h2c = rtw89_debug_priv_set_and_get(early_h2c),
+	.fw_crash = rtw89_debug_priv_set_and_get(fw_crash),
+	.btc_info = rtw89_debug_priv_get(btc_info),
+	.btc_manual = rtw89_debug_priv_set(btc_manual),
+	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual),
+	.phy_info = rtw89_debug_priv_get(phy_info),
+	.stations = rtw89_debug_priv_get(stations),
+	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
 	do {									\
-		rtw89_debug_priv_ ##name.rtwdev = rtwdev;			\
-		if (!debugfs_create_file(#name, mode,				\
-					 parent, &rtw89_debug_priv_ ##name,	\
-					 &file_ops_ ##fopname))			\
+		struct rtw89_debugfs_priv *priv = &rtwdev->debugfs->name;	\
+		priv->rtwdev = rtwdev;						\
+		if (IS_ERR(debugfs_create_file(#name, mode, parent, priv,	\
+					       &file_ops_ ##fopname)))		\
 			pr_debug("Unable to initialize debugfs:%s\n", #name);	\
 	} while (0)
 
@@ -3954,6 +3938,11 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 {
 	struct dentry *debugfs_topdir;
 
+	rtwdev->debugfs = kmemdup(&rtw89_debugfs_templ,
+				  sizeof(rtw89_debugfs_templ), GFP_KERNEL);
+	if (!rtwdev->debugfs)
+		return;
+
 	debugfs_topdir = debugfs_create_dir("rtw89",
 					    rtwdev->hw->wiphy->debugfsdir);
 
@@ -3976,6 +3965,11 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 	rtw89_debugfs_add_r(stations);
 	rtw89_debugfs_add_rw(disable_dm);
 }
+
+void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev)
+{
+	kfree(rtwdev->debugfs);
+}
 #endif
 
 #ifdef CONFIG_RTW89_DEBUGMSG
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index 800ea59873a1..fc690f7c55dc 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -49,8 +49,10 @@ enum rtw89_debug_mac_reg_sel {
 
 #ifdef CONFIG_RTW89_DEBUGFS
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev);
+void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev);
 #else
 static inline void rtw89_debugfs_init(struct rtw89_dev *rtwdev) {}
+static inline void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev) {}
 #endif
 
 #define rtw89_info(rtwdev, a...) dev_info((rtwdev)->dev, ##a)
-- 
2.25.1


