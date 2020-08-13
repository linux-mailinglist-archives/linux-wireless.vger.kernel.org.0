Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B072437DD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMJqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:46:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21564 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgHMJqt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:46:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597312009; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=jTxVgfD/n0KtjHa4pMQZKD5yHhete+JGI5+kiey9IWc=; b=MfuVCsg2c80nZnQBHXA+HDvuUwepLsLZa+1Pfr18vRIjcR6BYrKpfUh94DDuz92UFif0vxU8
 y44lK+2oJSomADWiN1nhqbD8Teo99K4TD9jAJCeV1zQFpwNlpe4eC4HKB9/ugDDI9B3X18Gr
 gJhUjKK3uYWUeO7PCL3sKTvGZJY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f350c0546ed996674ce633a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:46:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB155C433C9; Thu, 13 Aug 2020 09:46:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EABEC43391;
        Thu, 13 Aug 2020 09:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EABEC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 2/3] ath10k: remove return for NL80211_STA_INFO_TX_BITRATE
Date:   Thu, 13 Aug 2020 17:47:08 +0800
Message-Id: <1597312029-32348-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
References: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_sta_statistics is used to report many info to iw wlan0 link,
if it return for empty legacy and nss of arsta->txrate, then the other
stats after it will not be set.

It has 4 bit to set after the return:
NL80211_STA_INFO_TX_FAILED
NL80211_STA_INFO_RX_BITRATE
NL80211_STA_INFO_TX_BITRATE
NL80211_STA_INFO_TX_RETRIES

This patch not effect the info of above 4 bit for all hardware, reason
as below:

NL80211_STA_INFO_TX_FAILED is only for htt.disable_tx_comp is true, it
is for QCA6174 SDIO.

NL80211_STA_INFO_RX_BITRATE and NL80211_STA_INFO_TX_BITRATE are both
set in ath10k_mac_sta_get_peer_stats_info, it is only enabled for chips
which supports_peer_stats_info is true in hw_params, recently only for
QCA6174 SDIO, NL80211_STA_INFO_TX_BITRATE is set again in function
ath10k_mac_sta_get_peer_stats_info because the value which parsed from
arsta->tx_rate_code and arsta->tx_bitrate_kbps is correct for QCA6174
SDIO and PCIe, and the value arsta->txrate is not correct for QCA6174
SDIO and PCIe, so it need to set again with the correct value.

NL80211_STA_INFO_TX_RETRIES is use value of arsta->tx_retries, it is set
in ath10k_update_per_peer_tx_stats, which accumulate the retry_pkts in
HTT message from firmware, if the chips not support this feature, then
it is always 0 after accumulate, then iw wlan0 station dump always show
0 for retry count. If not set NL80211_STA_INFO_TX_RETRIES here, then it
is still 0, so the result is same, then set NL80211_STA_INFO_TX_RETRIES
has no effect.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048
Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3e3896214e8b..4554a82d0105 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8533,18 +8533,17 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
-	if (!arsta->txrate.legacy && !arsta->txrate.nss)
-		return;
-
-	if (arsta->txrate.legacy) {
-		sinfo->txrate.legacy = arsta->txrate.legacy;
-	} else {
-		sinfo->txrate.mcs = arsta->txrate.mcs;
-		sinfo->txrate.nss = arsta->txrate.nss;
-		sinfo->txrate.bw = arsta->txrate.bw;
+	if (arsta->txrate.legacy || arsta->txrate.nss) {
+		if (arsta->txrate.legacy) {
+			sinfo->txrate.legacy = arsta->txrate.legacy;
+		} else {
+			sinfo->txrate.mcs = arsta->txrate.mcs;
+			sinfo->txrate.nss = arsta->txrate.nss;
+			sinfo->txrate.bw = arsta->txrate.bw;
+		}
+		sinfo->txrate.flags = arsta->txrate.flags;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
-	sinfo->txrate.flags = arsta->txrate.flags;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
 	if (ar->htt.disable_tx_comp) {
 		sinfo->tx_failed = arsta->tx_failed;
-- 
2.23.0

