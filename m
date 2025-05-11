Return-Path: <linux-wireless+bounces-22837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64FAB2669
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDE117C3CB
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12B18DB1F;
	Sun, 11 May 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VnZw1/qu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3E18D63A
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935573; cv=none; b=sTKp8Ibw7wVyJvXSVS/cPnmI7/+9avHShob8rVdRu12kpGbqvYj5EMHbJDtmdIQQa4laJCGkevDxnSrhruUOd8W6uK+FjYXTrV9N8Yx8ZuAWm44YpSFvKYzpvRkZ6jYopXCcMG98QI3B7hPjzK66iPXmwRW9eDewfhCDKFel140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935573; c=relaxed/simple;
	bh=9NSPm9+3DOsAq2Y36BZXXcy7K6ONm6C898gzOy0LqS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK/Wlh+g5PNdyZI2NOBkkNZFUmS8HiIZ91rbYpsFoSXmRPCTGCxGYhrc8Y3I0HufffGpj8SseRa2kNZ+zHRIkQzhnWXHzSc9EQhIEKnpWesBOoXd9kxjhz9lsJuHXggH8kS24EEQ38FEi6ocSn/dz+UMIfmF78tOdJFBjaxWa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VnZw1/qu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qndA73302907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935569; bh=9NSPm9+3DOsAq2Y36BZXXcy7K6ONm6C898gzOy0LqS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VnZw1/qu4VtZzwlo5WXR138d5oNN7WWh4PxcxqUh5STYZZv9eOQm2dLS+sr+S6KBA
	 DfARZYDgrza4giz42yLkcbhk0kJGLInPTWP5ktsak7PsCdo5X4bWD+cc556kB7D4ig
	 3RsfSZzOYMuE6iew5ggslrLTU1mPNu7WglYZ5HxI7TSIFc9p9HA4O/x+Td7QI1mOdZ
	 0Ca6S6O6Jg1oWOBhkcEWb8Uud/b5zDBYqPP5SLbH7IIje+obgfkm55ua5RAv6WFP3p
	 y4a5MkD3Lma66oIvf5t+8g2GivCnigZkpAj13QROpVvsKRiuFlyd/XfO9xUnk6ERrq
	 Dwd9ge0nBV+Uw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qndA73302907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:49 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/6] wifi: rtw89: mcc: avoid redundant recalculations if no chance to improve
Date: Sun, 11 May 2025 11:52:17 +0800
Message-ID: <20250511035217.10410-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

MCC will track the changes of beacon offset, and trigger a recalculation
when the difference is larger than the tolerance. It means that a better
pattern is expected after recalculating. However, in the cases which get
a worse beacon offset, there is no chance to improve the pattern even if
recalculating. So, bypass them.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b7593c7465b9..806f42429a29 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2367,7 +2367,7 @@ static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_config *config = &mcc->config;
 	struct rtw89_mcc_pattern *pattern = &config->pattern;
-	s16 tolerance;
+	u16 tolerance;
 	u16 bcn_ofst;
 	u16 diff;
 
@@ -2375,18 +2375,25 @@ static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
 		return;
 
 	bcn_ofst = rtw89_mcc_get_bcn_ofst(rtwdev);
+	if (bcn_ofst == config->beacon_offset)
+		return;
+
 	if (bcn_ofst > config->beacon_offset) {
 		diff = bcn_ofst - config->beacon_offset;
 		if (pattern->tob_aux < 0)
 			tolerance = -pattern->tob_aux;
-		else
+		else if (pattern->toa_aux > 0)
 			tolerance = pattern->toa_aux;
+		else
+			return; /* no chance to improve */
 	} else {
 		diff = config->beacon_offset - bcn_ofst;
 		if (pattern->toa_aux < 0)
 			tolerance = -pattern->toa_aux;
-		else
+		else if (pattern->tob_aux > 0)
 			tolerance = pattern->tob_aux;
+		else
+			return; /* no chance to improve */
 	}
 
 	if (diff <= tolerance)
-- 
2.25.1


