Return-Path: <linux-wireless+bounces-15164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7489C38AC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6EB1C21A9E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD615886D;
	Mon, 11 Nov 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wmSeUo0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24A1487F4
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307948; cv=none; b=jFfoqZZ+kXx7bMt6s9okyC/EDih/as09Q2/VOuxBM0QGT+4Cl6aikrppbZ22I5MkuEkb3x4W1V6UkAbJQVvM+NEHtd2Ul9/acnFRW0fMsy2v8HszuEgMVM3E448aIN7JdWHfnQQE+QhvGkPFhQQA9hXN3xtfSpNrp+CQbJPvnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307948; c=relaxed/simple;
	bh=EFSTZLrrWXRJAmmrx47cTOtKoyXuGcLv8EXeDa9T/Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEYT/9ZzAb3C5R69K+wNUkUkc8YX9cTjgHXLs/QCEriIiB2M6FKrz7vFIj/RRYlhFjHWHTZYFd/mi91TGbCZfW0RsH6k4ddpwmTHjozhhxCAAcIwMz8xYZ+HplSDUhguFilxRTi3UaoqC/bY3MGs35YPBfDJ27FoWOocCCIKbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wmSeUo0d; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6qNI211779823, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731307943; bh=EFSTZLrrWXRJAmmrx47cTOtKoyXuGcLv8EXeDa9T/Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wmSeUo0d3xH9cilf5nYhwKUtplC0UQBm/SQZ2N0ha6NTpMyO96V78RXUZ+ymxwKL/
	 6C55WxYUKZvxyEmkR3LovjlK1DiXs25KHK/fnUMNLUkY50yJL8DQ17eVVh8ql5tpxW
	 bQl/N1Juj+rscaNUQv9iUQsRwvOm+EI+9VWvwfS0H6iCARhLcGm+LttjQp3g82dWNL
	 AHtIRLtJHNI4dJNeGmiPgpXQYeK7GJ6Iy0UwCuIwP2wlbA0i/rTJO8YSlZ/YKU70Y8
	 /5LCnWZE/0QTnbl4ER/Yan6t3Xt6m0L68RgQBjzuanJQb4qGDOCAA9EPxVmA+81BqW
	 pcqdw2S9tPYAg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6qNI211779823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 14:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:52:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 14:52:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 1/3] wifi: rtw89: sar: tweak 6GHz SAR subbands span
Date: Mon, 11 Nov 2024 14:51:30 +0800
Message-ID: <20241111065132.19587-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111065132.19587-1-pkshih@realtek.com>
References: <20241111065132.19587-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Given that the 6GHz subband edges are not aligned, specific frequencies
can span two adjacent subbands. We considered the need for this
functionality outside of SAR and moved it to a common function.

No logic change for existing chips.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 47 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  9 ++++
 drivers/net/wireless/realtek/rtw89/sar.c  | 57 +++--------------------
 3 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e5b2968c1431..f73704fc5f85 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -203,6 +203,53 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	},
 };
 
+#define RTW89_6GHZ_SPAN_HEAD 6145
+#define RTW89_6GHZ_SPAN_IDX(center_freq) \
+	((((int)(center_freq) - RTW89_6GHZ_SPAN_HEAD) / 5) / 2)
+
+#define RTW89_DECL_6GHZ_SPAN(center_freq, subband_l, subband_h) \
+	[RTW89_6GHZ_SPAN_IDX(center_freq)] = { \
+		.sar_subband_low = RTW89_SAR_6GHZ_ ## subband_l, \
+		.sar_subband_high = RTW89_SAR_6GHZ_ ## subband_h, \
+	}
+
+/* Since 6GHz subbands are not edge aligned, some cases span two subbands.
+ * In the following, we describe each of them with rtw89_6ghz_span.
+ */
+static const struct rtw89_6ghz_span rtw89_overlapping_6ghz[] = {
+	RTW89_DECL_6GHZ_SPAN(6145, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_6GHZ_SPAN(6165, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_6GHZ_SPAN(6185, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_6GHZ_SPAN(6505, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_6GHZ_SPAN(6525, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_6GHZ_SPAN(6545, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_6GHZ_SPAN(6665, SUBBAND_7_L, SUBBAND_7_H),
+	RTW89_DECL_6GHZ_SPAN(6705, SUBBAND_7_L, SUBBAND_7_H),
+	RTW89_DECL_6GHZ_SPAN(6825, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_6GHZ_SPAN(6865, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_6GHZ_SPAN(6875, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_6GHZ_SPAN(6885, SUBBAND_7_H, SUBBAND_8),
+};
+
+const struct rtw89_6ghz_span *
+rtw89_get_6ghz_span(struct rtw89_dev *rtwdev, u32 center_freq)
+{
+	int idx;
+
+	if (center_freq >= RTW89_6GHZ_SPAN_HEAD) {
+		idx = RTW89_6GHZ_SPAN_IDX(center_freq);
+		/* To decrease size of rtw89_overlapping_6ghz[],
+		 * RTW89_6GHZ_SPAN_IDX() truncates the leading NULLs
+		 * to make first span as index 0 of the table. So, if center
+		 * frequency is less than the first one, it will get netative.
+		 */
+		if (idx >= 0 && idx < ARRAY_SIZE(rtw89_overlapping_6ghz))
+			return &rtw89_overlapping_6ghz[idx];
+	}
+
+	return NULL;
+}
+
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate)
 {
 	struct ieee80211_rate rate;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5ad32eacd0d5..f76c05513d3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4597,6 +4597,13 @@ struct rtw89_sar_info {
 	};
 };
 
+struct rtw89_6ghz_span {
+	enum rtw89_sar_subband sar_subband_low;
+	enum rtw89_sar_subband sar_subband_high;
+};
+
+#define RTW89_SAR_SPAN_VALID(span) ((span)->sar_subband_high)
+
 enum rtw89_tas_state {
 	RTW89_TAS_STATE_DPR_OFF,
 	RTW89_TAS_STATE_DPR_ON,
@@ -6908,6 +6915,8 @@ struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
 					  unsigned int link_id);
 void rtw89_sta_unset_link(struct rtw89_sta *rtwsta, unsigned int link_id);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
+const struct rtw89_6ghz_span *
+rtw89_get_6ghz_span(struct rtw89_dev *rtwdev, u32 center_freq);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 			      struct rtw89_chan *chan);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index bcc287771b2a..871f45a6508c 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -42,7 +42,7 @@ static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 
 	/* freq 6875 (ch 185, 20MHz) spans RTW89_SAR_6GHZ_SUBBAND_7_H
 	 * and RTW89_SAR_6GHZ_SUBBAND_8, so directly describe it with
-	 * struct rtw89_sar_span in the following.
+	 * struct rtw89_6ghz_span.
 	 */
 
 	case 6895 ... 7115:
@@ -50,63 +50,18 @@ static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 	}
 }
 
-struct rtw89_sar_span {
-	enum rtw89_sar_subband subband_low;
-	enum rtw89_sar_subband subband_high;
-};
-
-#define RTW89_SAR_SPAN_VALID(span) ((span)->subband_high)
-
-#define RTW89_SAR_6GHZ_SPAN_HEAD 6145
-#define RTW89_SAR_6GHZ_SPAN_IDX(center_freq) \
-	((((int)(center_freq) - RTW89_SAR_6GHZ_SPAN_HEAD) / 5) / 2)
-
-#define RTW89_DECL_SAR_6GHZ_SPAN(center_freq, subband_l, subband_h) \
-	[RTW89_SAR_6GHZ_SPAN_IDX(center_freq)] = { \
-		.subband_low = RTW89_SAR_6GHZ_ ## subband_l, \
-		.subband_high = RTW89_SAR_6GHZ_ ## subband_h, \
-	}
-
-/* Since 6GHz SAR subbands are not edge aligned, some cases span two SAR
- * subbands. In the following, we describe each of them with rtw89_sar_span.
- */
-static const struct rtw89_sar_span rtw89_sar_overlapping_6ghz[] = {
-	RTW89_DECL_SAR_6GHZ_SPAN(6145, SUBBAND_5_L, SUBBAND_5_H),
-	RTW89_DECL_SAR_6GHZ_SPAN(6165, SUBBAND_5_L, SUBBAND_5_H),
-	RTW89_DECL_SAR_6GHZ_SPAN(6185, SUBBAND_5_L, SUBBAND_5_H),
-	RTW89_DECL_SAR_6GHZ_SPAN(6505, SUBBAND_6, SUBBAND_7_L),
-	RTW89_DECL_SAR_6GHZ_SPAN(6525, SUBBAND_6, SUBBAND_7_L),
-	RTW89_DECL_SAR_6GHZ_SPAN(6545, SUBBAND_6, SUBBAND_7_L),
-	RTW89_DECL_SAR_6GHZ_SPAN(6665, SUBBAND_7_L, SUBBAND_7_H),
-	RTW89_DECL_SAR_6GHZ_SPAN(6705, SUBBAND_7_L, SUBBAND_7_H),
-	RTW89_DECL_SAR_6GHZ_SPAN(6825, SUBBAND_7_H, SUBBAND_8),
-	RTW89_DECL_SAR_6GHZ_SPAN(6865, SUBBAND_7_H, SUBBAND_8),
-	RTW89_DECL_SAR_6GHZ_SPAN(6875, SUBBAND_7_H, SUBBAND_8),
-	RTW89_DECL_SAR_6GHZ_SPAN(6885, SUBBAND_7_H, SUBBAND_8),
-};
-
 static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev,
 					 u32 center_freq, s32 *cfg)
 {
 	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
-	const struct rtw89_sar_span *span = NULL;
 	enum rtw89_sar_subband subband_l, subband_h;
-	int idx;
-
-	if (center_freq >= RTW89_SAR_6GHZ_SPAN_HEAD) {
-		idx = RTW89_SAR_6GHZ_SPAN_IDX(center_freq);
-		/* To decrease size of rtw89_sar_overlapping_6ghz[],
-		 * RTW89_SAR_6GHZ_SPAN_IDX() truncates the leading NULLs
-		 * to make first span as index 0 of the table. So, if center
-		 * frequency is less than the first one, it will get netative.
-		 */
-		if (idx >= 0 && idx < ARRAY_SIZE(rtw89_sar_overlapping_6ghz))
-			span = &rtw89_sar_overlapping_6ghz[idx];
-	}
+	const struct rtw89_6ghz_span *span;
+
+	span = rtw89_get_6ghz_span(rtwdev, center_freq);
 
 	if (span && RTW89_SAR_SPAN_VALID(span)) {
-		subband_l = span->subband_low;
-		subband_h = span->subband_high;
+		subband_l = span->sar_subband_low;
+		subband_h = span->sar_subband_high;
 	} else {
 		subband_l = rtw89_sar_get_subband(rtwdev, center_freq);
 		subband_h = subband_l;
-- 
2.25.1


