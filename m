Return-Path: <linux-wireless+bounces-15774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C929DB2A4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30E1B22163
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE5813DDB5;
	Thu, 28 Nov 2024 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hOLa6Agk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5A1428E7
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773306; cv=none; b=Wy339fcquzfdA5qtesxEPZtxzTcIx51xSnjhB+uw4IL2JK80glUrr2LW/esCuC0dA7xho2MI8mv2kjZR8VS4LeLbySj5yNOCMBjSaOArsXjsvu5FBhxwsabSyk7i7iibJfkUGJIc3Gmr62rE9ZIIP7cJjpbQ+kVANoxIzc07OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773306; c=relaxed/simple;
	bh=qeLh1UFyN58swPmpM0NSUXgX4s0jXS3VOswjGKEmUcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9r1FytP22QxS6ZrG5lsGKhjnwpO4TGrXmYNvxnYFty6EIDrqyeaZKIf2jH58GELx8rXaVxiAZUbn9ZrfSDnKvodHtFOohUgxRs26MpsNrMJY8AKPywtRDKfc/rsEyr5X7QSm4pAH6vU+zJSEkD4jzsdeCRamf9hQagQtxqB7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hOLa6Agk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5t1iN53960596, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773301; bh=qeLh1UFyN58swPmpM0NSUXgX4s0jXS3VOswjGKEmUcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hOLa6AgkWXHIMGb4bSRsQnrDmloxaeaqaUtJ/NrFn2LjwdG07Akp6nT+8obeHya4d
	 GK/GMbiys+NvS1i1ipkLHEBaDyRbA2Ztsg2vdndOngINWUGdkBfUqlbB7v16rkli0q
	 6IZ3As8rbHf0ygwKp007uDmhQYx8H+t/gxHbjF0u/iYUGLur7By88bIsEwlv+hVxv4
	 jTyrxI13IhZMOj6k8kTA6MoVqOSfu1SYrrTsub1M98pNo1LbuUecpTekKx0QviOQwW
	 uvt0OnR4DA4/im9g08BYW6THROzwpCIGZRCwhbyNE0LDSx6tEOaYTL1FkryVBzk8th
	 NZSAOYR13Ew/g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5t1iN53960596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:55:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:55:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:55:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 5/6] wifi: rtw89: refine link handling for link_sta_rc_update
Date: Thu, 28 Nov 2024 13:54:32 +0800
Message-ID: <20241128055433.11851-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128055433.11851-1-pkshih@realtek.com>
References: <20241128055433.11851-1-pkshih@realtek.com>
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

The original handling will iterate all active links under the given sta
and apply the changes to each. Now, stack tweaks ops from sta_rc_update
to link_sta_rc_update, which means targeting a given link. Then, our link
iteration looks redundant. So, refine it to apply the changes to the link
directly.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  9 +++++++--
 drivers/net/wireless/realtek/rtw89/phy.c      | 15 ++++++---------
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 +++
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index bf7a674bce28..5eac0b524060 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1307,10 +1307,15 @@ static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
 				    struct ieee80211_link_sta *link_sta,
 				    u32 changed)
 {
-	struct ieee80211_sta *sta = link_sta->sta;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(link_sta->sta);
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_sta_link *rtwsta_link;
+
+	rtwsta_link = rtwsta->links[link_sta->link_id];
+	if (unlikely(!rtwsta_link))
+		return;
 
-	rtw89_phy_ra_update_sta(rtwdev, sta, changed);
+	rtw89_phy_ra_update_sta_link(rtwdev, rtwsta_link, changed);
 }
 
 static int rtw89_ops_add_chanctx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index be2f5338c3a0..e88ed9ec57c5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -467,11 +467,11 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->csi_mode = csi_mode;
 }
 
-static void __rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif_link *rtwvif_link,
-				      struct rtw89_sta_link *rtwsta_link,
-				      u32 changed)
+void rtw89_phy_ra_update_sta_link(struct rtw89_dev *rtwdev,
+				  struct rtw89_sta_link *rtwsta_link,
+				  u32 changed)
 {
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	struct ieee80211_link_sta *link_sta;
@@ -504,14 +504,11 @@ void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta
 			     u32 changed)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
-	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	unsigned int link_id;
 
-	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
-		rtwvif_link = rtwsta_link->rtwvif_link;
-		__rtw89_phy_ra_update_sta(rtwdev, rtwvif_link, rtwsta_link, changed);
-	}
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
+		rtw89_phy_ra_update_sta_link(rtwdev, rtwsta_link, changed);
 }
 
 static bool __check_rate_pattern(struct rtw89_phy_rate_pattern *next,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index f4ef7f5fb081..08a026ac9d38 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -926,6 +926,9 @@ void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
 			     u32 changed);
+void rtw89_phy_ra_update_sta_link(struct rtw89_dev *rtwdev,
+				  struct rtw89_sta_link *rtwsta_link,
+				  u32 changed);
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				const struct cfg80211_bitrate_mask *mask);
-- 
2.25.1


