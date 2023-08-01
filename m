Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4C76BB95
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjHARqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHARqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:46:17 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 10:46:12 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053442128
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690911510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tMb1KuKLW71AvWoMA2PeNskKoaQcwJJvCEtvK3dASsQ=;
        b=nGR3Xzmn6tXIjaG91nGTwws90xOlNwXHKyrdpA0HuLNOp4bzekH7Hxb2yGmLOXCM8ycgij
        rCaWAUmQtGRBOrpW9yvltHIzABhjum5A7h9Ayj/pwqmbTBfEPZrwi/YcmbRhWSC2O2B4Zt
        YzhyTxlnet+PojutSPX+URCZ02T55YA=
From:   Sven Eckelmann <sven@narfation.org>
Date:   Tue, 01 Aug 2023 19:38:17 +0200
Subject: [PATCH RFC] ath11k: Don't drop tx_status when peer cannot be found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-ath11k-ack_status_leak-v1-1-539cb72c55bc@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAhDyWQC/x2NywrCMBAAf6Xs2UAeSItXwQ/wKlK26WpCQizZV
 ITSf3fpcQaG2YCpRmK4dBtU+kaOnyJgTh34gOVNKs7CYLV1etBGYQvGJIU+jdywrTxmwqSscwP
 NeMbeGpB4QiY1VSw+SF7WnEUulV7xd9wecL9d4bnvf1jUBT6CAAAA
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3912; i=sven@narfation.org;
 h=from:subject:message-id; bh=mePIzwASQczcP1X0hv82OStbS9js0qoRSNuEYQKg39o=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyUMTHfoQvxBssiJyi9fTmZEOvBco1xbvGh2yR
 Lz9XI9IbLGJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMlDEwAKCRBdhwoHwSZ7
 RqrAD/9/v53zwtwSacEf9SLgb3SBsT4ddt2Rs0w+RNPuzLJ/lG5Qrapw8AAtItgqJATRhMSOJWT
 mKabZeZIy8jx7v8hJHp6B19ZgYSqP3/AyLkMPnkOFZkdhwnAht2g5bqPhi5ByN0ZO/LIVYaVRtc
 1sLNX+7MkLWFlmORnwi1RO9nTsOI903IOTiYBOXk7sRjgMlMPv0XtQFmZ/kpbAbRAGYsmreViPx
 YPITN7+PUu3NoDDgamOiKfnuxkvr9oPFV/ceprnjotNJvgbnm3SJcbfFw/sYTwgdLBmgwKaiscI
 bYV1Py0EtQUmSdi1QQEApg7R5E9RPhnLP6EbweYccEbEHxMzYos2J84VpyDiiaRP+eb16gjlghV
 PRp482xHzx7svGfCZKyTY22VSKBCHhbGvnSBb8vcsa6rKu5PYF9lGk4iSZnZ2UjPtwSUgJS4OGU
 ugaNfP2EV8u+RTwd7HAURIzBXofaFHjynyfGQAM5oJJMFJ8GAoYa04ltjDkmMkjKJzonBgNeNur
 UneuH49btKeGjwnU2jUmLWNSRIDSUOjQW2iYliaNsJM/rX+64Sdn/ymd52rLc+Ew+v23lIwKKZQ
 GZmZh+ujhAWwwS9OJav+0pcAz32T5RmJWtk4hqZ/sBQ6MKVuLGUZRhvthUOykgg4I12SewD9iZ6
 cr+IzoPhVz1XDfg==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a station idles for a long time, hostapd will try to send a QoS Null
frame to the station as "poll". NL80211_CMD_PROBE_CLIENT is used for this
purpose. And the skb will be added to ack_status_frame - waiting for a
tx_complete via ieee80211_tx_status*();

But when the peer was already removed before the tx_complete arrives, the
peer will be missing and thus the entry will not be removed from
ack_status_frame. This IDR will therefore run full after 8K clients which
disappeared this way - the access point will then just stall and not allow
any new clients because idr_alloc for ack_status_frame will fail.

Tested-on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
Fixes: 94739d45c388 ("ath11k: switch to using ieee80211_tx_status_ext()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This problem can be seen with QCA's ath11k fork as:

  attach ack fail -28

when new clients try to connect - and connection attempt will obviously
fail. Most likely with an "deauthenticated due to inactivity (timer
DEAUTH/REMOVE)" by hostapd.

And the fix (required for both platches) would then be something like:

  --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
  +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
  @@ -629,8 +629,14 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
   			   "dp_tx: failed to find the peer with peer_id %d\n",
   			    ts->peer_id);
   		spin_unlock_bh(&ab->base_lock);
  -		dev_kfree_skb_any(msdu);
  -		goto exit;
  +		rcu_read_unlock();
  +
  +		if (skb_cb->flags & ATH11K_SKB_HW_80211_ENCAP)
  +			ieee80211_tx_status_8023(ar->hw, skb_cb->vif, msdu);
  +		else
  +			ieee80211_tx_status(ar->hw, msdu);
  +
  +		return;
   	}
   	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
   	status.sta = peer->sta;

But this is not possible any longer because Felix Fietkau removed
ieee80211_tx_status_8023 in commit 9ae708f00161 ("wifi: mac80211: remove
ieee80211_tx_status_8023") - and the function ieee80211_lookup_ra_sta
(required for this task) is currently not exported. And the sta information
is required to reach the ieee80211_sta_tx_notify code section in
ieee80211_tx_status_ext()
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a34833de7c67..c25283a11d27 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -369,7 +369,14 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			    ts->peer_id);
 		spin_unlock_bh(&ab->base_lock);
-		dev_kfree_skb_any(msdu);
+
+		/* report back to clean up resources - even when the peer
+		 * is not known by ath11k.
+		 *
+		 * TODO handle also for ATH11K_SKB_HW_80211_ENCAP
+		 */
+		if (!(skb_cb->flags & ATH11K_SKB_HW_80211_ENCAP))
+			ieee80211_tx_status(ar->hw, msdu);
 		return;
 	}
 	spin_unlock_bh(&ab->base_lock);
@@ -624,7 +631,14 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			    ts->peer_id);
 		spin_unlock_bh(&ab->base_lock);
-		dev_kfree_skb_any(msdu);
+
+		/* report back to clean up resources - even when the peer
+		 * is not known by ath11k.
+		 *
+		 * TODO handle also for ATH11K_SKB_HW_80211_ENCAP
+		 */
+		if (!(skb_cb->flags & ATH11K_SKB_HW_80211_ENCAP))
+			ieee80211_tx_status(ar->hw, msdu);
 		return;
 	}
 	arsta = (struct ath11k_sta *)peer->sta->drv_priv;

---
base-commit: 1d7dd5aa35474e553b8671b58579e0749b560779
change-id: 20230801-ath11k-ack_status_leak-2338eda5a721

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

