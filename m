Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6328E20EE48
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgF3G01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 02:26:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:41282 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgF3G00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 02:26:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593498386; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bik6olVsHFxI7ynOd4CnDIW+0YcHOHLWVBwDqD735N4=; b=pF9+VBLHFQzi1owwEUhxU5+7xwNTLDxGzoFmfWk9+jhF6fbPrsOhLageClq0b20wo8xoQXHJ
 3+lAg8zHTCt6vBie8sK9jx7JprN68iNKiozVpLO4Uceq6X5QqItvrAD/TS0fwqipN4C46FCW
 DlygIY9M3FBqEkHID1pA892qYTE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5efadb11567385e8e7a54499 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 06:26:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB849C433CA; Tue, 30 Jun 2020 06:26:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vmaloo-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vmaloo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75337C433C6;
        Tue, 30 Jun 2020 06:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75337C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vmaloo@codeaurora.org
From:   "Vinita S. Maloo" <vmaloo@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: Add support to get BIP failure counters
Date:   Tue, 30 Jun 2020 11:56:21 +0530
Message-Id: <1593498381-9337-1-git-send-email-vmaloo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to get number of MIC errors, missing MME incidents and
packet replay incidents observed while using IGTK/BIGTK keys when
PMF and/or beacon protection features are enabled.

Signed-off-by: Vinita S. Maloo <vmaloo@codeaurora.org>

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e2dbc9c0..ade5ade 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1556,6 +1556,16 @@ struct cfg80211_tid_stats {
  *	an FCS error. This counter should be incremented only when TA of the
  *	received packet with an FCS error matches the peer MAC address.
  * @airtime_link_metric: mesh airtime link metric.
+ * @bip_mic_error_count: number of group addressed robust mgmt. frames received
+ *	from this station with invalid MIC or missing MME when PMF is enabled.
+ * @bip_replay_count: number of group addressed robust mgmt. frames received
+ *	from this station with packet number less than or equal to the last
+ *	received packet number (Replay packets) when PMF is enabled.
+ * @beacon_mic_error_count: number of beacons received from this station with
+ *	invalid MIC or missing MME when beacon protection is enabled.
+ * @beacon_replay_count: number of beacons received from this station with
+ *	packet number less than or equal to the last received packet number
+ *	(Replay packets) when beacon protection is enabled.
  */
 struct station_info {
 	u64 filled;
@@ -1613,6 +1623,11 @@ struct station_info {
 	u32 fcs_err_count;
 
 	u32 airtime_link_metric;
+
+	u32 bip_mic_error_count;
+	u32 bip_replay_count;
+	u32 beacon_mic_error_count;
+	u32 beacon_replay_count;
 };
 
 #if IS_ENABLED(CONFIG_CFG80211)
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14666b..a06b2c4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3365,6 +3365,18 @@ enum nl80211_sta_bss_param {
  * @NL80211_STA_INFO_AIRTIME_LINK_METRIC: airtime link metric for mesh station
  * @NL80211_STA_INFO_ASSOC_AT_BOOTTIME: Timestamp (CLOCK_BOOTTIME, nanoseconds)
  *	of STA's association
+ * @NL80211_STA_INFO_BIP_MIC_ERROR_COUNT: number of group addressed robust mgmt.
+ *	frames received from this station with invalid MIC or missing MME when
+ *	PMF is enabled (u32).
+ * @NL80211_STA_INFO_BIP_REPLAY_COUNT: number of group addressed robust mgmt.
+ *	frames received from this station with packet number less than or equal
+ *	to the last received packet number when PMF is enabled (u32)
+ * @NL80211_STA_INFO_BEACON_MIC_ERROR_COUNT: number of beacons received from
+ *	this station with invalid MIC or missing MME when beacon protection is
+ *	enabled (u32)
+ * @NL80211_STA_INFO_BEACON_REPLAY_COUNT: number of beacons received from this
+ *	station with packet number less than or equal to the last received
+ *	packet number when beacon protection is enabled (u32)
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3412,6 +3424,10 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_AIRTIME_WEIGHT,
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
 	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
+	NL80211_STA_INFO_BIP_MIC_ERROR_COUNT,
+	NL80211_STA_INFO_BIP_REPLAY_COUNT,
+	NL80211_STA_INFO_BEACON_MIC_ERROR_COUNT,
+	NL80211_STA_INFO_BEACON_REPLAY_COUNT,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22c4d13..bc6767c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5409,6 +5409,10 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
 	PUT_SINFO(RX_MPDUS, rx_mpdu_count, u32);
 	PUT_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
+	PUT_SINFO(BIP_MIC_ERROR_COUNT, bip_mic_error_count, u32);
+	PUT_SINFO(BIP_REPLAY_COUNT, bip_replay_count, u32);
+	PUT_SINFO(BEACON_MIC_ERROR_COUNT, beacon_mic_error_count, u32);
+	PUT_SINFO(BEACON_REPLAY_COUNT, beacon_replay_count, u32);
 	if (wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
 		PUT_SINFO(ACK_SIGNAL, ack_signal, u8);
-- 
2.7.4

