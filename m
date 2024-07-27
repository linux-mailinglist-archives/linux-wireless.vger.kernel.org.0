Return-Path: <linux-wireless+bounces-10556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6293DDC4
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87381C21847
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141F2F877;
	Sat, 27 Jul 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="I6MUH2zT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1484086A
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067638; cv=none; b=ZaTiC/o1Q4E9yKW8uiUql3H7qRcetctDbhk/cdwIvAPx+zCD9fabGxogQUsA873wb79zKWL83ZRWaStZOg8928XWNQPwEgb+pGIfUdU+tIPsKDN+5aqM5HI45o08F4awNqOqj7MS0Eq+3sfJ//CpfO4XdqchU30thw46TeB5JCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067638; c=relaxed/simple;
	bh=9Jzw/ws4a+kEki4jFNouEvXbpwdd/RVuLFTNTz8UJGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFIZx1jtHqnyA02+o058csB6SbRCkm0oy5LxXIX2embnC+OxwdFjLrn2mJTE5keWZ4B2NdGw+lFKnTQHEWb5Q0Zex9zPvVNRzMxHyHuermiYo7ujW7GzAsFUNUsizo7ZjexuR2lQvE2oZ9zd4Fdnu+lg5iEMzTkI0TUVgw94KrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=I6MUH2zT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87DqF41417416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067634; bh=9Jzw/ws4a+kEki4jFNouEvXbpwdd/RVuLFTNTz8UJGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=I6MUH2zT9e1gBS7uwbfyCihZZNtBI0yjrkXZ9u4AKbl0UN1nAEOPA1g9l/WVYK2Fg
	 v/l54CRkzGI7b+RXZXBDneBnl11Tror11a/9mS4jdmTtaXRgm8UrHaRe0z+uoku3cG
	 2cjuTN2u0jo0OBOhv9GdSnKh5Q2wqU8y1vHoGPiHW8AZwaOJUYKluV2bSsONqvypng
	 bD0QrPqUjbi+JN/w9E0Nae2g500Il9rZHot2NRzJHQW1Eo1GlkcM3Am68DgU0LuCME
	 gnD1hmSQgzyNtFVCd8nGtP09gQeg0Hhyy2rFS/FWtUz1m0zhsJwfD80Wy7yJRJ+9fA
	 U6moobjUAP3eQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87DqF41417416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:13 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/7] wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
Date: Sat, 27 Jul 2024 16:06:44 +0800
Message-ID: <20240727080650.12195-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

Originally during unassign-chanctx, MCC (multi-channel concurrency) is
re-planed before set-channel if need. But, we might calculate MCC stuffs
based on old channel info. And, the following set-channel might be racing
with FW MCC state mechanism. So, we refine this flow. Now, if MCC re-plan
is needed here, it will be done after set-channel.

Besides, to be more rigorous, we now ensure entity isn't paused before we
deal with MCC things here.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 37 +++++++++++++++--------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 7f90d93dcdc0..3789c98de36a 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2443,9 +2443,10 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_entity_weight w = {};
 	enum rtw89_sub_entity_idx roll;
 	enum rtw89_entity_mode cur;
+	enum rtw89_entity_mode new;
+	int ret;
 
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->chanctx_assigned = false;
@@ -2469,21 +2470,33 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 	rtw89_swap_sub_entity(rtwdev, cfg->idx, roll);
 
 out:
-	rtw89_entity_calculate_weight(rtwdev, &w);
+	if (!hal->entity_pause) {
+		cur = rtw89_get_entity_mode(rtwdev);
+		switch (cur) {
+		case RTW89_ENTITY_MODE_MCC:
+			rtw89_mcc_stop(rtwdev);
+			break;
+		default:
+			break;
+		}
+	}
+
+	ret = rtw89_set_channel(rtwdev);
+	if (ret)
+		return;
 
-	cur = rtw89_get_entity_mode(rtwdev);
-	switch (cur) {
+	if (hal->entity_pause)
+		return;
+
+	new = rtw89_get_entity_mode(rtwdev);
+	switch (new) {
 	case RTW89_ENTITY_MODE_MCC:
-		/* If still multi-roles, re-plan MCC for chanctx changes.
-		 * Otherwise, just stop MCC.
-		 */
-		rtw89_mcc_stop(rtwdev);
-		if (w.active_roles == NUM_OF_RTW89_MCC_ROLES)
-			rtw89_mcc_start(rtwdev);
+		/* re-plan MCC for chanctx changes. */
+		ret = rtw89_mcc_start(rtwdev);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
 		break;
 	default:
 		break;
 	}
-
-	rtw89_set_channel(rtwdev);
 }
-- 
2.25.1


