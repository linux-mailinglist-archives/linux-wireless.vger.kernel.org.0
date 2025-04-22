Return-Path: <linux-wireless+bounces-21817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C4A95AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1060174D36
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920C18D63A;
	Tue, 22 Apr 2025 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N3Z9wvV9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA35156678
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286457; cv=none; b=dNwuslhCytqydwnMbscHCMcz+H/4CUOrtlreRA8isXY9hlp0gnSbqKmJPJ0nz669qiZY0Mvrd1Kfb51mOPR27dI3rq8DM/gJAPoGqv9Ut3GZCjkRl8RmZW3i57DdkJ600C/ozVJtkTxGTDnMGqynAtG2Bjh2uyROONZpPKn0VZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286457; c=relaxed/simple;
	bh=mSV2M3/Kk18mVyx9NCClEKU6WTRDuR9oDn/LFCcaa3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7dGWMVqh4F2uSEk1/ToTRdK8SXVx7wsNmz+xIJAzJeQOdpTopfFPJs0Ej9UwPn4JMnQS2ciURiBCoj3tY0kWwKVkgDIC28dPhkHhqC8XLO4SpztJm4+Ca8b6BmT7XlFj3QUP7yiv2T+Qt7MvZHq6Oa0waDSvFmWqo1BRrfgT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N3Z9wvV9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lXg153859610, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286453; bh=mSV2M3/Kk18mVyx9NCClEKU6WTRDuR9oDn/LFCcaa3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=N3Z9wvV98TnU0l7UwMnau5247bedowD94r5dMUs5CHVQi1g/MAFIIi0tLiIoxvfXn
	 Yf5SwtoQq6Mql3FkbHKK7GZAWZt9+AGZBycgRN9viFkRawvHbqzqqz+M/5sCWGfwau
	 h4jPzjaZ2g1X6E6F9DRVAZKFjJfyuBIO/oRF0UWtqKdCnu7An54+/M6SrsCrJ9fdO/
	 +/hb0y4UklhpJaxVUSD/fgV9nexAO/LlzuVJYVh+i2Ygx2YVOGh75X7yBk/GNZRyaH
	 gqkI8F4EuH3CpJpc+7vpcexD+7oQhugCFENJdcetYTOtVR9WbwaQ9qJpN6RvD2hBXk
	 PwehXiiRID9dw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lXg153859610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: mcc: avoid that loose pattern sets negative timing for auxiliary GO
Date: Tue, 22 Apr 2025 09:46:20 +0800
Message-ID: <20250422014620.18421-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

A MCC (multi-channel concurrency) schedule is like the following.

   |<                mcc interval                 >|
   |<    duration ref     >|<    duration aux     >|
   |< tob ref >|< toa ref >|< tob aux >|< toa aux >|
               V                       V
           tbtt ref                tbtt aux
               |<    beacon offset    >|

Original logic might unexpectedly calculate toa (time offset ahead) of
auxiliary role to be negative even when there is no role timing limit.
If toa-aux is negative, TBTT-aux would in logic fall into duration-ref.
Then, if auxiliary role is GO unfortunately, it cannot guarantee that
beacons will TX well. So now, when deciding the lower bound of toa-ref,
take toa-aux into account. Make toa-aux at least be zero in normal cases.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b54316eae21d..355e582ecd19 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1004,6 +1004,7 @@ static void __rtw89_mcc_calc_pattern_loose(struct rtw89_dev *rtwdev,
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
+	u16 mcc_intvl = config->mcc_interval;
 	u16 bcn_ofst = config->beacon_offset;
 	u16 bt_dur_in_mid = 0;
 	u16 max_bcn_ofst;
@@ -1037,7 +1038,7 @@ static void __rtw89_mcc_calc_pattern_loose(struct rtw89_dev *rtwdev,
 
 	res = bcn_ofst - bt_dur_in_mid;
 	upper = min_t(s16, ref->duration, res);
-	lower = 0;
+	lower = max_t(s16, 0, ref->duration - (mcc_intvl - bcn_ofst));
 
 	if (ref->limit.enable) {
 		upper = min_t(s16, upper, ref->limit.max_toa);
-- 
2.25.1


