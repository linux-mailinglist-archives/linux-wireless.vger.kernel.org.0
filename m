Return-Path: <linux-wireless+bounces-30617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F5D0CD0D
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F500301D63C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DB6BB5B;
	Sat, 10 Jan 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pWHjuqk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F02494FF
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011641; cv=none; b=DtS7ExJZmtwpC2jWM3CMSpNubDKeuSvr5FSuoC/WZVHWrFJ+8Tnxb8xm/J7iHM6zDp2F6FnBGIrvcmi3xodyXdBGyuLZtl/IPbRfHtkqJ05uN0tL0Ae3rcMBcoX9c1VwaAe2E0KSOSFGZEnJDLHi0RYEjNlnwnV1h5MwOoKs3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011641; c=relaxed/simple;
	bh=4WkZfHEXUdEhuPjUQPYmfxQ8Ndqj9M5XAJqGpQrgviE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ2QIMZ3zF2RZ2UP7cuYar2/9HwEdnd+oCW/mXgEwbS51h1gG5b+b8OxkI5ufEmOyAd0BnNleGm17Jxta0D6v+Os9+PUnAzY+l1C4joN7TnGAqsCBbt7/mJ0NsnZKKH31RXkyK6U5cUb31XrSWa+5chyNoG9Q1CSMDmOUXglFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pWHjuqk0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KZqY4241724, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011635; bh=NTCEVKLps6qNv7eJkFQWPiQ8s/lPYroBmF7ZoI80i+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pWHjuqk0rZcBTfSqGruYQa1gnjIywPlp2O9TBAgCWq6IOoB5pcxz+IcP6LPqyx1wu
	 M5s2CXgUcCRp8/TEdLGM74gbI00TMse73KWwSOq7wGztFsJ02ZzsrRh/+ybWPY6M8g
	 DSjT0SX4zDQiAr5dxCDOEKexae+/CkKg6kLp/QA9IOO9HbSv7+8Tu8RULD34kqyhA/
	 LZwxanYEHrcfhwvRWIgCveSBOVp8c9BZUUoBCadf26XwpmNNrAH3dvay8XhAMGQ9UU
	 fAKCke9uTG9wL0ZB+DQWMGqMNF2ElSKHKa3bEbabHhFzYuo7zI87wo3ESGJM5uIwiI
	 ZoZnbIpCIibEA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KZqY4241724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:35 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:35 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 3/8] wifi: rtw89: support EHT GI/LTF setting
Date: Sat, 10 Jan 2026 10:20:14 +0800
Message-ID: <20260110022019.2254969-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add support for fixed EHT GI/LTF via nl80211.

The command example:
  iw wlan0 set bitrates eht-gi-6 0.8 eht-ltf-6 2

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 28 +++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d29fbc9cb5ac..0b72d3dcf666 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -281,8 +281,7 @@ static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 	struct cfg80211_bitrate_mask *mask = &rtwsta_link->mask;
 	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
-	u8 he_ltf = mask->control[nl_band].he_ltf;
-	u8 he_gi = mask->control[nl_band].he_gi;
+	u8 ltf, gi;
 
 	*fix_giltf_en = true;
 
@@ -293,22 +292,31 @@ static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 	else
 		*fix_giltf = RTW89_GILTF_2XHE08;
 
-	if (!(rtwsta_link->use_cfg_mask && link_sta->he_cap.has_he))
+	if (!rtwsta_link->use_cfg_mask)
+		return;
+
+	if (link_sta->eht_cap.has_eht) {
+		ltf = mask->control[nl_band].eht_ltf;
+		gi = mask->control[nl_band].eht_gi;
+	} else if (link_sta->he_cap.has_he) {
+		ltf = mask->control[nl_band].he_ltf;
+		gi = mask->control[nl_band].he_gi;
+	} else {
 		return;
+	}
 
-	if (he_ltf == 2 && he_gi == 2) {
+	if (ltf == 2 && gi == 2)
 		*fix_giltf = RTW89_GILTF_LGI_4XHE32;
-	} else if (he_ltf == 2 && he_gi == 0) {
+	else if (ltf == 2 && gi == 0)
 		*fix_giltf = RTW89_GILTF_SGI_4XHE08;
-	} else if (he_ltf == 1 && he_gi == 1) {
+	else if (ltf == 1 && gi == 1)
 		*fix_giltf = RTW89_GILTF_2XHE16;
-	} else if (he_ltf == 1 && he_gi == 0) {
+	else if (ltf == 1 && gi == 0)
 		*fix_giltf = RTW89_GILTF_2XHE08;
-	} else if (he_ltf == 0 && he_gi == 1) {
+	else if (ltf == 0 && gi == 1)
 		*fix_giltf = RTW89_GILTF_1XHE16;
-	} else if (he_ltf == 0 && he_gi == 0) {
+	else if (ltf == 0 && gi == 0)
 		*fix_giltf = RTW89_GILTF_1XHE08;
-	}
 }
 
 static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
-- 
2.25.1


