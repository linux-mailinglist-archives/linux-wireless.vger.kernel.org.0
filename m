Return-Path: <linux-wireless+bounces-29689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375ADCB7BAA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37E393009C2A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C541D21E091;
	Fri, 12 Dec 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LmOgAa+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B0255248
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509228; cv=none; b=gXFseqDc4nhH2fYl2/qFcByhSlaA4HemJZpxrrE37V4wx+GxerPgKMPB5hbY5ecXtO4Ifz4THNPQbYD1KJz9iXYwgtKrYk1d/BktSNPeAKteyfu6V5lhpY/JJfu8fDSqZFjYkRwHIyzr73Y9p2YWN+ONJ0nfWf3590q5HWQXNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509228; c=relaxed/simple;
	bh=Dy6TnAkupU4nBcEcyfjiABosVEYOjBEKPe8TZula3RQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccQwTQPAbKYRJ5xxt+Q/+sQYo/7fsdurdB/B3Jro7e7A2wlXIqMhDLet4MRJ9oadUe4Ymk3iQxi6QUS1+4JVxplEaxVVYPfbYF5NpwUlqOz8vl+AG4DouvJ07CBcBFsNUIouA+WsPaUPQcS2RXeWBGr3+1Yfp/k9vjizd6f14VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LmOgAa+7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3DiQrA3508107, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509224; bh=+lbByilnuuT3hvU4iHkRzwhrmGgYvatDVCVyDnuZmkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LmOgAa+7XsGc2+gUZUqVxorDmv/1YN9yqkSqOYLOzraZLfyaeaasbWCc1BdxTCICW
	 MbkWI9W06sY8MoHci689iJOD4qaZ5L3vtKgGKGEZOazkRrvC7uD8fe1IWzKDnbyj49
	 bw1j1NV0reKwOAtYiqdlztGVN5SVUSOznfbDhwRc7FonuBb666m2cL5z6SENteciei
	 g76TkKZXqmJIZlG1BqUC+YROVtPPGNPsJmer8pllzUWAm6+OClhtxjZYBCbgoj2srw
	 CTOw8csBN+1b/M+DHawqRUeU5GRq/XMtO5y+HM1EV+B7GWPkSzJJAtuMZJMfs8eiwQ
	 m6upSz6/NVE+Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3DiQrA3508107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:13:44 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 11:13:32 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:13:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
Date: Fri, 12 Dec 2025 11:12:53 +0800
Message-ID: <20251212031303.19882-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Fix missing null-data 1 when switching links. The FW should send a
null-data 1 to notify AP before disabling the old link. Adjust the
position of the H2C rtw89_fw_h2c_mlo_link_cfg to ensure proper FW
behavior during link transition.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f39ca1c2ed10..e4fc513aa158 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1612,12 +1612,23 @@ static int __rtw89_ops_set_vif_links(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static void rtw89_vif_cfg_fw_links(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif,
-				   unsigned long links, bool en)
+static void rtw89_vif_update_fw_links(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif *rtwvif,
+				      u16 current_links, bool en)
 {
+	struct rtw89_vif_ml_trans *trans = &rtwvif->ml_trans;
 	struct rtw89_vif_link *rtwvif_link;
 	unsigned int link_id;
+	unsigned long links;
+
+	/* Do follow-up when all updating links exist. */
+	if (current_links != trans->mediate_links)
+		return;
+
+	if (en)
+		links = trans->links_to_add;
+	else
+		links = trans->links_to_del;
 
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		rtwvif_link = rtwvif->links[link_id];
@@ -1628,20 +1639,6 @@ static void rtw89_vif_cfg_fw_links(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_vif_update_fw_links(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif,
-				      u16 current_links)
-{
-	struct rtw89_vif_ml_trans *trans = &rtwvif->ml_trans;
-
-	/* Do follow-up when all updating links exist. */
-	if (current_links != trans->mediate_links)
-		return;
-
-	rtw89_vif_cfg_fw_links(rtwdev, rtwvif, trans->links_to_del, false);
-	rtw89_vif_cfg_fw_links(rtwdev, rtwvif, trans->links_to_add, true);
-}
-
 static
 int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
@@ -1683,7 +1680,7 @@ int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
-	rtw89_vif_update_fw_links(rtwdev, rtwvif, old_links);
+	rtw89_vif_update_fw_links(rtwdev, rtwvif, old_links, true);
 
 	if (!old_links)
 		__rtw89_ops_clr_vif_links(rtwdev, rtwvif,
@@ -1716,6 +1713,9 @@ int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 						  BIT(RTW89_VIF_IDLE_LINK_ID));
 	}
 
+	if (!ret)
+		rtw89_vif_update_fw_links(rtwdev, rtwvif, new_links, false);
+
 	rtw89_enter_ips_by_hwflags(rtwdev);
 	return ret;
 }
-- 
2.25.1


