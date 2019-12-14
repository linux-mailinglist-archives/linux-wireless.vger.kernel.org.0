Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2011EF6C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLNBBz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 20:01:55 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:36956 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLNBBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 20:01:54 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D49BA13C283;
        Fri, 13 Dec 2019 17:01:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D49BA13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576285313;
        bh=KzIggzShseVv//0133sYU/j/0LdXBAsZ22NHcvYo4jw=;
        h=From:To:Cc:Subject:Date:From;
        b=Au2od75tUMo3be7Ky9zR7Wqul9+SsHfUIjsQZ94WYri7dsfI5wh0KZVb7lWg4CjQI
         9P3Gk7p1pIgR2k1q6aWhV83/4XwItwKPVKzfeIcW5v0Wt3pmEiM++QUoFRzWv3oIwY
         bvdf9iyOhEQDpvAUlYyIEQlRlLRplypwQ4qqRmNQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [RFC] ath10k:  Per-chain rssi should sum the secondary channels
Date:   Fri, 13 Dec 2019 17:01:49 -0800
Message-Id: <20191214010149.32647-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This makes per-chain RSSI be more consistent between HT20, HT40, HT80.
Instead of doing precise log math for adding dbm, I did a rough estimate,
it seems to work good enough.

Tested on ath10k-ct 9984 firmware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c  | 83 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/rx_desc.h |  3 +-
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 13f652b622df..985271ad65e6 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1167,6 +1167,63 @@ static bool ath10k_htt_rx_h_channel(struct ath10k *ar,
 	return true;
 }
 
+static int ath10k_sum_sigs(int p20, int e20, int e40, int e80) {
+	int rv = p20;
+	int diff;
+	int accum = 0;
+
+	/* Hacky attempt at summing dbm without resorting to log(10) business */
+
+	/* Find strongest signal, that is our baseline */
+	if ((e20 != 0x80) && (p20 < e20))
+		rv = e20;
+	if ((e40 != 0x80) && (rv < e40))
+		rv = e40;
+	if ((e80 != 0x80) && (rv < e80))
+		rv = e80;
+
+	if (e20 != 0x80) {
+		diff = rv - e20;
+		if (diff == 0)
+			rv += 3;
+		else if (diff == 1)
+			rv += 2;
+		else if (diff == 2)
+			rv += 1;
+		else if (diff < 6)
+			accum++;
+	}
+
+	if (e40 != 0x80) {
+		diff = rv - e40;
+		if (diff == 0)
+			rv += 3;
+		else if (diff == 1)
+			rv += 2;
+		else if (diff == 2)
+			rv += 1;
+		else if (diff < 6)
+			accum++;
+	}
+
+	if (e80 != 0x80) {
+		diff = rv - e80;
+		if (diff == 0)
+			rv += 3;
+		else if (diff == 1)
+			rv += 2;
+		else if (diff == 2)
+			rv += 1;
+		else if (diff < 6)
+			accum++;
+	}
+
+	if (accum >= 2)
+		rv++;
+
+	return rv;
+}
+
 static void ath10k_htt_rx_h_signal(struct ath10k *ar,
 				   struct ieee80211_rx_status *status,
 				   struct htt_rx_desc *rxd)
@@ -1177,18 +1234,32 @@ static void ath10k_htt_rx_h_signal(struct ath10k *ar,
 		status->chains &= ~BIT(i);
 
 		if (rxd->ppdu_start.rssi_chains[i].pri20_mhz != 0x80) {
-			status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR +
-				rxd->ppdu_start.rssi_chains[i].pri20_mhz;
+			status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR
+				+ ath10k_sum_sigs(rxd->ppdu_start.rssi_chains[i].pri20_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext20_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext40_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext80_mhz);
+			//ath10k_warn(ar, "rx-h-sig, chain[%i] pri20: %d ext20: %d  ext40: %d  ext80: %d\n",
+			//	    i, rxd->ppdu_start.rssi_chains[i].pri20_mhz, rxd->ppdu_start.rssi_chains[i].ext20_mhz,
+			//	    rxd->ppdu_start.rssi_chains[i].ext40_mhz, rxd->ppdu_start.rssi_chains[i].ext80_mhz);
 
 			status->chains |= BIT(i);
 		}
 	}
 
 	/* FIXME: Get real NF */
-	status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
-			 rxd->ppdu_start.rssi_comb;
-	/* ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x  chain[0]: %d  chain[1]: %d  chan[2]: %d\n",
-                       status->signal, status->chains, status->chain_signal[0], status->chain_signal[1], status->chain_signal[2]); */
+	if (rxd->ppdu_start.rssi_comb_ht != 0x80) {
+		status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
+			rxd->ppdu_start.rssi_comb_ht;
+	}
+	else {
+		status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
+			rxd->ppdu_start.rssi_comb;
+	}
+
+	//ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x  chain[0]: %d  chain[1]: %d  chain[2]: %d chain[3]: %d\n",
+	//	    status->signal, status->chains, status->chain_signal[0],
+	//	    status->chain_signal[1], status->chain_signal[2], status->chain_signal[3]);
 	status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h b/drivers/net/wireless/ath/ath10k/rx_desc.h
index dec1582005b9..6b44677474dd 100644
--- a/drivers/net/wireless/ath/ath10k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
@@ -726,7 +726,8 @@ struct rx_ppdu_start {
 		u8 ext80_mhz;
 	} rssi_chains[4];
 	u8 rssi_comb;
-	__le16 rsvd0;
+	u8 rsvd0; /* first two bits are bandwidth, other 6 are reserved */
+	u8 rssi_comb_ht;
 	u8 info0; /* %RX_PPDU_START_INFO0_ */
 	__le32 info1; /* %RX_PPDU_START_INFO1_ */
 	__le32 info2; /* %RX_PPDU_START_INFO2_ */
-- 
2.20.1

