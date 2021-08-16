Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3F3ED09E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhHPIw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 04:52:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37343 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHPIw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 04:52:56 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17G8qHQh9026669, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17G8qHQh9026669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Aug 2021 16:52:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Aug 2021 16:52:17 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 16 Aug
 2021 16:52:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>
Subject: [PATCH 1/2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
Date:   Mon, 16 Aug 2021 16:51:27 +0800
Message-ID: <20210816085128.10931-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/16/2021 06:52:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMTYgpFekyCAwMzowNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/16/2021 06:59:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165566 [Aug 16 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/16/2021 07:03:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

In ieee80211_amsdu_aggregate() set a pointer frag_tail point to the
end of skb_shinfo(head)->frag_list, and use it to bind other skb in
the end of this function. But when execute ieee80211_amsdu_aggregate()
->ieee80211_amsdu_realloc_pad()->pskb_expand_head(), the address of
skb_shinfo(head)->frag_list will be changed. However, the
ieee80211_amsdu_aggregate() not update frag_tail after call
pskb_expand_head(). That will cause the second skb can't bind to the
head skb appropriately.So we update the address of frag_tail to fix it.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8509778ff31f..9e0d4fca1c76 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3406,6 +3406,12 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 
 	head->len += skb->len;
 	head->data_len += skb->len;
+
+	/* frag_list should be updated after pskb_expand_head() */
+	frag_tail = &skb_shinfo(head)->frag_list;
+	while (*frag_tail)
+		frag_tail = &(*frag_tail)->next;
+
 	*frag_tail = skb;
 
 out_recalc:
-- 
2.25.1

