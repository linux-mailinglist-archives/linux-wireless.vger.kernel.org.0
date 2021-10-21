Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF354436449
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJUOc6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 10:32:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FBC0613B9
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=cdYXHuGe7zXdR1U10eYmj8+iks0RE7V7sHVpgsPJD6A=; t=1634826641; x=1636036241; 
        b=dxRIJyw3nglIysL7cj7y1SYrzg37qc/KGFan1mNX1K6HSeOxYZ7hzw0x8HxxNiBrp+WUekVXwYX
        uLKEWFYdySFjMPVWGfCKVuiA5AJ4X4MDAbdyVoDUbSeWOrkx5jiYeK4cDckLTf4YBCQM53CRCX8pb
        tjlxLHs0agCgLqhLCd94PIWYyzlX2i2/PipCWXvDd2136RRT6O3IDAwMikyz6JrmbRMaWwjYyjmUq
        FK+qrWGJS5blnsp2KEXncxqm+eflsAmUwk+vj7Ycf1OKrxlm8zGbO4EsgIbUqo8N9HW9xueULPRIk
        X8kN/aGIdMXVRQydXi1ygMIZHABuaB3KwwAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mdZ5b-005J5p-1P;
        Thu, 21 Oct 2021 16:30:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH] mac80211: debugfs: calculate free buffer size correctly
Date:   Thu, 21 Oct 2021 16:30:36 +0200
Message-Id: <20211021163035.b9ae48c06e27.I6a6ed197110eae28cf4f6e38ce36828a7c136337@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In breaking patch buf memory moved from stack to heap and sizeof(buf)
change from size of actual memory to size of the pointer to the heap.

Fix this by holding a separated variable for allocate size.

Fixes: 01f84f0ed3b4 ("mac80211: reduce stack usage in debugfs")
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
---
 net/mac80211/debugfs_sta.c | 91 ++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index da22725eca0f..481f01b0f65c 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -153,20 +153,20 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	rcu_read_lock();
 
 	p += scnprintf(p,
-		       bufsz+buf-p,
+		       bufsz + buf - p,
 		       "target %uus interval %uus ecn %s\n",
 		       codel_time_to_us(sta->cparams.target),
 		       codel_time_to_us(sta->cparams.interval),
 		       sta->cparams.ecn ? "yes" : "no");
 	p += scnprintf(p,
-		       bufsz+buf-p,
+		       bufsz + buf - p,
 		       "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
 
 	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 		if (!sta->sta.txq[i])
 			continue;
 		txqi = to_txq_info(sta->sta.txq[i]);
-		p += scnprintf(p, bufsz+buf-p,
+		p += scnprintf(p, bufsz + buf - p,
 			       "%d %d %u %u %u %u %u %u %u %u %u 0x%lx(%s%s%s)\n",
 			       txqi->txq.tid,
 			       txqi->txq.ac,
@@ -315,22 +315,23 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 					size_t count, loff_t *ppos)
 {
 	char *buf, *p;
+	ssize_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
 	int i;
 	struct sta_info *sta = file->private_data;
 	struct tid_ampdu_rx *tid_rx;
 	struct tid_ampdu_tx *tid_tx;
 	ssize_t ret;
 
-	buf = kzalloc(71 + IEEE80211_NUM_TIDS * 40, GFP_KERNEL);
+	buf = kzalloc(bufsz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	p = buf;
 
 	rcu_read_lock();
 
-	p += scnprintf(p, sizeof(buf) + buf - p, "next dialog_token: %#02x\n",
+	p += scnprintf(p, bufsz + buf - p, "next dialog_token: %#02x\n",
 			sta->ampdu_mlme.dialog_token_allocator + 1);
-	p += scnprintf(p, sizeof(buf) + buf - p,
+	p += scnprintf(p, bufsz + buf - p,
 		       "TID\t\tRX\tDTKN\tSSN\t\tTX\tDTKN\tpending\n");
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
@@ -340,21 +341,21 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[i]);
 		tid_rx_valid = test_bit(i, sta->ampdu_mlme.agg_session_valid);
 
-		p += scnprintf(p, sizeof(buf) + buf - p, "%02d", i);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t\t%x",
+		p += scnprintf(p, bufsz + buf - p, "%02d", i);
+		p += scnprintf(p, bufsz + buf - p, "\t\t%x",
 			       tid_rx_valid);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t%#.2x",
+		p += scnprintf(p, bufsz + buf - p, "\t%#.2x",
 			       tid_rx_valid ?
 					sta->ampdu_mlme.tid_rx_token[i] : 0);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t%#.3x",
+		p += scnprintf(p, bufsz + buf - p, "\t%#.3x",
 				tid_rx ? tid_rx->ssn : 0);
 
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t\t%x", !!tid_tx);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t%#.2x",
+		p += scnprintf(p, bufsz + buf - p, "\t\t%x", !!tid_tx);
+		p += scnprintf(p, bufsz + buf - p, "\t%#.2x",
 				tid_tx ? tid_tx->dialog_token : 0);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\t%03d",
+		p += scnprintf(p, bufsz + buf - p, "\t%03d",
 				tid_tx ? skb_queue_len(&tid_tx->pending) : 0);
-		p += scnprintf(p, sizeof(buf) + buf - p, "\n");
+		p += scnprintf(p, bufsz + buf - p, "\n");
 	}
 	rcu_read_unlock();
 
@@ -444,19 +445,20 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	} while (0)
 	char *buf, *p;
 	int i;
+	ssize_t bufsz = 512;
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_sta_ht_cap *htc = &sta->sta.ht_cap;
 	ssize_t ret;
 
-	buf = kzalloc(512, GFP_KERNEL);
+	buf = kzalloc(bufsz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	p = buf;
 
-	p += scnprintf(p, sizeof(buf) + buf - p, "ht %ssupported\n",
+	p += scnprintf(p, bufsz + buf - p, "ht %ssupported\n",
 			htc->ht_supported ? "" : "not ");
 	if (htc->ht_supported) {
-		p += scnprintf(p, sizeof(buf)+buf-p, "cap: %#.4x\n", htc->cap);
+		p += scnprintf(p, bufsz + buf - p, "cap: %#.4x\n", htc->cap);
 
 		PRINT_HT_CAP((htc->cap & BIT(0)), "RX LDPC");
 		PRINT_HT_CAP((htc->cap & BIT(1)), "HT20/HT40");
@@ -498,23 +500,23 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 
 		PRINT_HT_CAP((htc->cap & BIT(15)), "L-SIG TXOP protection");
 
-		p += scnprintf(p, sizeof(buf)+buf-p, "ampdu factor/density: %d/%d\n",
+		p += scnprintf(p, bufsz + buf - p, "ampdu factor/density: %d/%d\n",
 				htc->ampdu_factor, htc->ampdu_density);
-		p += scnprintf(p, sizeof(buf)+buf-p, "MCS mask:");
+		p += scnprintf(p, bufsz + buf - p, "MCS mask:");
 
 		for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
-			p += scnprintf(p, sizeof(buf)+buf-p, " %.2x",
+			p += scnprintf(p, bufsz + buf - p, " %.2x",
 					htc->mcs.rx_mask[i]);
-		p += scnprintf(p, sizeof(buf)+buf-p, "\n");
+		p += scnprintf(p, bufsz + buf - p, "\n");
 
 		/* If not set this is meaningless */
 		if (le16_to_cpu(htc->mcs.rx_highest)) {
-			p += scnprintf(p, sizeof(buf)+buf-p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "MCS rx highest: %d Mbps\n",
 				       le16_to_cpu(htc->mcs.rx_highest));
 		}
 
-		p += scnprintf(p, sizeof(buf)+buf-p, "MCS tx params: %x\n",
+		p += scnprintf(p, bufsz + buf - p, "MCS tx params: %x\n",
 				htc->mcs.tx_params);
 	}
 
@@ -531,56 +533,57 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.vht_cap;
 	ssize_t ret;
+	ssize_t bufsz = 512;
 
-	buf = kzalloc(512, GFP_KERNEL);
+	buf = kzalloc(bufsz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	p = buf;
 
-	p += scnprintf(p, sizeof(buf) + buf - p, "VHT %ssupported\n",
+	p += scnprintf(p, bufsz + buf - p, "VHT %ssupported\n",
 			vhtc->vht_supported ? "" : "not ");
 	if (vhtc->vht_supported) {
-		p += scnprintf(p, sizeof(buf) + buf - p, "cap: %#.8x\n",
+		p += scnprintf(p, bufsz + buf - p, "cap: %#.8x\n",
 			       vhtc->cap);
 #define PFLAG(a, b)							\
 		do {							\
 			if (vhtc->cap & IEEE80211_VHT_CAP_ ## a)	\
-				p += scnprintf(p, sizeof(buf) + buf - p, \
+				p += scnprintf(p, bufsz + buf - p, \
 					       "\t\t%s\n", b);		\
 		} while (0)
 
 		switch (vhtc->cap & 0x3) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\tMAX-MPDU-3895\n");
 			break;
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\tMAX-MPDU-7991\n");
 			break;
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\tMAX-MPDU-11454\n");
 			break;
 		default:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\tMAX-MPDU-UNKNOWN\n");
 		}
 		switch (vhtc->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 		case 0:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\t80Mhz\n");
 			break;
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\t160Mhz\n");
 			break;
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\t80+80Mhz\n");
 			break;
 		default:
-			p += scnprintf(p, sizeof(buf) + buf - p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "\t\tUNKNOWN-MHZ: 0x%x\n",
 				       (vhtc->cap >> 2) & 0x3);
 		}
@@ -588,15 +591,15 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 		PFLAG(SHORT_GI_80, "SHORT-GI-80");
 		PFLAG(SHORT_GI_160, "SHORT-GI-160");
 		PFLAG(TXSTBC, "TXSTBC");
-		p += scnprintf(p, sizeof(buf) + buf - p,
+		p += scnprintf(p, bufsz + buf - p,
 			       "\t\tRXSTBC_%d\n", (vhtc->cap >> 8) & 0x7);
 		PFLAG(SU_BEAMFORMER_CAPABLE, "SU-BEAMFORMER-CAPABLE");
 		PFLAG(SU_BEAMFORMEE_CAPABLE, "SU-BEAMFORMEE-CAPABLE");
-		p += scnprintf(p, sizeof(buf) + buf - p,
+		p += scnprintf(p, bufsz + buf - p,
 			"\t\tBEAMFORMEE-STS: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK) >>
 			IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
-		p += scnprintf(p, sizeof(buf) + buf - p,
+		p += scnprintf(p, bufsz + buf - p,
 			"\t\tSOUNDING-DIMENSIONS: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK)
 			>> IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT);
@@ -604,28 +607,28 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 		PFLAG(MU_BEAMFORMEE_CAPABLE, "MU-BEAMFORMEE-CAPABLE");
 		PFLAG(VHT_TXOP_PS, "TXOP-PS");
 		PFLAG(HTC_VHT, "HTC-VHT");
-		p += scnprintf(p, sizeof(buf) + buf - p,
+		p += scnprintf(p, bufsz + buf - p,
 			"\t\tMPDU-LENGTH-EXPONENT: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
 		PFLAG(VHT_LINK_ADAPTATION_VHT_UNSOL_MFB,
 		      "LINK-ADAPTATION-VHT-UNSOL-MFB");
-		p += scnprintf(p, sizeof(buf) + buf - p,
+		p += scnprintf(p, bufsz + buf - p,
 			"\t\tLINK-ADAPTATION-VHT-MRQ-MFB: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_MRQ_MFB) >> 26);
 		PFLAG(RX_ANTENNA_PATTERN, "RX-ANTENNA-PATTERN");
 		PFLAG(TX_ANTENNA_PATTERN, "TX-ANTENNA-PATTERN");
 
-		p += scnprintf(p, sizeof(buf)+buf-p, "RX MCS: %.4x\n",
+		p += scnprintf(p, bufsz + buf - p, "RX MCS: %.4x\n",
 			       le16_to_cpu(vhtc->vht_mcs.rx_mcs_map));
 		if (vhtc->vht_mcs.rx_highest)
-			p += scnprintf(p, sizeof(buf)+buf-p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "MCS RX highest: %d Mbps\n",
 				       le16_to_cpu(vhtc->vht_mcs.rx_highest));
-		p += scnprintf(p, sizeof(buf)+buf-p, "TX MCS: %.4x\n",
+		p += scnprintf(p, bufsz + buf - p, "TX MCS: %.4x\n",
 			       le16_to_cpu(vhtc->vht_mcs.tx_mcs_map));
 		if (vhtc->vht_mcs.tx_highest)
-			p += scnprintf(p, sizeof(buf)+buf-p,
+			p += scnprintf(p, bufsz + buf - p,
 				       "MCS TX highest: %d Mbps\n",
 				       le16_to_cpu(vhtc->vht_mcs.tx_highest));
 #undef PFLAG
-- 
2.31.1

