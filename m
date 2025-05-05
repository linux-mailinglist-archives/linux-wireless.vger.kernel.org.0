Return-Path: <linux-wireless+bounces-22589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8572AAAF8C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E131BA3ED7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460E2FD628;
	Mon,  5 May 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAYWWJej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47902F22FD;
	Mon,  5 May 2025 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486790; cv=none; b=hstMvCpfA993eiL4IBjG/D7DPhemCyiDej/CebZCQhPCvyn2hFJ24hXdOi0rb6CUNrDgxXVbBJt6qX6u2pHGIHspy/rOiLJU/hGEm2yXHDvbTGMpbty5hRcrEEBzbOVx+i/UULH0QsYXH2ESQWSjjhtFH0DdYtqXoQSMHQcrJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486790; c=relaxed/simple;
	bh=dFJ7kdfFKY6ePp1Mf8A8g+BRMuRxlALm8+b6ySf5vNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJeI1sw1gwVcuD8lR4g3SlWdP4jYFzZGTeuaHwN/Ykm5BreiCUtUqskBxsJ0rcK4r132JFSwoz+YvzB6xJ97vmNAKCzXePUtNEUzyIKa8m/mRXJEn5XZ21i37xmyJLmApq0KLTuv/mIAwbDlddYhHoqFiGI0jApWgEFcXbQ+9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAYWWJej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A7BC4CEED;
	Mon,  5 May 2025 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486789;
	bh=dFJ7kdfFKY6ePp1Mf8A8g+BRMuRxlALm8+b6ySf5vNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAYWWJejbV2ts/RMN+Z/KBHdmxoktQdagQEBeAU2TNO3UJR3yyFtjZ7AmG+z92rgl
	 OfFZNX9O80CPpdCdHcUnpf1aZTHvZuEvspAK3SF+T011cd4wGucxzX1tnfMjp0Q6cy
	 xzKHhZr0GEJp9gKGB4/m41SH2RYxJcsm1Yg0SOXl9hQRtt7IGzTl7AIYbNPeK9D7dD
	 hmOCY5wqkrRcOCZPU3Wgj8paiycPU75RCG56rwxjXsa0Wa+NimCdod6mR+Fq12ryoq
	 wnsrOB9fQaHdX+/WFb7im2rB16guoOgX+vTmoTIshdwcxVDkO1m84ETBCz30RBnfvi
	 bWXO1fiaIXmdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 206/212] wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
Date: Mon,  5 May 2025 19:06:18 -0400
Message-Id: <20250505230624.2692522-206-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 6e5a740b128f0..2d31193fcc87d 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -334,6 +334,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	wiphy_lock(wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -350,4 +351,5 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(wiphy);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index afb1b41e1a9a5..f5dacdc4d11ab 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -153,9 +153,11 @@ static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 	rtw89_debug(rtwdev, RTW89_DBG_SER, "ser: %s receive %s\n",
 		    ser_st_name(ser), ser_ev_name(ser, evt));
 
+	wiphy_lock(rtwdev->hw->wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_lps(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(rtwdev->hw->wiphy);
 
 	ser->st_tbl[ser->state].st_func(ser, evt);
 }
@@ -624,9 +626,11 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 
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


