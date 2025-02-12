Return-Path: <linux-wireless+bounces-18828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA49A32033
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4379B160BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF6A1E47B4;
	Wed, 12 Feb 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RFiDOVwv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54B1D86F2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346342; cv=none; b=e5cudAopUHXUz8diBFyZvvuJZhGq5Hd3Nc7g05kIxRNdFkWvjv+71Ks8MG42WFf8p9FCMCSLsaDp62s6nk0umhco3UqkYgAjNXXgvaffeD6B6JaDd1C2N3Q6kF0CZRZc6qCl8gM1rDeXQz9OxuicDeVojIZ475TucM7j7p/vpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346342; c=relaxed/simple;
	bh=Foe7Le7/O3Upjk93ADzitet7C1b1b2RxXWUsQz/GwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2n9ezMcnp43Wf8yQZZZbjLrRzzW7oL4tIYd5NOHkYECaJFSipEgkuZ/s5mydJY3BBx16EIgtvf29npZbotMH9qdf5JM8AdnDLaedmJOfdN0JPHwtHfizRD+sdq1h92ehL4UBMNXywKECWSzyg8qtZWFTPe9Japr4xcPTjSMRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RFiDOVwv; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id 97F00680C2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 10:40:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d94:0:640:e777:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9BFF060C60;
	Wed, 12 Feb 2025 10:40:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AeJGcO0OcqM0-ZPsskJny;
	Wed, 12 Feb 2025 10:40:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739346011; bh=1rAIp2McjMN91n0KGK0pWqs4w95eZe7A45Sv2VPlO5I=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=RFiDOVwvh01CT5v2V1srgHzNZK5w6qcXkj61d2b5SVieiuu+L72+vfi5ZGCB9PiKM
	 Spd8ke1bgWHZgTpDikFMGwOINyI8TtVfpLvxR8jPi1P+GGr2FLAblLNeErbL+cn276
	 lBLfeZZTSji+JO82IPyuyyBWxWbTtM/UhVrEpz80=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Date: Wed, 12 Feb 2025 10:38:33 +0300
Message-ID: <20250212073833.1265407-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <0b028bab48ab4d64ac82b1228e1ad21c@realtek.com>
References: <0b028bab48ab4d64ac82b1228e1ad21c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Ping-Ke, 'tssi_alimk_time' of 'struct rtw89_tssi_info'
is in microseconds. So adjust rtw8852b{t}-specific '_tssi_alimentk()'
to not mess the former with nanoseconds and print both per-call
and accumulated times. Compile tested only.

Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: actually use microseconds and print both times
---
 drivers/net/wireless/realtek/rtw89/core.h          |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 12 ++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b3fdd8eded21..eb2a6b90c940 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5141,7 +5141,7 @@ struct rtw89_tssi_info {
 	u32 alignment_backup_by_ch[RF_PATH_MAX][TSSI_MAX_CH_NUM][TSSI_ALIMK_VALUE_NUM];
 	u32 alignment_value[RF_PATH_MAX][TSSI_ALIMK_MAX][TSSI_ALIMK_VALUE_NUM];
 	bool alignment_done[RF_PATH_MAX][TSSI_ALIMK_MAX];
-	u32 tssi_alimk_time;
+	u64 tssi_alimk_time;
 };
 
 struct rtw89_power_trim_info {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index ef47a5facc83..1e0490813c40 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -3585,7 +3585,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time, this_time;
 	u32 bb_reg_backup[8] = {0};
 	const s16 *power;
 	u8 band;
@@ -3613,7 +3613,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		return;
 	}
 
-	start_time = ktime_get_ns();
+	start_time = ktime_get();
 
 	if (chan->band_type == RTW89_BAND_2G)
 		power = power_2g;
@@ -3738,12 +3738,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	this_time = ktime_us_delta(ktime_get(), start_time);
+	tssi_info->tssi_alimk_time += this_time;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
-		    tssi_info->tssi_alimk_time);
+		    "[TSSI PA K] %s processing time = %llu us (acc = %llu us)\n",
+		    __func__, this_time, tssi_info->tssi_alimk_time);
 }
 
 void rtw8852b_dpk_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 336a83e1d46b..1745d8039c33 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -3663,7 +3663,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time, this_time;
 	u32 bb_reg_backup[8] = {};
 	const s16 *power;
 	u8 band;
@@ -3675,7 +3675,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    "======> %s   channel=%d   path=%d\n", __func__, channel,
 		    path);
 
-	start_time = ktime_get_ns();
+	start_time = ktime_get();
 
 	if (chan->band_type == RTW89_BAND_2G)
 		power = power_2g;
@@ -3802,12 +3802,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	this_time = ktime_us_delta(ktime_get(), start_time);
+	tssi_info->tssi_alimk_time += this_time;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
-		    tssi_info->tssi_alimk_time);
+		    "[TSSI PA K] %s processing time = %llu us (acc = %llu us)\n",
+		    __func__, this_time, tssi_info->tssi_alimk_time);
 }
 
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
-- 
2.48.1


