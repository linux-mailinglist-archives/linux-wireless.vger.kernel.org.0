Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CC1EDDA8
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFDHKD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgFDHKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2DC03E96E
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0l-0001P3-Fi; Thu, 04 Jun 2020 09:09:59 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 05/12] mac80211: add multiple bssid IE parsing
Date:   Thu,  4 Jun 2020 09:09:45 +0200
Message-Id: <20200604070952.15481-6-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drivers might need to know the offset and length of the IE. Add parsing
code and propagate the values to the driver using the mutable struct.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  5 +++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/tx.c          | 10 ++++++++++
 net/mac80211/util.c        |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bb2edace71a9..1a98b3907aa7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4717,12 +4717,17 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @csa_counter_offs: array of IEEE80211_MAX_CSA_COUNTERS_NUM offsets
  *	to CSA counters.  This array can contain zero values which
  *	should be ignored.
+ * @mbssid_offset: position of mbssid_offset
+ * @mbssid_length: position of mbssid_offset
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 csa_counter_offs[IEEE80211_MAX_CSA_COUNTERS_NUM];
+
+	u16 multiple_bssid_offset;
+	u16 multiple_bssid_length;
 };
 
 /**
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2502726d0a58..abe488424287 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1520,6 +1520,7 @@ struct ieee802_11_elems {
 	u8 dtim_count;
 	u8 dtim_period;
 	const struct ieee80211_addba_ext_ie *addba_ext_ie;
+	u16 multiple_bssid_offset;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1540,6 +1541,7 @@ struct ieee802_11_elems {
 	u8 perr_len;
 	u8 country_elem_len;
 	u8 bssid_index_len;
+	u8 multiple_bssid_len;
 
 	/* whether a parse error occurred while retrieving these elements */
 	bool parse_error;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 49d35936cc9d..5e2879cd24b0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4747,11 +4747,21 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 						 is_template);
 
 			if (offs) {
+				struct ieee802_11_elems elems;
+
 				offs->tim_offset = beacon->head_len;
 				offs->tim_length = skb->len - beacon->head_len;
 
 				/* for AP the csa offsets are from tail */
 				csa_off_base = skb->len;
+
+				ieee802_11_parse_elems(skb->head, skb->len, true, &elems,
+						       sdata->wdev.address, NULL);
+				if (!elems.parse_error)
+					goto out;
+
+				offs->multiple_bssid_offset = elems.multiple_bssid_offset;
+				offs->multiple_bssid_length = elems.multiple_bssid_len;
 			}
 
 			if (beacon->tail)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a7c4d6a44e21..bbe2f1d9166c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1311,6 +1311,10 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 								&crc : NULL,
 							  elem, elems);
 			break;
+		case WLAN_EID_MULTIPLE_BSSID:
+			elems->multiple_bssid_offset = pos - start;
+			elems->multiple_bssid_len = elen;
+			break;
 		default:
 			break;
 		}
-- 
2.20.1

