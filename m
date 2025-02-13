Return-Path: <linux-wireless+bounces-18890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D94A33788
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 06:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3AB18895CE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2892066E4;
	Thu, 13 Feb 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hIxm1mqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD8EC4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425771; cv=none; b=an7Dz+ScnjaHkZZgnro6qzxcpwgl0W57VSAazpnqtKeJ74UegcuFvdHeypIAT9p3UUcg5AcT7qOsqtwowDn3AjxfIGRXzRexT1u4XrjRAHKmXoP6oHkUVkQJ7tWfNap4SW8To8XcNDUeBMH8FjqzKkWVO2UQbQPic9CtEd86oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425771; c=relaxed/simple;
	bh=Yn/UfSBqRpuguLRrIT5Hz2gIRDqadEEtW2VBgweP6Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBSeLldrWBI5qB3FP3xfW+xpHzuC78EIRlsp0L9Mw+mKGKkJihEDfarZgXT5t5L5LzPl6gjzh21c/petWXgZPZCd83u9Jyl1WyTszpxsO4jEJhjMubevifeIZf8XyLKgM4QD34HAyYzf0gYNzaYmgrW+n5YfGA1EmhHLny9gjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=hIxm1mqp; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id BF1D8660B1
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 08:42:59 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:188a:0:640:98b0:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 306F8609B0;
	Thu, 13 Feb 2025 08:42:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ogIPT7BOoGk0-jy4cx0XU;
	Thu, 13 Feb 2025 08:42:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739425371; bh=4Ru8J80Juh6jMbYEnNt+sl9rI0+u4066ZJZRVtexvKU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hIxm1mqpz06iPAivGG6TvXFdZ5Q4DA31pp8lCOtPVAbuY5TehM6RwRqJhxmEWjKLO
	 XM9c2wfhGoPjjsxXv5/TNqhXaCcSRW5Up7NQORENj7pXR0jH6JtEd6W8Hw/pg/AkEn
	 Ti0hi4CDh1WTqT2njkfNPaUX25aFi9PpIziFKi78=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Date: Thu, 13 Feb 2025 08:42:48 +0300
Message-ID: <20250213054248.1284672-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2a466aad362d456abbc4bde0a592483c@realtek.com>
References: <2a466aad362d456abbc4bde0a592483c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Ping-Ke, the vendor driver measures 'tssi_alimk_time' of
'struct rtw89_tssi_info' in microseconds. So adjust rtw8852b{t}-specific
'_tssi_alimentk()' to not mess the former with nanoseconds and print both
per-call and accumulated times. Compile tested only.

Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
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
index ef47a5facc83..8b1cc8b71d1f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -3585,7 +3585,8 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time;
+	s64 this_time;
 	u32 bb_reg_backup[8] = {0};
 	const s16 *power;
 	u8 band;
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
index 336a83e1d46b..07c31929222e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -3663,7 +3663,8 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
 	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
-	u32 start_time, finish_time;
+	ktime_t start_time;
+	s64 this_time;
 	u32 bb_reg_backup[8] = {};
 	const s16 *power;
 	u8 band;
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


