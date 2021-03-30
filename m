Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E034F4DB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 01:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhC3XII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 19:08:08 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:51494 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhC3XHy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 19:07:54 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6686113C2B0;
        Tue, 30 Mar 2021 16:07:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6686113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617145674;
        bh=4hCnNB6cX64vrsPj5W538P5FZ2xNJ40RSORE2NgDsIU=;
        h=From:To:Cc:Subject:Date:From;
        b=mwlnlFzwt56vz77lCO5RdLAcb71NzYFNPZnlo8EPlJIuMVsHTgm7deC8GTjRocT7n
         i4lgp2b3y6wB4okITbJRtkxm8cqeHGUzUbBwMxHV65ifGJozj8Kdww1D9MiAS4dEgs
         3zgdLMkg0NSMM15tnpN8aQnoQQy2mAB/R11pvowQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org, nbd@nbd.name
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  fix time-is-after bug in mlme.
Date:   Tue, 30 Mar 2021 16:07:49 -0700
Message-Id: <20210330230749.14097-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This fixes commit:  mac80211: optimize station connection monitor
which came in in the 5.10 kernel.

This incorrect timeout check caused probing to happen when it did
not need to happen.  This in turn caused tx performance drop
for around 5 seconds in ath10k-ct driver.  Possibly that tx drop
is due to a secondary issue, but fixing the probe to not happen
when traffic is running fixes the symptom.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c137a8b5d8e1..b06c76116d86 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4729,7 +4729,10 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 		timeout = sta->rx_stats.last_rx;
 	timeout += IEEE80211_CONNECTION_IDLE_TIME;
 
-	if (time_is_before_jiffies(timeout)) {
+	/* If timeout is after now, then update timer to fire at
+	 * the later date, but do not actually probe at this time.
+	 */
+	if (time_is_after_jiffies(timeout)) {
 		mod_timer(&ifmgd->conn_mon_timer, round_jiffies_up(timeout));
 		return;
 	}
-- 
2.20.1

