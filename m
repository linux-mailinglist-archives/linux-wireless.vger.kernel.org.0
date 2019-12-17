Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C41234EA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfLQSdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:33:47 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:42056 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQSdq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:33:46 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 1183013C283;
        Tue, 17 Dec 2019 10:33:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1183013C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576607626;
        bh=XX83yePqZv7V4kiu46hX/CsPwOAtwl9PpVmUx8YM+BE=;
        h=From:To:Cc:Subject:Date:From;
        b=SqpA0eV3nfyr0cp3gUyxSY/T/WNLkXC0z5hxqDm1ocniJr0QPdQRS0RtBpZP28Tcf
         lTAtxKCtY5UoUhothxHl4dUzk6z6dMfYf2rP76+7IyCgVft901JjS8EhZr30RUxKTv
         M1TScAT/OUx27LhZlLr6yj8Eudq05Sgf10M7Ntc0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] ath10k: Per-chain rssi should sum the secondary channels
Date:   Tue, 17 Dec 2019 10:33:43 -0800
Message-Id: <20191217183343.25585-1-greearb@candelatech.com>
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

v2:  Should fix wave-1 rssi measurement (Thanks Sebastian)
     Add comments (Thanks Justin)
     Patch applies against upstream Linux ath10k driver

 drivers/net/wireless/ath/ath10k/htt_rx.c  | 75 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/rx_desc.h |  3 +-
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index d95b63f133ab..1227c9a83e47 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1149,6 +1149,48 @@ static bool ath10k_htt_rx_h_channel(struct ath10k *ar,
 	return true;
 }
 
+static int ath10k_sum_sigs_2(int a, int b) {
+	int diff;
+
+	/* 0x80 means value-is-not-set */
+	if (b == 0x80)
+		return a;
+
+	if (a >= b) {
+		/* a is largest value, add to it. */
+		diff = a - b;
+		if (diff == 0)
+			return a + 3;
+		else if (diff == 1)
+			return a + 2;
+		else if (diff == 2)
+			return a + 1;
+		return a;
+	}
+	else {
+		/* b is largest value, add to it. */
+		diff = b - a;
+		if (diff == 0)
+			return b + 3;
+		else if (diff == 1)
+			return b + 2;
+		else if (diff == 2)
+			return b + 1;
+		return b;
+	}
+}
+
+static int ath10k_sum_sigs(int p20, int e20, int e40, int e80) {
+	/* Hacky attempt at summing dbm without resorting to log(10) business */
+	/* 0x80 means value-is-not-set */
+	if (e40 != 0x80) {
+		return ath10k_sum_sigs_2(ath10k_sum_sigs_2(p20, e20), ath10k_sum_sigs_2(e40, e80));
+	}
+	else {
+		return ath10k_sum_sigs_2(p20, e20);
+	}
+}
+
 static void ath10k_htt_rx_h_signal(struct ath10k *ar,
 				   struct ieee80211_rx_status *status,
 				   struct htt_rx_desc *rxd)
@@ -1159,16 +1201,41 @@ static void ath10k_htt_rx_h_signal(struct ath10k *ar,
 		status->chains &= ~BIT(i);
 
 		if (rxd->ppdu_start.rssi_chains[i].pri20_mhz != 0x80) {
-			status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR +
-				rxd->ppdu_start.rssi_chains[i].pri20_mhz;
+			status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR
+				+ ath10k_sum_sigs(rxd->ppdu_start.rssi_chains[i].pri20_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext20_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext40_mhz,
+						  rxd->ppdu_start.rssi_chains[i].ext80_mhz);
+			/* ath10k_warn(ar, "rx-h-sig, chain[%i] pri20: %d ext20: %d  ext40: %d  ext80: %d\n",
+			 *	    i, rxd->ppdu_start.rssi_chains[i].pri20_mhz,
+			 *          rxd->ppdu_start.rssi_chains[i].ext20_mhz,
+			 *	    rxd->ppdu_start.rssi_chains[i].ext40_mhz,
+			 *          rxd->ppdu_start.rssi_chains[i].ext80_mhz);
+			 */
 
 			status->chains |= BIT(i);
 		}
 	}
 
 	/* FIXME: Get real NF */
-	status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
-			 rxd->ppdu_start.rssi_comb;
+	/* 0x80 means value-is-not-set on wave-2 firmware.
+	 * For wave-2 firmware, value is not defined and is set to zero. */
+	if (rxd->ppdu_start.rssi_comb_ht &&
+	    (rxd->ppdu_start.rssi_comb_ht != 0x80)) {
+		status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
+			rxd->ppdu_start.rssi_comb_ht;
+	}
+	else {
+		status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
+			rxd->ppdu_start.rssi_comb;
+	}
+
+	/* ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x  chain[0]: %d  chain[1]: %d  chain[2]: %d chain[3]: %d\n",
+	 *	    status->signal, status->chains, status->chain_signal[0],
+	 *	    status->chain_signal[1], status->chain_signal[2],
+	 *          status->chain_signal[3]);
+	 */
+
 	status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h b/drivers/net/wireless/ath/ath10k/rx_desc.h
index dec1582005b9..661deb81027c 100644
--- a/drivers/net/wireless/ath/ath10k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
@@ -726,7 +726,8 @@ struct rx_ppdu_start {
 		u8 ext80_mhz;
 	} rssi_chains[4];
 	u8 rssi_comb;
-	__le16 rsvd0;
+	u8 rsvd0; /* wave-2: first two bits are bandwidth, other 6 reserved */
+	u8 rssi_comb_ht; /* wave-2 only, wave-1 sets to zero */
 	u8 info0; /* %RX_PPDU_START_INFO0_ */
 	__le32 info1; /* %RX_PPDU_START_INFO1_ */
 	__le32 info2; /* %RX_PPDU_START_INFO2_ */
-- 
2.20.1

