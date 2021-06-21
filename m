Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE83AF3B6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhFUSDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 14:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhFUSB3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 14:01:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 709C5613E9;
        Mon, 21 Jun 2021 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624298096;
        bh=ltZV6Jt4ghxEh3yLIw/23FrPMnxa2xTgM43AU+i0y1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPq4Rn/NOZgokfQAxFTqh2wMQs6dbCr5BAHqvaRTfDupl/pwlU4z1gVKlrx6ELZ7G
         UEfkJQE2fjkHZYkQQxSa7ztmGiJAmc9EnSph8ni56lpYjidMclz7X2YO57IeuFnPZb
         RQQGK6EH/tLhi6wWr2+62f+7CN8jnJk1WkQ8xQpwa9ic0awxc6iaXos0ALTxEuuQr6
         C1CaMzmJkK418APd4MTYiD6pC6GAxb5LLX7zuyBuaJtSHB+sLkLb3IDILRRZacVV1f
         /oB6zYYrssDin61J+ij1uX2x80G7itRFVCSSR0bZ6rZHlQwdMOIrEuNrNRYRCLzAPG
         aOULoVGlVOg9Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/16] mac80211: drop multicast fragments
Date:   Mon, 21 Jun 2021 13:54:37 -0400
Message-Id: <20210621175450.736067-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621175450.736067-1-sashal@kernel.org>
References: <20210621175450.736067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a9799541ca34652d9996e45f80e8e03144c12949 ]

These are not permitted by the spec, just drop them.

Link: https://lore.kernel.org/r/20210609161305.23def022b750.Ibd6dd3cdce573dae262fcdc47f8ac52b883a9c50@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2ba19decb126..012697efafc3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2124,17 +2124,15 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = sc & IEEE80211_SCTL_FRAG;
 
-	if (is_multicast_ether_addr(hdr->addr1)) {
-		I802_DEBUG_INC(rx->local->dot11MulticastReceivedFrameCount);
-		goto out_no_led;
-	}
-
 	if (rx->sta)
 		cache = &rx->sta->frags;
 
 	if (likely(!ieee80211_has_morefrags(fc) && frag == 0))
 		goto out;
 
+	if (is_multicast_ether_addr(hdr->addr1))
+		return RX_DROP_MONITOR;
+
 	I802_DEBUG_INC(rx->local->rx_handlers_fragments);
 
 	if (skb_linearize(rx->skb))
@@ -2260,7 +2258,6 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 
  out:
 	ieee80211_led_rx(rx->local);
- out_no_led:
 	if (rx->sta)
 		rx->sta->rx_stats.packets++;
 	return RX_CONTINUE;
-- 
2.30.2

