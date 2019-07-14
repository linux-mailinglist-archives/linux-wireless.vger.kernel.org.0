Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA067FEA
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGNPof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:35 -0400
Received: from nbd.name ([46.4.11.11]:59384 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNPof (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:35 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgfw-0007cJ-K2; Sun, 14 Jul 2019 17:44:32 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/6] mac80211: add xmit rate to struct ieee80211_tx_status
Date:   Sun, 14 Jul 2019 17:44:14 +0200
Message-Id: <20190714154419.11854-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190714154419.11854-1-john@phrozen.org>
References: <20190714154419.11854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now struct ieee80211_tx_rate cannot hold HE rates. Lets use
struct ieee80211_tx_status instead. This will also make the code
future-proof for when we have EHT.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c1e3dd0893e2..15f853cc02b9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1066,11 +1066,13 @@ struct ieee80211_tx_info {
  * @sta: Station that the packet was transmitted for
  * @info: Basic tx status information
  * @skb: Packet skb (can be NULL if not provided by the driver)
+ * @rate: The TX rate that was when sending the packet
  */
 struct ieee80211_tx_status {
 	struct ieee80211_sta *sta;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
+	struct rate_info *rate;
 };
 
 /**
-- 
2.20.1

