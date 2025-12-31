Return-Path: <linux-wireless+bounces-30216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13CCEBA28
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487C23075F31
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06231197A;
	Wed, 31 Dec 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aKmq+MSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17D31577B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172045; cv=none; b=NMFwJtUj3JjbbVa/5P8ZjiWGljLegrWAkHRiufSHkmoz+I374pB6bEMYl0EhUTqPptMeuz5+iONdlUQHi27WMofgczJeQ+AeUef/nnvZKcPJ4kQoXIOvxZc5l8sZT7K5pxUlCuCGzCJDictszeeQCmbhYQK+bHYID31HtgNPMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172045; c=relaxed/simple;
	bh=9XweXxzFNvnzdAGVkba9AOgaTeTkrI6kgHYYS9Pusb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/esohZBSJu2qxKc19JgEgqtHq98dC0BA3FEDP3dBFUXiNx7xE6hY7cDtC1ld/PYTTGry9zOzOyLY8unsCtqcpC00185KwzRvWucdeNuhpuJaorbBnC8w00Y5gXbwmVcW+DRlhU28eYH37/qbPrrCFXqqcmpZw1cAqD/W47lF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aKmq+MSh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97LYI0880570, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172041; bh=2N2q2fzHX2gVGUgEJGrGlo5Tjr8i1OTZ502N1u382v8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aKmq+MShuX8tYx4jlx0HJl6lGwHIBl29nMMJDu+QLJbMPSqP3V4pPDsR31C+O1Aog
	 2wO0OGINoehaOadeR3GhTsXg5uA973XJhJyShdzhJ0Z6aTZ3eObS1MQXqIBue5xT3l
	 UOeRzadaK9gSiQa9wSZOMCTRdLq1sFcG4nwJS5a3ePfGORXOO57ZC4SgUP1dVdcW9I
	 A80SxlkvKAaMEgSBQ7dJeBQMGxP8HCQSWmkXIJ/Eo0vIkfeo5m0ox0GY2GKmMZPDin
	 gZiQI38YUvIrdGO+JYjPftAzM6WZlv7O+jY01iww3Xsr/910wc/Qv0RyC/K7p1lKEl
	 TmENflx748tBg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97LYI0880570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:21 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: pre-handle RF calibration on link when needed
Date: Wed, 31 Dec 2025 17:06:39 +0800
Message-ID: <20251231090647.56407-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The Wi-Fi 7 RF calibration flow has a new design which mainly affect
MLO cases. Before, old RFK H2C command can just send the used channels
and MLO mode even if there are multiple active links. After, each RFK
H2C command should send one channel corresponding to one active link.

For example, connect MLD AP (channel X) and then activate second link
(channel X + channel Y)

Before:
	RFK#1: channel X (path A + path B)
	RFK#2: channel X (path A) + channel Y (path B)

After:
	RFK#1: channel X (path A + path B)
		[set MLO mode to focus on 2nd link/channel]
	RFK#2: channel Y (path A + path B)
		[set MLO mode back to target case]

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 33 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/core.c     | 29 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 13 +++-----
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 5 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 8fe6a7ef738f..0b5509468582 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -295,6 +295,8 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 			mgnt->chanctx_tbl[i][j] = RTW89_CHANCTX_IDLE;
 	}
 
+	hal->entity_force_hw = RTW89_PHY_NUM;
+
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -417,12 +419,43 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(__rtw89_mgnt_chan_get);
 
+bool rtw89_entity_check_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_2_PLUS_0_1RF:
+		return phy_idx == RTW89_PHY_0;
+	case MLO_0_PLUS_2_1RF:
+		return phy_idx == RTW89_PHY_1;
+	default:
+		return false;
+	}
+}
+
+void rtw89_entity_force_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtwdev->hal.entity_force_hw = phy_idx;
+
+	if (phy_idx != RTW89_PHY_NUM)
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN, "%s: %d\n", __func__, phy_idx);
+	else
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN, "%s: (none)\n", __func__);
+}
+
 static enum rtw89_mlo_dbcc_mode
 rtw89_entity_sel_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
 {
 	if (rtwdev->chip->chip_gen != RTW89_CHIP_BE)
 		return MLO_DBCC_NOT_SUPPORT;
 
+	switch (rtwdev->hal.entity_force_hw) {
+	case RTW89_PHY_0:
+		return MLO_2_PLUS_0_1RF;
+	case RTW89_PHY_1:
+		return MLO_0_PLUS_2_1RF;
+	default:
+		break;
+	}
+
 	switch (active_hws) {
 	case BIT(0):
 		return MLO_2_PLUS_0_1RF;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 5b22764d5329..c797cda2e763 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -166,6 +166,8 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
+bool rtw89_entity_check_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw89_entity_force_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e713422ebd7c..96fb2839379f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -470,6 +470,32 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_1);
 }
 
+void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool mon = !!rtwdev->pure_monitor_mode_vif;
+	bool prehdl_link = false;
+
+	if (chip->chip_gen != RTW89_CHIP_AX &&
+	    !RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw) &&
+	    !mon && !rtw89_entity_check_hw(rtwdev, rtwvif_link->phy_idx))
+		prehdl_link = true;
+
+	if (prehdl_link) {
+		rtw89_entity_force_hw(rtwdev, rtwvif_link->phy_idx);
+		rtw89_set_channel(rtwdev);
+	}
+
+	if (chip->ops->rfk_channel)
+		chip->ops->rfk_channel(rtwdev, rtwvif_link);
+
+	if (prehdl_link) {
+		rtw89_entity_force_hw(rtwdev, RTW89_PHY_NUM);
+		rtw89_set_channel(rtwdev);
+	}
+}
+
 static void rtw89_chip_rfk_channel_for_pure_mon_vif(struct rtw89_dev *rtwdev,
 						    enum rtw89_phy_idx phy_idx)
 {
@@ -6218,7 +6244,8 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		goto wake_queue;
 	}
 
-	rtw89_chip_rfk_channel(rtwdev, target);
+	if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+		rtw89_chip_rfk_channel(rtwdev, target);
 
 	rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b7d5eb25ef74..52d6e5683d63 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5075,6 +5075,8 @@ struct rtw89_hal {
 	enum rtw89_entity_mode entity_mode;
 	struct rtw89_entity_mgnt entity_mgnt;
 
+	enum rtw89_phy_idx entity_force_hw;
+
 	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
 
 	u8 thermal_prot_th;
@@ -7125,15 +7127,6 @@ static inline void rtw89_chip_rfk_init_late(struct rtw89_dev *rtwdev)
 		chip->ops->rfk_init_late(rtwdev);
 }
 
-static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif_link *rtwvif_link)
-{
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-
-	if (chip->ops->rfk_channel)
-		chip->ops->rfk_channel(rtwdev, rtwvif_link);
-}
-
 static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy_idx,
 					       const struct rtw89_chan *chan)
@@ -7647,6 +7640,8 @@ struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
 					  unsigned int link_id);
 void rtw89_sta_unset_link(struct rtw89_sta *rtwsta, unsigned int link_id);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
+void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link);
 const struct rtw89_6ghz_span *
 rtw89_get_6ghz_span(struct rtw89_dev *rtwdev, u32 center_freq);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f80c847d1741..96dc94c1f556 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -720,7 +720,8 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MLD_VALID_LINKS) {
 		struct rtw89_vif_link *cur = rtw89_get_designated_link(rtwvif);
 
-		rtw89_chip_rfk_channel(rtwdev, cur);
+		if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+			rtw89_chip_rfk_channel(rtwdev, cur);
 
 		if (hweight16(vif->active_links) == 1)
 			rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
-- 
2.25.1


