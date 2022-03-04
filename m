Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8C4CDFB1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 22:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiCDVWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 16:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDVWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 16:22:50 -0500
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 13:22:01 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E41D4ECC1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 13:22:01 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1111F22A7DA
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 21:16:54 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.118])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 708D41A007E
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 21:16:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 441BD1C008C
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 21:16:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B308413C2B0;
        Fri,  4 Mar 2022 13:16:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B308413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1646428611;
        bh=dmErXHScqXNLWmV34dvhzy1TyVL1oiXl7IhtRZn/QOI=;
        h=From:To:Cc:Subject:Date:From;
        b=IThEK7r7QIh7MjlVWMawhxguhC9nZZPjt+FR4uBIE9CXDzoIRrTD6xt2FLaR1A+CF
         If+x54McEsNjViSaiQDXcudhDLS4bJ362w9CqE4j+Ec4UuqvtkKUONxGiGkjEMACAG
         654g6+Co3e56yP2OxGpeeoJm3Nn2ToL/oMSaqOz4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iwlwifi:  Fix per-chain rssi averaging for 1nss frames.
Date:   Fri,  4 Mar 2022 13:16:48 -0800
Message-Id: <20220304211648.4580-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1646428612-97GZIMxL3Qmk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Averaging in the weak secondary chain for a single-spatial-stream packet
causes the per-chain averages to look abnormally weak.  So, move calculation
of nss above where the rssi is calculated, and then use the nss inside the
rssi-calculation to ignore the weak spatial stream for 1nss frames.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  This on top of the two other related patches I sent recently.

 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 102 ++++++++++--------
 1 file changed, 58 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 489f8a843f82..ac555ae7c180 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -285,12 +285,26 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 	u32 rate_flags = rate_n_flags;
 	struct iwl_mvm_sta *mvmsta = NULL;
 
+	rx_status->chains =
+		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
+
 	if (sta && !(is_beacon && !my_beacon)) {
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
-		if (energy_a)
-			ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
-		if (energy_b)
-			ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
+		/* In cases of OFDM encodings (and maybe other cases), energy is
+		 * reported for each chain, but we do not want to average the weak
+		 * chain since it will average in a false weak reading.
+		 */
+		if (rx_status->nss >= 2) {
+			if (energy_a)
+				ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
+			if (energy_b)
+				ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
+		} else {
+			if (energy_a && (energy_a >= energy_b))
+				ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
+			else if (energy_b)
+				ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
+		}
 	}
 
 	energy_a = energy_a ? -energy_a : S8_MIN;
@@ -303,8 +317,6 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 			energy_a, energy_b, max_energy);
 
 	rx_status->signal = max_energy;
-	rx_status->chains =
-		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
 
@@ -1906,6 +1918,46 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			my_beacon = true;
 	}
 
+	is_sgi = format == RATE_MCS_HE_MSK ?
+		iwl_he_is_sgi(rate_n_flags) :
+		rate_n_flags & RATE_MCS_SGI_MSK;
+
+	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
+		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
+	if (format == RATE_MCS_HT_MSK) {
+		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
+			RATE_MCS_STBC_POS;
+		rx_status->encoding = RX_ENC_HT;
+		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
+		rx_status->nss = rx_status->rate_idx / 8 + 1;
+		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+	} else if (format == RATE_MCS_VHT_MSK) {
+		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
+			RATE_MCS_STBC_POS;
+		rx_status->nss =
+			((rate_n_flags & RATE_MCS_NSS_MSK) >>
+			RATE_MCS_NSS_POS) + 1;
+		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
+		rx_status->encoding = RX_ENC_VHT;
+		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		if (rate_n_flags & RATE_MCS_BF_MSK)
+			rx_status->enc_flags |= RX_ENC_FLAG_BF;
+	} else if (!(format == RATE_MCS_HE_MSK)) {
+		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
+								 rx_status->band);
+
+		if (WARN(rate < 0 || rate > 0xFF,
+			 "Invalid rate flags 0x%x, band %d,\n",
+			 rate_n_flags, rx_status->band)) {
+			kfree_skb(skb);
+			goto out;
+		}
+		rx_status->rate_idx = rate;
+		rx_status->nss = 1;
+	}
+
 	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
 				    energy_b, sta, is_beacon, my_beacon);
 
@@ -2006,44 +2058,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		}
 	}
 
-	is_sgi = format == RATE_MCS_HE_MSK ?
-		iwl_he_is_sgi(rate_n_flags) :
-		rate_n_flags & RATE_MCS_SGI_MSK;
-
-	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
-		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (format == RATE_MCS_HT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-			RATE_MCS_STBC_POS;
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (format == RATE_MCS_VHT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-			RATE_MCS_STBC_POS;
-			rx_status->nss =
-			((rate_n_flags & RATE_MCS_NSS_MSK) >>
-			RATE_MCS_NSS_POS) + 1;
-		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-		rx_status->encoding = RX_ENC_VHT;
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		if (rate_n_flags & RATE_MCS_BF_MSK)
-			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-	} else if (!(format == RATE_MCS_HE_MSK)) {
-		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
-								 rx_status->band);
-
-		if (WARN(rate < 0 || rate > 0xFF,
-			 "Invalid rate flags 0x%x, band %d,\n",
-			 rate_n_flags, rx_status->band)) {
-			kfree_skb(skb);
-			goto out;
-		}
-		rx_status->rate_idx = rate;
-	}
-
 	/* management stuff on default queue */
 	if (!queue) {
 		if (unlikely((ieee80211_is_beacon(hdr->frame_control) ||
-- 
2.20.1

