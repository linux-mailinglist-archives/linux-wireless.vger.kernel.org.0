Return-Path: <linux-wireless+bounces-10336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFA93483C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 08:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029CC2811E6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAAF41C65;
	Thu, 18 Jul 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aLzuKkRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFD2AD29
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284952; cv=none; b=b3EgHEQODnneu2kI/Fhr5It5BNjlviJFjO1C99uVBNhQRrA875XQMnVQcE1JMRDA1bh8w40l6t71mbdjgsqe7mTYF+RxLe3CxbGmqiiFqRfGC5RDF1MR7P3SifXyqKDLzPOtPxIFrR6dt7DReobchM4t5wt91OzTEnGTlXeSJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284952; c=relaxed/simple;
	bh=hDApoBJztn+mFTjR/LhIwQk8Ezdn9oEuads+8+8G2q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irLfszd0fso9HhTnn+a/SeOIcrO3rjG/iU5yr71e8wqP4iqv0gJqEY9HYIODKK0G3LZAYCm90Z4n5vfgfkMv/3LvAV4sLQBN9pkYgoZbsAenJfvMqEzFsQ9oEViQhdHAKto1N/5ipayu8fpJzwAerM/zJjgWHbrvNVRUWrYWMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aLzuKkRH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I6gNFJ13079624, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721284943; bh=hDApoBJztn+mFTjR/LhIwQk8Ezdn9oEuads+8+8G2q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aLzuKkRHgA2yXi0x8gY8CG4Mr72CX+ViH52Z73iL4XnaQ1ebAma2FjkLzi5hE6Msq
	 +Grm4garwWvTNiMm7ZS2Caht36FYpDuljvwEIEMq+IkIGAmbyYf6YVXp3uko8l3xhe
	 lUJ8QaCIeCbGl+oB7NmYTpB2CE2Eaz9XYDV1cvpDZyXS4P/NqimeB2+2vCxjV4ZsUG
	 9AvQJLweUBpPJsjowHt/ZlQ2apr89Z7S9eXSirBeXM5N2mFIn21NbJplKB+OlPIRcp
	 cUcLuZElzBe9c/cvXfqpTuD8obGETGe+xpVOaeNbCOSL9hYlSQOEjaOfog8jCUHyFD
	 SxCiu/BQw526A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I6gNFJ13079624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:42:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 14:42:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 14:42:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: debugfs: support multiple adapters debugging
Date: Thu, 18 Jul 2024 14:41:55 +0800
Message-ID: <20240718064155.38955-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

Originally in order to read partial registers from large area, we write
a range value stored into a static variable and read registers according
to the static variable.

However, if we install more than one adapters supported by this driver,
the static variables will be overwritten by latter adapters. To resolve
the problem, move the static variables to struct rtw_dev for each adapter.

With changes, smatch spends too much time to parse rtw_debugfs_init():
    debug.c:1289 rtw_debugfs_init() parse error: turning off implications
    after 60 seconds
Move stuffs of adding debugfs entries to three rtw_debugfs_add_xxx()
functions.

Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com/T/#m27662022c70d9f893ba96f6c6a8dd8fce2434dfe
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 303 ++++++++++++---------
 drivers/net/wireless/realtek/rtw88/debug.h |   2 +
 drivers/net/wireless/realtek/rtw88/main.c  |   1 +
 drivers/net/wireless/realtek/rtw88/main.h  |   3 +-
 4 files changed, 180 insertions(+), 129 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5b2036798159..c26a6905fd15 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -43,6 +43,62 @@ struct rtw_debugfs_priv {
 	};
 };
 
+struct rtw_debugfs {
+	struct rtw_debugfs_priv mac_0;
+	struct rtw_debugfs_priv mac_1;
+	struct rtw_debugfs_priv mac_2;
+	struct rtw_debugfs_priv mac_3;
+	struct rtw_debugfs_priv mac_4;
+	struct rtw_debugfs_priv mac_5;
+	struct rtw_debugfs_priv mac_6;
+	struct rtw_debugfs_priv mac_7;
+	struct rtw_debugfs_priv mac_10;
+	struct rtw_debugfs_priv mac_11;
+	struct rtw_debugfs_priv mac_12;
+	struct rtw_debugfs_priv mac_13;
+	struct rtw_debugfs_priv mac_14;
+	struct rtw_debugfs_priv mac_15;
+	struct rtw_debugfs_priv mac_16;
+	struct rtw_debugfs_priv mac_17;
+	struct rtw_debugfs_priv bb_8;
+	struct rtw_debugfs_priv bb_9;
+	struct rtw_debugfs_priv bb_a;
+	struct rtw_debugfs_priv bb_b;
+	struct rtw_debugfs_priv bb_c;
+	struct rtw_debugfs_priv bb_d;
+	struct rtw_debugfs_priv bb_e;
+	struct rtw_debugfs_priv bb_f;
+	struct rtw_debugfs_priv bb_18;
+	struct rtw_debugfs_priv bb_19;
+	struct rtw_debugfs_priv bb_1a;
+	struct rtw_debugfs_priv bb_1b;
+	struct rtw_debugfs_priv bb_1c;
+	struct rtw_debugfs_priv bb_1d;
+	struct rtw_debugfs_priv bb_1e;
+	struct rtw_debugfs_priv bb_1f;
+	struct rtw_debugfs_priv bb_2c;
+	struct rtw_debugfs_priv bb_2d;
+	struct rtw_debugfs_priv bb_40;
+	struct rtw_debugfs_priv bb_41;
+	struct rtw_debugfs_priv rf_dump;
+	struct rtw_debugfs_priv tx_pwr_tbl;
+	struct rtw_debugfs_priv write_reg;
+	struct rtw_debugfs_priv h2c;
+	struct rtw_debugfs_priv rf_write;
+	struct rtw_debugfs_priv rf_read;
+	struct rtw_debugfs_priv read_reg;
+	struct rtw_debugfs_priv fix_rate;
+	struct rtw_debugfs_priv dump_cam;
+	struct rtw_debugfs_priv rsvd_page;
+	struct rtw_debugfs_priv phy_info;
+	struct rtw_debugfs_priv coex_enable;
+	struct rtw_debugfs_priv coex_info;
+	struct rtw_debugfs_priv edcca_enable;
+	struct rtw_debugfs_priv fw_crash;
+	struct rtw_debugfs_priv force_lowest_basic_rate;
+	struct rtw_debugfs_priv dm_cap;
+};
+
 static const char * const rtw_dm_cap_strs[] = {
 	[RTW_DM_CAP_NA] = "NA",
 	[RTW_DM_CAP_TXGAPK] = "TXGAPK",
@@ -524,7 +580,7 @@ static int rtw_debug_get_bb_page(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int rtw_debug_get_rf_dump(struct seq_file *m, void *v)
+static int rtw_debugfs_get_rf_dump(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
@@ -1074,139 +1130,102 @@ static int rtw_debugfs_get_dm_cap(struct seq_file *m, void *v)
 	return 0;
 }
 
-#define rtw_debug_impl_mac(page, addr)				\
-static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
+#define rtw_debug_priv_mac(addr)				\
+{								\
 	.cb_read = rtw_debug_get_mac_page,			\
 	.cb_data = addr,					\
 }
 
-rtw_debug_impl_mac(0, 0x0000);
-rtw_debug_impl_mac(1, 0x0100);
-rtw_debug_impl_mac(2, 0x0200);
-rtw_debug_impl_mac(3, 0x0300);
-rtw_debug_impl_mac(4, 0x0400);
-rtw_debug_impl_mac(5, 0x0500);
-rtw_debug_impl_mac(6, 0x0600);
-rtw_debug_impl_mac(7, 0x0700);
-rtw_debug_impl_mac(10, 0x1000);
-rtw_debug_impl_mac(11, 0x1100);
-rtw_debug_impl_mac(12, 0x1200);
-rtw_debug_impl_mac(13, 0x1300);
-rtw_debug_impl_mac(14, 0x1400);
-rtw_debug_impl_mac(15, 0x1500);
-rtw_debug_impl_mac(16, 0x1600);
-rtw_debug_impl_mac(17, 0x1700);
-
-#define rtw_debug_impl_bb(page, addr)			\
-static struct rtw_debugfs_priv rtw_debug_priv_bb_ ##page = {	\
+#define rtw_debug_priv_bb(addr)					\
+{								\
 	.cb_read = rtw_debug_get_bb_page,			\
 	.cb_data = addr,					\
 }
 
-rtw_debug_impl_bb(8, 0x0800);
-rtw_debug_impl_bb(9, 0x0900);
-rtw_debug_impl_bb(a, 0x0a00);
-rtw_debug_impl_bb(b, 0x0b00);
-rtw_debug_impl_bb(c, 0x0c00);
-rtw_debug_impl_bb(d, 0x0d00);
-rtw_debug_impl_bb(e, 0x0e00);
-rtw_debug_impl_bb(f, 0x0f00);
-rtw_debug_impl_bb(18, 0x1800);
-rtw_debug_impl_bb(19, 0x1900);
-rtw_debug_impl_bb(1a, 0x1a00);
-rtw_debug_impl_bb(1b, 0x1b00);
-rtw_debug_impl_bb(1c, 0x1c00);
-rtw_debug_impl_bb(1d, 0x1d00);
-rtw_debug_impl_bb(1e, 0x1e00);
-rtw_debug_impl_bb(1f, 0x1f00);
-rtw_debug_impl_bb(2c, 0x2c00);
-rtw_debug_impl_bb(2d, 0x2d00);
-rtw_debug_impl_bb(40, 0x4000);
-rtw_debug_impl_bb(41, 0x4100);
-
-static struct rtw_debugfs_priv rtw_debug_priv_rf_dump = {
-	.cb_read = rtw_debug_get_rf_dump,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_tx_pwr_tbl = {
-	.cb_read = rtw_debugfs_get_tx_pwr_tbl,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_write_reg = {
-	.cb_write = rtw_debugfs_set_write_reg,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_h2c = {
-	.cb_write = rtw_debugfs_set_h2c,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_rf_write = {
-	.cb_write = rtw_debugfs_set_rf_write,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_rf_read = {
-	.cb_write = rtw_debugfs_set_rf_read,
-	.cb_read = rtw_debugfs_get_rf_read,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_read_reg = {
-	.cb_write = rtw_debugfs_set_read_reg,
-	.cb_read = rtw_debugfs_get_read_reg,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_fix_rate = {
-	.cb_write = rtw_debugfs_set_fix_rate,
-	.cb_read = rtw_debugfs_get_fix_rate,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_dump_cam = {
-	.cb_write = rtw_debugfs_set_single_input,
-	.cb_read = rtw_debugfs_get_dump_cam,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_rsvd_page = {
-	.cb_write = rtw_debugfs_set_rsvd_page,
-	.cb_read = rtw_debugfs_get_rsvd_page,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
-	.cb_read = rtw_debugfs_get_phy_info,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_coex_enable = {
-	.cb_write = rtw_debugfs_set_coex_enable,
-	.cb_read = rtw_debugfs_get_coex_enable,
-};
-
-static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
-	.cb_read = rtw_debugfs_get_coex_info,
-};
+#define rtw_debug_priv_get(name)				\
+{								\
+	.cb_read = rtw_debugfs_get_ ##name,			\
+}
 
-static struct rtw_debugfs_priv rtw_debug_priv_edcca_enable = {
-	.cb_write = rtw_debugfs_set_edcca_enable,
-	.cb_read = rtw_debugfs_get_edcca_enable,
-};
+#define rtw_debug_priv_set(name)				\
+{								\
+	.cb_write = rtw_debugfs_set_ ##name,			\
+}
 
-static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
-	.cb_write = rtw_debugfs_set_fw_crash,
-	.cb_read = rtw_debugfs_get_fw_crash,
-};
+#define rtw_debug_priv_set_and_get(name)			\
+{								\
+	.cb_write = rtw_debugfs_set_ ##name,			\
+	.cb_read = rtw_debugfs_get_ ##name,			\
+}
 
-static struct rtw_debugfs_priv rtw_debug_priv_force_lowest_basic_rate = {
-	.cb_write = rtw_debugfs_set_force_lowest_basic_rate,
-	.cb_read = rtw_debugfs_get_force_lowest_basic_rate,
-};
+#define rtw_debug_priv_set_single_and_get(name)			\
+{								\
+	.cb_write = rtw_debugfs_set_single_input,		\
+	.cb_read = rtw_debugfs_get_ ##name,			\
+}
 
-static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
-	.cb_write = rtw_debugfs_set_dm_cap,
-	.cb_read = rtw_debugfs_get_dm_cap,
+static const struct rtw_debugfs rtw_debugfs_templ = {
+	.mac_0 = rtw_debug_priv_mac(0x0000),
+	.mac_1 = rtw_debug_priv_mac(0x0100),
+	.mac_2 = rtw_debug_priv_mac(0x0200),
+	.mac_3 = rtw_debug_priv_mac(0x0300),
+	.mac_4 = rtw_debug_priv_mac(0x0400),
+	.mac_5 = rtw_debug_priv_mac(0x0500),
+	.mac_6 = rtw_debug_priv_mac(0x0600),
+	.mac_7 = rtw_debug_priv_mac(0x0700),
+	.mac_10 = rtw_debug_priv_mac(0x1000),
+	.mac_11 = rtw_debug_priv_mac(0x1100),
+	.mac_12 = rtw_debug_priv_mac(0x1200),
+	.mac_13 = rtw_debug_priv_mac(0x1300),
+	.mac_14 = rtw_debug_priv_mac(0x1400),
+	.mac_15 = rtw_debug_priv_mac(0x1500),
+	.mac_16 = rtw_debug_priv_mac(0x1600),
+	.mac_17 = rtw_debug_priv_mac(0x1700),
+	.bb_8 = rtw_debug_priv_bb(0x0800),
+	.bb_9 = rtw_debug_priv_bb(0x0900),
+	.bb_a = rtw_debug_priv_bb(0x0a00),
+	.bb_b = rtw_debug_priv_bb(0x0b00),
+	.bb_c = rtw_debug_priv_bb(0x0c00),
+	.bb_d = rtw_debug_priv_bb(0x0d00),
+	.bb_e = rtw_debug_priv_bb(0x0e00),
+	.bb_f = rtw_debug_priv_bb(0x0f00),
+	.bb_18 = rtw_debug_priv_bb(0x1800),
+	.bb_19 = rtw_debug_priv_bb(0x1900),
+	.bb_1a = rtw_debug_priv_bb(0x1a00),
+	.bb_1b = rtw_debug_priv_bb(0x1b00),
+	.bb_1c = rtw_debug_priv_bb(0x1c00),
+	.bb_1d = rtw_debug_priv_bb(0x1d00),
+	.bb_1e = rtw_debug_priv_bb(0x1e00),
+	.bb_1f = rtw_debug_priv_bb(0x1f00),
+	.bb_2c = rtw_debug_priv_bb(0x2c00),
+	.bb_2d = rtw_debug_priv_bb(0x2d00),
+	.bb_40 = rtw_debug_priv_bb(0x4000),
+	.bb_41 = rtw_debug_priv_bb(0x4100),
+	.rf_dump = rtw_debug_priv_get(rf_dump),
+	.tx_pwr_tbl = rtw_debug_priv_get(tx_pwr_tbl),
+	.write_reg = rtw_debug_priv_set(write_reg),
+	.h2c = rtw_debug_priv_set(h2c),
+	.rf_write = rtw_debug_priv_set(rf_write),
+	.rf_read = rtw_debug_priv_set_and_get(rf_read),
+	.read_reg = rtw_debug_priv_set_and_get(read_reg),
+	.fix_rate = rtw_debug_priv_set_and_get(fix_rate),
+	.dump_cam = rtw_debug_priv_set_single_and_get(dump_cam),
+	.rsvd_page = rtw_debug_priv_set_and_get(rsvd_page),
+	.phy_info = rtw_debug_priv_get(phy_info),
+	.coex_enable = rtw_debug_priv_set_and_get(coex_enable),
+	.coex_info = rtw_debug_priv_get(coex_info),
+	.edcca_enable = rtw_debug_priv_set_and_get(edcca_enable),
+	.fw_crash = rtw_debug_priv_set_and_get(fw_crash),
+	.force_lowest_basic_rate = rtw_debug_priv_set_and_get(force_lowest_basic_rate),
+	.dm_cap = rtw_debug_priv_set_and_get(dm_cap),
 };
 
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
-		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
+		struct rtw_debugfs_priv *priv = &rtwdev->debugfs->name;	\
+		priv->rtwdev = rtwdev;					\
 		if (IS_ERR(debugfs_create_file(#name, mode,		\
-					 parent, &rtw_debug_priv_ ##name,\
+					 parent, priv,			\
 					 &file_ops_ ##fopname)))	\
 			pr_debug("Unable to initialize debugfs:%s\n",	\
 			       #name);					\
@@ -1219,12 +1238,9 @@ static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
 #define rtw_debugfs_add_r(name)						\
 	rtw_debugfs_add_core(name, S_IFREG | 0444, single_r, debugfs_topdir)
 
-void rtw_debugfs_init(struct rtw_dev *rtwdev)
+static
+void rtw_debugfs_add_basic(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
 {
-	struct dentry *debugfs_topdir;
-
-	debugfs_topdir = debugfs_create_dir("rtw88",
-					    rtwdev->hw->wiphy->debugfsdir);
 	rtw_debugfs_add_w(write_reg);
 	rtw_debugfs_add_rw(read_reg);
 	rtw_debugfs_add_w(rf_write);
@@ -1236,6 +1252,17 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(coex_info);
 	rtw_debugfs_add_rw(coex_enable);
 	rtw_debugfs_add_w(h2c);
+	rtw_debugfs_add_r(rf_dump);
+	rtw_debugfs_add_r(tx_pwr_tbl);
+	rtw_debugfs_add_rw(edcca_enable);
+	rtw_debugfs_add_rw(fw_crash);
+	rtw_debugfs_add_rw(force_lowest_basic_rate);
+	rtw_debugfs_add_rw(dm_cap);
+}
+
+static
+void rtw_debugfs_add_sec0(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
+{
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
@@ -1252,6 +1279,11 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(bb_d);
 	rtw_debugfs_add_r(bb_e);
 	rtw_debugfs_add_r(bb_f);
+}
+
+static
+void rtw_debugfs_add_sec1(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
+{
 	rtw_debugfs_add_r(mac_10);
 	rtw_debugfs_add_r(mac_11);
 	rtw_debugfs_add_r(mac_12);
@@ -1274,14 +1306,29 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 		rtw_debugfs_add_r(bb_40);
 		rtw_debugfs_add_r(bb_41);
 	}
-	rtw_debugfs_add_r(rf_dump);
-	rtw_debugfs_add_r(tx_pwr_tbl);
-	rtw_debugfs_add_rw(edcca_enable);
-	rtw_debugfs_add_rw(fw_crash);
-	rtw_debugfs_add_rw(force_lowest_basic_rate);
-	rtw_debugfs_add_rw(dm_cap);
 }
 
+void rtw_debugfs_init(struct rtw_dev *rtwdev)
+{
+	struct dentry *debugfs_topdir;
+
+	rtwdev->debugfs = kmemdup(&rtw_debugfs_templ, sizeof(rtw_debugfs_templ),
+				  GFP_KERNEL);
+	if (!rtwdev->debugfs)
+		return;
+
+	debugfs_topdir = debugfs_create_dir("rtw88",
+					    rtwdev->hw->wiphy->debugfsdir);
+
+	rtw_debugfs_add_basic(rtwdev, debugfs_topdir);
+	rtw_debugfs_add_sec0(rtwdev, debugfs_topdir);
+	rtw_debugfs_add_sec1(rtwdev, debugfs_topdir);
+}
+
+void rtw_debugfs_deinit(struct rtw_dev *rtwdev)
+{
+	kfree(rtwdev->debugfs);
+}
 #endif /* CONFIG_RTW88_DEBUGFS */
 
 #ifdef CONFIG_RTW88_DEBUG
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index 9a1e0e85a13c..6570e84d8d24 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -34,11 +34,13 @@ enum rtw_debug_mask {
 #ifdef CONFIG_RTW88_DEBUGFS
 
 void rtw_debugfs_init(struct rtw_dev *rtwdev);
+void rtw_debugfs_deinit(struct rtw_dev *rtwdev);
 void rtw_debugfs_get_simple_phy_info(struct seq_file *m);
 
 #else
 
 static inline void rtw_debugfs_init(struct rtw_dev *rtwdev) {}
+static inline void rtw_debugfs_deinit(struct rtw_dev *rtwdev) {}
 
 #endif /* CONFIG_RTW88_DEBUGFS */
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9d9d33a4a503..dd77adea15c7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2299,6 +2299,7 @@ void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	ieee80211_unregister_hw(hw);
 	rtw_unset_supported_band(hw, chip);
+	rtw_debugfs_deinit(rtwdev);
 }
 EXPORT_SYMBOL(rtw_unregister_hw);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9d21637cf5d5..b60a0f840e13 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -50,6 +50,7 @@ extern const struct ieee80211_ops rtw_ops;
 #define RTW_MAX_CHANNEL_NUM_5G 49
 
 struct rtw_dev;
+struct rtw_debugfs;
 
 enum rtw_hci_type {
 	RTW_HCI_TYPE_PCIE,
@@ -2053,7 +2054,7 @@ struct rtw_dev {
 	bool beacon_loss;
 	struct completion lps_leave_check;
 
-	struct dentry *debugfs;
+	struct rtw_debugfs *debugfs;
 
 	u8 sta_cnt;
 	u32 rts_threshold;
-- 
2.25.1


