Return-Path: <linux-wireless+bounces-18745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C59A304C5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB16D161F3E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782D1EE7DF;
	Tue, 11 Feb 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jX+Bhz6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671A1D7E57
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260032; cv=none; b=iYJrNpRpS9xxTFJLaa2/FRmELciMems7vM8U5HAwx8YGxUewu3Tk1xBHMA2wKpHjSlBa5ZcjGMIi9LiM8CaEYJhBJ6QdrxFRCHikK8OivJRgPFjJwJWgPdAOALKzvoFzdlFK8lwwMFHk5rwhp8zFg/WRuP6vJ6bpC3VaULn761s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260032; c=relaxed/simple;
	bh=wCBwyJs45AoxuhtN0miKPgByeNMWTL3KUBNTPlXjeYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agybgJD+g7raH61ibn+LWdbXy+J+eoFPi93RQgrKpaoaf+56h69xJOgRsZRPEqTRryIy8B+1FzlvPvML1IB57aGfepMcVoKTNSMkQNXjG2AvQaE3vl8G6MOSN8GjDCMizzwCw/Uaya7PeSf7JUkAa5xFet45zQG471g+acSHzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jX+Bhz6Z; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward203d.mail.yandex.net (Yandex) with ESMTPS id 9BCA164DE9
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 10:41:29 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:8f4f:0:640:c72e:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 9A43360996;
	Tue, 11 Feb 2025 10:41:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JfIL4w0Oga60-Oa6MYQXa;
	Tue, 11 Feb 2025 10:41:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739259681; bh=ThXXcB2pcSfqobiNLH7JRlWhjxKrcxhriF5n08o/RVw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=jX+Bhz6ZPaq2IVP/Mnruziy/YQuJgpuCG2YtyKuu1g9Q9/D8LDPabp0TV8kW0tHFI
	 /4dqSOERZJQ9SgUAi6OMp072WumPwYN26bqHdHibevjAD8A4QAo6LKeQvW52BsO6qv
	 SYnrHx97abOH3e6ZbkbLVZY+kQ3t1J0IZgLtyei4=
Authentication-Results: mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Date: Tue, 11 Feb 2025 10:39:15 +0300
Message-ID: <20250211073915.648418-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211073915.648418-1-dmantipov@yandex.ru>
References: <20250211073915.648418-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assuming that 'tssi_alimk_time' of 'struct rtw89_tssi_info' is
in milliseconds, adjust rtw8852b{t}-specific '_tssi_alimentk()'
to not mix the former with nanoseconds. Compile tested only.

Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/core.h          | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 9 ++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 9 ++++-----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ff4894c7fa8a..93e41def81b4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5135,7 +5135,7 @@ struct rtw89_tssi_info {
 	u32 alignment_backup_by_ch[RF_PATH_MAX][TSSI_MAX_CH_NUM][TSSI_ALIMK_VALUE_NUM];
 	u32 alignment_value[RF_PATH_MAX][TSSI_ALIMK_MAX][TSSI_ALIMK_VALUE_NUM];
 	bool alignment_done[RF_PATH_MAX][TSSI_ALIMK_MAX];
-	u32 tssi_alimk_time;
+	u64 tssi_alimk_time;
 };
 
 struct rtw89_power_trim_info {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index ef47a5facc83..c33cf04aed4a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -3585,7 +3585,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time;
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
@@ -3738,11 +3738,10 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	tssi_info->tssi_alimk_time += ktime_ms_delta(ktime_get(), start_time);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
+		    "[TSSI PA K] %s processing time = %llu ms\n", __func__,
 		    tssi_info->tssi_alimk_time);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 336a83e1d46b..a35952245fb3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -3663,7 +3663,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time;
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
@@ -3802,11 +3802,10 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	tssi_info->tssi_alimk_time += ktime_ms_delta(ktime_get(), start_time);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
+		    "[TSSI PA K] %s processing time = %llu ms\n", __func__,
 		    tssi_info->tssi_alimk_time);
 }
 
-- 
2.48.1


