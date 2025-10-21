Return-Path: <linux-wireless+bounces-28143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55235BF6CD3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8B719A5F9E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA33385A4;
	Tue, 21 Oct 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="j59Oj/3p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B62512DE
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053667; cv=none; b=jIT5xgn+eBiU203IwW6lhWF5hhJTXZAzhCVscdjZjrdCMTzgk3dLqZOW9qYMuQMg9jIqms7bZMmG3mezpf/JttHUyeVHeIx57fcm+79V6NUm3p0gVC0IdEQ2MVRQ6BoZJvssEw4CtQ5/EWP0RbAG42roDLOotOHZfs37qfLwz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053667; c=relaxed/simple;
	bh=6n4kxl0ybRMrHvZRNPxwVoCzhGgfyHXVn1rSnW31/0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBF2MKxe8993JmzcMlYrWUcC9nEuNgNyTse3d//OU/CjAnKoZWGZJiN2R9R9TBybpfkWm/zHm+7SLCG97nLWfpwgLYeaBSrUmYy0otVU4miBxTwgmcT1Y93zTGjCE8+CLsZhx4AwdUreMQ8NCrqxg8JvAwUGluvwAoQvGj0qKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=j59Oj/3p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYK4p83088097, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053660; bh=H3Fuh07POmwFj5h6dtlSXUzOO3IgaVZ/VysFT4urWqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=j59Oj/3pT75iGyi4hryATMc87MaDN0G9k4Vh0xn1VsYzOM4G6MOI8lmmvaAZ1zCTR
	 kQRxUnmr8dMGyxVyS8G4cjeH17PDtxgaz0x/3ZJWbTZIy/42Ba775L5Dtg+DGRPgbB
	 cXLleIh7DnYmOLsV2xlWTIad/n6EGC22+fit21tCjGnG9togDodZievICniUFVfXdn
	 rDdVDkNliVO/oqJyTsdakDKJ7nvpATqwKQ/tLM1OSUTgxwH8I/Punb5lj5SOKOHRWA
	 0ZAgjyapSJGLgFNnNaiVZ3iSxygDhCovm7AzOss25sl9o+5dTbqNQqD8jgDMVEDph2
	 Y/JPC2oKaJSsw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYK4p83088097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:20 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:20 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 3/8] wifi: rtw89: mlo: handle needed H2C when link switching is requested by stack
Date: Tue, 21 Oct 2025 21:33:57 +0800
Message-ID: <20251021133402.15467-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

To switch link, FW needs H2C commands to indicate which link is on or off.
Originally, these H2C commands are considered only when the link switching
is initiated by driver. But, in some cases, e.g. ml_reconf or TTLM, link
switching would be initiated by stack. Hence, plan these H2C commands into
ieee80211_ops.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +-----
 drivers/net/wireless/realtek/rtw89/core.h     |  8 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 64 ++++++++++++++++++-
 3 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 8b40cada4149..a3f156bf708e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6010,7 +6010,7 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	u16 usable_links = ieee80211_vif_usable_links(vif);
 	u16 active_links = vif->active_links;
-	struct rtw89_vif_link *target, *cur;
+	struct rtw89_vif_link *target;
 	int ret;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
@@ -6036,11 +6036,9 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	ieee80211_stop_queues(rtwdev->hw);
 	flush_work(&rtwdev->txq_work);
 
-	cur = rtw89_get_designated_link(rtwvif);
-
-	ret = ieee80211_set_active_links(vif, active_links | BIT(link_id));
+	ret = ieee80211_set_active_links(vif, BIT(link_id));
 	if (ret) {
-		rtw89_err(rtwdev, "%s: failed to activate link id %u\n",
+		rtw89_err(rtwdev, "%s: failed to work on link id %u\n",
 			  __func__, link_id);
 		goto wake_queue;
 	}
@@ -6055,16 +6053,6 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		goto wake_queue;
 	}
 
-	if (likely(cur))
-		rtw89_fw_h2c_mlo_link_cfg(rtwdev, cur, false);
-
-	rtw89_fw_h2c_mlo_link_cfg(rtwdev, target, true);
-
-	ret = ieee80211_set_active_links(vif, BIT(link_id));
-	if (ret)
-		rtw89_err(rtwdev, "%s: failed to inactivate links 0x%x\n",
-			  __func__, active_links);
-
 	rtw89_chip_rfk_channel(rtwdev, target);
 
 	rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 928c8c84c964..7c74ed3cfaf7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5933,6 +5933,7 @@ struct rtw89_mcc_info {
 
 enum rtw89_mlo_mode {
 	RTW89_MLO_MODE_MLSR = 0,
+	RTW89_MLO_MODE_EMLSR = 1,
 
 	NUM_OF_RTW89_MLO_MODE,
 };
@@ -6097,6 +6098,12 @@ struct rtw89_link_conf_container {
 	struct ieee80211_bss_conf *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
+struct rtw89_vif_ml_trans {
+	u16 mediate_links;
+	u16 links_to_del;
+	u16 links_to_add;
+};
+
 #define RTW89_VIF_IDLE_LINK_ID 0
 
 struct rtw89_vif {
@@ -6119,6 +6126,7 @@ struct rtw89_vif {
 	bool offchan;
 
 	enum rtw89_mlo_mode mlo_mode;
+	struct rtw89_vif_ml_trans ml_trans;
 
 	struct list_head dlink_pool;
 	u8 links_inst_valid_num;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 7b04183a3a5d..a19304ff8306 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -718,6 +718,17 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ARP_FILTER)
 		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
+
+	if (changed & BSS_CHANGED_MLD_VALID_LINKS) {
+		struct rtw89_vif_link *cur = rtw89_get_designated_link(rtwvif);
+
+		rtw89_chip_rfk_channel(rtwdev, cur);
+
+		if (hweight16(vif->active_links) == 1)
+			rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
+		else
+			rtwvif->mlo_mode = RTW89_MLO_MODE_EMLSR;
+	}
 }
 
 static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
@@ -1531,10 +1542,29 @@ static bool rtw89_ops_can_activate_links(struct ieee80211_hw *hw,
 					 u16 active_links)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	u16 current_links = vif->active_links;
+	struct rtw89_vif_ml_trans trans = {
+		.mediate_links = current_links | active_links,
+		.links_to_del = current_links & ~active_links,
+		.links_to_add = active_links & ~current_links,
+	};
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	return rtw89_can_work_on_links(rtwdev, vif, active_links);
+	if (!rtw89_can_work_on_links(rtwdev, vif, active_links))
+		return false;
+
+	/*
+	 * Leave LPS at the beginning of ieee80211_set_active_links().
+	 * Because the entire process takes the same lock as our track
+	 * work, LPS will not enter during ieee80211_set_active_links().
+	 */
+	rtw89_leave_lps(rtwdev);
+
+	rtwvif->ml_trans = trans;
+
+	return true;
 }
 
 static void __rtw89_ops_clr_vif_links(struct rtw89_dev *rtwdev,
@@ -1579,6 +1609,36 @@ static int __rtw89_ops_set_vif_links(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_vif_cfg_fw_links(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif,
+				   unsigned long links, bool en)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rtwvif_link = rtwvif->links[link_id];
+		if (unlikely(!rtwvif_link))
+			continue;
+
+		rtw89_fw_h2c_mlo_link_cfg(rtwdev, rtwvif_link, en);
+	}
+}
+
+static void rtw89_vif_update_fw_links(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif *rtwvif,
+				      u16 current_links)
+{
+	struct rtw89_vif_ml_trans *trans = &rtwvif->ml_trans;
+
+	/* Do follow-up when all updating links exist. */
+	if (current_links != trans->mediate_links)
+		return;
+
+	rtw89_vif_cfg_fw_links(rtwdev, rtwvif, trans->links_to_del, false);
+	rtw89_vif_cfg_fw_links(rtwdev, rtwvif, trans->links_to_add, true);
+}
+
 static
 int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
@@ -1620,6 +1680,8 @@ int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
+	rtw89_vif_update_fw_links(rtwdev, rtwvif, old_links);
+
 	if (!old_links)
 		__rtw89_ops_clr_vif_links(rtwdev, rtwvif,
 					  BIT(RTW89_VIF_IDLE_LINK_ID));
-- 
2.25.1


