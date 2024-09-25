Return-Path: <linux-wireless+bounces-13137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD49850CF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 04:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B401C23758
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A91494B5;
	Wed, 25 Sep 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SUJLbqYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6F1E505
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229731; cv=none; b=KnobmuhTRyr5Ft3JsI2/p5OYs3YW+BrcBdRHw6kYaTsH0eJQJ9ybfE6ap7Ge1ZKrE6YPKD7EfydGHlKPy1FR3shKizrOSu5fAuLzQHrjA3zXK38liEs1Cxf48Bnn5CbKDlthyQ4L9uvjY5c5Y9pHI5dbxyPNcgf0TGahwdU1sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229731; c=relaxed/simple;
	bh=KsPy6PpDGV4QM3OV8yEaCUycTBor6eWXErUlFeLs60E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZZKgPzz0Nh4v+eIULdZSkV1ViowQ3TqqtwzGQJo4qeIko+vRQ/zJEnPkd6ipA8uMaODkzJYYc6rM3q2GRjxSqb626k3f1avOtfPvvxS5uAK7ZDtBTO9p0tMkQDJzA2p43hMY5dI3zq1O8AzLgdJ+ug3RogUSp72ESyLAoleMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SUJLbqYw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P2278k83860304, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727229727; bh=KsPy6PpDGV4QM3OV8yEaCUycTBor6eWXErUlFeLs60E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SUJLbqYwJIgI7BwZ3B6LeiAZXmcz/IUd5kwFvhcImJRwzRCpNzJkxDfgpXxbVIVzC
	 8bhFQ40XnggyVbUs8Zz2XCuP3BHapJljZQpL+oI2W+AwJER1XgUwKMZH6VFsnw4b8F
	 UfisOelVhXy8xAq9HI3EeDJuWwEUpe2G7EGomCMfY7afOVaWVt7gUfi7V7Rcbm8Uky
	 roAyjPeAD+XH1yTLdNUML34JMh85CInU0nnMkqcAejNs4IW5QedtR3FqnjBWT9ev2/
	 Ieoj+uw25fzvGXcOXG5l+vWxWC5gF05L6ojtDgETndR8trskoV5xfUi7u8HXpvghyK
	 ojdMt1zKrw3Cw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P2278k83860304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 10:02:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 10:02:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 10:02:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: handle entity active flag per PHY
Date: Wed, 25 Sep 2024 10:01:19 +0800
Message-ID: <20240925020119.13170-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925020119.13170-1-pkshih@realtek.com>
References: <20240925020119.13170-1-pkshih@realtek.com>
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

Originally, we have an active flag to record whether we have set PHY once.
After impending MLO support, there will be dual-PHY and they can be set
individually on Wi-Fi 7 chips. So, we now have active flag per PHY and
handle them individually.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.h | 11 +++++++----
 drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c  |  3 ++-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 4ed777ea5064..74de13a2e7da 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -43,18 +43,21 @@ struct rtw89_entity_weight {
 	unsigned int active_roles;
 };
 
-static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
+static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return READ_ONCE(hal->entity_active);
+	return READ_ONCE(hal->entity_active[phy_idx]);
 }
 
-static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
+static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy_idx,
+					  bool active)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	WRITE_ONCE(hal->entity_active, active);
+	WRITE_ONCE(hal->entity_active[phy_idx], active);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6200755b5ce9..e5dc6d36245d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -352,10 +352,6 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	entity_active = rtw89_get_entity_state(rtwdev);
-	if (!entity_active)
-		return;
-
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_SCC:
@@ -375,6 +371,11 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 		chanctx_idx = roc_idx;
 
 	phy_idx = RTW89_PHY_0;
+
+	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
+	if (!entity_active)
+		return;
+
 	chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 }
@@ -393,8 +394,6 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	entity_active = rtw89_get_entity_state(rtwdev);
-
 	mode = rtw89_entity_recalc(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_SCC:
@@ -416,6 +415,8 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	mac_idx = RTW89_MAC_0;
 	phy_idx = RTW89_PHY_0;
 
+	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
+
 	chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	chan_rcd = rtw89_chan_rcd_get(rtwdev, chanctx_idx);
 
@@ -432,7 +433,7 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 		rtw89_chip_rfk_band_changed(rtwdev, phy_idx, chan);
 	}
 
-	rtw89_set_entity_state(rtwdev, true);
+	rtw89_set_entity_state(rtwdev, phy_idx, true);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f1f10b7b0731..598eee12339e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4669,7 +4669,7 @@ struct rtw89_hal {
 	struct rtw89_chanctx chanctx[NUM_OF_RTW89_CHANCTX];
 	struct cfg80211_chan_def roc_chandef;
 
-	bool entity_active;
+	bool entity_active[RTW89_PHY_MAX];
 	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6a0262e512ea..b3f417003087 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1483,7 +1483,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
-		rtw89_set_entity_state(rtwdev, false);
+		rtw89_set_entity_state(rtwdev, RTW89_PHY_0, false);
+		rtw89_set_entity_state(rtwdev, RTW89_PHY_1, false);
 	}
 
 	return 0;
-- 
2.25.1


