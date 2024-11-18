Return-Path: <linux-wireless+bounces-15439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 286389D084A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72692B21F8F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39282D66;
	Mon, 18 Nov 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ML2GuzUa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816EB13CA8A
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902643; cv=none; b=pLfUST2tBn0nmlsMPt163qqy4N2ukk84dEuTVuZGpFyCqVfXSZVPvIKKRfbCMD+iXECFk4X0m/mcB3oB4MDwOSLaB0lQJaacVJmRG1eOEiIm7+x+kGX8fNB8u52Kgc+7rBtUZksE6908Pz/4S78tyT/10VaZcLNg/ERVI8uoNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902643; c=relaxed/simple;
	bh=I1btq3uxtIkLiU/c7LUuzYzeiYu73+57pxFD3Gp0aZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTtRiBcJlGZ7Q99tw1Z9QWsTg4/ZRRhphb2phl/Gx5ECEDZRP2n/WetQjNksST6Od0TS6IOuEtcF8hp8C0a9SYUZku68VzbgQDb4G9hhs+8nphtwagC+NAZPZ4QZ+AXKe/TasjQLA8K6P5MNPOT1nLuNQDCEA7fPTY4dfZfGsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ML2GuzUa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI43wGV2100362, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902638; bh=I1btq3uxtIkLiU/c7LUuzYzeiYu73+57pxFD3Gp0aZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ML2GuzUab4K1vWJkIDeK6jhlg6MylxLzD64zfl1ynlE67xWYxcKEPUa6eLVnL5sjS
	 koyMNH0ju6koB1vOHMzMoM5VcN12o4kC3vVEI7Ff6UFG931duir0Hej1GpD6sJjHQL
	 M1tk5HlgPPb3P1lTyrREpIEx1VDS7vRdsa7f68EYbPa2ZQHANzwqp/7CwjMfKiqYxX
	 l11hyqBdxAgdXtvLW1CCHc6+sEUITgYDYDSWbHJXjOZZV0Tfa66F46vzaiRmK4BIvl
	 Gnha4h86O/68Fc0nv0I3JzlQlnLfr6O1tZyebISHQkxwcj61n7n5F8VHgYVZSOMefG
	 9HoYekf2mVcTA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI43wGV2100362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:03:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:03:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:03:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 3/6] wifi: rtw89: implement ops of change vif/sta links
Date: Mon, 18 Nov 2024 12:02:52 +0800
Message-ID: <20241118040255.40854-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118040255.40854-1-pkshih@realtek.com>
References: <20241118040255.40854-1-pkshih@realtek.com>
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

To support MLO, implement change_vif_links() and change_sta_links() ops.
Basically, we follow arguments to set/clear links. One special thing is
that when vif is idle, i.e. no connection, link id 0 is set up by us for
default uses. So, when bitmap of vif links change from 0x0 to non-zero,
we clear the default one first. And when bitmap of vif links change from
non-zero to 0x0, we set up a default one at the end.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  17 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 226 +++++++++++++++++-
 2 files changed, 238 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index dcd2ccadac96..bcfefd7fa01e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5700,10 +5700,17 @@ struct rtw89_dev {
 	u8 priv[] __aligned(sizeof(void *));
 };
 
+struct rtw89_link_conf_container {
+	struct ieee80211_bss_conf *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
+};
+
+#define RTW89_VIF_IDLE_LINK_ID 0
+
 struct rtw89_vif {
 	struct rtw89_dev *rtwdev;
 	struct list_head list;
 	struct list_head mgnt_entry;
+	struct rtw89_link_conf_container __rcu *snap_link_confs;
 
 	u8 mac_addr[ETH_ALEN];
 	__be32 ip_addr;
@@ -6273,9 +6280,19 @@ static inline struct ieee80211_bss_conf *
 __rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolink)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_link_conf_container *snap;
 	struct ieee80211_bss_conf *bss_conf;
 
+	snap = rcu_dereference(rtwvif->snap_link_confs);
+	if (snap) {
+		bss_conf = snap->link_conf[rtwvif_link->link_id];
+		goto out;
+	}
+
 	bss_conf = rcu_dereference(vif->link_conf[rtwvif_link->link_id]);
+
+out:
 	if (unlikely(!bss_conf)) {
 		*nolink = true;
 		return &vif->bss_conf;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 40ff5aa041fa..a4e47ef22b9b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -202,7 +202,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
 
-	rtwvif_link = rtw89_vif_set_link(rtwvif, 0);
+	rtwvif_link = rtw89_vif_set_link(rtwvif, RTW89_VIF_IDLE_LINK_ID);
 	if (!rtwvif_link) {
 		ret = -EINVAL;
 		goto release_port;
@@ -218,7 +218,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	return 0;
 
 unset_link:
-	rtw89_vif_unset_link(rtwvif, 0);
+	rtw89_vif_unset_link(rtwvif, RTW89_VIF_IDLE_LINK_ID);
 release_port:
 	list_del_init(&rtwvif->list);
 	rtw89_core_release_bit_map(rtwdev->hw_port, port);
@@ -246,17 +246,17 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
-	rtwvif_link = rtwvif->links[0];
+	rtwvif_link = rtwvif->links[RTW89_VIF_IDLE_LINK_ID];
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
-			  __func__, 0);
+			  __func__, RTW89_VIF_IDLE_LINK_ID);
 		goto bottom;
 	}
 
 	__rtw89_ops_remove_iface_link(rtwdev, rtwvif_link);
 
-	rtw89_vif_unset_link(rtwvif, 0);
+	rtw89_vif_unset_link(rtwvif, RTW89_VIF_IDLE_LINK_ID);
 
 bottom:
 	list_del_init(&rtwvif->list);
@@ -1508,6 +1508,220 @@ static bool rtw89_ops_can_activate_links(struct ieee80211_hw *hw,
 	return rtw89_can_work_on_links(rtwdev, vif, active_links);
 }
 
+static void __rtw89_ops_clr_vif_links(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif *rtwvif,
+				      unsigned long clr_links)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &clr_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rtwvif_link = rtwvif->links[link_id];
+		if (unlikely(!rtwvif_link))
+			continue;
+
+		__rtw89_ops_remove_iface_link(rtwdev, rtwvif_link);
+
+		rtw89_vif_unset_link(rtwvif, link_id);
+	}
+}
+
+static int __rtw89_ops_set_vif_links(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     unsigned long set_links)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+	int ret;
+
+	for_each_set_bit(link_id, &set_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rtwvif_link = rtw89_vif_set_link(rtwvif, link_id);
+		if (!rtwvif_link)
+			return -EINVAL;
+
+		ret = __rtw89_ops_add_iface_link(rtwdev, rtwvif_link);
+		if (ret) {
+			rtw89_err(rtwdev, "%s: failed to add iface (link id %u)\n",
+				  __func__, link_id);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static
+int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       u16 old_links, u16 new_links,
+			       struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	unsigned long clr_links = old_links & ~new_links;
+	unsigned long set_links = new_links & ~old_links;
+	bool removing_links = !old_links || clr_links;
+	struct rtw89_link_conf_container *snap;
+	int ret = 0;
+	int i;
+
+	guard(mutex)(&rtwdev->mutex);
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE,
+		    "%s: old_links (0x%08x) -> new_links (0x%08x)\n",
+		    __func__, old_links, new_links);
+
+	if (!rtw89_can_work_on_links(rtwdev, vif, new_links))
+		return -EOPNOTSUPP;
+
+	if (removing_links) {
+		snap = kzalloc(sizeof(*snap), GFP_KERNEL);
+		if (!snap)
+			return -ENOMEM;
+
+		for (i = 0; i < ARRAY_SIZE(snap->link_conf); i++)
+			snap->link_conf[i] = old[i];
+
+		rcu_assign_pointer(rtwvif->snap_link_confs, snap);
+	}
+
+	/* might depend on @snap; don't change order */
+	rtw89_leave_ips_by_hwflags(rtwdev);
+
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
+	if (!old_links)
+		__rtw89_ops_clr_vif_links(rtwdev, rtwvif,
+					  BIT(RTW89_VIF_IDLE_LINK_ID));
+	else if (clr_links)
+		__rtw89_ops_clr_vif_links(rtwdev, rtwvif, clr_links);
+
+	if (removing_links) {
+		/* @snap is required if and only if during removing links.
+		 * However, it's done here. So, cleanup @snap immediately.
+		 */
+		rcu_assign_pointer(rtwvif->snap_link_confs, NULL);
+
+		/* The pointers in @old will free after this function return,
+		 * so synchronously wait for all readers of snap to be done.
+		 */
+		synchronize_rcu();
+		kfree(snap);
+	}
+
+	if (set_links) {
+		ret = __rtw89_ops_set_vif_links(rtwdev, rtwvif, set_links);
+		if (ret)
+			__rtw89_ops_clr_vif_links(rtwdev, rtwvif, set_links);
+	} else if (!new_links) {
+		ret = __rtw89_ops_set_vif_links(rtwdev, rtwvif,
+						BIT(RTW89_VIF_IDLE_LINK_ID));
+		if (ret)
+			__rtw89_ops_clr_vif_links(rtwdev, rtwvif,
+						  BIT(RTW89_VIF_IDLE_LINK_ID));
+	}
+
+	rtw89_enter_ips_by_hwflags(rtwdev);
+	return ret;
+}
+
+static void __rtw89_ops_clr_sta_links(struct rtw89_dev *rtwdev,
+				      struct rtw89_sta *rtwsta,
+				      unsigned long clr_links)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &clr_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rtwsta_link = rtwsta->links[link_id];
+		if (unlikely(!rtwsta_link))
+			continue;
+
+		rtwvif_link = rtwsta_link->rtwvif_link;
+
+		rtw89_core_sta_link_disassoc(rtwdev, rtwvif_link, rtwsta_link);
+		rtw89_core_sta_link_disconnect(rtwdev, rtwvif_link, rtwsta_link);
+		rtw89_core_sta_link_remove(rtwdev, rtwvif_link, rtwsta_link);
+
+		rtw89_sta_unset_link(rtwsta, link_id);
+	}
+}
+
+static int __rtw89_ops_set_sta_links(struct rtw89_dev *rtwdev,
+				     struct rtw89_sta *rtwsta,
+				     unsigned long set_links)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+	int ret;
+
+	for_each_set_bit(link_id, &set_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rtwsta_link = rtw89_sta_set_link(rtwsta, link_id);
+		if (!rtwsta_link)
+			return -EINVAL;
+
+		rtwvif_link = rtwsta_link->rtwvif_link;
+
+		ret = rtw89_core_sta_link_add(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret) {
+			rtw89_err(rtwdev, "%s: failed to add sta (link id %u)\n",
+				  __func__, link_id);
+			return ret;
+		}
+
+		rtw89_vif_type_mapping(rtwvif_link, true);
+
+		ret = rtw89_core_sta_link_assoc(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret) {
+			rtw89_err(rtwdev, "%s: failed to assoc sta (link id %u)\n",
+				  __func__, link_id);
+			return ret;
+		}
+
+		__rtw89_ops_bss_link_assoc(rtwdev, rtwvif_link);
+	}
+
+	return 0;
+}
+
+static
+int rtw89_ops_change_sta_links(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       u16 old_links, u16 new_links)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	unsigned long clr_links = old_links & ~new_links;
+	unsigned long set_links = new_links & ~old_links;
+	int ret = 0;
+
+	guard(mutex)(&rtwdev->mutex);
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE,
+		    "%s: old_links (0x%08x) -> new_links (0x%08x)\n",
+		    __func__, old_links, new_links);
+
+	if (!rtw89_can_work_on_links(rtwdev, vif, new_links))
+		return -EOPNOTSUPP;
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	if (clr_links)
+		__rtw89_ops_clr_sta_links(rtwdev, rtwsta, clr_links);
+
+	if (set_links) {
+		ret = __rtw89_ops_set_sta_links(rtwdev, rtwsta, set_links);
+		if (ret)
+			__rtw89_ops_clr_sta_links(rtwdev, rtwsta, set_links);
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_PM
 static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 			     struct cfg80211_wowlan *wowlan)
@@ -1636,6 +1850,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.link_sta_rc_update	= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
 	.can_activate_links	= rtw89_ops_can_activate_links,
+	.change_vif_links	= rtw89_ops_change_vif_links,
+	.change_sta_links	= rtw89_ops_change_sta_links,
 #ifdef CONFIG_PM
 	.suspend		= rtw89_ops_suspend,
 	.resume			= rtw89_ops_resume,
-- 
2.25.1


