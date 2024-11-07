Return-Path: <linux-wireless+bounces-15043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5059C0039
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C781F23342
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D781922D8;
	Thu,  7 Nov 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bE1OvUR1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A721DA113
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968895; cv=none; b=KpORxvAWqpHpAxj6wpL9UbFMy7a7H0MvFWbCP9f2lt2/vJnGsKAW2PVQf8prlg9G+xXddGwPc9n7NUKoxLN0nOVTr7EdDs5VLOTC9X0gMzXzb8cKDCn3bzZxG/LVfGdMqyNV19uQXyiq8qJFVeUC1NoCygIsesan3pLVFBmLuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968895; c=relaxed/simple;
	bh=jOtZ20fs8M+tR3TavSlhfy8EXtxUPV4Lv0HD1BpXc0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+XTEPrJdpmRbv/FjsgWiGQvNirjFgUqtO+0EaknGP+W2EpbadxdIn4g1RD4AcRgg8iBykHE/uvq8x3WV7iB3yGLIzkoz5d7b+B8ak2Wq5Rle49ck2/VaoMOnYnYGxMboBcq5G58VyZe34kEh5Zps1xlPFa84CpuuRAkRD0VFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bE1OvUR1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A78fUdW54173705, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730968890; bh=jOtZ20fs8M+tR3TavSlhfy8EXtxUPV4Lv0HD1BpXc0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bE1OvUR1W70nyFW1D1jb6B/ucgS3p9SXRUCpjO9y09PHlKMmtYf2vycyAsEfe2qxC
	 1wheAQ+WWUC2jTG5JyMAdmLRgslaTVE3pdw/sqnC+N3vZ/bMNSnT76OjhIDRtAVCV7
	 8YneCFYL+YDFeFF9pXeWeI9QEEr+MgpH7DEFScOFhiwC//FxFS2Fe6qjZ5A/73s25B
	 MB+US6Cucu/wihv/rd7Vo9NqUb2TEt9NDiwLHrnk8rESea7pkurcQHmFSGOSUpi7E3
	 +kGMlK0iNu1gOsSdDcdffDdzeC+1KGeoCLOqocXyWdGPbgZmtWuXCav3Vm41k9e0oR
	 4/5C307rF1RZQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A78fUdW54173705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 7 Nov 2024 16:41:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:41:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Nov
 2024 16:41:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/6] wifi: rtw89: implement ops of change vif/sta links
Date: Thu, 7 Nov 2024 16:40:38 +0800
Message-ID: <20241107084041.20775-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107084041.20775-1-pkshih@realtek.com>
References: <20241107084041.20775-1-pkshih@realtek.com>
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
index b441d0491e88..b8f617c5a67a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5659,10 +5659,17 @@ struct rtw89_dev {
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
@@ -6232,9 +6239,19 @@ static inline struct ieee80211_bss_conf *
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
index ef3eb0fa651d..5e31d206bb11 100644
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
@@ -1506,6 +1506,220 @@ static bool rtw89_ops_can_activate_links(struct ieee80211_hw *hw,
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
@@ -1634,6 +1848,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
 	.can_activate_links	= rtw89_ops_can_activate_links,
+	.change_vif_links	= rtw89_ops_change_vif_links,
+	.change_sta_links	= rtw89_ops_change_sta_links,
 #ifdef CONFIG_PM
 	.suspend		= rtw89_ops_suspend,
 	.resume			= rtw89_ops_resume,
-- 
2.25.1


