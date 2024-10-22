Return-Path: <linux-wireless+bounces-14298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA099A9CAA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DB21C22D76
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2014EC4E;
	Tue, 22 Oct 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YTFcMkfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB0157487
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585907; cv=none; b=czWzA/CCzvQsaOMWIbgJLveLm+bU3H5Vbn2ZpthgDjGtYF02cyyralb9JtUi0a++bN38LSH5ljG/7UpFiG0UJsSyeIttgq/WvarBGsLB7xkQMFBL2lYsyirEm+MZ+jQnNIx2wotF2NezOdebCPoNefKPFAhdyZt62Kb5oKaakrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585907; c=relaxed/simple;
	bh=lhG8wlzbthmwXY9bcgULveYWiaXOEDRJ8+PFVpwW7Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhW+Dt59Y3yewghyENHU/OALM5k7xpw9x+TSbj95nN0UzhLCm5ZlGWkRFq7eQjUea598tIFnCM73X15WwFiRi6RZL0abMfllsd3V6l+5goeV2X3ZBFE9PT0RzqUvEB+aPodGj5/A9MnVceVX4VuZfWjb+1BGfKZnbjKwa/QZcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YTFcMkfm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8VglpE3771857, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585902; bh=lhG8wlzbthmwXY9bcgULveYWiaXOEDRJ8+PFVpwW7Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YTFcMkfm+MS2wR34tzh/zXfmbHUdm3/lo81/iH7VSjwL2Ap5SjrPBLgvtSLBargHn
	 b4aIhCavxxa3iyTmS+ApgIR70bcnkthGxdgCCYfP3IhoZcrIdTtDpETdpDd33REd3N
	 hRrb4EMapxNVR+VAKo33GTdPqxxY9a1Jm/m4KJ9gJ1+utTh+IAtW+84NdXvBsKrGfU
	 hxhLMBKPlhITIirFjtaarNasO8/GZl01gdsv3HVCirsInGPVqjoJZnPBhkCGJ23hkO
	 B8mG8P+BIRK4zXOvI2bVm7xqvJTPmSPzdZdN1tijHbk016opRslSy/fYPjPML1eSmV
	 nGuoM0Ozd9z/g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8VglpE3771857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/5] wifi: rtw89: chan: manage active interfaces
Date: Tue, 22 Oct 2024 16:31:04 +0800
Message-ID: <20241022083106.149252-4-pkshih@realtek.com>
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

To set channel well for combination of MCC (multi-channel concurrency) and
impending MLO support, we need a method to manage relation between active
interfaces and channel contexts. If an interface owns at least one active
link, we call it an active interface. We add a list to manage active ones.

Basically, the list follows the active order except for the below case. To
be compatible with legacy behavior, the first interface that owns the first
channel context will put at the first entry in the list when recalculating.

Besides, MCC can also select and fill roles based on the above active list.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 105 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  10 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +
 4 files changed, 108 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ba6332da8019..2b7e6921ff9c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -10,6 +10,10 @@
 #include "ps.h"
 #include "util.h"
 
+static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
+			       enum rtw89_chanctx_idx idx1,
+			       enum rtw89_chanctx_idx idx2);
+
 static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
 						 u8 center_chan)
 {
@@ -226,11 +230,15 @@ static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
 void rtw89_entity_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 
 	hal->entity_pause = false;
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_CHANCTX);
 	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	atomic_set(&hal->roc_chanctx_idx, RTW89_CHANCTX_IDLE);
+
+	INIT_LIST_HEAD(&mgnt->active_list);
+
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -272,6 +280,71 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_vif_link *cur;
+
+	if (unlikely(!rtwvif_link->chanctx_assigned))
+		return;
+
+	cur = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (!cur || !cur->chanctx_assigned)
+		return;
+
+	if (cur == rtwvif_link)
+		return;
+
+	rtw89_swap_chanctx(rtwdev, rtwvif_link->chanctx_idx, cur->chanctx_idx);
+}
+
+static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
+	struct rtw89_vif_link *link;
+	struct rtw89_vif *role;
+	u8 pos = 0;
+	int i;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++)
+		mgnt->active_roles[i] = NULL;
+
+	/* To be consistent with legacy behavior, expect the first active role
+	 * which uses RTW89_CHANCTX_0 to put at position 0, and make its first
+	 * link instance take RTW89_CHANCTX_0. (normalizing)
+	 */
+	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
+		for (i = 0; i < role->links_inst_valid_num; i++) {
+			link = rtw89_vif_get_link_inst(role, i);
+			if (!link || !link->chanctx_assigned)
+				continue;
+
+			if (link->chanctx_idx == RTW89_CHANCTX_0) {
+				rtw89_normalize_link_chanctx(rtwdev, link);
+
+				list_del(&role->mgnt_entry);
+				list_add(&role->mgnt_entry, &mgnt->active_list);
+				break;
+			}
+		}
+	}
+
+	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
+		if (unlikely(pos >= RTW89_MAX_INTERFACE_NUM)) {
+			rtw89_warn(rtwdev,
+				   "%s: active roles are over max iface num\n",
+				   __func__);
+			break;
+		}
+
+		mgnt->active_roles[pos++] = role;
+	}
+}
+
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
 	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_CHANCTX) = {};
@@ -327,6 +400,8 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		rtw89_assign_entity_chan(rtwdev, idx, &chan);
 	}
 
+	rtw89_entity_recalc_mgnt_roles(rtwdev);
+
 	if (hal->entity_pause)
 		return rtw89_get_entity_mode(rtwdev);
 
@@ -716,6 +791,7 @@ struct rtw89_mcc_fill_role_selector {
 };
 
 static_assert((u8)NUM_OF_RTW89_CHANCTX >= NUM_OF_RTW89_MCC_ROLES);
+static_assert(RTW89_MAX_INTERFACE_NUM >= NUM_OF_RTW89_MCC_ROLES);
 
 static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *mcc_role,
@@ -745,14 +821,18 @@ static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 
 static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_mcc_fill_role_selector sel = {};
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *rtwvif;
 	int ret;
+	int i;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (!rtw89_vif_is_active_role(rtwvif))
-			continue;
+	for (i = 0; i < NUM_OF_RTW89_MCC_ROLES; i++) {
+		rtwvif = mgnt->active_roles[i];
+		if (!rtwvif)
+			break;
 
 		rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 		if (unlikely(!rtwvif_link)) {
@@ -760,14 +840,7 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 			continue;
 		}
 
-		if (sel.bind_vif[rtwvif_link->chanctx_idx]) {
-			rtw89_warn(rtwdev,
-				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
-				   rtwvif_link->mac_id, rtwvif_link->chanctx_idx);
-			continue;
-		}
-
-		sel.bind_vif[rtwvif_link->chanctx_idx] = rtwvif_link;
+		sel.bind_vif[i] = rtwvif_link;
 	}
 
 	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
@@ -2501,12 +2574,18 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_entity_weight w = {};
 
 	rtwvif_link->chanctx_idx = cfg->idx;
 	rtwvif_link->chanctx_assigned = true;
 	cfg->ref_count++;
 
+	if (list_empty(&rtwvif->mgnt_entry))
+		list_add_tail(&rtwvif->mgnt_entry, &mgnt->active_list);
+
 	if (cfg->idx == RTW89_CHANCTX_0)
 		goto out;
 
@@ -2526,6 +2605,7 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_chanctx_idx roll;
 	enum rtw89_entity_mode cur;
@@ -2536,6 +2616,9 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_assigned = false;
 	cfg->ref_count--;
 
+	if (!rtw89_vif_is_active_role(rtwvif))
+		list_del_init(&rtwvif->mgnt_entry);
+
 	if (cfg->ref_count != 0)
 		goto out;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3317f9b8a705..53aaf500bca5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -192,13 +192,13 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	{
 		.limits = rtw89_iface_limits,
 		.n_limits = ARRAY_SIZE(rtw89_iface_limits),
-		.max_interfaces = 2,
+		.max_interfaces = RTW89_MAX_INTERFACE_NUM,
 		.num_different_channels = 1,
 	},
 	{
 		.limits = rtw89_iface_limits_mcc,
 		.n_limits = ARRAY_SIZE(rtw89_iface_limits_mcc),
-		.max_interfaces = 2,
+		.max_interfaces = RTW89_MAX_INTERFACE_NUM,
 		.num_different_channels = 2,
 	},
 };
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4366b581c56b..5306ee97444c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4634,6 +4634,14 @@ enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_UNHANDLED = -ESRCH,
 };
 
+#define RTW89_MAX_INTERFACE_NUM 2
+
+/* only valid when running with chanctx_ops */
+struct rtw89_entity_mgnt {
+	struct list_head active_list;
+	struct rtw89_vif *active_roles[RTW89_MAX_INTERFACE_NUM];
+};
+
 struct rtw89_chanctx {
 	struct cfg80211_chan_def chandef;
 	struct rtw89_chan chan;
@@ -4677,6 +4685,7 @@ struct rtw89_hal {
 	bool entity_active[RTW89_PHY_MAX];
 	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
+	struct rtw89_entity_mgnt entity_mgnt;
 
 	struct rtw89_edcca_bak edcca_bak;
 	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
@@ -5614,6 +5623,7 @@ struct rtw89_dev {
 struct rtw89_vif {
 	struct rtw89_dev *rtwdev;
 	struct list_head list;
+	struct list_head mgnt_entry;
 
 	u8 mac_addr[ETH_ALEN];
 	__be32 ip_addr;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ee63a85308f..672da8def90f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -192,6 +192,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 
+	INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 
 	rtwvif->offchan = false;
-- 
2.25.1


