Return-Path: <linux-wireless+bounces-36020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMAVLKA++2nTYQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:14:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEB4DACE8
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EAC93016CB5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03632BF5A;
	Wed,  6 May 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RobYHH6S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8323D7FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073056; cv=none; b=QCA8GSkld1GrFZH5Iku7NRlBVBr0d51iR+FQwaEVeTahp6KX689KutBWcJNNqNbqp1cMv1roHg6TC1bPqkMAoQkpCW4pfv9oB8l0Ld9gnlZd4gbyCLqyIOV7wobzPR+xH8VnUcQ2wDW0aHRGwTZMdix5ly7ubV1D5dH6I4BJ3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073056; c=relaxed/simple;
	bh=yeIfsHCF7ealiL8+Qjn4nymfmLs1ImzJ9EKDsgh9tnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjGZBUWCS6wICZyshf9EHWePTarkIrnez6MNpVP+IY1AWUCog1tXDIi3aQAgjaTakZKrTgjfY9PfvEOfHp+5JujfnAGCOvvMA24WR/VH5yaTvSjbCpwM93Jcny5qBTzf1/tB+2DPhXClXaQ13Dholqs/fLNuP8rHzeuMZW/OQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RobYHH6S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DArz761987147, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073053; bh=MptVeJaR9ijAaNsOQe1dnoL97aGK1Ni3+rTmkKNmNlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RobYHH6SsC7u0xJLw3ztT4AbsUwMG5bcR1xYw1BnUbZDIS8/JxLuQy4oNfDJ5pDT9
	 cFO0P49ZninM1dKi65nkEKzzqENJCpWG5NO848QRJDmBuu8EbGyokFITbE8ebhXEJO
	 Sg9OsJ4ZqzVyM1CACqVKSZkWyDIsXXB8CTdi+sQEEGSXrStAicu2cNdesrW+y9SQDH
	 FHa/0xlO/6Xg4nRr6k3bKK/IYga038lxGKTEdY7Gu7fpVXtCQDWu9Pb6UQw4dOCkxQ
	 bI2ob75U4GDFV9yW8p3oTUKOJn5tSf/102qG/j/RDjQAk3VFlFNTgb9pXTFCa9nr6S
	 9P9GIBfEHmmrQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DArz761987147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:53 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:53 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 10/14] wifi: rtw89: add debugfs entry of monitor mode options to capture HE-MU packets
Date: Wed, 6 May 2026 21:09:56 +0800
Message-ID: <20260506131000.1706298-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 47BEB4DACE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36020-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

To capture HE-MU packets, set BSS color and AID for specific connected
station.

The writing format: <bss color> <aid>
For example,
  $ echo 0x4 0x16 > monitor_opts

Read this entry to get current setting:
  bss_color=0x4 aid=0x16

By the way, add another sec2() function to create debugfs entries to
prevent running smatch timeout.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 57 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c   | 23 ++++++---
 drivers/net/wireless/realtek/rtw89/phy.h   |  2 +
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 6fe8e7254e80..8ee800c76cfe 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -93,6 +93,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv beacon_info;
 	struct rtw89_debugfs_priv diag_mac;
 	struct rtw89_debugfs_priv diag_bb;
+	struct rtw89_debugfs_priv monitor_opts;
 };
 
 struct rtw89_debugfs_iter_data {
@@ -5326,6 +5327,54 @@ rtw89_debug_priv_diag_bb_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
+static ssize_t
+rtw89_debug_priv_monitor_opts_get(struct rtw89_dev *rtwdev,
+				  struct rtw89_debugfs_priv *debugfs_priv,
+				  char *buf, size_t bufsz)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	char *p = buf, *end = buf + bufsz;
+	u32 bss_color;
+	u32 aid;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	bss_color = rtw89_phy_read32_idx(rtwdev, chip->bss_clr_map_reg,
+					 B_BSS_CLR_MAP_TGT, RTW89_PHY_0);
+	aid = rtw89_phy_read32_idx(rtwdev, chip->bss_clr_map_reg,
+				   B_BSS_CLR_MAP_STAID, RTW89_PHY_0);
+
+	p += scnprintf(p, end - p, "bss_color=0x%x aid=0x%x\n", bss_color, aid);
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_monitor_opts_set(struct rtw89_dev *rtwdev,
+				  struct rtw89_debugfs_priv *debugfs_priv,
+				  const char *buf, size_t count)
+{
+	u32 bss_color;
+	u32 aid;
+	int num;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	num = sscanf(buf, "%x %x", &bss_color, &aid);
+	if (num != 2) {
+		rtw89_info(rtwdev, "valid format: <bss color> <aid>\n");
+		return -EINVAL;
+	}
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	__rtw89_phy_set_bss_color(rtwdev, bss_color, aid, RTW89_PHY_0);
+
+	return count;
+}
+
 #define rtw89_debug_priv_get(name, opts...)			\
 {								\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
@@ -5390,6 +5439,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.beacon_info = rtw89_debug_priv_get(beacon_info),
 	.diag_mac = rtw89_debug_priv_get(diag_mac, RSIZE_16K, RLOCK),
 	.diag_bb = rtw89_debug_priv_get(diag_bb, RSIZE_8K, RLOCK),
+	.monitor_opts = rtw89_debug_priv_set_and_get(monitor_opts, RWLOCK),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
@@ -5435,12 +5485,18 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_r(phy_info);
 	rtw89_debugfs_add_rw(bb_info);
 	rtw89_debugfs_add_r(stations);
+}
+
+static
+void rtw89_debugfs_add_sec2(struct rtw89_dev *rtwdev, struct dentry *debugfs_topdir)
+{
 	rtw89_debugfs_add_rw(disable_dm);
 	rtw89_debugfs_add_rw(static_pd_th);
 	rtw89_debugfs_add_rw(mlo_mode);
 	rtw89_debugfs_add_r(beacon_info);
 	rtw89_debugfs_add_r(diag_mac);
 	rtw89_debugfs_add_r(diag_bb);
+	rtw89_debugfs_add_rw(monitor_opts);
 }
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
@@ -5457,6 +5513,7 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 
 	rtw89_debugfs_add_sec0(rtwdev, debugfs_topdir);
 	rtw89_debugfs_add_sec1(rtwdev, debugfs_topdir);
+	rtw89_debugfs_add_sec2(rtwdev, debugfs_topdir);
 }
 
 void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 15483a86951d..759be4dab42b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -8231,12 +8231,24 @@ void rtw89_phy_dm_init_data(struct rtw89_dev *rtwdev)
 		__rtw89_phy_dm_init_data(rtwdev, bb);
 }
 
+void __rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, u8 bss_color, u16 aid,
+			       enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
+
+	rtw89_phy_write32_idx(rtwdev, bss_clr_vld->addr, bss_clr_vld->mask, 0x1,
+			      phy_idx);
+	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_TGT,
+			      bss_color, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_STAID,
+			      aid, phy_idx);
+}
+
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 	struct ieee80211_bss_conf *bss_conf;
 	u8 bss_color;
@@ -8253,12 +8265,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
-	rtw89_phy_write32_idx(rtwdev, bss_clr_vld->addr, bss_clr_vld->mask, 0x1,
-			      phy_idx);
-	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_TGT,
-			      bss_color, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_STAID,
-			      vif->cfg.aid, phy_idx);
+	__rtw89_phy_set_bss_color(rtwdev, bss_color, vif->cfg.aid, phy_idx);
 }
 
 static bool rfk_chan_validate_desc(const struct rtw89_rfk_chan_desc *desc)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 74fbf5baff58..b4b818f786df 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1128,6 +1128,8 @@ void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_antdiv_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link);
+void __rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, u8 bss_color, u16 aid,
+			       enum rtw89_phy_idx phy_idx);
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
 					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
-- 
2.25.1


