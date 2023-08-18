Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E33780374
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Aug 2023 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbjHRBlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357147AbjHRBlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 21:41:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 878D23A9A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 18:40:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37I1eLppD021016, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37I1eLppD021016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 09:40:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Aug 2023 09:40:41 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Aug
 2023 09:40:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <gregory.greenman@intel.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: limit reorder_buf_filtered <=64 to avoid shift-out-of-bounds UBSAN warning
Date:   Fri, 18 Aug 2023 09:40:04 +0800
Message-ID: <20230818014004.16177-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit 06470f7468c8 ("mac80211: add API to allow filtering frames in BA sessions")
adds reorder_buf_filtered to mark frames filtered by firmware, and it can
only work correctly if hw.max_rx_aggregation_subframes <= 64 because
maximum BlockAck is 64 at that moment.

However, new HE or EHT devices can support BlockAck number up to 256 or
1024, and leads UBSAN warning:

 UBSAN: shift-out-of-bounds in net/mac80211/rx.c:1129:39
 shift exponent 215 is too large for 64-bit type 'long long unsigned int'
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x48/0x70
  dump_stack+0x10/0x20
  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
  ieee80211_release_reorder_frame.constprop.0.cold+0x64/0x69 [mac80211]
  ieee80211_sta_reorder_release+0x9c/0x400 [mac80211]
  ieee80211_prepare_and_rx_handle+0x1234/0x1420 [mac80211]
  ? __pfx_jhash+0x10/0x10
  ? rht_key_get_hash.isra.0+0x19/0x30 [mac80211]
  ieee80211_rx_list+0xaef/0xf60 [mac80211]
  ? kfree_skbmem+0x58/0xb0
  ? rtw89_vif_rx_stats_iter+0x2bb/0x2e1 [rtw89_core]
  ieee80211_rx_napi+0x53/0xd0 [mac80211]

Since only old hardware that supports <=64 BlockAck uses
ieee80211_mark_rx_ba_filtered_frames(), limit the use as it is, so add a
WARN_ONCE() and comment to note to avoid using this function if hardware
capability is not suitable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 include/net/mac80211.h |  1 +
 net/mac80211/rx.c      | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3a8a2d2c58c3..2a55ae932c56 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6612,6 +6612,7 @@ void ieee80211_stop_rx_ba_session(struct ieee80211_vif *vif, u16 ba_rx_bitmap,
  * marks frames marked in the bitmap as having been filtered. Afterwards, it
  * checks if any frames in the window starting from @ssn can now be released
  * (in case they were only waiting for frames that were filtered.)
+ * (Only work correctly if @max_rx_aggregation_subframes <= 64 frames)
  */
 void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 					  u16 ssn, u64 filtered,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4f707d2a160f..0af2599c17e8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_ready(struct tid_ampdu_rx *tid_agg_rx,
 	struct sk_buff *tail = skb_peek_tail(frames);
 	struct ieee80211_rx_status *status;
 
-	if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
+	if (tid_agg_rx->reorder_buf_filtered &&
+	    tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
 		return true;
 
 	if (!tail)
@@ -1124,7 +1125,8 @@ static void ieee80211_release_reorder_frame(struct ieee80211_sub_if_data *sdata,
 	}
 
 no_frame:
-	tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
+	if (tid_agg_rx->reorder_buf_filtered)
+		tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
 	tid_agg_rx->head_seq_num = ieee80211_sn_inc(tid_agg_rx->head_seq_num);
 }
 
@@ -4264,6 +4266,7 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 					  u16 ssn, u64 filtered,
 					  u16 received_mpdus)
 {
+	struct ieee80211_local *local;
 	struct sta_info *sta;
 	struct tid_ampdu_rx *tid_agg_rx;
 	struct sk_buff_head frames;
@@ -4281,6 +4284,11 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 
 	sta = container_of(pubsta, struct sta_info, sta);
 
+	local = sta->sdata->local;
+	WARN_ONCE(local->hw.max_rx_aggregation_subframes > 64,
+		  "RX BA marker can't support max_rx_aggregation_subframes %u > 64\n",
+		  local->hw.max_rx_aggregation_subframes);
+
 	if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
 		return;
 
-- 
2.25.1

