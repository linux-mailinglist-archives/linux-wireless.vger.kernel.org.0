Return-Path: <linux-wireless+bounces-17818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20324A18B9D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559AE169591
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3919007D;
	Wed, 22 Jan 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WEGCPQgM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7F14A619
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525841; cv=none; b=R8ax9lBTT4ltH8eZYlq+fa4eVqyFv2VEgEnm47D3jhUJs02fHFBa7i8ynHxRYmdh4kG1nMLRryGZUd4EZgpLEBAZijFSFF8o6UxxfLckCHZ8MLsVsC2kYdsGas+d4gzyVG/VI7ILAq3Y6DFb3OqhPXnGaYta1ywLibWKn4lhXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525841; c=relaxed/simple;
	bh=rk8cIueChkOzsXc6fsYU+V4Ow1pMwIlFyoFwB08aqz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdcU/rC2e8HZGZj57Y6W3DvYXpNYr1QqhDnMutNKF+IUzdS5CLd5P+xicKNAnSEX+rscTXbzCkE8/IJWNDAjboGpy5vDNkoTPSh7NxHjJj7WyCT8wYKZMp+DROWTOKn+U5RQ0Sm9MFVZbw4lBqSvZAQZE87yQmCUQMhuzYDtK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WEGCPQgM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M63tveE2495072, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525835; bh=rk8cIueChkOzsXc6fsYU+V4Ow1pMwIlFyoFwB08aqz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WEGCPQgM4VCs01fWdGrQGsaDRu4p7gUKuTmwwjYwDi1lwEWE1pdrCzUbJ4HwlTFle
	 viBWC7DizwH35qE1eJVctYe8rtnO/Xgpu5VVUJMBX/5siO891bkrg3kq7HaNR3rlfW
	 k/O5Vw3tkraVt4y/bibTepkV5TVvt1kjB0j/PB9KDH6fB45kNyJlVi2s7sJak2MnmV
	 /PEVVW9aKD99teFCI8y8tXBHchUH9iJesyPjCaQWQyLtZp51sGR06UhXgYb3vB4lck
	 qZuMXeE+N7b/u/bbJ8XRSY3JXztsEQwPI3szmft1AXCfsIiI37u3ouDPltquUWB3cZ
	 F/sgAXu9d+HLA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M63tveE2495072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:03:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:03:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/10] wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed
Date: Wed, 22 Jan 2025 14:03:05 +0800
Message-ID: <20250122060310.31976-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
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

If a debugfs entry takes driver mutex now, let it uses
wiphy_locked_debugfs_{read,write}() to take both driver mutex and
wiphy lock. Add rwlock option to support this.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 63 +++++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f3ec18860797..35bf627dbae2 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -24,6 +24,8 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
 #ifdef CONFIG_RTW89_DEBUGFS
 struct rtw89_debugfs_priv_opt {
+	bool rlock:1;
+	bool wlock:1;
 	size_t rsize;
 };
 
@@ -123,6 +125,19 @@ static u16 rtw89_rate_info_bw_to_mhz(enum rate_info_bw bw)
 	return 0;
 }
 
+static ssize_t rtw89_debugfs_file_read_helper(struct wiphy *wiphy, struct file *file,
+					      char *buf, size_t bufsz, void *data)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	ssize_t n;
+
+	n = debugfs_priv->cb_read(rtwdev, debugfs_priv, buf, bufsz);
+	rtw89_might_trailing_ellipsis(buf, bufsz, n);
+
+	return n;
+}
+
 static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
 				       size_t count, loff_t *ppos)
 {
@@ -145,26 +160,55 @@ static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
 		goto out;
 	}
 
-	n = debugfs_priv->cb_read(rtwdev, debugfs_priv, buf, bufsz);
-	rtw89_might_trailing_ellipsis(buf, bufsz, n);
+	if (opt->rlock) {
+		n = wiphy_locked_debugfs_read(rtwdev->hw->wiphy, file, buf, bufsz,
+					      userbuf, count, ppos,
+					      rtw89_debugfs_file_read_helper,
+					      debugfs_priv);
+		debugfs_priv->rused = n;
 
+		return n;
+	}
+
+	n = rtw89_debugfs_file_read_helper(rtwdev->hw->wiphy, file, buf, bufsz,
+					   debugfs_priv);
 	debugfs_priv->rused = n;
 
 out:
 	return simple_read_from_buffer(userbuf, count, ppos, buf, n);
 }
 
+static ssize_t rtw89_debugfs_file_write_helper(struct wiphy *wiphy, struct file *file,
+					       char *buf, size_t count, void *data)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+
+	return debugfs_priv->cb_write(rtwdev, debugfs_priv, buf, count);
+}
+
 static ssize_t rtw89_debugfs_file_write(struct file *file,
 					const char __user *userbuf,
 					size_t count, loff_t *loff)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = file->private_data;
+	struct rtw89_debugfs_priv_opt *opt = &debugfs_priv->opt;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	char *buf __free(kfree) = kmalloc(count + 1, GFP_KERNEL);
+	ssize_t n;
 
 	if (!buf)
 		return -ENOMEM;
 
+	if (opt->wlock) {
+		n = wiphy_locked_debugfs_write(rtwdev->hw->wiphy,
+					       file, buf, count + 1,
+					       userbuf, count,
+					       rtw89_debugfs_file_write_helper,
+					       debugfs_priv);
+		return n;
+	}
+
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
@@ -4206,6 +4250,9 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 #define RSIZE_64K .rsize = 0x10000
 #define RSIZE_128K .rsize = 0x20000
 #define RSIZE_1M .rsize = 0x100000
+#define RLOCK .rlock = 1
+#define WLOCK .wlock = 1
+#define RWLOCK RLOCK, WLOCK
 
 static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.read_reg = rtw89_debug_priv_select_and_get(read_reg),
@@ -4213,18 +4260,18 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.read_rf = rtw89_debug_priv_select_and_get(read_rf),
 	.write_rf = rtw89_debug_priv_set(write_rf),
 	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump, RSIZE_8K),
-	.txpwr_table = rtw89_debug_priv_get(txpwr_table, RSIZE_20K),
+	.txpwr_table = rtw89_debug_priv_get(txpwr_table, RSIZE_20K, RLOCK),
 	.mac_reg_dump = rtw89_debug_priv_select_and_get(mac_reg_dump, RSIZE_128K),
-	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump, RSIZE_16K),
+	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump, RSIZE_16K, RLOCK),
 	.mac_dbg_port_dump = rtw89_debug_priv_select_and_get(mac_dbg_port_dump, RSIZE_1M),
 	.send_h2c = rtw89_debug_priv_set(send_h2c),
-	.early_h2c = rtw89_debug_priv_set_and_get(early_h2c),
-	.fw_crash = rtw89_debug_priv_set_and_get(fw_crash),
+	.early_h2c = rtw89_debug_priv_set_and_get(early_h2c, RWLOCK),
+	.fw_crash = rtw89_debug_priv_set_and_get(fw_crash, WLOCK),
 	.btc_info = rtw89_debug_priv_get(btc_info, RSIZE_12K),
 	.btc_manual = rtw89_debug_priv_set(btc_manual),
-	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual),
+	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual, WLOCK),
 	.phy_info = rtw89_debug_priv_get(phy_info),
-	.stations = rtw89_debug_priv_get(stations),
+	.stations = rtw89_debug_priv_get(stations, RLOCK),
 	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm),
 };
 
-- 
2.25.1


