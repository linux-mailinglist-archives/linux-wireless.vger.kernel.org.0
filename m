Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EE1D7EEC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgERQok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 12:44:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30946 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbgERQoj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 12:44:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589820279; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aGXo9By2LLVQkR2dTDUVvy4YYM3xSRcy58Kpi8/S5dc=; b=unKZSt6NuETVdqeGunZSx9nZ3XIPdoaCbBRhrH02cnbV8wQefQWSX3vPL1Py5LL9E/TD0O+I
 WHzO3HN0jfHbBN5JAwVSrdXSTRKLNarOMnxT9O0w26B7xd9agBvZgdQ/G6c5Aemw0D0v+iAf
 66/nIj5HfyICAaJoFKAwV1+V6pU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec2bb72.7f7080806a08-smtp-out-n01;
 Mon, 18 May 2020 16:44:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8A4AC44791; Mon, 18 May 2020 16:44:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBBBBC4478F;
        Mon, 18 May 2020 16:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBBBBC4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH 4/9] ath11k: Use freq instead of channel number in rx path
Date:   Mon, 18 May 2020 09:44:19 -0700
Message-Id: <20200518164424.29497-5-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518164424.29497-1-pradeepc@codeaurora.org>
References: <20200518164424.29497-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As 6GHz channel numbers overlap with those of 5GHz and 2GHz bands,
it is necessary to use frequency when determining the band info
in rx path.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 6 +++++-
 drivers/net/wireless/ath/ath11k/wmi.c   | 5 ++++-
 drivers/net/wireless/ath/ath11k/wmi.h   | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a54610d75c40..c8f1ea69ea9d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2162,6 +2162,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 				struct ieee80211_rx_status *rx_status)
 {
 	u8 channel_num;
+	u32 center_freq;
 
 	rx_status->freq = 0;
 	rx_status->rate_idx = 0;
@@ -2172,8 +2173,11 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
 	channel_num = ath11k_dp_rx_h_msdu_start_freq(rx_desc);
+	center_freq = ath11k_dp_rx_h_msdu_start_freq(rx_desc) >> 16;
 
-	if (channel_num >= 1 && channel_num <= 14) {
+	if (center_freq >= 5935 && center_freq <= 7105)
+		rx_status->band = NL80211_BAND_6GHZ;
+	else if (channel_num >= 1 && channel_num <= 14) {
 		rx_status->band = NL80211_BAND_2GHZ;
 	} else if (channel_num >= 36 && channel_num <= 173) {
 		rx_status->band = NL80211_BAND_5GHZ;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index f405c162c2b2..c299ad0936f5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3833,6 +3833,7 @@ static int ath11k_pull_mgmt_rx_params_tlv(struct ath11k_base *ab,
 	}
 
 	hdr->pdev_id =  ev->pdev_id;
+	hdr->chan_freq = ev->chan_freq;
 	hdr->channel =  ev->channel;
 	hdr->snr =  ev->snr;
 	hdr->rate =  ev->rate;
@@ -5204,7 +5205,9 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 	if (rx_ev.status & WMI_RX_STATUS_ERR_MIC)
 		status->flag |= RX_FLAG_MMIC_ERROR;
 
-	if (rx_ev.channel >= 1 && rx_ev.channel <= 14) {
+	if (rx_ev.chan_freq >= ATH11K_MIN_6G_FREQ) {
+		status->band = NL80211_BAND_6GHZ;
+	} else if (rx_ev.channel >= 1 && rx_ev.channel <= 14) {
 		status->band = NL80211_BAND_2GHZ;
 	} else if (rx_ev.channel >= 36 && rx_ev.channel <= ATH11K_MAX_5G_CHAN) {
 		status->band = NL80211_BAND_5GHZ;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b9f3e559ced7..afa3c4cf90e9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4228,6 +4228,7 @@ struct wmi_pdev_temperature_event {
 #define WLAN_MGMT_TXRX_HOST_MAX_ANTENNA 4
 
 struct mgmt_rx_event_params {
+	u32 chan_freq;
 	u32 channel;
 	u32 snr;
 	u8 rssi_ctl[WLAN_MGMT_TXRX_HOST_MAX_ANTENNA];
@@ -4257,6 +4258,7 @@ struct wmi_mgmt_rx_hdr {
 	u32 rx_tsf_l32;
 	u32 rx_tsf_u32;
 	u32 pdev_id;
+	u32 chan_freq;
 } __packed;
 
 #define MAX_ANTENNA_EIGHT 8
-- 
2.17.1
