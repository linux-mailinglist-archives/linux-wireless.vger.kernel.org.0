Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269CE3AC90B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhFRKoV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48162 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233779AbhFRKoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwt-001YXx-87; Fri, 18 Jun 2021 13:42:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:33 +0300
Message-Id: <iwlwifi.20210618133832.98f058d7a8b2.Ie605e6a10e72eae02f5734032826af48b85b6d11@changeid>
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
Subject: [PATCH 08/31] mac80211: free skb in WEP error case
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If, for some strange reason, ieee80211_wep_encrypt() fails in
ieee80211_send_auth() free the SKB instead of sending out the
useless frame, in addition to the warning. This can't really
happen since the SKB was freshly allocated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a0ff27487686..0f6fd90f6696 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1693,7 +1693,10 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 		err = ieee80211_wep_encrypt(local, skb, key, key_len, key_idx);
-		WARN_ON(err);
+		if (WARN_ON(err)) {
+			kfree_skb(skb);
+			return;
+		}
 	}
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
-- 
2.32.0

