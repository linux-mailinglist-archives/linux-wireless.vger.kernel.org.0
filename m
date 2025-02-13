Return-Path: <linux-wireless+bounces-18912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16AA33BA1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAADE1883147
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC020D4FC;
	Thu, 13 Feb 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="I2XvjDw/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3A2080C8
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440221; cv=none; b=b2ZHTP1XOryY3OlKaGPYS1a16UoSoVDizGWge1LMyd2+FWGqrKd/ycf69SzlWVkmU39RoDTHcMkQFKvxmeD69NrXlnBIOcvOi8V9nPKbwTtsg8XPo7F+V+AdFGO2Fa0pXnzewpfSbJZL3NKKbaqGu4Nr3H9j8Su96OR93woirNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440221; c=relaxed/simple;
	bh=IHWRE/BsjqrPCwLtppDhb7yAmvtoh7G1SOLwMZjbKiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/xnAzKmjwxooiwWVoTLuvBKnbsnOkN/UWe54fw5guwAuJ6LN5f9QXxNUEqi8+M0Ho3MKgH2RhF5dQfJpjlX6/jx44QvL5haEPPcFwCm48MeeiI71cN7r4BtVj0/qJqHV1ObnXiHs5kkiF4jdTI3WaeR+VC9LSbsUUH6FpNTA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=I2XvjDw/; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:c:0:640:bd4a:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id D50DF60AFB;
	Thu, 13 Feb 2025 12:50:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8oMHxa0OruQ0-exyqtaq8;
	Thu, 13 Feb 2025 12:50:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739440209; bh=iEWJsQDE6mD1JmeJk+aHC/sFQPTUS65ovSCUsSEwp50=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=I2XvjDw/2DY4kCz/ApgVOjnmW1ujFzNBb0u4/myP+Y4vuk9v2K9N0YLobaiAgAgWX
	 uUjGfXiQRAlP701F8YzetaWCocyB2ljGokynwmE434j9J5WVZAtUY623518pPBAXB2
	 uQg8m8qV53Ju1XVxD6ttVU4andVgGaXCxsfTDLV4=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Date: Thu, 13 Feb 2025 12:50:06 +0300
Message-ID: <20250213095006.1308810-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <8c7cc2e680cf43379734aa86f22f8d49@realtek.com>
References: <8c7cc2e680cf43379734aa86f22f8d49@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the vendor driver is claimed to measure 'tssi_alimk_time' of
'struct rtw89_tssi_info' in microseconds, adjust rtw8852b{t}-specific
'_tssi_alimentk()' to not mess the former with nanoseconds and print
both per-call and accumulated times. Compile tested only.

Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: adjust declarations and commit message
v3: do not mess s64 vs. ktime_t and print the former as signed
v2: actually use microseconds and print both times
---
 drivers/net/wireless/realtek/rtw89/core.h          |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 13 +++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 13 +++++++------
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index ef47a5facc83..fbf82d42687b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -3585,9 +3585,10 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
 	u32 bb_reg_backup[8] = {0};
+	ktime_t start_time;
 	const s16 *power;
+	s64 this_time;
 	u8 band;
 	bool ok;
 	u32 tmp;
@@ -3613,7 +3614,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		return;
 	}
 
-	start_time = ktime_get_ns();
+	start_time = ktime_get();
 
 	if (chan->band_type == RTW89_BAND_2G)
 		power = power_2g;
@@ -3738,12 +3739,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	this_time = ktime_us_delta(ktime_get(), start_time);
+	tssi_info->tssi_alimk_time += this_time;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
-		    tssi_info->tssi_alimk_time);
+		    "[TSSI PA K] %s processing time = %lld us (acc = %llu us)\n",
+		    __func__, this_time, tssi_info->tssi_alimk_time);
 }
 
 void rtw8852b_dpk_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 336a83e1d46b..6e6889eea9a0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -3663,9 +3663,10 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
 	u32 bb_reg_backup[8] = {};
+	ktime_t start_time;
 	const s16 *power;
+	s64 this_time;
 	u8 band;
 	bool ok;
 	u32 tmp;
@@ -3675,7 +3676,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    "======> %s   channel=%d   path=%d\n", __func__, channel,
 		    path);
 
-	start_time = ktime_get_ns();
+	start_time = ktime_get();
 
 	if (chan->band_type == RTW89_BAND_2G)
 		power = power_2g;
@@ -3802,12 +3803,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
 	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	finish_time = ktime_get_ns();
-	tssi_info->tssi_alimk_time += finish_time - start_time;
+	this_time = ktime_us_delta(ktime_get(), start_time);
+	tssi_info->tssi_alimk_time += this_time;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
-		    tssi_info->tssi_alimk_time);
+		    "[TSSI PA K] %s processing time = %lld us (acc = %llu us)\n",
+		    __func__, this_time, tssi_info->tssi_alimk_time);
 }
 
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
-- 
2.48.1


