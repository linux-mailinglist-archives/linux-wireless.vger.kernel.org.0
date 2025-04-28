Return-Path: <linux-wireless+bounces-22140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290DA9EF09
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518847AB392
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384A265CAD;
	Mon, 28 Apr 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RKlDQuVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAB25D536
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839571; cv=none; b=Du5RvTgxERCDDtCBh9+aaL2sDLkAUaapjB65LaBJcQp6DOdAdgtvxcStokzH9mHYMb6s4G5insWcoivFmV3F4xl736aCTZDwbx0yV93PApHObNX06AZyLjBBtqRk9M/lUvPCRlRnrYdIpxdiiK+Z76I8KOiktcdhIrocTPOJWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839571; c=relaxed/simple;
	bh=NpV/Qhq23pJTZ38HFzhSGd8SKyxVDc9dTJ4dTJgrPWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJc1tDg2BNE/vcANkg6nZ1uKc47bSYiOBYfWSUxM2TAbozL/Ls1NzHw7fj0mS35lTVAF5KRj8AVNfhnY/pQtOv6JBfoV62miTNAG8RGslSmD7qmM93TWYj1qSkEZB3kMxiMkmoD8sKwbKz3dRfyEEnSo05tjym28dS0nBtrC3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RKlDQuVQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBQ7Pu82101733, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839567; bh=NpV/Qhq23pJTZ38HFzhSGd8SKyxVDc9dTJ4dTJgrPWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RKlDQuVQjilT2dlpe5ebPNZxyoUdAVeyAqNLIMAMXP36ih6cdR8wSo9887OSOf15Z
	 emTjIDMPlIlrb/TPr3+vBh+fAxdIStcxwnR7tg3lYjRK+RJ9+ohfFUkZ5AvuJ8p+Z5
	 ZVz+rqQIePrOHOOw8ydVCwPVawInP2g1ajTnH+hS+g5i+AsGn5aALrBR0zLNLObT/6
	 qfWs/yUHNCLoINokm0FNnezRY2I0jNuMtPhcgypTyDpQCtRyaeh39Tprw36pEtaPHB
	 cEeVmsMBLqv9ExZ6O9ypKT6TWfi6xAqRBlMVLeXU/zRBFk7Z3NpWzZQibHh73DkQlR
	 74IkYhrFAQRDQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBQ7Pu82101733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:26:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:26:07 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:26:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/10] wifi: rtw89: introduce helper to get designated link for MLO
Date: Mon, 28 Apr 2025 19:24:56 +0800
Message-ID: <20250428112456.13165-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

A link bound to HW band 0 was previously always assumed to exist, because
it's true on non-MLD connection, and MLO connection is not supported yet.
Now, start to consider MLO cases and prepare to enable MLO support in the
following. Add skeleton of designated link. For single-link cases, helper
returns the one. For multi-link cases, priorities can be scheduled. Then,
drop assumption of link bound to HW band 0.

One exception is that MCC doesn't work with MLD yet, so it still expects
link on HW band 0 somewhere.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 12 ++-----
 drivers/net/wireless/realtek/rtw89/core.c     | 33 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     | 12 +++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c | 21 +++++++-----
 drivers/net/wireless/realtek/rtw89/wow.c      |  3 +-
 5 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 6d17456046d5..4fec61ed3454 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -694,19 +694,13 @@ static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_vif *target = mcc_role->rtwvif_link->rtwvif;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
-	struct rtw89_sta_link *rtwsta_link;
+	u8 macid;
 
 	if (rtwvif != target)
 		return;
 
-	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
-	if (unlikely(!rtwsta_link)) {
-		rtw89_err(rtwdev, "mcc sta macid: find no link on HW-0\n");
-		return;
-	}
-
-	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta_link->mac_id);
+	macid = rtw89_sta_get_main_macid(rtwsta);
+	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, macid);
 }
 
 static void rtw89_mcc_fill_role_macid_bitmap(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 268107b1e039..57fb3cfc0a0d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1133,22 +1133,20 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
-	/* By default, driver writes tx via the link on HW-0. And then,
-	 * according to links' status, HW can change tx to another link.
-	 */
-
 	if (rtwsta) {
-		rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+		rtwsta_link = rtw89_get_designated_link(rtwsta);
 		if (unlikely(!rtwsta_link)) {
-			rtw89_err(rtwdev, "tx: find no sta link on HW-0\n");
+			rtw89_err(rtwdev, "tx: find no sta designated link\n");
 			return -ENOLINK;
 		}
-	}
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
-	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "tx: find no vif link on HW-0\n");
-		return -ENOLINK;
+		rtwvif_link = rtwsta_link->rtwvif_link;
+	} else {
+		rtwvif_link = rtw89_get_designated_link(rtwvif);
+		if (unlikely(!rtwvif_link)) {
+			rtw89_err(rtwdev, "tx: find no vif designated link\n");
+			return -ENOLINK;
+		}
 	}
 
 	tx_req.skb = skb;
@@ -3147,9 +3145,9 @@ static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
 	if (!rtwsta)
 		return false;
 
-	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	rtwsta_link = rtw89_get_designated_link(rtwsta);
 	if (unlikely(!rtwsta_link)) {
-		rtw89_err(rtwdev, "agg wait: find no link on HW-0\n");
+		rtw89_err(rtwdev, "agg wait: find no designated link\n");
 		return false;
 	}
 
@@ -3372,10 +3370,9 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc start: find no link on HW-%u\n",
-			  RTW89_ROC_BY_LINK_INDEX);
+		rtw89_err(rtwdev, "roc start: find no designated link\n");
 		return;
 	}
 
@@ -4806,6 +4803,7 @@ struct rtw89_vif_link *rtw89_vif_set_link(struct rtw89_vif *rtwvif,
 
 	set_bit(index, rtwvif->links_inst_map);
 	rtwvif->links[link_id] = rtwvif_link;
+	list_add_tail(&rtwvif_link->dlink_schd, &rtwvif->dlink_pool);
 	return rtwvif_link;
 
 err:
@@ -4826,6 +4824,7 @@ void rtw89_vif_unset_link(struct rtw89_vif *rtwvif, unsigned int link_id)
 	index = rtw89_vif_link_inst_get_index(link);
 	clear_bit(index, rtwvif->links_inst_map);
 	*container = NULL;
+	list_del(&link->dlink_schd);
 }
 
 struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
@@ -4856,6 +4855,7 @@ struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
 
 	set_bit(index, rtwsta->links_inst_map);
 	rtwsta->links[link_id] = rtwsta_link;
+	list_add_tail(&rtwsta_link->dlink_schd, &rtwsta->dlink_pool);
 	return rtwsta_link;
 
 err:
@@ -4876,6 +4876,7 @@ void rtw89_sta_unset_link(struct rtw89_sta *rtwsta, unsigned int link_id)
 	index = rtw89_sta_link_inst_get_index(link);
 	clear_bit(index, rtwsta->links_inst_map);
 	*container = NULL;
+	list_del(&link->dlink_schd);
 }
 
 int rtw89_core_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5e4b096f42fc..20c0bab2600a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3380,6 +3380,7 @@ struct rtw89_sec_cam_entry {
 
 struct rtw89_sta_link {
 	struct rtw89_sta *rtwsta;
+	struct list_head dlink_schd;
 	unsigned int link_id;
 
 	u8 mac_id;
@@ -3446,8 +3447,6 @@ enum rtw89_roc_state {
 	RTW89_ROC_MGMT,
 };
 
-#define RTW89_ROC_BY_LINK_INDEX 0
-
 struct rtw89_roc {
 	struct ieee80211_channel chan;
 	struct wiphy_delayed_work roc_work;
@@ -3487,6 +3486,7 @@ struct rtw89_p2p_noa_setter {
 
 struct rtw89_vif_link {
 	struct rtw89_vif *rtwvif;
+	struct list_head dlink_schd;
 	unsigned int link_id;
 
 	bool chanctx_assigned; /* only valid when running with chanctx_ops */
@@ -5878,6 +5878,7 @@ struct rtw89_vif {
 	struct rtw89_roc roc;
 	bool offchan;
 
+	struct list_head dlink_pool;
 	u8 links_inst_valid_num;
 	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
 	struct rtw89_vif_link *links[IEEE80211_MLD_MAX_NUM_LINKS];
@@ -5917,6 +5918,7 @@ struct rtw89_sta {
 
 	DECLARE_BITMAP(pairwise_sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
 
+	struct list_head dlink_pool;
 	u8 links_inst_valid_num;
 	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
 	struct rtw89_sta_link *links[IEEE80211_MLD_MAX_NUM_LINKS];
@@ -6012,6 +6014,12 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
 }
 
+#define rtw89_get_designated_link(links_holder) \
+({ \
+	typeof(links_holder) p = links_holder; \
+	list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), dlink_schd); \
+})
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f4384c1c8cb0..182a952127c4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -187,6 +187,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif)) {
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 		INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+		INIT_LIST_HEAD(&rtwvif->dlink_pool);
 	}
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
@@ -495,6 +496,8 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
+	INIT_LIST_HEAD(&rtwsta->dlink_pool);
+
 	skb_queue_head_init(&rtwsta->roc_queue);
 	bitmap_zero(rtwsta->pairwise_sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
 
@@ -1019,7 +1022,7 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_sta_link *rtwsta_link;
 
-	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	rtwsta_link = rtw89_get_designated_link(rtwsta);
 	if (unlikely(!rtwsta_link))
 		return;
 
@@ -1154,9 +1157,9 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "sw scan start: find no link on HW-0\n");
+		rtw89_err(rtwdev, "sw scan start: find no designated link\n");
 		return;
 	}
 
@@ -1174,9 +1177,9 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "sw scan complete: find no link on HW-0\n");
+		rtw89_err(rtwdev, "sw scan complete: find no designated link\n");
 		return;
 	}
 
@@ -1208,9 +1211,9 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (rtwdev->scanning || rtwvif->offchan)
 		return -EBUSY;
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "hw scan: find no link on HW-0\n");
+		rtw89_err(rtwdev, "hw scan: find no designated link\n");
 		return -ENOLINK;
 	}
 
@@ -1245,9 +1248,9 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (!rtwdev->scanning)
 		return;
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
+		rtw89_err(rtwdev, "cancel hw scan: find no designated link\n");
 		return;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 17eee58503cb..34a0ab49bd7a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1086,8 +1086,7 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 		rtw89_wow_init_pno(rtwdev, wowlan->nd_config);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		/* use the link on HW-0 to do wow flow */
-		rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+		rtwvif_link = rtw89_get_designated_link(rtwvif);
 		if (!rtwvif_link)
 			continue;
 
-- 
2.25.1


