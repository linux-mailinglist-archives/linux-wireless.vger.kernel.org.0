Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56E73A3A13
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 05:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFKDGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 23:06:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42241 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKDGi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 23:06:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15B34Rb04012031, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15B34Rb04012031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Jun 2021 11:04:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Jun 2021 11:04:26 +0800
Received: from localhost (172.16.17.134) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 11 Jun
 2021 11:04:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA is connected HE
Date:   Fri, 11 Jun 2021 11:04:22 +0800
Message-ID: <20210611030422.9608-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.134]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/11/2021 02:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMTEgpFekyCAwMTowODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/11/2021 02:51:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164259 [Jun 10 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/11/2021 02:54:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HE_NULLFUNC_STACK hw_flag to allow sending nullfunc when STA is
connected HE. Then, sw connection monitor can detects AP has left, and sw
scan can issue nullfunc properly when switching to off channel.

The related commits are commit 41cbb0f5a295 ("mac80211: add support for HE")
that stops sending nullfunc when STA is connected HE, and commit f39b07fdfb68
("mac80211: HE STA disassoc due to QOS NULL not sent") that makes STA
doesn't disconnect locally even if AP has left.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 include/net/mac80211.h  | 4 ++++
 net/mac80211/debugfs.c  | 1 +
 net/mac80211/mlme.c     | 9 ++++++---
 net/mac80211/sta_info.c | 3 ++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..6e78d59db528 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2402,6 +2402,9 @@ struct ieee80211_txq {
  *	usage and 802.11 frames with %RX_FLAG_ONLY_MONITOR set for monitor to
  *	the stack.
  *
+ * @IEEE80211_HW_HE_NULLFUNC_STACK: HE hardware needs stack to send nullfunc
+ *	frames.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2457,6 +2460,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
+	IEEE80211_HW_HE_NULLFUNC_STACK,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 9245c0421bda..59997cef5a63 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -457,6 +457,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
 	FLAG(SUPPORTS_RX_DECAP_OFFLOAD),
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
+	FLAG(HE_NULLFUNC_STACK),
 #undef FLAG
 };
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2480bd0577bb..fc0d6ad651b4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1095,7 +1095,8 @@ void ieee80211_send_nullfunc(struct ieee80211_local *local,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
 	/* Don't send NDPs when STA is connected HE */
-	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+	if (!ieee80211_hw_check(&local->hw, HE_NULLFUNC_STACK) &&
+	    sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 		return;
 
@@ -1131,7 +1132,8 @@ static void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 		return;
 
 	/* Don't send NDPs when connected HE */
-	if (!(sdata->u.mgd.flags & IEEE80211_STA_DISABLE_HE))
+	if (!ieee80211_hw_check(&local->hw, HE_NULLFUNC_STACK) &&
+	    !(sdata->u.mgd.flags & IEEE80211_STA_DISABLE_HE))
 		return;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + 30);
@@ -2617,7 +2619,8 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
 		ifmgd->nullfunc_failed = false;
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+		if (!ieee80211_hw_check(&sdata->local->hw, HE_NULLFUNC_STACK) &&
+		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 			ifmgd->probe_send_count--;
 		else
 			ieee80211_send_nullfunc(sdata->local, sdata, false);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f2fb69da9b6e..beda2b1bd9d1 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1399,7 +1399,8 @@ static void ieee80211_send_null_response(struct sta_info *sta, int tid,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
 	/* Don't send NDPs when STA is connected HE */
-	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+	if (!ieee80211_hw_check(&local->hw, HE_NULLFUNC_STACK) &&
+	    sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    !(sdata->u.mgd.flags & IEEE80211_STA_DISABLE_HE))
 		return;
 
-- 
2.25.1

