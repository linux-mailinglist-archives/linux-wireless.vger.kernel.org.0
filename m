Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523603AC974
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFRLK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:10:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48288 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230268AbhFRLK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:10:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBxA-001YXx-Po; Fri, 18 Jun 2021 13:42:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:54 +0300
Message-Id: <iwlwifi.20210618133832.76e2f5ab0fe3.Iab8e73126dfe75a5448048ce118550bebda200b8@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 29/31] mac8021: Allow probe request injection on passive non radar channels
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Based on section 11.1.4.3.8 (Non-scanning probe request transmission)
in Draft P802.11REVmd_D5.0 transmission of a probe request to an AP
known to be in range is allowed. Thus, allow probe request injection on
monitor interface in case the target AP is found in range and the
channel is not a radar channel.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/tx.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0b719f3d2dec..663c2fb99b11 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2337,8 +2337,31 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	 * monitor flag interfaces used for AP support.
 	 */
 	if (!cfg80211_reg_can_beacon(local->hw.wiphy, chandef,
-				     sdata->vif.type))
-		goto fail_rcu;
+				     sdata->vif.type)) {
+		/*
+		 * Allow probe request transmissions on non radar channels
+		 * in case the AP is known to be in range. This is in accordance
+		 * to section 11.1.4.3.8 (Non-scanning probe request
+		 * transmission) in Draft P802.11REVmd_D5.0 specification.
+		 */
+		if (!ieee80211_is_probe_req(hdr->frame_control) ||
+		    chandef->chan->flags & IEEE80211_CHAN_RADAR) {
+			goto fail_rcu;
+		} else {
+			struct cfg80211_bss *tmp =
+				cfg80211_get_bss(local->hw.wiphy,
+						 chandef->chan,
+						 hdr->addr1,
+						 NULL, 0,
+						 IEEE80211_BSS_TYPE_ANY,
+						 IEEE80211_PRIVACY_ANY);
+
+			if (!tmp)
+				goto fail_rcu;
+			else
+				cfg80211_put_bss(local->hw.wiphy, tmp);
+		}
+	}
 
 	info->band = chandef->chan->band;
 
-- 
2.32.0

