Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908DB26D732
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIQIzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQIzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 04:55:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10742C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 01:55:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIpgs-005SMx-UX; Thu, 17 Sep 2020 10:54:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Tova Mussai <tova.mussai@intel.com>
Subject: [PATCH v2] nl80211/cfg80211: support 6 GHz scanning
Date:   Thu, 17 Sep 2020 10:54:50 +0200
Message-Id: <20200917105449.eb93c5df14ba.Ida22f0212f9122f47094d81659e879a50434a6a2@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Support 6 GHz scanning, by
 * a new scan flag to scan for colocated BSSes advertised
   by (and found) APs on 2.4 & 5 GHz
 * doing the necessary reduced neighbor report parsing for
   this, to find them
 * adding the ability to split the scan request in case the
   device by itself cannot support this.

Also add some necessary bits in mac80211 to not break with
these changes.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  29 ++-
 include/uapi/linux/nl80211.h |   3 +
 net/mac80211/scan.c          |   9 +-
 net/wireless/core.c          |   8 +-
 net/wireless/core.h          |   5 +-
 net/wireless/nl80211.c       |  11 +-
 net/wireless/scan.c          | 488 ++++++++++++++++++++++++++++++++++-
 7 files changed, 536 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c9bce9bba511..bb9afe9f9df1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2041,6 +2041,24 @@ struct cfg80211_scan_info {
 	bool aborted;
 };
 
+/**
+ * struct cfg80211_scan_6ghz_params - relevant for 6 GHz only
+ *
+ * @short_bssid: short ssid to scan for
+ * @bssid: bssid to scan for
+ * @channel_idx: idx of the channel in the channel array in the scan request
+ *	 which the above info relvant to
+ * @unsolicited_probe: the AP transmits unsolicited probe response every 20 TU
+ * @short_ssid_valid: short_ssid is valid and can be used
+ */
+struct cfg80211_scan_6ghz_params {
+	u32 short_ssid;
+	u32 channel_idx;
+	u8 bssid[ETH_ALEN];
+	bool unsolicited_probe;
+	bool short_ssid_valid;
+};
+
 /**
  * struct cfg80211_scan_request - scan request description
  *
@@ -2068,6 +2086,10 @@ struct cfg80211_scan_info {
  * @mac_addr_mask: MAC address mask used with randomisation, bits that
  *	are 0 in the mask should be randomised, bits that are 1 should
  *	be taken from the @mac_addr
+ * @scan_6ghz: relevant for split scan request only,
+ *	true if this is the second scan request
+ * @n_6ghz_params: number of 6 GHz params
+ * @scan_6ghz_params: 6 GHz params
  * @bssid: BSSID to scan for (most commonly, the wildcard BSSID)
  */
 struct cfg80211_scan_request {
@@ -2095,6 +2117,9 @@ struct cfg80211_scan_request {
 	struct cfg80211_scan_info info;
 	bool notified;
 	bool no_cck;
+	bool scan_6ghz;
+	u32 n_6ghz_params;
+	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
 
 	/* keep last */
 	struct ieee80211_channel *channels[];
@@ -4163,6 +4188,8 @@ struct cfg80211_ops {
 /**
  * enum wiphy_flags - wiphy capability flags
  *
+ * @WIPHY_FLAG_SPLIT_SCAN_6GHZ: if set to true, the scan request will be split
+ *	 into two, first for legacy bands and second for UHB.
  * @WIPHY_FLAG_NETNS_OK: if not set, do not allow changing the netns of this
  *	wiphy at all
  * @WIPHY_FLAG_PS_ON_BY_DEFAULT: if set to true, powersave will be enabled
@@ -4206,7 +4233,7 @@ struct cfg80211_ops {
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
 	/* use hole at 1 */
-	/* use hole at 2 */
+	WIPHY_FLAG_SPLIT_SCAN_6GHZ		= BIT(2),
 	WIPHY_FLAG_NETNS_OK			= BIT(3),
 	WIPHY_FLAG_PS_ON_BY_DEFAULT		= BIT(4),
 	WIPHY_FLAG_4ADDR_AP			= BIT(5),
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0584e0d349f0..b354564de93f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6024,6 +6024,8 @@ enum nl80211_timeout_reason {
  * @NL80211_SCAN_FLAG_FREQ_KHZ: report scan results with
  *	%NL80211_ATTR_SCAN_FREQ_KHZ. This also means
  *	%NL80211_ATTR_SCAN_FREQUENCIES will not be included.
+ * @NL80211_SCAN_FLAG_COLOCATED_6GHZ: scan for colocated APs reported by
+ *	2.4/5 GHz APs
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,
@@ -6040,6 +6042,7 @@ enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_RANDOM_SN				= 1<<11,
 	NL80211_SCAN_FLAG_MIN_PREQ_CONTENT			= 1<<12,
 	NL80211_SCAN_FLAG_FREQ_KHZ				= 1<<13,
+	NL80211_SCAN_FLAG_COLOCATED_6GHZ			= 1<<14,
 };
 
 /**
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5ac2785cdc7b..7361e1239bf2 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -712,6 +712,10 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 			req->duration_mandatory;
 
 		local->hw_scan_band = 0;
+		local->hw_scan_req->req.n_6ghz_params = req->n_6ghz_params;
+		local->hw_scan_req->req.scan_6ghz_params =
+			req->scan_6ghz_params;
+		local->hw_scan_req->req.scan_6ghz = req->scan_6ghz;
 
 		/*
 		 * After allocating local->hw_scan_req, we must
@@ -1124,7 +1128,8 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 		int max_n;
 
 		for (band = 0; band < NUM_NL80211_BANDS; band++) {
-			if (!local->hw.wiphy->bands[band])
+			if (!local->hw.wiphy->bands[band] ||
+			    band == NL80211_BAND_6GHZ)
 				continue;
 
 			max_n = local->hw.wiphy->bands[band]->n_channels;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 354b0ccbdc24..9f23923e8d29 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -236,7 +236,9 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 
 	if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
-		if (WARN_ON(!rdev->scan_req->notified))
+		if (WARN_ON(!rdev->scan_req->notified &&
+			    (!rdev->int_scan_req ||
+			     !rdev->int_scan_req->notified)))
 			rdev->scan_req->info.aborted = true;
 		___cfg80211_scan_done(rdev, false);
 	}
@@ -1336,7 +1338,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 	case NETDEV_DOWN:
 		cfg80211_update_iface_num(rdev, wdev->iftype, -1);
 		if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
-			if (WARN_ON(!rdev->scan_req->notified))
+			if (WARN_ON(!rdev->scan_req->notified &&
+				    (!rdev->int_scan_req ||
+				     !rdev->int_scan_req->notified)))
 				rdev->scan_req->info.aborted = true;
 			___cfg80211_scan_done(rdev, false);
 		}
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 2ebc2a66680d..e1ec9ac8e608 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -72,6 +72,7 @@ struct cfg80211_registered_device {
 	u32 bss_generation;
 	u32 bss_entries;
 	struct cfg80211_scan_request *scan_req; /* protected by RTNL */
+	struct cfg80211_scan_request *int_scan_req;
 	struct sk_buff *scan_msg;
 	struct list_head sched_scan_req_list;
 	time64_t suspend_at;
@@ -457,6 +458,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev);
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 				u32 center_freq_khz, u32 bw_khz);
 
+int cfg80211_scan(struct cfg80211_registered_device *rdev);
+
 extern struct work_struct cfg80211_disconnect_work;
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 52a35e788547..55ff3cfa035c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8117,7 +8117,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	request->scan_start = jiffies;
 
 	rdev->scan_req = request;
-	err = rdev_scan(rdev, request);
+	err = cfg80211_scan(rdev);
 
 	if (err)
 		goto out_free;
@@ -15399,6 +15399,7 @@ static int nl80211_add_scan_req(struct sk_buff *msg,
 	struct cfg80211_scan_request *req = rdev->scan_req;
 	struct nlattr *nest;
 	int i;
+	struct cfg80211_scan_info *info;
 
 	if (WARN_ON(!req))
 		return 0;
@@ -15442,11 +15443,13 @@ static int nl80211_add_scan_req(struct sk_buff *msg,
 	    nla_put_u32(msg, NL80211_ATTR_SCAN_FLAGS, req->flags))
 		goto nla_put_failure;
 
-	if (req->info.scan_start_tsf &&
+	info = rdev->int_scan_req ? &rdev->int_scan_req->info :
+		&rdev->scan_req->info;
+	if (info->scan_start_tsf &&
 	    (nla_put_u64_64bit(msg, NL80211_ATTR_SCAN_START_TIME_TSF,
-			       req->info.scan_start_tsf, NL80211_BSS_PAD) ||
+			       info->scan_start_tsf, NL80211_BSS_PAD) ||
 	     nla_put(msg, NL80211_ATTR_SCAN_START_TIME_TSF_BSSID, ETH_ALEN,
-		     req->info.tsf_bssid)))
+		     info->tsf_bssid)))
 		goto nla_put_failure;
 
 	return 0;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 84fc8ab16dd2..e7ded0a35748 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -14,6 +14,8 @@
 #include <linux/wireless.h>
 #include <linux/nl80211.h>
 #include <linux/etherdevice.h>
+#include <linux/crc32.h>
+#include <linux/bitfield.h>
 #include <net/arp.h>
 #include <net/cfg80211.h>
 #include <net/cfg80211-wext.h>
@@ -74,6 +76,42 @@ MODULE_PARM_DESC(bss_entries_limit,
 
 #define IEEE80211_SCAN_RESULT_EXPIRE	(30 * HZ)
 
+/**
+ * struct cfg80211_colocated_ap - colocated AP information
+ *
+ * @list: linked list to all colocated aPS
+ * @bssid: BSSID of the reported AP
+ * @ssid: SSID of the reported AP
+ * @ssid_len: length of the ssid
+ * @center_freq: frequency the reported AP is on
+ * @unsolicited_probe: the reported AP is part of an ESS, where all the APs
+ *	that operate in the same channel as the reported AP and that might be
+ *	detected by a STA receiving this frame, are transmitting unsolicited
+ *	Probe Response frames every 20 TUs
+ * @oct_recommended: OCT is recommended to exchange MMPDUs with the reported AP
+ * @same_ssid: the reported AP has the same SSID as the reporting AP
+ * @multi_bss: the reported AP is part of a multiple BSSID set
+ * @transmitted_bssid: the reported AP is the transmitting BSSID
+ * @colocated_ess: all the APs that share the same ESS as the reported AP are
+ *	colocated and can be discovered via legacy bands.
+ * @short_ssid_valid: short_ssid is valid and can be used
+ */
+struct cfg80211_colocated_ap {
+	struct list_head list;
+	u8 bssid[ETH_ALEN];
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	size_t ssid_len;
+	u32 short_ssid;
+	u32 center_freq;
+	u8 unsolicited_probe:1,
+	   oct_recommended:1,
+	   same_ssid:1,
+	   multi_bss:1,
+	   transmitted_bssid:1,
+	   colocated_ess:1,
+	   short_ssid_valid:1;
+};
+
 static void bss_free(struct cfg80211_internal_bss *bss)
 {
 	struct cfg80211_bss_ies *ies;
@@ -448,10 +486,421 @@ static bool cfg80211_bss_expire_oldest(struct cfg80211_registered_device *rdev)
 	return ret;
 }
 
+static u8 cfg80211_parse_bss_param(u8 data,
+				   struct cfg80211_colocated_ap *coloc_ap)
+{
+	coloc_ap->oct_recommended =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED);
+	coloc_ap->same_ssid =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_SAME_SSID);
+	coloc_ap->multi_bss =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID);
+	coloc_ap->transmitted_bssid =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_TRANSMITTED_BSSID);
+	coloc_ap->unsolicited_probe =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE);
+	coloc_ap->colocated_ess =
+		u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_COLOC_ESS);
+
+	return u8_get_bits(data, IEEE80211_RNR_TBTT_PARAMS_COLOC_AP);
+}
+
+static int cfg80211_calc_short_ssid(const struct cfg80211_bss_ies *ies,
+				    const struct element **elem, u32 *s_ssid)
+{
+
+	*elem = cfg80211_find_elem(WLAN_EID_SSID, ies->data, ies->len);
+	if (!*elem || (*elem)->datalen > IEEE80211_MAX_SSID_LEN)
+		return -EINVAL;
+
+	*s_ssid = ~crc32_le(~0, (*elem)->data, (*elem)->datalen);
+	return 0;
+}
+
+static void cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list)
+{
+	struct cfg80211_colocated_ap *ap, *tmp_ap;
+
+	list_for_each_entry_safe(ap, tmp_ap, coloc_ap_list, list) {
+		list_del(&ap->list);
+		kfree(ap);
+	}
+}
+
+static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
+				  const u8 *pos, u8 length,
+				  const struct element *ssid_elem,
+				  int s_ssid_tmp)
+{
+	/* skip the TBTT offset */
+	pos++;
+
+	memcpy(entry->bssid, pos, ETH_ALEN);
+	pos += ETH_ALEN;
+
+	if (length == IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM) {
+		memcpy(&entry->short_ssid, pos,
+		       sizeof(entry->short_ssid));
+		entry->short_ssid_valid = true;
+		pos += 4;
+	}
+
+	/* skip non colocated APs */
+	if (!cfg80211_parse_bss_param(*pos, entry))
+		return -EINVAL;
+	pos++;
+
+	if (length == IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM) {
+		/*
+		 * no information about the short ssid. Consider the entry valid
+		 * for now. It would later be dropped in case there are explicit
+		 * SSIDs that need to be matched
+		 */
+		if (!entry->same_ssid)
+			return 0;
+	}
+
+	if (entry->same_ssid) {
+		entry->short_ssid = s_ssid_tmp;
+		entry->short_ssid_valid = true;
+
+		/*
+		 * This is safe because we validate datalen in
+		 * cfg80211_parse_colocated_ap(), before calling this
+		 * function.
+		 */
+		memcpy(&entry->ssid, &ssid_elem->data,
+		       ssid_elem->datalen);
+		entry->ssid_len = ssid_elem->datalen;
+	}
+	return 0;
+}
+
+static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
+				       struct list_head *list)
+{
+	struct ieee80211_neighbor_ap_info *ap_info;
+	const struct element *elem, *ssid_elem;
+	const u8 *pos, *end;
+	u32 s_ssid_tmp;
+	int n_coloc = 0, ret;
+	LIST_HEAD(ap_list);
+
+	elem = cfg80211_find_elem(WLAN_EID_REDUCED_NEIGHBOR_REPORT, ies->data,
+				  ies->len);
+	if (!elem || elem->datalen > IEEE80211_MAX_SSID_LEN)
+		return 0;
+
+	pos = elem->data;
+	end = pos + elem->datalen;
+
+	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
+	if (ret)
+		return ret;
+
+	/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
+	while (pos + sizeof(*ap_info) <= end) {
+		enum nl80211_band band;
+		int freq;
+		u8 length, i, count;
+
+		ap_info = (void *)pos;
+		count = u8_get_bits(ap_info->tbtt_info_hdr,
+				    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
+		length = ap_info->tbtt_info_len;
+
+		pos += sizeof(*ap_info);
+
+		if (!ieee80211_operating_class_to_band(ap_info->op_class,
+						       &band))
+			break;
+
+		freq = ieee80211_channel_to_frequency(ap_info->channel, band);
+
+		if (end - pos < count * ap_info->tbtt_info_len)
+			break;
+
+		/*
+		 * TBTT info must include bss param + BSSID +
+		 * (short SSID or same_ssid bit to be set).
+		 * ignore other options, and move to the
+		 * next AP info
+		 */
+		if (band != NL80211_BAND_6GHZ ||
+		    (length != IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM &&
+		     length < IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM)) {
+			pos += count * ap_info->tbtt_info_len;
+			continue;
+		}
+
+		for (i = 0; i < count; i++) {
+			struct cfg80211_colocated_ap *entry;
+
+			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
+					GFP_ATOMIC);
+
+			if (!entry)
+				break;
+
+			entry->center_freq = freq;
+
+			if (!cfg80211_parse_ap_info(entry, pos, length,
+						    ssid_elem, s_ssid_tmp)) {
+				n_coloc++;
+				list_add_tail(&entry->list, &ap_list);
+			} else {
+				kfree(entry);
+			}
+
+			pos += ap_info->tbtt_info_len;
+		}
+	}
+
+	if (pos != end) {
+		cfg80211_free_coloc_ap_list(&ap_list);
+		return 0;
+	}
+
+	list_splice_tail(&ap_list, list);
+	return n_coloc;
+}
+
+static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
+					struct ieee80211_channel *chan,
+					bool add_to_6ghz)
+{
+	int i;
+	u32 n_channels = request->n_channels;
+	struct cfg80211_scan_6ghz_params *params =
+		&request->scan_6ghz_params[request->n_6ghz_params];
+
+	for (i = 0; i < n_channels; i++) {
+		if (request->channels[i] == chan) {
+			if (add_to_6ghz)
+				params->channel_idx = i;
+			return;
+		}
+	}
+
+	request->channels[n_channels] = chan;
+	if (add_to_6ghz)
+		request->scan_6ghz_params[request->n_6ghz_params].channel_idx =
+			n_channels;
+
+	request->n_channels++;
+}
+
+static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,
+				     struct cfg80211_scan_request *request)
+{
+	u8 i;
+	u32 s_ssid;
+
+	for (i = 0; i < request->n_ssids; i++) {
+		/* wildcard ssid in the scan request */
+		if (!request->ssids[i].ssid_len)
+			return true;
+
+		if (ap->ssid_len &&
+		    ap->ssid_len == request->ssids[i].ssid_len) {
+			if (!memcmp(request->ssids[i].ssid, ap->ssid,
+				    ap->ssid_len))
+				return true;
+		} else if (ap->short_ssid_valid) {
+			s_ssid = ~crc32_le(~0, request->ssids[i].ssid,
+					   request->ssids[i].ssid_len);
+
+			if (ap->short_ssid == s_ssid)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
+{
+	u8 i;
+	struct cfg80211_colocated_ap *ap;
+	int n_channels, count = 0, err;
+	struct cfg80211_scan_request *request, *rdev_req = rdev->scan_req;
+	LIST_HEAD(coloc_ap_list);
+	bool need_scan_psc;
+	const struct ieee80211_sband_iftype_data *iftd;
+
+	rdev_req->scan_6ghz = true;
+
+	if (!rdev->wiphy.bands[NL80211_BAND_6GHZ])
+		return -EOPNOTSUPP;
+
+	iftd = ieee80211_get_sband_iftype_data(rdev->wiphy.bands[NL80211_BAND_6GHZ],
+					       rdev_req->wdev->iftype);
+	if (!iftd || !iftd->he_cap.has_he)
+		return -EOPNOTSUPP;
+
+	n_channels = rdev->wiphy.bands[NL80211_BAND_6GHZ]->n_channels;
+
+	if (rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) {
+		struct cfg80211_internal_bss *intbss;
+
+		spin_lock_bh(&rdev->bss_lock);
+		list_for_each_entry(intbss, &rdev->bss_list, list) {
+			struct cfg80211_bss *res = &intbss->pub;
+
+			count += cfg80211_parse_colocated_ap(res->ies,
+							     &coloc_ap_list);
+		}
+		spin_unlock_bh(&rdev->bss_lock);
+	}
+
+	request = kzalloc(struct_size(request, channels, n_channels) +
+			  sizeof(*request->scan_6ghz_params) * count,
+			  GFP_KERNEL);
+	if (!request) {
+		cfg80211_free_coloc_ap_list(&coloc_ap_list);
+		return -ENOMEM;
+	}
+
+	*request = *rdev_req;
+	request->n_channels = 0;
+	request->scan_6ghz_params =
+		(void *)&request->channels[n_channels];
+
+	/*
+	 * PSC channels should not be scanned if all the reported co-located APs
+	 * are indicating that all APs in the same ESS are co-located
+	 */
+	if (count) {
+		need_scan_psc = false;
+
+		list_for_each_entry(ap, &coloc_ap_list, list) {
+			if (!ap->colocated_ess) {
+				need_scan_psc = true;
+				break;
+			}
+		}
+	} else {
+		need_scan_psc = true;
+	}
+
+	/*
+	 * add to the scan request the channels that need to be scanned
+	 * regardless of the collocated APs (PSC channels or all channels
+	 * in case that NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set)
+	 */
+	for (i = 0; i < rdev_req->n_channels; i++) {
+		if (rdev_req->channels[i]->band == NL80211_BAND_6GHZ &&
+		    ((need_scan_psc &&
+		      cfg80211_channel_is_psc(rdev_req->channels[i])) ||
+		     !(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))) {
+			cfg80211_scan_req_add_chan(request,
+						   rdev_req->channels[i],
+						   false);
+		}
+	}
+
+	if (!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))
+		goto skip;
+
+	list_for_each_entry(ap, &coloc_ap_list, list) {
+		bool found = false;
+		struct cfg80211_scan_6ghz_params *scan_6ghz_params =
+			&request->scan_6ghz_params[request->n_6ghz_params];
+		struct ieee80211_channel *chan =
+			ieee80211_get_channel(&rdev->wiphy, ap->center_freq);
+
+		if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		for (i = 0; i < rdev_req->n_channels; i++) {
+			if (rdev_req->channels[i] == chan)
+				found = true;
+		}
+
+		if (!found)
+			continue;
+
+		if (request->n_ssids > 0 &&
+		    !cfg80211_find_ssid_match(ap, request))
+			continue;
+
+		cfg80211_scan_req_add_chan(request, chan, true);
+		memcpy(scan_6ghz_params->bssid, ap->bssid, ETH_ALEN);
+		scan_6ghz_params->short_ssid = ap->short_ssid;
+		scan_6ghz_params->short_ssid_valid = ap->short_ssid_valid;
+		scan_6ghz_params->unsolicited_probe = ap->unsolicited_probe;
+		request->n_6ghz_params++;
+	}
+
+skip:
+	cfg80211_free_coloc_ap_list(&coloc_ap_list);
+
+	if (request->n_channels) {
+		struct cfg80211_scan_request *old = rdev->int_scan_req;
+
+		rdev->int_scan_req = request;
+
+		/*
+		 * If this scan follows a previous scan, save the scan start
+		 * info from the first part of the scan
+		 */
+		if (old)
+			rdev->int_scan_req->info = old->info;
+
+		err = rdev_scan(rdev, request);
+		if (err) {
+			rdev->int_scan_req = old;
+			kfree(request);
+		} else {
+			kfree(old);
+		}
+
+		return err;
+	}
+
+	kfree(request);
+	return -EINVAL;
+}
+
+int cfg80211_scan(struct cfg80211_registered_device *rdev)
+{
+	struct cfg80211_scan_request *request;
+	struct cfg80211_scan_request *rdev_req = rdev->scan_req;
+	u32 n_channels = 0, idx, i;
+
+	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ))
+		return rdev_scan(rdev, rdev_req);
+
+	for (i = 0; i < rdev_req->n_channels; i++) {
+		if (rdev_req->channels[i]->band != NL80211_BAND_6GHZ)
+			n_channels++;
+	}
+
+	if (!n_channels)
+		return cfg80211_scan_6ghz(rdev);
+
+	request = kzalloc(struct_size(request, channels, n_channels),
+			  GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+
+	*request = *rdev_req;
+	request->n_channels = n_channels;
+
+	for (i = idx = 0; i < rdev_req->n_channels; i++) {
+		if (rdev_req->channels[i]->band != NL80211_BAND_6GHZ)
+			request->channels[idx++] = rdev_req->channels[i];
+	}
+
+	rdev_req->scan_6ghz = false;
+	rdev->int_scan_req = request;
+	return rdev_scan(rdev, request);
+}
+
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 			   bool send_message)
 {
-	struct cfg80211_scan_request *request;
+	struct cfg80211_scan_request *request, *rdev_req;
 	struct wireless_dev *wdev;
 	struct sk_buff *msg;
 #ifdef CONFIG_CFG80211_WEXT
@@ -466,11 +915,18 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 		return;
 	}
 
-	request = rdev->scan_req;
-	if (!request)
+	rdev_req = rdev->scan_req;
+	if (!rdev_req)
 		return;
 
-	wdev = request->wdev;
+	wdev = rdev_req->wdev;
+	request = rdev->int_scan_req ? rdev->int_scan_req : rdev_req;
+
+	if (wdev_running(wdev) &&
+	    (rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ) &&
+	    !rdev_req->scan_6ghz && !request->info.aborted &&
+	    !cfg80211_scan_6ghz(rdev))
+		return;
 
 	/*
 	 * This must be before sending the other events!
@@ -501,8 +957,11 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	if (wdev->netdev)
 		dev_put(wdev->netdev);
 
+	kfree(rdev->int_scan_req);
+	rdev->int_scan_req = NULL;
+
+	kfree(rdev->scan_req);
 	rdev->scan_req = NULL;
-	kfree(request);
 
 	if (!send_message)
 		rdev->scan_msg = msg;
@@ -525,10 +984,25 @@ void __cfg80211_scan_done(struct work_struct *wk)
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
 			struct cfg80211_scan_info *info)
 {
+	struct cfg80211_scan_info old_info = request->info;
+
 	trace_cfg80211_scan_done(request, info);
-	WARN_ON(request != wiphy_to_rdev(request->wiphy)->scan_req);
+	WARN_ON(request != wiphy_to_rdev(request->wiphy)->scan_req &&
+		request != wiphy_to_rdev(request->wiphy)->int_scan_req);
 
 	request->info = *info;
+
+	/*
+	 * In case the scan is split, the scan_start_tsf and tsf_bssid should
+	 * be of the first part. In such a case old_info.scan_start_tsf should
+	 * be non zero.
+	 */
+	if (request->scan_6ghz && old_info.scan_start_tsf) {
+		request->info.scan_start_tsf = old_info.scan_start_tsf;
+		memcpy(request->info.tsf_bssid, old_info.tsf_bssid,
+		       sizeof(request->info.tsf_bssid));
+	}
+
 	request->notified = true;
 	queue_work(cfg80211_wq, &wiphy_to_rdev(request->wiphy)->scan_done_wk);
 }
-- 
2.26.2

