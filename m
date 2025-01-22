Return-Path: <linux-wireless+bounces-17816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA2A18B9C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861C27A2268
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432F18871F;
	Wed, 22 Jan 2025 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TCvEI6yi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E914A619
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525834; cv=none; b=YKIcE/myPDOZlC8LFfi65sSWpvEebTaKLIB0gVMX3TPawiJbo1iOPFGIBKX3FtadQI4fDjOG4Vs0+ZIHg5rIQtGvkX4LKpiYo1WiVRlmDD7tbFcFkbz9LeGTEyvK8WBy+m4AhGge6bpczkpGqdh0B8CefObb1QZHCI5MUa/qzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525834; c=relaxed/simple;
	bh=REo92+VE+iRgYRes22fzFDCWGMswhuflmqYNhVjrdSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9GGNQQXBiRGK4/7gufdLLc7Q6WESfKtKsCM2wkw26C41Qb2XyTH2izzvnJHB8JiSbBPyLtutER4hQTJ1cNtMPFEMLb7W1l/sRslHXOzOGOD4EpP0o7gV8WovltxtGFLdGbvw6mlOpr5MxIvBxPpitN2Mm3x/LjH0jP6eeT76sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TCvEI6yi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M63nIaA2495047, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525829; bh=REo92+VE+iRgYRes22fzFDCWGMswhuflmqYNhVjrdSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TCvEI6yikp9Cw05GSL9mxUjZpA1ZN66ECYdiorXMLjsZjhudtUif0Bsm2Cn2w6Xki
	 pIfzC8KUepzVem1hLcghdAj8+Nv0kdpXAmoBSzjJFMdjMIAv+6cvpcHFS02MeQZXNG
	 Il2aJRhM+nB/hxEeqIyHIfai3gK789Myx0YuGGTEBvkXtGtmeXGu6r/23fptTmstPO
	 PUXKS8z3OIn7L8qFz8FcFAUB7lCkblAIEuOUbVZi+/JVSswM8MaJOen0cosShrYKwo
	 JA69GbcYgThApYa4KoIZlESVLWnUKHLEFaQ2TLYxqEfVc9XOFcVPAJq1Mwdc3Ik05R
	 Tn6QmMEOU5SUQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M63nIaA2495047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:03:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:03:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:03:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/10] wifi: rtw89: debugfs: specify buffer size allocated by devm_kazlloc() for reading
Date: Wed, 22 Jan 2025 14:03:04 +0800
Message-ID: <20250122060310.31976-5-pkshih@realtek.com>
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

Some debufs entries need output buffer over default size 4K. Since reading
of many debugfs entries is to access IO, it costs time to dynamically
re-allocate larger buffer and access IO again and again. Add an option to
specify the size it needs.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 62 ++++++++++++++++------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index db0e7a4beb07..f3ec18860797 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -23,6 +23,10 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 #endif
 
 #ifdef CONFIG_RTW89_DEBUGFS
+struct rtw89_debugfs_priv_opt {
+	size_t rsize;
+};
+
 struct rtw89_debugfs_priv {
 	struct rtw89_dev *rtwdev;
 	ssize_t (*cb_read)(struct rtw89_dev *rtwdev,
@@ -31,6 +35,7 @@ struct rtw89_debugfs_priv {
 	ssize_t (*cb_write)(struct rtw89_dev *rtwdev,
 			    struct rtw89_debugfs_priv *debugfs_priv,
 			    const char *buf, size_t count);
+	struct rtw89_debugfs_priv_opt opt;
 	union {
 		u32 cb_data;
 		struct {
@@ -55,6 +60,8 @@ struct rtw89_debugfs_priv {
 			u8 sel;
 		} mac_mem;
 	};
+	ssize_t rused;
+	char *rbuf;
 };
 
 struct rtw89_debugfs {
@@ -120,23 +127,31 @@ static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
 				       size_t count, loff_t *ppos)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = file->private_data;
+	struct rtw89_debugfs_priv_opt *opt = &debugfs_priv->opt;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	size_t bufsz = PAGE_SIZE;
+	size_t bufsz = opt->rsize ? opt->rsize : PAGE_SIZE;
 	char *buf;
 	ssize_t n;
 
-	buf = kvmalloc(bufsz, GFP_KERNEL);
+	if (!debugfs_priv->rbuf)
+		debugfs_priv->rbuf = devm_kzalloc(rtwdev->dev, bufsz, GFP_KERNEL);
+
+	buf = debugfs_priv->rbuf;
 	if (!buf)
-		return 0;
+		return -ENOMEM;
+
+	if (*ppos) {
+		n = debugfs_priv->rused;
+		goto out;
+	}
 
 	n = debugfs_priv->cb_read(rtwdev, debugfs_priv, buf, bufsz);
 	rtw89_might_trailing_ellipsis(buf, bufsz, n);
 
-	n = simple_read_from_buffer(userbuf, count, ppos, buf, n);
-
-	kvfree(buf);
+	debugfs_priv->rused = n;
 
-	return n;
+out:
+	return simple_read_from_buffer(userbuf, count, ppos, buf, n);
 }
 
 static ssize_t rtw89_debugfs_file_write(struct file *file,
@@ -4157,42 +4172,55 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
-#define rtw89_debug_priv_get(name)				\
+#define rtw89_debug_priv_get(name, opts...)			\
 {								\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+	.opt = { opts },					\
 }
 
-#define rtw89_debug_priv_set(name)				\
+#define rtw89_debug_priv_set(name, opts...)			\
 {								\
 	.cb_write = rtw89_debug_priv_ ##name## _set,		\
+	.opt = { opts },					\
 }
 
-#define rtw89_debug_priv_select_and_get(name)			\
+#define rtw89_debug_priv_select_and_get(name, opts...)		\
 {								\
 	.cb_write = rtw89_debug_priv_ ##name## _select,		\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+	.opt = { opts },					\
 }
 
-#define rtw89_debug_priv_set_and_get(name)			\
+#define rtw89_debug_priv_set_and_get(name, opts...)		\
 {								\
 	.cb_write = rtw89_debug_priv_ ##name## _set,		\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
+	.opt = { opts },					\
 }
 
+#define RSIZE_8K .rsize = 0x2000
+#define RSIZE_12K .rsize = 0x3000
+#define RSIZE_16K .rsize = 0x4000
+#define RSIZE_20K .rsize = 0x5000
+#define RSIZE_32K .rsize = 0x8000
+#define RSIZE_64K .rsize = 0x10000
+#define RSIZE_128K .rsize = 0x20000
+#define RSIZE_1M .rsize = 0x100000
+
 static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.read_reg = rtw89_debug_priv_select_and_get(read_reg),
 	.write_reg = rtw89_debug_priv_set(write_reg),
 	.read_rf = rtw89_debug_priv_select_and_get(read_rf),
 	.write_rf = rtw89_debug_priv_set(write_rf),
-	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump),
-	.txpwr_table = rtw89_debug_priv_get(txpwr_table),
-	.mac_reg_dump = rtw89_debug_priv_select_and_get(mac_reg_dump),
-	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump),
-	.mac_dbg_port_dump = rtw89_debug_priv_select_and_get(mac_dbg_port_dump),
+	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump, RSIZE_8K),
+	.txpwr_table = rtw89_debug_priv_get(txpwr_table, RSIZE_20K),
+	.mac_reg_dump = rtw89_debug_priv_select_and_get(mac_reg_dump, RSIZE_128K),
+	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump, RSIZE_16K),
+	.mac_dbg_port_dump = rtw89_debug_priv_select_and_get(mac_dbg_port_dump, RSIZE_1M),
 	.send_h2c = rtw89_debug_priv_set(send_h2c),
 	.early_h2c = rtw89_debug_priv_set_and_get(early_h2c),
 	.fw_crash = rtw89_debug_priv_set_and_get(fw_crash),
-	.btc_info = rtw89_debug_priv_get(btc_info),
+	.btc_info = rtw89_debug_priv_get(btc_info, RSIZE_12K),
 	.btc_manual = rtw89_debug_priv_set(btc_manual),
 	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual),
 	.phy_info = rtw89_debug_priv_get(phy_info),
-- 
2.25.1


