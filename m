Return-Path: <linux-wireless+bounces-22540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F778AAA7A8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35CE4A6216
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA71933D7DB;
	Mon,  5 May 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMwB9sUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815333D7D4;
	Mon,  5 May 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484656; cv=none; b=pY+mTIsyUKDgNLAHVoHv0rrfKzlk7RRkMMQns2amem/eZ1XZFZamzis6XdlT9CdmF4wgCgXsadEcWtFD2mNeH/ztw8oIHXqfhq7JRavW1kN2UpsZG9cAh66jtmokrUJuRX8IrfmMFZ7pFD252kCaLb/74LAeBLkNlb7kJOyuges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484656; c=relaxed/simple;
	bh=Ro52b4B88y6vsZ8XDTWH8BP1hXgTmhpeQqm5Xz+FezA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V66IYOJlNXqUhTOaYIWn+i6hI7QDIZYlPpDoRdV9OPZqAD4PQQ1OPNS90km77KrU+hUTKTmiEh9wC65eToqIPHGNe1vMm1DJFcIEi+3mLZB3WgtQtZAONqrRHTypXdGXPQN+OL+oxItU3dKRTPRk3jlp/aXtqNcQ7NZBXkIUoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMwB9sUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A73DC4CEE4;
	Mon,  5 May 2025 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484655;
	bh=Ro52b4B88y6vsZ8XDTWH8BP1hXgTmhpeQqm5Xz+FezA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMwB9sUdq4dT8vyY0AJVnTSAx5nvN+VtczOjSG9vecsjZ4dL7MignHn7yw4LXXs7s
	 +RQrs3xRF4h342kLo282JSJykR1F4n6ucxMkqgTg3nbGj5JnfKf9Vm8tWEtuHq7tXg
	 I9Scgi+eQessRbPF9XjNXeR8G5JQ6j+nciPM9qUt+0IKBFI2s8/hE7mh1UH2qDFUPi
	 ZJR0aUgwsnAvJrWSSbjyAcghVQFfTUmadgCsBe+5ua4L7HVojOtHP25MppwUWkY0EI
	 2vblKO1/ltIJ/+EWUmcPTsxw+3uC+s3EutJPk0FSedNmmJ+1Qb1EOhze94skD168wt
	 aQUrOGpf8DwvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 588/642] wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
Date: Mon,  5 May 2025 18:13:24 -0400
Message-Id: <20250505221419.2672473-588-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 80b2f74589eb9..5b8d95c90d739 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -720,6 +720,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	wiphy_lock(wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -737,6 +738,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(wiphy);
 }
 
 /* Maximum Transmit Power field (@raw) can be EIRP or PSD.
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 26a944d3b6727..d0c8584308c06 100644
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
@@ -708,9 +710,11 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 
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


