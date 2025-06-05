Return-Path: <linux-wireless+bounces-23766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D1AACEEA5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A2B189B04C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59F218580;
	Thu,  5 Jun 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TphBZdEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7794217707
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123759; cv=none; b=KR3G/61xSosAjpxSHGh7rNgCvLiGB2NdIBQb2+j9waGStxievbh4OWQ1zgGf9Pr2pXwKVnS62oKB8TazprDhT8z22gk5hRUPwrKhdgzJWJp3Z292JCY7RSoXWWkVkaXZeGCOd9C+ZWdwAlOduG0sPElqQZct5QLcSo7HTL5Dj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123759; c=relaxed/simple;
	bh=82dI9eDii3JxHG9wN1lHvNSipscbWjzDx5eWnudzPvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnTwNsm8Wn0O9lhjz1WvzeQnEVRBtvtOWiT/tJe9RnIGtzS1H9/9dsQ2fMzknYI5RWEpgxtn6V5fI+EhOeE2xl7XJK44KEssnSA9HsTvxfpOt23rAT7KDJuE1s/vJf0Me957mbvJFu08Rfx4Wi+pbhx7vJ01xpGw2B0MoPIDQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TphBZdEz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555BgYoG51471113, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123755; bh=7rkBbDOP3/Bm6rCgLZ0pCp716nOu8Swds/DyD9fXg6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TphBZdEzyCPq9l1buHEMLLfKe4373FwMPxChZ9yMXqHtEQdduHhVEgRltfW161OZq
	 AikhW7EB9u9fU28H0WcnMb8XXDACCX0THMUqMceYmP04CeJfkTmDoo5BISaYrnR132
	 7wLud3y5YXyc22x8w3socgcvLOqBNlJyMwD5jUBPFvv9Je8sIasRJy0C1GKJAKp0n3
	 qCuSJbGdKFOcayzbWc8CVfoBQrD3clTG1bOtwvSBpTlv+1afQ2dC5PwUg95XCxaVsd
	 uM7tLkqRu7WwEHmg52/7NmntuHJ9E1gnF9XzR+MqKAxyg8jyJZ2J8CZOthmODm9a+6
	 AfMpJrB8p1v8Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555BgYoG51471113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:35 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/5] wifi: rtw89: implement channel switch support
Date: Thu, 5 Jun 2025 19:42:05 +0800
Message-ID: <20250605114207.12381-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605114207.12381-1-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com>
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

To support channel switch on STA mode, declare IEEE80211_HW_CHANCTX_STA_CSA
and implement ieee80211_ops::switch_vif_chanctx. Handling of CSA procedure
still relies on mac80211 SW flow, since FW doesn't support chanctx offload.
To support channel switch on AP mode, declare WIPHY_FLAG_HAS_CHANNEL_SWITCH
and implement ieee80211_ops::channel_switch_beacon additionally.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 32 +++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  5 ++
 drivers/net/wireless/realtek/rtw89/core.c     | 40 +++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 72 +++++++++++++++++++
 5 files changed, 151 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 31e15f472740..b2bc650a911b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2912,3 +2912,35 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 		break;
 	}
 }
+
+int rtw89_chanctx_ops_reassign_vif(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct ieee80211_chanctx_conf *old_ctx,
+				   struct ieee80211_chanctx_conf *new_ctx,
+				   bool replace)
+{
+	int ret;
+
+	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif_link, old_ctx);
+
+	if (!replace)
+		goto assign;
+
+	rtw89_chanctx_ops_remove(rtwdev, old_ctx);
+	ret = rtw89_chanctx_ops_add(rtwdev, new_ctx);
+	if (ret) {
+		rtw89_err(rtwdev, "%s: failed to add chanctx: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+assign:
+	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, new_ctx);
+	if (ret) {
+		rtw89_err(rtwdev, "%s: failed to assign chanctx: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index c75260eca71d..9c5e61ccab88 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -143,5 +143,10 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct ieee80211_chanctx_conf *ctx);
+int rtw89_chanctx_ops_reassign_vif(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct ieee80211_chanctx_conf *old_ctx,
+				   struct ieee80211_chanctx_conf *new_ctx,
+				   bool replace);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49447668cbf3..51d4f6113c38 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -204,6 +204,7 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 };
 
 static const u8 rtw89_ext_capa_sta[] = {
+	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
 	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 };
@@ -4655,6 +4656,43 @@ void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 }
 
+void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_vif_link *rtwvif_link =
+		container_of(work, struct rtw89_vif_link, csa_beacon_work.work);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct ieee80211_bss_conf *bss_conf;
+	unsigned int delay;
+
+	lockdep_assert_wiphy(wiphy);
+
+	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE)
+		return;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (!bss_conf->csa_active) {
+		rcu_read_unlock();
+		return;
+	}
+
+	delay = ieee80211_tu_to_usec(bss_conf->beacon_int);
+
+	rcu_read_unlock();
+
+	if (!ieee80211_beacon_cntdwn_is_complete(vif, rtwvif_link->link_id)) {
+		rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
+
+		wiphy_delayed_work_queue(wiphy, &rtwvif_link->csa_beacon_work,
+					 usecs_to_jiffies(delay));
+	} else {
+		ieee80211_csa_finish(vif, rtwvif_link->link_id);
+	}
+}
+
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond)
 {
 	struct completion *cmpl = &wait->completion;
@@ -5504,6 +5542,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 
 	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
@@ -5530,6 +5569,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
 			    WIPHY_FLAG_AP_UAPSD |
+			    WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			    WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (!chip->support_rnr)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c..53a00edc554d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3533,6 +3533,7 @@ struct rtw89_vif_link {
 	bool pwr_diff_en;
 	u8 def_tri_idx;
 	struct wiphy_work update_beacon_work;
+	struct wiphy_delayed_work csa_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
@@ -7317,6 +7318,7 @@ void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a47971003bd4..a531d18fe34f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -112,6 +112,8 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtw89_vif_type_mapping(rtwvif_link, false);
 
 	wiphy_work_init(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
+	wiphy_delayed_work_init(&rtwvif_link->csa_beacon_work, rtw89_core_csa_beacon_work);
+
 	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
 
 	rtw89_p2p_noa_once_init(rtwvif_link);
@@ -144,6 +146,7 @@ static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
+	wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->csa_beacon_work);
 
 	rtw89_p2p_noa_once_deinit(rtwvif_link);
 
@@ -1354,6 +1357,73 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif_link, ctx);
 }
 
+static
+int rtw89_ops_switch_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif_chanctx_switch *vifs,
+				 int n_vifs,
+				 enum ieee80211_chanctx_switch_mode mode)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	bool replace;
+	int ret;
+	int i;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	switch (mode) {
+	case CHANCTX_SWMODE_REASSIGN_VIF:
+		replace = false;
+		break;
+	case CHANCTX_SWMODE_SWAP_CONTEXTS:
+		replace = true;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < n_vifs; i++) {
+		struct ieee80211_vif_chanctx_switch *p = &vifs[i];
+		struct ieee80211_bss_conf *link_conf = p->link_conf;
+		struct rtw89_vif *rtwvif = vif_to_rtwvif(p->vif);
+		struct rtw89_vif_link *rtwvif_link;
+
+		rtwvif_link = rtwvif->links[link_conf->link_id];
+		if (unlikely(!rtwvif_link)) {
+			rtw89_err(rtwdev,
+				  "%s: rtwvif link (link_id %u) is not active\n",
+				  __func__, link_conf->link_id);
+			return -ENOLINK;
+		}
+
+		ret = rtw89_chanctx_ops_reassign_vif(rtwdev, rtwvif_link,
+						     p->old_ctx, p->new_ctx,
+						     replace);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void rtw89_ops_channel_switch_beacon(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct cfg80211_chan_def *chandef)
+{
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif_link *rtwvif_link;
+
+	BUILD_BUG_ON(RTW89_MLD_NON_STA_LINK_NUM != 1);
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "chsw bcn: find no link on HW-0\n");
+		return;
+	}
+
+	wiphy_delayed_work_queue(hw->wiphy, &rtwvif_link->csa_beacon_work, 0);
+}
+
 static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_channel *chan,
@@ -1805,6 +1875,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.change_chanctx		= rtw89_ops_change_chanctx,
 	.assign_vif_chanctx	= rtw89_ops_assign_vif_chanctx,
 	.unassign_vif_chanctx	= rtw89_ops_unassign_vif_chanctx,
+	.switch_vif_chanctx	= rtw89_ops_switch_vif_chanctx,
+	.channel_switch_beacon	= rtw89_ops_channel_switch_beacon,
 	.remain_on_channel		= rtw89_ops_remain_on_channel,
 	.cancel_remain_on_channel	= rtw89_ops_cancel_remain_on_channel,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
-- 
2.25.1


