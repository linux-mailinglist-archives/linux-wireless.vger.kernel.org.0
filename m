Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9867FEC
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfGNPoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:37 -0400
Received: from nbd.name ([46.4.11.11]:59402 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbfGNPoh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:37 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgfy-0007cJ-EP; Sun, 14 Jul 2019 17:44:34 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 3/6] mac80211: add struct ieee80211_tx_status support to ieee80211_add_tx_radiotap_header
Date:   Sun, 14 Jul 2019 17:44:16 +0200
Message-Id: <20190714154419.11854-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190714154419.11854-1-john@phrozen.org>
References: <20190714154419.11854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to ieee80211_add_tx_radiotap_header() for handling rates
reported via ieee80211_tx_status. This allows us to also report HE rates.
Reporting 60GHz rates is now also possible but is not part of the patch due
to lack of test HW.

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/status.c | 174 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 162 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index a3502da02b4e..167c97d941a3 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -257,7 +257,8 @@ static void ieee80211_set_bar_pending(struct sta_info *sta, u8 tid, u16 ssn)
 	tid_tx->bar_pending = true;
 }
 
-static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info)
+static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info,
+				     struct ieee80211_tx_status *status)
 {
 	int len = sizeof(struct ieee80211_radiotap_header);
 
@@ -275,7 +276,14 @@ static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info)
 
 	/* IEEE80211_RADIOTAP_MCS
 	 * IEEE80211_RADIOTAP_VHT */
-	if (info->status.rates[0].idx >= 0) {
+	if (status && status->rate) {
+		if (status->rate->flags & RATE_INFO_FLAGS_MCS)
+			len += 3;
+		else if (status->rate->flags & RATE_INFO_FLAGS_VHT_MCS)
+			len = ALIGN(len, 2) + 12;
+		else if (status->rate->flags & RATE_INFO_FLAGS_HE_MCS)
+			len = ALIGN(len, 2) + 12;
+	} else if (info->status.rates[0].idx >= 0) {
 		if (info->status.rates[0].flags & IEEE80211_TX_RC_MCS)
 			len += 3;
 		else if (info->status.rates[0].flags & IEEE80211_TX_RC_VHT_MCS)
@@ -289,12 +297,14 @@ static void
 ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 				 struct ieee80211_supported_band *sband,
 				 struct sk_buff *skb, int retry_count,
-				 int rtap_len, int shift)
+				 int rtap_len, int shift,
+				 struct ieee80211_tx_status *status)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_radiotap_header *rthdr;
 	unsigned char *pos;
+	u16 legacy_rate = 0;
 	u16 txflags;
 
 	rthdr = skb_push(skb, rtap_len);
@@ -313,14 +323,22 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 	 */
 
 	/* IEEE80211_RADIOTAP_RATE */
-	if (info->status.rates[0].idx >= 0 &&
-	    !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
-					     IEEE80211_TX_RC_VHT_MCS))) {
-		u16 rate;
 
+	if (status && status->rate && !(status->rate->flags &
+					(RATE_INFO_FLAGS_MCS |
+					 RATE_INFO_FLAGS_60G |
+					 RATE_INFO_FLAGS_VHT_MCS |
+					 RATE_INFO_FLAGS_HE_MCS)))
+		legacy_rate = status->rate->legacy;
+	else if (info->status.rates[0].idx >= 0 &&
+		 !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
+						  IEEE80211_TX_RC_VHT_MCS)))
+		legacy_rate =
+			sband->bitrates[info->status.rates[0].idx].bitrate;
+
+	if (legacy_rate) {
 		rthdr->it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_RATE);
-		rate = sband->bitrates[info->status.rates[0].idx].bitrate;
-		*pos = DIV_ROUND_UP(rate, 5 * (1 << shift));
+		*pos = DIV_ROUND_UP(legacy_rate, 5 * (1 << shift));
 		/* padding for tx flags */
 		pos += 2;
 	}
@@ -344,7 +362,139 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 	*pos = retry_count;
 	pos++;
 
-	if (info->status.rates[0].idx < 0)
+	if (status && status->rate &&
+	    (status->rate->flags & RATE_INFO_FLAGS_MCS)) {
+		rthdr->it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_MCS);
+		pos[0] = IEEE80211_RADIOTAP_MCS_HAVE_MCS |
+			 IEEE80211_RADIOTAP_MCS_HAVE_GI |
+			 IEEE80211_RADIOTAP_MCS_HAVE_BW;
+		if (status->rate->flags & RATE_INFO_FLAGS_SHORT_GI)
+			pos[1] |= IEEE80211_RADIOTAP_MCS_SGI;
+		if (status->rate->bw == RATE_INFO_BW_40)
+			pos[1] |= IEEE80211_RADIOTAP_MCS_BW_40;
+		pos[2] = status->rate->mcs;
+		pos += 3;
+	} else if (status && status->rate &&
+		   (status->rate->flags & RATE_INFO_FLAGS_VHT_MCS)) {
+		u16 known = local->hw.radiotap_vht_details &
+			(IEEE80211_RADIOTAP_VHT_KNOWN_GI |
+			 IEEE80211_RADIOTAP_VHT_KNOWN_BANDWIDTH);
+
+		rthdr->it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_VHT);
+
+		/* required alignment from rthdr */
+		pos = (u8 *)rthdr + ALIGN(pos - (u8 *)rthdr, 2);
+
+		/* u16 known - IEEE80211_RADIOTAP_VHT_KNOWN_* */
+		put_unaligned_le16(known, pos);
+		pos += 2;
+
+		/* u8 flags - IEEE80211_RADIOTAP_VHT_FLAG_* */
+		if (status->rate->flags & RATE_INFO_FLAGS_SHORT_GI)
+			*pos |= IEEE80211_RADIOTAP_VHT_FLAG_SGI;
+		pos++;
+
+		/* u8 bandwidth */
+		switch (status->rate->bw) {
+		case RATE_INFO_BW_160:
+			*pos = 11;
+			break;
+		case RATE_INFO_BW_80:
+			*pos = 2;
+			break;
+		case RATE_INFO_BW_40:
+			*pos = 1;
+			break;
+		default:
+			*pos = 0;
+			break;
+		}
+
+		/* u8 mcs_nss[4] */
+		*pos = (status->rate->mcs << 4) | status->rate->nss;
+		pos += 4;
+
+		/* u8 coding */
+		pos++;
+		/* u8 group_id */
+		pos++;
+		/* u16 partial_aid */
+		pos += 2;
+	} else if (status && status->rate &&
+		   (status->rate->flags & RATE_INFO_FLAGS_HE_MCS)) {
+		struct ieee80211_radiotap_he *he;
+
+		rthdr->it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_HE);
+
+		/* required alignment from rthdr */
+		pos = (u8 *)rthdr + ALIGN(pos - (u8 *)rthdr, 2);
+		he = (struct ieee80211_radiotap_he *)pos;
+
+		he->data1 = IEEE80211_RADIOTAP_HE_DATA1_FORMAT_SU |
+			    IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
+			    IEEE80211_RADIOTAP_HE_DATA1_DATA_DCM_KNOWN |
+			    IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN;
+
+		he->data2 = IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN;
+
+#define HE_PREP(f, val) le16_encode_bits(val, IEEE80211_RADIOTAP_HE_##f)
+
+		he->data6 |= HE_PREP(DATA6_NSTS, status->rate->nss);
+
+#define CHECK_GI(s) \
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA5_GI_##s != \
+	(int)NL80211_RATE_INFO_HE_GI_##s)
+
+		CHECK_GI(0_8);
+		CHECK_GI(1_6);
+		CHECK_GI(3_2);
+
+		he->data3 |= HE_PREP(DATA3_DATA_MCS, status->rate->mcs);
+		he->data3 |= HE_PREP(DATA3_DATA_DCM, status->rate->he_dcm);
+
+		he->data5 |= HE_PREP(DATA5_GI, status->rate->he_gi);
+
+		switch (status->rate->bw) {
+		case RATE_INFO_BW_20:
+			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
+					     IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_20MHZ);
+			break;
+		case RATE_INFO_BW_40:
+			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
+					     IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_40MHZ);
+			break;
+		case RATE_INFO_BW_80:
+			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
+					     IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_80MHZ);
+			break;
+		case RATE_INFO_BW_160:
+			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
+					     IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_160MHZ);
+			break;
+		case RATE_INFO_BW_HE_RU:
+#define CHECK_RU_ALLOC(s) \
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_##s##T != \
+	NL80211_RATE_INFO_HE_RU_ALLOC_##s + 4)
+
+			CHECK_RU_ALLOC(26);
+			CHECK_RU_ALLOC(52);
+			CHECK_RU_ALLOC(106);
+			CHECK_RU_ALLOC(242);
+			CHECK_RU_ALLOC(484);
+			CHECK_RU_ALLOC(996);
+			CHECK_RU_ALLOC(2x996);
+
+			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
+					     status->rate->he_ru_alloc + 4);
+			break;
+		default:
+			WARN_ONCE(1, "Invalid SU BW %d\n", status->rate->bw);
+		}
+
+		pos += sizeof(struct ieee80211_radiotap_he);
+	}
+
+	if ((status && status->rate) || info->status.rates[0].idx < 0)
 		return;
 
 	/* IEEE80211_RADIOTAP_MCS
@@ -658,14 +808,14 @@ void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 	int rtap_len;
 
 	/* send frame to monitor interfaces now */
-	rtap_len = ieee80211_tx_radiotap_len(info);
+	rtap_len = ieee80211_tx_radiotap_len(info, status);
 	if (WARN_ON_ONCE(skb_headroom(skb) < rtap_len)) {
 		pr_err("ieee80211_tx_status: headroom too small\n");
 		dev_kfree_skb(skb);
 		return;
 	}
 	ieee80211_add_tx_radiotap_header(local, sband, skb, retry_count,
-					 rtap_len, shift);
+					 rtap_len, shift, status);
 
 	/* XXX: is this sufficient for BPF? */
 	skb_reset_mac_header(skb);
-- 
2.20.1

