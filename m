Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851676C08A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 00:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHAWrJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 18:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHAWrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 18:47:07 -0400
X-Greylist: delayed 18512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 15:47:06 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14391FC6
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690930025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHR/Ceyz+zF+hD08DGQG8Nbyef7sGRTfSEsJc2cgywQ=;
        b=mrssuWkinsKzLAVcizT+VbIKVMfZ8sGKoQbzLDgNdDettjzI75mHYqPDqIWHKYww40ZDtt
        HxtELkAkOugAojp4rlhGj6bwo400FKt/LyoyXHGPRnVjgG4JkX4KgX2yR+qQ5307K8aSss
        1+Vry9zdw9OSE6fr2K13k74wopzZJZE=
From:   Sven Eckelmann <sven@narfation.org>
Date:   Wed, 02 Aug 2023 00:46:26 +0200
Subject: [PATCH v2 1/2] ath11k: Don't drop tx_status when peer cannot be
 found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org>
References: <20230802-ath11k-ack_status_leak-v2-0-c0af729d6229@narfation.org>
In-Reply-To: <20230802-ath11k-ack_status_leak-v2-0-c0af729d6229@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=sven@narfation.org;
 h=from:subject:message-id; bh=HRZoXCCJ8UfiG8qCssNPWEfidZon9wcj2whQmfFjpS0=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyYtPaaXRGe5hL8YZkiJ5gh9JoTh666OGBntxI
 jWSu2IjW/+JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMmLTwAKCRBdhwoHwSZ7
 Rr8aD/9CJ3h275r6O4MZIzWNZTf1G1CCDt4OtOCWFUaq9Hb9FXE3TE/NEKC8vQXghGk7cbIMdQC
 7IYFHRdu3SB2Qa4JAY7AeJ5aMQcIF8Kuk8pFSg9HCtNgIAUzyZCB6eUl05cQRGtFy8FCwWX1SNS
 KMofFZmhNGePn+H6ZglTJQcwt/6joWHvCmTolSWWfGGOIKo75ePtx9YO/pz5DtwbkNgSYkv4H63
 9BRxLMH1+UgE6YVwDAFIAZT8Gw6pYEG+UW6ngMWRPs7o9W0+MJnsVuzXBsdDVzUy8Qir/FG9WuD
 lfTltxr9lQM8PSSUMcdw8Smf2AGb7/J8p6ybPBprJ2xrkdHbDLwVROboOwzlwHGDvL99UPVsxQu
 /+OdraQzeNMjdTc2myRupmvAu5IAFhRsSxx62b5tflrt4sdwOFxx+4aqEFvaBScRQbkr2nYve7q
 O8/fuDFJRLQf2sF1uZgWKURAL4CvTYF7JBinUq+j5JT+iWv2+LTEL5Xw8/Ad6jW3lxBUytlHzEQ
 VRe8+VYtd13Qqf48F0P6Z1BJueM4a4Y5fNU10MJeBm981gBSvThq49uI/3gTIfNYRMHPVvEbDlz
 /CSttv6RtweZILhgIGcjDlU5LrTlXf+Exse14ZRirthh+rCMWaUyB3+nmwkyXSzVVhuj8R2NgvV
 ZXo5F9Fsbdfob3A==
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
completion via ieee80211_report_ack_skb().

But when the peer was already removed before the tx_complete arrives, the
peer will be missing. And when using dev_kfree_skb_any (instead of going
through mac80211), the entry will stay inside ack_status_frames. This IDR
will therefore run full after 8K request were generated for such clients.
At this point, the access point will then just stall and not allow any new
clients because idr_alloc() for ack_status_frame will fail.

ieee80211_free_txskb() on the other hand will (when required) call
ieee80211_report_ack_skb() and make sure that (when required) remove the
entry from the ack_status_frame.

Tested-on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
Fixes: 94739d45c388 ("ath11k: switch to using ieee80211_tx_status_ext()")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a34833de7c67..27c976f52c7a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -369,7 +369,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			    ts->peer_id);
 		spin_unlock_bh(&ab->base_lock);
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 	spin_unlock_bh(&ab->base_lock);
@@ -624,7 +624,7 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			    ts->peer_id);
 		spin_unlock_bh(&ab->base_lock);
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 	arsta = (struct ath11k_sta *)peer->sta->drv_priv;

-- 
2.39.2

