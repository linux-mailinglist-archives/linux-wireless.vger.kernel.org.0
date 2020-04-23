Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49671B5284
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 04:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgDWC2r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 22:28:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58893 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgDWC2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 22:28:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587608926; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=aPpPKTGsqkL6cyzNhUhTTZSVkPYP436EodQfBMFtlas=; b=YYjc+LB4MZdGwVWKsSpOzL1FIGILz95sAKt9nzGyCi7eUfWwMWYBXF9200RwCw734IMR6xHv
 HV0nigLw/a5L1lD/NIEvXzs+q8KlSFTzo7WIGIWiygwOHPikVRHTBB3SqxEitgqZhIWT34xi
 vORzjoNR1G0jW/tqu61zd6ZLlhE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea0fd4d.7f857d6783b0-smtp-out-n05;
 Thu, 23 Apr 2020 02:28:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B84FC433BA; Thu, 23 Apr 2020 02:28:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A74ACC433CB;
        Thu, 23 Apr 2020 02:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A74ACC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: enable rx duration report default for wmi tlv
Date:   Thu, 23 Apr 2020 10:27:58 +0800
Message-Id: <20200423022758.5365-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When run command "iw dev wlan0 station dump", the rx duration is 0.
When firmware indicate WMI_UPDATE_STATS_EVENTID, extended flag of
statsis not set by default, so firmware do not report rx duration.

one sample:
localhost # iw wlan0 station dump
Station c4:04:15:5d:97:22 (on wlan0)
        inactive time:  48 ms
        rx bytes:       21670
        rx packets:     147
        tx bytes:       11529
        tx packets:     100
        tx retries:     88
        tx failed:      36
        beacon loss:    1
        beacon rx:      31
        rx drop misc:   47
        signal:         -72 [-74, -75] dBm
        signal avg:     -71 [-74, -75] dBm
        beacon signal avg:      -71 dBm
        tx bitrate:     54.0 MBit/s MCS 3 40MHz
        rx bitrate:     1.0 MBit/s
	rx duration:    0 us

This patch enable firmware's extened flag of stats by setting flag
WMI_TLV_STAT_PEER_EXTD of ar->fw_stats_req_mask which is set in
ath10k_core_init_firmware_features via WMI_REQUEST_STATS_CMDID.

After apply this patch, rx duration show value with the command:
Station c4:04:15:5d:97:22 (on wlan0)
        inactive time:  883 ms
        rx bytes:       44289
        rx packets:     265
        tx bytes:       10838
        tx packets:     93
        tx retries:     899
        tx failed:      103
        beacon loss:    0
        beacon rx:      78
        rx drop misc:   46
        signal:         -71 [-74, -76] dBm
        signal avg:     -70 [-74, -76] dBm
        beacon signal avg:      -70 dBm
        tx bitrate:     54.0 MBit/s MCS 3 40MHz
        rx bitrate:     1.0 MBit/s
        rx duration:    358004 us

This patch do not have side effect for all chips, because function
ath10k_debug_fw_stats_request is already exported to debugfs
"fw_stats" and WMI_REQUEST_STATS_CMDID is safely sent after condition
checked by ath10k_peer_stats_enabled in ath10k_sta_statistics.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debug.c | 2 +-
 drivers/net/wireless/ath/ath10k/debug.h | 8 ++++++++
 drivers/net/wireless/ath/ath10k/mac.c   | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 69139c2e6f82..e8250a665433 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -349,7 +349,7 @@ void ath10k_debug_fw_stats_process(struct ath10k *ar, struct sk_buff *skb)
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static int ath10k_debug_fw_stats_request(struct ath10k *ar)
+int ath10k_debug_fw_stats_request(struct ath10k *ar)
 {
 	unsigned long timeout, time_left;
 	int ret;
diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
index 82f7eb8583d9..4cbfd9279d6f 100644
--- a/drivers/net/wireless/ath/ath10k/debug.h
+++ b/drivers/net/wireless/ath/ath10k/debug.h
@@ -125,6 +125,9 @@ static inline int ath10k_debug_is_extd_tx_stats_enabled(struct ath10k *ar)
 {
 	return ar->debug.enable_extd_tx_stats;
 }
+
+int ath10k_debug_fw_stats_request(struct ath10k *ar);
+
 #else
 
 static inline int ath10k_debug_start(struct ath10k *ar)
@@ -192,6 +195,11 @@ static inline int ath10k_debug_is_extd_tx_stats_enabled(struct ath10k *ar)
 	return 0;
 }
 
+static inline int ath10k_debug_fw_stats_request(struct ath10k *ar)
+{
+	return 0;
+}
+
 #define ATH10K_DFS_STAT_INC(ar, c) do { } while (0)
 
 #define ath10k_debug_get_et_strings NULL
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6791c0035be0..ea5a26ea9b32 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8306,6 +8306,8 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	if (!ath10k_peer_stats_enabled(ar))
 		return;
 
+	ath10k_debug_fw_stats_request(ar);
+
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
-- 
2.23.0
