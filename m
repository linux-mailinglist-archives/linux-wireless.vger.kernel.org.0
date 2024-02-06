Return-Path: <linux-wireless+bounces-3190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFE84ACAB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C2C28658C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161E73175;
	Tue,  6 Feb 2024 03:07:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215D73163
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188842; cv=none; b=KRuU7N3+5gl9yh6iGUE1iwaA1Sk7Z4lsOyLA3lJCNhnzQ2XoowNWnAl9RlcnV+bdzrFu0pqUFUSGs4qMyzFWT/i0ubaHvDNnwFgeG5tvAZ8dgUyw9LX5Gg8Nj55NrM6lHveXMLPcZrnXgLuwC6iAfSOcitGdO534laZV1K6VHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188842; c=relaxed/simple;
	bh=0foG6KG6cjlpU6jK2o4X6AgQ3eRIS/2fecopVP7Ts3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmKSEeFS/ugzfZ/V/+mK1jMXxxX/m4CWEaiYiD8dG94CIh30pnFgqyEA8MFNvLMNm/+AY3qgJq1tvM2ajrGvq99xZeRczbUOZxxqgWzBFtKHG6YPZFgbQ02OfNDwhaZW0YIC7AkDfUNpdyizb2MQPowoWX78TBZtfu+1ixp9efI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41637FzZ43532488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41637FzZ43532488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 6 Feb 2024 11:07:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: chan: tweak bitmap recalc ahead before MLO
Date: Tue, 6 Feb 2024 11:06:21 +0800
Message-ID: <20240206030624.23382-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206030624.23382-1-pkshih@realtek.com>
References: <20240206030624.23382-1-pkshih@realtek.com>
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

Originally, we just declared two sub-entity, and according to rolling
down mechanism, we ensured that index 0 contained sub-entity as long
as there are sub-entity. So, we could use for-loop after deciding the
last index.

But, we are preparing to expand num of sub-entity for MLO. Then, there
won't be just two sub-entity. And, there might be holes between two bits
in the bitmap. So, we cannot simply do for-loop as before. Instead, we
need to follow the set bits.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 11d46878f51e..6a666a92b59b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -214,31 +214,32 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
+	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_SUB_ENTITY) = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct cfg80211_chan_def *chandef;
 	enum rtw89_entity_mode mode;
 	struct rtw89_chan chan;
 	u8 weight;
-	u8 last;
 	u8 idx;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
+	bitmap_copy(recalc_map, hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+
 	weight = bitmap_weight(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	switch (weight) {
 	default:
 		rtw89_warn(rtwdev, "unknown ent chan weight: %d\n", weight);
-		bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+		bitmap_zero(recalc_map, NUM_OF_RTW89_SUB_ENTITY);
 		fallthrough;
 	case 0:
 		rtw89_config_default_chandef(rtwdev);
+		set_bit(RTW89_SUB_ENTITY_0, recalc_map);
 		fallthrough;
 	case 1:
-		last = RTW89_SUB_ENTITY_0;
 		mode = RTW89_ENTITY_MODE_SCC;
 		break;
 	case 2:
-		last = RTW89_SUB_ENTITY_1;
 		mode = rtw89_get_entity_mode(rtwdev);
 		if (mode == RTW89_ENTITY_MODE_MCC)
 			break;
@@ -247,7 +248,7 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		break;
 	}
 
-	for (idx = 0; idx <= last; idx++) {
+	for_each_set_bit(idx, recalc_map, NUM_OF_RTW89_SUB_ENTITY) {
 		chandef = rtw89_chandef_get(rtwdev, idx);
 		rtw89_get_channel_params(chandef, &chan);
 		if (chan.channel == 0) {
-- 
2.25.1


