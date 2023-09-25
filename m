Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F707ADB58
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjIYPZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjIYPZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8910C
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8ELnot2GeJSP9to23PEJpX0TDgJ1eWioL+xFbX4kCdA=;
        t=1695655516; x=1696865116; b=VDRny3CWPIQfkksb/SX0JnAGtY5F5L1nXTx1TkkOCoemlc5
        AR5c6xiRPfIQGoZ954WrVpyNc0ZNlFEjvFS0r0cXJflmDQVzsu3k9zbKxaAyB4aeFPi+YszxTkbhv
        u2KyuDJAt1pYpvuiS2QHi0mZKvmiP/pUx+BJS3Wk592Nc0HoVCcNr6IFMxeKkaEt2LNjz8/KCZKpg
        MS59rDBbZQ5DEPBq1z8IECI0brxwIg8VOIgHspbcaGnwbnt1JNqJ4+0XeS11Y5FNEiqSBu8zWjSiJ
        qxKwlQwecpt/WY8xL2DZdHBOs1UhZgYegmKGobZQ+bDJ6i7DccAPpcm2h6KTkAHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknST-003kq9-35;
        Mon, 25 Sep 2023 17:25:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() return value
Date:   Mon, 25 Sep 2023 17:25:10 +0200
Message-ID: <20230925172508.f60df94d5f05.I8c68472bcfb7162cc87f7b15fec7145ace325877@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925172508.bc62dfb8a129.I9d64271b6d375aa87c8cac82145823374800b246@changeid>
References: <20230925172508.bc62dfb8a129.I9d64271b6d375aa87c8cac82145823374800b246@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This has many different reasons, split the return value into
the individual reasons for better traceability. Also, since
symbolic tracing doesn't work for these, add a few comments
for the numbering.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/drop.h |  9 +++++++++
 net/mac80211/rx.c   | 21 +++++++++------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 725a07a5b614..3acc21ae9c69 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -18,6 +18,7 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 /* this line for the trailing \ - add before this */
 
 #define MAC80211_DROP_REASONS_UNUSABLE(R)	\
+	/* 0x00 == ___RX_DROP_UNUSABLE */	\
 	R(RX_DROP_U_MIC_FAIL)			\
 	R(RX_DROP_U_REPLAY)			\
 	R(RX_DROP_U_BAD_MMIE)			\
@@ -33,8 +34,15 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	R(RX_DROP_U_BAD_AMSDU)			\
 	R(RX_DROP_U_BAD_AMSDU_CIPHER)		\
 	R(RX_DROP_U_INVALID_8023)		\
+	/* 0x10 */				\
 	R(RX_DROP_U_RUNT_ACTION)		\
 	R(RX_DROP_U_UNPROT_ACTION)		\
+	R(RX_DROP_U_UNPROT_DUAL)		\
+	R(RX_DROP_U_UNPROT_UCAST_MGMT)		\
+	R(RX_DROP_U_UNPROT_MCAST_MGMT)		\
+	R(RX_DROP_U_UNPROT_BEACON)		\
+	R(RX_DROP_U_UNPROT_UNICAST_PUB_ACTION)	\
+	R(RX_DROP_U_UNPROT_ROBUST_ACTION)	\
 	R(RX_DROP_U_ACTION_UNKNOWN_SRC)		\
 	R(RX_DROP_U_REJECTED_ACTION_RESPONSE)	\
 	R(RX_DROP_U_EXPECT_DEFRAG_PROT)		\
@@ -43,6 +51,7 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	R(RX_DROP_U_NO_ICV)			\
 	R(RX_DROP_U_AP_RX_GROUPCAST)		\
 	R(RX_DROP_U_SHORT_MMIC)			\
+	/* 0x20 */				\
 	R(RX_DROP_U_MMIC_FAIL)			\
 	R(RX_DROP_U_SHORT_TKIP)			\
 	R(RX_DROP_U_TKIP_FAIL)			\
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1851b86fc5fd..ff98681c70e3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2416,12 +2416,12 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 	 * decrypted them already.
 	 */
 	if (status->flag & RX_FLAG_DECRYPTED)
-		return 0;
+		return RX_CONTINUE;
 
 	/* drop unicast protected dual (that wasn't protected) */
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
-		return -EACCES;
+		return RX_DROP_U_UNPROT_DUAL;
 
 	if (rx->sta && test_sta_flag(rx->sta, WLAN_STA_MFP)) {
 		if (unlikely(!ieee80211_has_protected(fc) &&
@@ -2433,13 +2433,13 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 				 * during 4-way-HS (key is installed after HS).
 				 */
 				if (!rx->key)
-					return 0;
+					return RX_CONTINUE;
 
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     rx->skb->data,
 							     rx->skb->len);
 			}
-			return -EACCES;
+			return RX_DROP_U_UNPROT_UCAST_MGMT;
 		}
 		/* BIP does not use Protected field, so need to check MMIE */
 		if (unlikely(ieee80211_is_multicast_robust_mgmt_frame(rx->skb) &&
@@ -2449,14 +2449,14 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     rx->skb->data,
 							     rx->skb->len);
-			return -EACCES;
+			return RX_DROP_U_UNPROT_MCAST_MGMT;
 		}
 		if (unlikely(ieee80211_is_beacon(fc) && rx->key &&
 			     ieee80211_get_mmie_keyidx(rx->skb) < 0)) {
 			cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 						     rx->skb->data,
 						     rx->skb->len);
-			return -EACCES;
+			return RX_DROP_U_UNPROT_BEACON;
 		}
 		/*
 		 * When using MFP, Action frames are not allowed prior to
@@ -2464,13 +2464,13 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 		 */
 		if (unlikely(ieee80211_is_action(fc) && !rx->key &&
 			     ieee80211_is_robust_mgmt_frame(rx->skb)))
-			return -EACCES;
+			return RX_DROP_U_UNPROT_ACTION;
 
 		/* drop unicast public action frames when using MPF */
 		if (is_unicast_ether_addr(mgmt->da) &&
 		    ieee80211_is_public_action((void *)rx->skb->data,
 					       rx->skb->len))
-			return -EACCES;
+			return RX_DROP_U_UNPROT_UNICAST_PUB_ACTION;
 	}
 
 	return 0;
@@ -3400,10 +3400,7 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 		rx->flags |= IEEE80211_RX_BEACON_REPORTED;
 	}
 
-	if (ieee80211_drop_unencrypted_mgmt(rx))
-		return RX_DROP_U_UNPROT_ACTION;
-
-	return RX_CONTINUE;
+	return ieee80211_drop_unencrypted_mgmt(rx);
 }
 
 static bool
-- 
2.41.0

