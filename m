Return-Path: <linux-wireless+bounces-5541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD69891811
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 12:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E81281A4D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D373D0A1;
	Fri, 29 Mar 2024 11:45:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9AA92A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712720; cv=none; b=q+HIp0AVe3QOyLcsNAmnR4Yjt+kOrBTy9dQkWatckLmDgk1sar1/N8FHAwjru1t07/+QtDTjcs8qmLso8EAy/yiDZ1etjAYII2S26V+hFF/lwArxeitXcVqfxNdrEZjZcTGUPhvLJLYn7b8tgYAca7u55vrBxjtJwFO2TJ/nffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712720; c=relaxed/simple;
	bh=uQi/fnPFDp3HyBFAZUljzlQo09yDCvloRVNRQgrzXBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1SQclZ4cPIXUZmXp6j4SPBrL+jqr2Iwen7Kt0by8Ju6zQS0k91NGkJSRJpJd5QF96Ak3lKvE2wX3m1kuno0Npfp9LMgkwtx/PsxkL1rTBULcBQ1O4H6ECvC/IjlBR8a0zuTngsciFQwF+l6DGC1Vzxd3GjdbFWRSl4tJKSQFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42TBjFTa93811051, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42TBjFTa93811051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 19:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 19:45:15 +0800
Received: from [127.0.1.1] (172.16.17.91) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 19:45:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: remove unsupported interface type of mesh point
Date: Fri, 29 Mar 2024 19:44:03 +0800
Message-ID: <20240329114403.5539-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

Mesh point was added during development, but not remove at first
submission, so it should not work properly. Remove it to reflect correct
supported features.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index d1f0e7541bfa..7ab7a988b123 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2237,8 +2237,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	else
 		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					     BIT(NL80211_IFTYPE_AP) |
-					     BIT(NL80211_IFTYPE_ADHOC) |
-					     BIT(NL80211_IFTYPE_MESH_POINT);
+					     BIT(NL80211_IFTYPE_ADHOC);
 	hw->wiphy->available_antennas_tx = hal->antenna_tx;
 	hw->wiphy->available_antennas_rx = hal->antenna_rx;
 
-- 
2.25.1


