Return-Path: <linux-wireless+bounces-14299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C99A9CAC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F2F1C22C3A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2BF16E860;
	Tue, 22 Oct 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Eh1EuwNJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406E157487
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585910; cv=none; b=AAsD0IZfVDyhMxxvJreplkom94X4Kp/jHFeVu4l6wJfCTlgJcQ517TatM9RB5dT3ClXscgAYMjyPYNhU1qsYBvxug89Iflwz8y7PV7eR/0qgyn1b2b2/uSGCwFcGwlojDZG8oSyY/wt7IhPKhhqsbEA4cptKDod+DEmtSGnV2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585910; c=relaxed/simple;
	bh=h380cGmjQWJKo1p6SXWqKAAczXNOazRc2LmrIbbhLho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ+t/J4o7SdhFAcEcAqGl9ZXJqFd7FiSpl4d/Ev+1NZb4vXcu3kwsS13CEY9tIRKGKxstCFgha0KpL9Uyiab+L/ih5o06p4b9mwVKUWCQkBZk7riS6uaLc0h77qP2hora91mY0Cq9OssJuvNLyy/kBU8yr536KPxJn8VxUesLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Eh1EuwNJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8Vk6qA3771877, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585906; bh=h380cGmjQWJKo1p6SXWqKAAczXNOazRc2LmrIbbhLho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Eh1EuwNJPKYEqGH44XLtQ5qBdgq7EAiTFZHxQC6pr68pAA80jVNCeQavxR3WB1HzC
	 pv6vPzeCOc6aXGvhM3st+d7xHJ2q+Q18L2V4iLF1IPGoNMU1Q494QsFCKoKaSRTPzn
	 tEb4GCuKD74gGgk7z/avsMBL6mwAYfZQXAB3t6C2kmGqJmcCZPflWUMiIN5txYlMFt
	 qQiM5X8geI9i1StyBa+kAnr/ojWLXQdLENcMK0/XU66k7VM8m8VtU1aYpj9Blje9rn
	 gVHP9qN1JqbjjfgZ2aPxDwUhEH0V4vtb3l53JO+n0Xg6s7UvNouWXGu1lxH5VePEeH
	 SDAUoSTadH7mA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8Vk6qA3771877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/5] wifi: rtw89: tweak setting of channel and TX power for MLO
Date: Tue, 22 Oct 2024 16:31:05 +0800
Message-ID: <20241022083106.149252-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083106.149252-1-pkshih@realtek.com>
References: <20241022083106.149252-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Setting of channel and TX power depend on channel contexts, but original
code cannot handle combination of MCC (multi-channel concurrency) and MLO
well. So according to active interfaces, we generate a table for current
channel contexts. And then based on entity mode, we get the corresponding
channel context to apply during channel or TX power setting. When MLO is
supported, there will be dual-PHY and we will apply the channel context of
the 2nd link to the 2nd PHY.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c |  80 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/chan.h |   8 ++
 drivers/net/wireless/realtek/rtw89/core.c | 111 ++++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h |  15 ++-
 4 files changed, 149 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2b7e6921ff9c..fb9449930c40 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -299,6 +299,64 @@ static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
 	rtw89_swap_chanctx(rtwdev, rtwvif_link->chanctx_idx, cur->chanctx_idx);
 }
 
+const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
+					       const char *caller_message,
+					       u8 link_index)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
+	enum rtw89_chanctx_idx chanctx_idx;
+	enum rtw89_chanctx_idx roc_idx;
+	enum rtw89_entity_mode mode;
+	u8 role_index;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (unlikely(link_index >= __RTW89_MLD_MAX_LINK_NUM)) {
+		WARN(1, "link index %u is invalid (max link inst num: %d)\n",
+		     link_index, __RTW89_MLD_MAX_LINK_NUM);
+		goto dflt;
+	}
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_SCC_OR_SMLD:
+	case RTW89_ENTITY_MODE_MCC:
+		role_index = 0;
+		break;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		role_index = 1;
+		break;
+	default:
+		WARN(1, "Invalid ent mode: %d\n", mode);
+		goto dflt;
+	}
+
+	chanctx_idx = mgnt->chanctx_tbl[role_index][link_index];
+	if (chanctx_idx == RTW89_CHANCTX_IDLE)
+		goto dflt;
+
+	roc_idx = atomic_read(&hal->roc_chanctx_idx);
+	if (roc_idx != RTW89_CHANCTX_IDLE) {
+		/* ROC is ongoing (given ROC runs on RTW89_ROC_BY_LINK_INDEX).
+		 * If @link_index is the same as RTW89_ROC_BY_LINK_INDEX, get
+		 * the ongoing ROC chanctx.
+		 */
+		if (link_index == RTW89_ROC_BY_LINK_INDEX)
+			chanctx_idx = roc_idx;
+	}
+
+	return rtw89_chan_get(rtwdev, chanctx_idx);
+
+dflt:
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "%s (%s): prefetch NULL on link index %u\n",
+		    __func__, caller_message ?: "", link_index);
+
+	return rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+}
+EXPORT_SYMBOL(__rtw89_mgnt_chan_get);
+
 static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -306,13 +364,18 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 	struct rtw89_vif_link *link;
 	struct rtw89_vif *role;
 	u8 pos = 0;
-	int i;
+	int i, j;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
 	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++)
 		mgnt->active_roles[i] = NULL;
 
+	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++) {
+		for (j = 0; j < __RTW89_MLD_MAX_LINK_NUM; j++)
+			mgnt->chanctx_tbl[i][j] = RTW89_CHANCTX_IDLE;
+	}
+
 	/* To be consistent with legacy behavior, expect the first active role
 	 * which uses RTW89_CHANCTX_0 to put at position 0, and make its first
 	 * link instance take RTW89_CHANCTX_0. (normalizing)
@@ -341,6 +404,14 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 			break;
 		}
 
+		for (i = 0; i < role->links_inst_valid_num; i++) {
+			link = rtw89_vif_get_link_inst(role, i);
+			if (!link || !link->chanctx_assigned)
+				continue;
+
+			mgnt->chanctx_tbl[pos][i] = link->chanctx_idx;
+		}
+
 		mgnt->active_roles[pos++] = role;
 	}
 }
@@ -371,9 +442,14 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		set_bit(RTW89_CHANCTX_0, recalc_map);
 		fallthrough;
 	case 1:
-		mode = RTW89_ENTITY_MODE_SCC;
+		mode = RTW89_ENTITY_MODE_SCC_OR_SMLD;
 		break;
 	case 2 ... NUM_OF_RTW89_CHANCTX:
+		if (w.active_roles == 1) {
+			mode = RTW89_ENTITY_MODE_SCC_OR_SMLD;
+			break;
+		}
+
 		if (w.active_roles != NUM_OF_RTW89_MCC_ROLES) {
 			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 				    "unhandled ent: %d chanctxs %d roles\n",
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 74de13a2e7da..2eb31dff2083 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -101,6 +101,14 @@ void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 			 enum rtw89_chanctx_pause_reasons rsn);
 void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev);
+
+const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
+					       const char *caller_message,
+					       u8 link_index);
+
+#define rtw89_mgnt_chan_get(rtwdev, link_index) \
+	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 53aaf500bca5..195b6861d9fc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -341,84 +341,47 @@ void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 	rtw89_chan_create(chan, center_chan, channel->hw_value, band, bandwidth);
 }
 
-void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
+static void __rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_phy_idx phy_idx)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_chan *chan;
-	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_chanctx_idx roc_idx;
-	enum rtw89_phy_idx phy_idx;
-	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	mode = rtw89_get_entity_mode(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_SCC:
-	case RTW89_ENTITY_MODE_MCC:
-		chanctx_idx = RTW89_CHANCTX_0;
-		break;
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chanctx_idx = RTW89_CHANCTX_1;
-		break;
-	default:
-		WARN(1, "Invalid ent mode: %d\n", mode);
+	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
+	if (!entity_active)
 		return;
-	}
 
-	roc_idx = atomic_read(&hal->roc_chanctx_idx);
-	if (roc_idx != RTW89_CHANCTX_IDLE)
-		chanctx_idx = roc_idx;
+	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
+}
 
-	phy_idx = RTW89_PHY_0;
+void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan;
 
-	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
-	if (!entity_active)
+	chan = rtw89_mgnt_chan_get(rtwdev, 0);
+	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_0);
+
+	if (!rtwdev->support_mlo)
 		return;
 
-	chan = rtw89_chan_get(rtwdev, chanctx_idx);
-	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
+	chan = rtw89_mgnt_chan_get(rtwdev, 1);
+	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_1);
 }
 
-int rtw89_set_channel(struct rtw89_dev *rtwdev)
+static void __rtw89_set_channel(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_mac_idx mac_idx,
+				enum rtw89_phy_idx phy_idx)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan_rcd *chan_rcd;
-	const struct rtw89_chan *chan;
-	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_chanctx_idx roc_idx;
-	enum rtw89_mac_idx mac_idx;
-	enum rtw89_phy_idx phy_idx;
 	struct rtw89_channel_help_params bak;
-	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	mode = rtw89_entity_recalc(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_SCC:
-	case RTW89_ENTITY_MODE_MCC:
-		chanctx_idx = RTW89_CHANCTX_0;
-		break;
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chanctx_idx = RTW89_CHANCTX_1;
-		break;
-	default:
-		WARN(1, "Invalid ent mode: %d\n", mode);
-		return -EINVAL;
-	}
-
-	roc_idx = atomic_read(&hal->roc_chanctx_idx);
-	if (roc_idx != RTW89_CHANCTX_IDLE)
-		chanctx_idx = roc_idx;
-
-	mac_idx = RTW89_MAC_0;
-	phy_idx = RTW89_PHY_0;
-
 	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
 
-	chan = rtw89_chan_get(rtwdev, chanctx_idx);
-	chan_rcd = rtw89_chan_rcd_get(rtwdev, chanctx_idx);
+	chan_rcd = rtw89_chan_rcd_get_by_chan(chan);
 
 	rtw89_chip_set_channel_prepare(rtwdev, &bak, chan, mac_idx, phy_idx);
 
@@ -434,6 +397,28 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	}
 
 	rtw89_set_entity_state(rtwdev, phy_idx, true);
+}
+
+int rtw89_set_channel(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan;
+	enum rtw89_entity_mode mode;
+
+	mode = rtw89_entity_recalc(rtwdev);
+	if (mode < 0 || mode >= NUM_OF_RTW89_ENTITY_MODE) {
+		WARN(1, "Invalid ent mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	chan = rtw89_mgnt_chan_get(rtwdev, 0);
+	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_0, RTW89_PHY_0);
+
+	if (!rtwdev->support_mlo)
+		return 0;
+
+	chan = rtw89_mgnt_chan_get(rtwdev, 1);
+	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_1, RTW89_PHY_1);
+
 	return 0;
 }
 
@@ -3178,9 +3163,10 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc start: find no link on HW-0\n");
+		rtw89_err(rtwdev, "roc start: find no link on HW-%u\n",
+			  RTW89_ROC_BY_LINK_INDEX);
 		return;
 	}
 
@@ -3233,9 +3219,10 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc end: find no link on HW-0\n");
+		rtw89_err(rtwdev, "roc end: find no link on HW-%u\n",
+			  RTW89_ROC_BY_LINK_INDEX);
 		return;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5306ee97444c..10a5144fd425 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3428,6 +3428,8 @@ enum rtw89_roc_state {
 	RTW89_ROC_MGMT,
 };
 
+#define RTW89_ROC_BY_LINK_INDEX 0
+
 struct rtw89_roc {
 	struct ieee80211_channel chan;
 	struct delayed_work roc_work;
@@ -4625,7 +4627,7 @@ enum rtw89_chanctx_changes {
 };
 
 enum rtw89_entity_mode {
-	RTW89_ENTITY_MODE_SCC,
+	RTW89_ENTITY_MODE_SCC_OR_SMLD,
 	RTW89_ENTITY_MODE_MCC_PREPARE,
 	RTW89_ENTITY_MODE_MCC,
 
@@ -4640,6 +4642,8 @@ enum rtw89_entity_mode {
 struct rtw89_entity_mgnt {
 	struct list_head active_list;
 	struct rtw89_vif *active_roles[RTW89_MAX_INTERFACE_NUM];
+	enum rtw89_chanctx_idx chanctx_tbl[RTW89_MAX_INTERFACE_NUM]
+					  [__RTW89_MLD_MAX_LINK_NUM];
 };
 
 struct rtw89_chanctx {
@@ -6378,6 +6382,15 @@ const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
 	return &hal->chanctx[idx].rcd;
 }
 
+static inline
+const struct rtw89_chan_rcd *rtw89_chan_rcd_get_by_chan(const struct rtw89_chan *chan)
+{
+	const struct rtw89_chanctx *chanctx =
+		container_of_const(chan, struct rtw89_chanctx, chan);
+
+	return &chanctx->rcd;
+}
+
 static inline
 const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1


