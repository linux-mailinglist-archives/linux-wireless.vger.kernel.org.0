Return-Path: <linux-wireless+bounces-14092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0909A0BCD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1761F2305D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB34207A2B;
	Wed, 16 Oct 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RVaPOpNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5420B1EE
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086313; cv=none; b=diiopfqErBRfbJ+2c9CqftSrJ4tD8FvWljdqSOqbZTyB1uhF9DSQaKtX4/XSbeQR3abZnBei0vL//aRSD/ETaXkJm30EMM0uzrUwecVPANXMPQcx6uTHEy4rkS9c5u+nUU11Er46X2ToC2Z+BlQ2S+ZiUT6yUIay0hp8Rvs/46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086313; c=relaxed/simple;
	bh=Qd55wJzVvNwtlkJgxySGG3jvfkrm0iMPd5aYiyRlqvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVVRF6MynPEJzXUXhEKsAQ4+CiphwdKMozXsjlUyS44M0sXYWciOK5UF6vpXFMV7PMWub7MrS8BXPoJDnMYJRKitWn7xG3PRp8zSiqk5ZMwUe5PTLYd3yTsJ8i9tMCh7/uZ+6+mchJyJHWNckDyInabUo/E+k2JelENJTbx/Xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RVaPOpNP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49GDj9Rc93082855, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729086309; bh=Qd55wJzVvNwtlkJgxySGG3jvfkrm0iMPd5aYiyRlqvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=RVaPOpNPpcFi535mRVWQDPVyhqkrIpulunU0ComauZRQaFZAWzvliOFiGJQG5vQM6
	 L2Mn54ifdi2CXnviD5ImL58MUSOZBe3XyA4P/FwdNgEcV4Y04x7pclzma2XuzjvYYJ
	 ZEmNoW/uIVmkQrGyOWEXYxyeFLFJLJ/V0JuihwBfXXvfETHohf+5+UXshyDh27OIcW
	 aq81ik4WE5sUJVH9VvaIl8ih1okUPzn4waZYMcpnmeJ8+0QkfUE0DbJp8eKyZpefCd
	 0EZa+CoKo1MskI2meOUzeukkrRwuykeOUiFTqkeuGGDl+kVtxllksEWyrJjS1mSXIE
	 fFY7FFRJ3trkQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49GDj9Rc93082855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 21:45:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 21:45:09 +0800
Received: from [127.0.1.1] (172.16.21.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Oct
 2024 21:45:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map
Date: Wed, 16 Oct 2024 21:44:57 +0800
Message-ID: <20241016134457.9375-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

If 6 GHz of a country is marked as N/A in our regd map,
we block 6 GHz channels now.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 32 +++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index bb064a086970..cad5189708e7 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -646,22 +646,44 @@ static void rtw89_regd_apply_policy_unii4(struct rtw89_dev *rtwdev,
 		sband->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 }
 
-static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
-					 struct wiphy *wiphy)
+static bool regd_is_6ghz_blocked(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_regd *regd = regulatory->regd;
-	struct ieee80211_supported_band *sband;
 	u8 index;
-	int i;
 
 	index = rtw89_regd_get_index(regd);
 	if (index != RTW89_REGD_MAX_COUNTRY_NUM &&
 	    !test_bit(index, regulatory->block_6ghz))
-		return;
+		return false;
 
 	rtw89_debug(rtwdev, RTW89_DBG_REGD, "%c%c 6 GHz is blocked by policy\n",
 		    regd->alpha2[0], regd->alpha2[1]);
+	return true;
+}
+
+static bool regd_is_6ghz_not_applicable(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
+
+	if (regd->txpwr_regd[RTW89_BAND_6G] != RTW89_NA)
+		return false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD, "%c%c 6 GHz is N/A in regd map\n",
+		    regd->alpha2[0], regd->alpha2[1]);
+	return true;
+}
+
+static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
+					 struct wiphy *wiphy)
+{
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (!regd_is_6ghz_blocked(rtwdev) &&
+	    !regd_is_6ghz_not_applicable(rtwdev))
+		return;
 
 	sband = wiphy->bands[NL80211_BAND_6GHZ];
 	if (!sband)
-- 
2.25.1


