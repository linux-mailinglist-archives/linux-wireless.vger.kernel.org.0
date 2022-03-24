Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65364E5C6E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 01:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbiCXAut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 20:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiCXAus (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 20:50:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31E90FDF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 17:49:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22O0n3rnD026454, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22O0n3rnD026454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Mar 2022 08:49:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 08:49:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Mar
 2022 08:49:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Date:   Thu, 24 Mar 2022 08:48:16 +0800
Message-ID: <20220324004816.6202-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/24/2022 00:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjMgpFWkyCAxMDowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Follow IEEE 802.11-21 that HTC subfield masked to 0 for all data frames
containing a QoS Control field. It also defines the AAD length depends on
QC and A4 fields, so change logic to determine length accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 net/mac80211/wpa.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 7ed0d268aff2f..cd35ae76d5b78 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -317,13 +317,12 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
 	__le16 mask_fc;
 	int a4_included, mgmt;
 	u8 qos_tid;
-	u16 len_a;
-	unsigned int hdrlen;
+	u16 len_a = 22;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	/*
 	 * Mask FC: zero subtype b4 b5 b6 (if not mgmt)
-	 * Retry, PwrMgt, MoreData; set Protected
+	 * Retry, PwrMgt, MoreData, Order (if Qos Data); set Protected
 	 */
 	mgmt = ieee80211_is_mgmt(hdr->frame_control);
 	mask_fc = hdr->frame_control;
@@ -333,14 +332,17 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
 		mask_fc &= ~cpu_to_le16(0x0070);
 	mask_fc |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 
-	hdrlen = ieee80211_hdrlen(hdr->frame_control);
-	len_a = hdrlen - 2;
 	a4_included = ieee80211_has_a4(hdr->frame_control);
+	if (a4_included)
+		len_a += 6;
 
-	if (ieee80211_is_data_qos(hdr->frame_control))
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		qos_tid = ieee80211_get_tid(hdr);
-	else
+		mask_fc &= ~cpu_to_le16(IEEE80211_FCTL_ORDER);
+		len_a += 2;
+	} else {
 		qos_tid = 0;
+	}
 
 	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
 	 * mode authentication are not allowed to collide, yet both are derived
-- 
2.25.1

