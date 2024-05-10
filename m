Return-Path: <linux-wireless+bounces-7455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722DC8C2565
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDA28330C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C256127E01;
	Fri, 10 May 2024 13:09:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F13537E8
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346594; cv=none; b=P3lQQOySrEpSf991DPrgDuSNUSCzGaJbfUg3mJSgMgduw9wulR7DCNNbf9BiZ3b9K4SJo1Ry/2fsHfq6huG2elI+Pk1qz4JcBYkh+T3VsOLlooJPSLVcYlnFGJiHqkBb8UPeuh9m83v4pkHxIRTI7O+eVOeRiFrrwIYlbrgblP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346594; c=relaxed/simple;
	bh=7dewnmOMFjSoEipQ3NImE9Br09V7z2RNbqwIVXXx2Ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tmoj+n3Q1+jKB0VA57AV3k8UWFalRD1XxMIuu9AXiK17ItEN9Tr1w7xHjnKbLSo6Rj6A9xbngyfBtZ131zecFh5reuPVI9xW2W60P2/yInBdsa3/9nfa6WSwLGViIuwgUcGtGCsQWMmBOnUrLp1qYOdR1mZftshSJ1EVK1XXypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44AD9k0aA2845324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44AD9k0aA2845324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 21:09:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 21:09:46 +0800
Received: from [127.0.1.1] (172.16.20.230) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 May
 2024 21:09:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: fix HW scan abort not completed issue
Date: Fri, 10 May 2024 21:09:34 +0800
Message-ID: <20240510130934.5825-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

When scan happens before suspending, rtw89_hw_scan_complete() might
happen after suspend flow. This causes the scan to be unable to
properly indicate scan completion to mac80211 before suspending. To
fix this issue, we modify to execute rtw89_hw_scan_complete() when
rtw89_hw_scan_abort() is called, regardless of result of
rtw89_hw_scan_offload().

Cc: stable@vger.kernel.org
Fixes: bcbefbd032df ("wifi: rtw89: add wait/completion for abort scan")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 044a5b90c7f4..e9aa5bdeb5d7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6212,7 +6212,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		.aborted = aborted,
 	};
 
-	if (!vif)
+	if (!vif || !rtwdev->scanning)
 		return;
 
 	rtw89_write32_mask(rtwdev,
@@ -6245,7 +6245,9 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 
 	ret = rtw89_hw_scan_offload(rtwdev, vif, false);
 	if (ret)
-		rtw89_hw_scan_complete(rtwdev, vif, true);
+		rtw89_warn(rtwdev, "rtw89_hw_scan_offload failed ret %d\n", ret);
+
+	rtw89_hw_scan_complete(rtwdev, vif, true);
 }
 
 static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
-- 
2.25.1


