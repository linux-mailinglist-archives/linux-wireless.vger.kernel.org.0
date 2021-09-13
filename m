Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B6409B4C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhIMR5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 13:57:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29696 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235841AbhIMR5D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 13:57:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631555747; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jHdzBSk4cdbPQS53S9z++PaBwDY9pMm0fESyUzRwxzk=; b=KXeF+MZm/cC9MEmvGDzuuL4MRUC3+0YmRLyZ4VbjIKTT67c4RPSsJUSLMl6heACPZrJQ3LO+
 1JP0FW6Zn4C7gYtKxNAFHq4cuGcHzpXDKOg2btLvoLV8q1ccL2e+vLiCqy1E+KZHVBiWoLxN
 4horLJtsWwVomAtEXGN4p+p95g8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 613f9094bd6681d8ed4ac4f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 17:55:32
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3870C4360C; Mon, 13 Sep 2021 17:55:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D69D6C43460;
        Mon, 13 Sep 2021 17:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D69D6C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: add 6 GHz params in peer assoc command
Date:   Mon, 13 Sep 2021 20:55:09 +0300
Message-Id: <20210913175510.193005-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913175510.193005-1-jouni@codeaurora.org>
References: <20210913175510.193005-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Currently A-MPDU aggregation parameters are not being configured
during peer association for 6 GHz band. Hence, extract these
parameters from station's capabilities received in association
request and send to firmware. Without this, A-MPDU aggregation
is not happening in 6 GHz band.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 50 ++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 04a8f82e3a17..aba005241095 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1959,6 +1959,53 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		   arg->peer_bw_rxnss_override);
 }
 
+static void ath11k_peer_assoc_h_he_6ghz(struct ath11k *ar,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct peer_assoc_params *arg)
+{
+	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct cfg80211_chan_def def;
+	enum nl80211_band band;
+	u8  ampdu_factor;
+
+	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
+		return;
+
+	band = def.chan->band;
+
+	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->he_6ghz_capa.capa)
+		return;
+
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+		arg->bw_80 = true;
+
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+		arg->bw_160 = true;
+
+	arg->peer_he_caps_6ghz = le16_to_cpu(sta->he_6ghz_capa.capa);
+	arg->peer_mpdu_density =
+		ath11k_parse_mpdudensity(FIELD_GET(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START,
+						   arg->peer_he_caps_6ghz));
+
+	/* From IEEE Std 802.11ax-2021 - Section 10.12.2: An HE STA shall be capable of
+	 * receiving A-MPDU where the A-MPDU pre-EOF padding length is up to the value
+	 * indicated by the Maximum A-MPDU Length Exponent Extension field in the HE
+	 * Capabilities element and the Maximum A-MPDU Length Exponent field in HE 6 GHz
+	 * Band Capabilities element in the 6 GHz band.
+	 *
+	 * Here, we are extracting the Max A-MPDU Exponent Extension from HE caps and
+	 * factor is the Maximum A-MPDU Length Exponent from HE 6 GHZ Band capability.
+	 */
+	ampdu_factor = FIELD_GET(IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK,
+				 he_cap->he_cap_elem.mac_cap_info[3]) +
+			FIELD_GET(IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP,
+				  arg->peer_he_caps_6ghz);
+
+	arg->peer_max_mpdu = (1u << (IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR +
+				     ampdu_factor)) - 1;
+}
+
 static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct peer_assoc_params *arg)
 {
@@ -2248,6 +2295,7 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 	ath11k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_he(ar, vif, sta, arg);
+	ath11k_peer_assoc_h_he_6ghz(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_qos(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_smps(sta, arg);
 
@@ -7496,7 +7544,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (cap->nss_ratio_enabled)
 		ieee80211_hw_set(ar->hw, SUPPORTS_VHT_EXT_NSS_BW);
 
-	if (ht_cap & WMI_HT_CAP_ENABLED) {
+	if ((ht_cap & WMI_HT_CAP_ENABLED) || ar->supports_6ghz) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
 		ieee80211_hw_set(ar->hw, SUPPORTS_REORDERING_BUFFER);
-- 
2.25.1

