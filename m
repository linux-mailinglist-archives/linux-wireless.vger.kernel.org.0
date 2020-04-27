Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261D41B9952
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgD0IE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 04:04:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26936 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgD0IE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 04:04:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587974697; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MYrnxNV4Yy6zPBy3u9eGTB7FYWfKkOKa+rVPVo5vI2w=; b=FL6AwBEfYRoyeX0bIuU/37TcK7CipfrObefdzllc1AqAVHWZeom9aDvFqav/B4RYDe1N3T08
 s7uTXkZReg5lFKM5970eQVxC4vV5AgLAfyWKUyl59XHDAuT1k+r2LlcIG1WoIFZuOmuulCK1
 9vT0mZj9xxp+qH02qJWSDlXVLtA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea69226.7f93a9fb8308-smtp-out-n04;
 Mon, 27 Apr 2020 08:04:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B41EFC433D2; Mon, 27 Apr 2020 08:04:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AD57C433F2;
        Mon, 27 Apr 2020 08:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AD57C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 4/4] ath10k: correct tx bitrate of iw for SDIO
Date:   Mon, 27 Apr 2020 16:04:16 +0800
Message-Id: <20200427080416.8265-5-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200427080416.8265-1-wgong@codeaurora.org>
References: <20200427080416.8265-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For legacy mode, tx bitrate not show correct sometimes, for example:
iw wlan0 link
Connected to 8c:21:0a:b3:5a:64 (on wlan0)
        SSID: tplinkgw
        freq: 2462
        RX: 19672 bytes (184 packets)
        TX: 9851 bytes (87 packets)
        signal: -51 dBm
        rx bitrate: 54.0 MBit/s
        tx bitrate: 2.8 MBit/s

This patch use the tx bitrate info from WMI_TLV_PEER_STATS_INFO_EVENTID
report from firmware, and tx bitrate show correct.

iw wlan0 link
Connected to 8c:21:0a:b3:5a:64 (on wlan0)
        SSID: tplinkgw
        freq: 2462
        RX: 13973 bytes (120 packets)
        TX: 6737 bytes (57 packets)
        signal: -52 dBm
        rx bitrate: 54.0 MBit/s
        tx bitrate: 54.0 MBit/s

This patch only effect SDIO chip, ath10k_mac_sta_get_peer_stats_info
has check for bitrate_statistics of hw_params, it is enabled only for
"qca6174 hw3.2 sdio".

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h    |  2 ++
 drivers/net/wireless/ath/ath10k/mac.c     | 10 ++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 1700bf59e8fa..ad6ef8d492c8 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -526,6 +526,8 @@ struct ath10k_sta {
 
 	u32 rx_rate_code;
 	u32 rx_bitrate_kbps;
+	u32 tx_rate_code;
+	u32 tx_bitrate_kbps;
 	struct work_struct update_wk;
 	u64 rx_duration;
 	struct ath10k_htt_tx_stats *tx_stats;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 38fc8cb3aac9..0b7d510d2725 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8502,6 +8502,16 @@ static void ath10k_mac_sta_get_peer_stats_info(struct ath10k *ar,
 		arsta->rx_rate_code = 0;
 		arsta->rx_bitrate_kbps = 0;
 	}
+
+	if (arsta->tx_rate_code != 0 && arsta->tx_bitrate_kbps != 0) {
+		ath10k_mac_parse_bitrate(ar, arsta->tx_rate_code,
+					 arsta->tx_bitrate_kbps,
+					 &sinfo->txrate);
+
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		arsta->tx_rate_code = 0;
+		arsta->tx_bitrate_kbps = 0;
+	}
 }
 
 static void ath10k_sta_statistics(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index eec1f1f27dec..9187b62b331c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -249,6 +249,8 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
 	arsta = (struct ath10k_sta *)sta->drv_priv;
 	arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
 	arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
+	arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
+	arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
 
 	return 0;
 }
-- 
2.23.0
