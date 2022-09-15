Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCD5B9B54
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIOMwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIOMwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 08:52:30 -0400
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 05:52:28 PDT
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48BB3876AB
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 05:52:28 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1663245799;
        bh=BWMUrbwCsBnvb29ULObdwGqAAjEVYyG+fdGEuy9c9ak=;
        h=From:To:Cc:Subject:Date;
        b=o4cj4DeWwL/2W/iWQjRQ2Mtgj+hvVw6TIESEkCFwsZ7EVHCHDIs5GNVsxiSQIhGQM
         OaBzW9e6fhgn5SgUq0y4misj96PvIh5h/H4d2BPw1C0D7+N1/x1JhPpphBR70bN/95
         z8/IPkZulBk6aleb3QnKObf1D8kv+8XsIjdGPv8w=
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] mac80211: Fix deadlock: Don't start TX while holding fq->lock
Date:   Thu, 15 Sep 2022 14:41:20 +0200
Message-Id: <20220915124120.301918-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_txq_purge() calls fq_tin_reset() and
ieee80211_purge_tx_queue(); Both are then calling
ieee80211_free_txskb(). Which can decide to TX the skb again.

There are at least two ways to get a deadlock:

1) When we have a TDLS teardown packet queued in either tin or frags
   ieee80211_tdls_td_tx_handle() will call ieee80211_subif_start_xmit()
   while we still hold fq->lock. ieee80211_txq_enqueue() will thus
   deadlock.

2) A variant of the above happens if aggregation is up and running:
   In that case ieee80211_iface_work() will deadlock with the original
   task: The original tasks already holds fq->lock and tries to get
   sta->lock after kicking off ieee80211_iface_work(). But the worker
   can get sta->lock prior to the original task and will then spin for
   fq->lock.

Avoid these deadlocks by not sending out any skbs when called via
ieee80211_free_txskb().

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

I have deadlock traces for the two scenarios above I can share, if
desired.
I found the issue while running the hostapd tests with my WIP patch
to switch all drivers over to iTXQ.

 net/mac80211/status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 8e77fd2e9fdf..3f9ddd7f04b6 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -729,7 +729,7 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 
 		if (!sdata) {
 			skb->dev = NULL;
-		} else {
+		} else if (!dropped) {
 			unsigned int hdr_size =
 				ieee80211_hdrlen(hdr->frame_control);
 
-- 
2.37.3

