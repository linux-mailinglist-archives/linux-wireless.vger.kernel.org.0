Return-Path: <linux-wireless+bounces-7755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E868C7F97
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 03:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6A28470B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E911849;
	Fri, 17 May 2024 01:34:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B71854
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909653; cv=none; b=UuwudV/ICIasHHlc2x0D39V0xtGvZp+jq0LBJDgRiHGywVWpK5D37chd5HJpkr4CpMCqz8Xbc2zGVuXWrv4Sbl1HqWG2PZ9xKf69vPC+O69k39afEcBNvK5wJVmXTOn8O2wu3JufrH/aQMfHeAEAalNj/LLRCmYMF7tR5JZIdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909653; c=relaxed/simple;
	bh=AkV6XeHClK+Fq1wvrLHeG+bWnMzsVCeLe4Vq/9STrvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBxOFwk2kfz+NWLMihB5iXNf/bM4pzosywTUEEd4EqI7EVff24+sxCn7AKblPS8YPXg/KzfOXlD80BfTB0ic0Zx0+KcycCFFt5Y8zE6JB7vf45unBInM8pvPt3bnMwsShT+KpeH/y7i+NKc8DTJmXSH+dsmsM3c2j2Z8HDP2qhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H1Y6Se81833139, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H1Y6Se81833139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 09:34:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 09:34:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 09:34:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH v2] wifi: rtw89: fix HW scan not aborting properly
Date: Fri, 17 May 2024 09:33:50 +0800
Message-ID: <20240517013350.11278-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

There is a length limit on the commands we send to firmware, so
dividing to two commands is sometimes required when scanning.
When aborting scan, we should not send second scan command to
firmware after the first one is finished. This could cause some
unexpected errors when we cannot receive firmware events
(e.g. in suspend).

Another case is scan happens before suspending, ieee80211_do_stop() is
called to abort scan and driver indicate scan completion by
ieee80211_scan_completed(), which queues event to scan work. But scan work
might be late to execute after ieee80211_do_stop(). To correct this, driver
indicates ieee80211_scan_completed() before returning, so that
ieee80211_do_stop() can flush scan work properly.

Fixes: bcbefbd032df ("wifi: rtw89: add wait/completion for abort scan")
Cc: stable@vger.kernel.org
Co-developed-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - scan abort case only wait for scan completion event, but no need to
    handle event in C2H work to do further things.
  - add more description in commit message
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 9 ++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 044a5b90c7f4..f5cd06c35982 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6245,7 +6245,14 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 
 	ret = rtw89_hw_scan_offload(rtwdev, vif, false);
 	if (ret)
-		rtw89_hw_scan_complete(rtwdev, vif, true);
+		rtw89_warn(rtwdev, "rtw89_hw_scan_offload failed ret %d\n", ret);
+
+	/* Indicate ieee80211_scan_completed() before returning, which is safe
+	 * because scan abort command always waits for completion of
+	 * RTW89_SCAN_END_SCAN_NOTIFY, so that ieee80211_stop() can flush scan
+	 * work properly.
+	 */
+	rtw89_hw_scan_complete(rtwdev, vif, true);
 }
 
 static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index baefc30b88c4..824ece03d92d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4756,6 +4756,9 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		}
 		return;
 	case RTW89_SCAN_END_SCAN_NOTIFY:
+		if (rtwdev->scan_info.abort)
+			return;
+
 		if (rtwvif && rtwvif->scan_req &&
 		    last_chan < rtwvif->scan_req->n_channels) {
 			ret = rtw89_hw_scan_offload(rtwdev, vif, true);
@@ -4764,7 +4767,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 				rtw89_warn(rtwdev, "HW scan failed: %d\n", ret);
 			}
 		} else {
-			rtw89_hw_scan_complete(rtwdev, vif, rtwdev->scan_info.abort);
+			rtw89_hw_scan_complete(rtwdev, vif, false);
 		}
 		break;
 	case RTW89_SCAN_ENTER_OP_NOTIFY:
-- 
2.25.1


