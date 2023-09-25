Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0867AD2B8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjIYIJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjIYIJs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:09:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4177A9
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:09:41 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38P89GusC3456775, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38P89GusC3456775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:09:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 25 Sep 2023 16:09:16 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 25 Sep
 2023 16:09:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: ieee80211: add UL-bandwidth definition of trigger frame
Date:   Mon, 25 Sep 2023 16:08:59 +0800
Message-ID: <20230925080902.51449-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925080902.51449-1-pkshih@realtek.com>
References: <20230925080902.51449-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Define UL-bandwidth values of trigger frame according to 802.11 std.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 include/linux/ieee80211.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 340d7e0f6bf7..691e387c8056 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -307,6 +307,13 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_TRIGGER_TYPE_BQRP		0x6
 #define IEEE80211_TRIGGER_TYPE_NFRP		0x7
 
+/* UL-bandwidth within common_info of trigger frame */
+#define IEEE80211_TRIGGER_ULBW_MASK		0xc0000
+#define IEEE80211_TRIGGER_ULBW_20MHZ		0x0
+#define IEEE80211_TRIGGER_ULBW_40MHZ		0x1
+#define IEEE80211_TRIGGER_ULBW_80MHZ		0x2
+#define IEEE80211_TRIGGER_ULBW_160_80P80MHZ	0x3
+
 struct ieee80211_hdr {
 	__le16 frame_control;
 	__le16 duration_id;
-- 
2.25.1

