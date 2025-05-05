Return-Path: <linux-wireless+bounces-22632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE4AAB687
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5763C4C1D87
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAE429545;
	Tue,  6 May 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyBCWyhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00388278769;
	Mon,  5 May 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485754; cv=none; b=ake2TGQRbERuY1Jelk6Y0EjhDDh8m4afTzJo13R6DN2vTD8rmaim6lMSF9zJXVfC+wo98TJFfuAfyODAZ5IuYSxCs89+hutn5Ms1WkAhl0lcVm9j7zLtiEpeR85qEyhU5FQ4UG3FfZqcOej6pmdP2kkaJAEpFnT1RwBoyTSE2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485754; c=relaxed/simple;
	bh=62Bhk/VVD4D0spqYKktOS5Xr1IEPMTNipmkICGhPAWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7o9H7qI+/YklAg2B5q1Yl0/VuigMKje5a2DKI5EgC5WSoBRTOBry/xBroV2ftuUX3DLrIRzHnCYgvJWRu4sFW/am91xVT7JDbHchnB6qtg7JRP2kkuF4yF103SEmW/PUs9pof4m1rL+pE9s2b15NKuwXv1v2+7wj9zDMykC3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyBCWyhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43389C4CEEF;
	Mon,  5 May 2025 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485752;
	bh=62Bhk/VVD4D0spqYKktOS5Xr1IEPMTNipmkICGhPAWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyBCWyhE2H8JAUPVOjSpyL3dlP3QN6QM3nBte0Ttsy52tGwE53yv09Q+rTHDHo3+/
	 X4rDWGxyi+BBTUWYcN5yk0A/GE8jkWM+FDyuSjUd0dgBi7wlEjHqxluZ+uiLPOHuHI
	 A/VYMw1vNNToCNr0OxFGl+MTvzPRDaxdYqbSoJ8MSqmm8qtqRbwkfnn7f21+r5DX/g
	 LUG5L61xuVB/CXW1a5sAAOh3bfA2XaHuh74XQkrgDnam/BKd7ikXNMAN2dl1ZsnBBg
	 3ZT0CJmw/c1U2Ip3/7R4qtlpvvsZgGUKJY7+KV1HWMyKzRi9KNPdzMc68lEwJpPkv5
	 Klj3LZUceq+xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 464/486] wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
Date: Mon,  5 May 2025 18:39:00 -0400
Message-Id: <20250505223922.2682012-464-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit ebfc9199df05d37b67f4d1b7ee997193f3d2e7c8 ]

To ensure where are protected by driver mutex can also be protected by
wiphy_lock(), so afterward we can remove driver mutex safely.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250122060310.31976-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 2 ++
 drivers/net/wireless/realtek/rtw89/ser.c  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index bb064a086970b..e8df68818da01 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -695,6 +695,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	wiphy_lock(wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -712,6 +713,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(wiphy);
 }
 
 /* Maximum Transmit Power field (@raw) can be EIRP or PSD.
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 7b203bb7f151a..02c2ac12f197a 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -156,9 +156,11 @@ static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 	rtw89_debug(rtwdev, RTW89_DBG_SER, "ser: %s receive %s\n",
 		    ser_st_name(ser), ser_ev_name(ser, evt));
 
+	wiphy_lock(rtwdev->hw->wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_lps(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(rtwdev->hw->wiphy);
 
 	ser->st_tbl[ser->state].st_func(ser, evt);
 }
@@ -707,9 +709,11 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 
 	switch (evt) {
 	case SER_EV_STATE_IN:
+		wiphy_lock(rtwdev->hw->wiphy);
 		mutex_lock(&rtwdev->mutex);
 		ser_l2_reset_st_pre_hdl(ser);
 		mutex_unlock(&rtwdev->mutex);
+		wiphy_unlock(rtwdev->hw->wiphy);
 
 		ieee80211_restart_hw(rtwdev->hw);
 		ser_set_alarm(ser, SER_RECFG_TIMEOUT, SER_EV_L2_RECFG_TIMEOUT);
-- 
2.39.5


