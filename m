Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D91C40C6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgEDRHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 13:07:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49700 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729930AbgEDRHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 13:07:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588612029; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1v4FzGS58NB4/ttumhbZ7Z1UsATJOWCKhmmhp4YmwLU=; b=I/iqlZYlkaA2+U5SFIgov4/77fg0Qaokc4pGyeSyhXAX2GFpz/A3g6N+raXICPrvaYdn36ik
 4LFdTMeomU5nMa6YS6Z0L+TMU/DLZ/6sjKFpW6W0Ey+4O+o0CRn/YPfinefooDYJKn7pvi+q
 ECrfIBtW9Ly1ZHzH+EgTMcDV0H4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb04baf.7fea8dbcc618-smtp-out-n01;
 Mon, 04 May 2020 17:06:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A66A1C433CB; Mon,  4 May 2020 17:06:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 189FFC432C2;
        Mon,  4 May 2020 17:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 189FFC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH 2/2] ath11k: Add peer max mpdu parameter in peer assoc command
Date:   Mon,  4 May 2020 22:35:00 +0530
Message-Id: <1588611900-21185-2-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588611900-21185-1-git-send-email-tamizhr@codeaurora.org>
References: <1588611900-21185-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add peer max mpdu length configuration support in peer_assoc_he
parameters. Noticed low throughput for the STA which
supports HE, HT and not VHT in MU-MIMO case without this
configuration

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f33c6d7..88e533c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1161,6 +1161,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   struct peer_assoc_params *arg)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	u8  ampdu_factor;
 	u16 v;
 
 	if (!he_cap->has_he)
@@ -1178,6 +1179,30 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	/* the top most byte is used to indicate BSS color info */
 	arg->peer_he_ops &= 0xffffff;
 
+	/* As per section 26.6.1 11ax Draft5.0, if the Max AMPDU Exponent Extension
+	 * in HE cap is zero, use the arg->peer_max_mpdu as calculated while parsing
+	 * VHT caps(if VHT caps is present) or HT caps (if VHT caps is not present).
+	 *
+	 * For non-zero value of Max AMPDU Extponent Extension in HE MAC caps,
+	 * if a HE STA sends VHT cap and HE cap IE in assoc request then, use
+	 * MAX_AMPDU_LEN_FACTOR as 20 to calculate max_ampdu length.
+	 * If a HE STA that does not send VHT cap, but HE and HT cap in assoc
+	 * request, then use MAX_AMPDU_LEN_FACTOR as 16 to calculate max_ampdu
+	 * length.
+	 */
+	ampdu_factor = (he_cap->he_cap_elem.mac_cap_info[3] &
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) >>
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_SHIFT;
+
+	if (ampdu_factor) {
+		if (sta->vht_cap.vht_supported)
+			arg->peer_max_mpdu = (1 << (IEEE80211_HE_VHT_MAX_AMPDU_FACTOR +
+						    ampdu_factor)) - 1;
+		else if (sta->ht_cap.ht_supported)
+			arg->peer_max_mpdu = (1 << (IEEE80211_HE_HT_MAX_AMPDU_FACTOR +
+						    ampdu_factor)) - 1;
+	}
+
 	if (he_cap->he_cap_elem.phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
 		int bit = 7;
-- 
1.9.1
