Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF8368E33
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhDWH7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWH7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 03:59:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C260C061574
        for <linux-wireless@vger.kernel.org>; Fri, 23 Apr 2021 00:58:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZqhy-00FZHv-77; Fri, 23 Apr 2021 09:58:38 +0200
Message-ID: <ec30381c062e3eb87abb724641a15331cfc3d11c.camel@sipsolutions.net>
Subject: Re: [PATCHv2] mac80211: increment rx stats according to USES_RSS
 flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thiraviyam Mariyappan <tmariyap@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 23 Apr 2021 09:58:37 +0200
In-Reply-To: <1ee8d562986128767c037d20aedb96a5@codeaurora.org>
References: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org>
         (sfid-20210217_125904_154301_738B3086) <c0aef41d2ecf09188de372fe4f7d6b1954e54e07.camel@sipsolutions.net>
         <1ee8d562986128767c037d20aedb96a5@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-04-21 at 22:18 +0530, Thiraviyam Mariyappan wrote:
> In case of Mesh fast_rx is not applicable, but still USES_RSS can be
> enabled from driver when parallel RX is supported by HW/Driver,
> right? 

Yes, I guess that's true.

> Hence checked for USES_RSS support to update per cpu stats.Please
> correct me if the meaning of USES_RSS is misunderstood and it applies
> only when fast_rx for a STA is enabled.
> 

Well, actually using multi-queue is pointless or even counter-productive
when you don't have fast-RX, since then you'll run into a common lock,
and doing much processing on multiple CPUs but under a common lock might
well be worse than doing it on a single CPU in the first place, since
you'll bounce the lock around all the time.

However, you're right that the driver might generally advertise
USES_RSS, but then not do it for mesh, but that throws off some
statistics.

Something like this might then be a much better fix though?


diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index ec6973ee88ef..f87e883862d9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2092,7 +2092,7 @@ sta_get_last_rx_stats(struct sta_info *sta)
 	struct ieee80211_local *local = sta->local;
 	int cpu;
 
-	if (!ieee80211_hw_check(&local->hw, USES_RSS))
+	if (!sta->pcpu_rx_stats)
 		return stats;
 
 	for_each_possible_cpu(cpu) {
@@ -2192,9 +2192,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 	int cpu;
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		if (!ieee80211_hw_check(&local->hw, USES_RSS))
-			tidstats->rx_msdu +=
-				sta_get_tidstats_msdu(&sta->rx_stats, tid);
+		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->rx_stats, tid);
 
 		if (sta->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
@@ -2308,8 +2306,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		if (!ieee80211_hw_check(&local->hw, USES_RSS))
-			sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
+		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
 
 		if (sta->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {


johannes

