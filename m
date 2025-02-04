Return-Path: <linux-wireless+bounces-18448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EEA278D7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71516165F04
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C093C2165FA;
	Tue,  4 Feb 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOp+rSPt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5602165E8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691010; cv=none; b=Y63REXw9nXXiMC6JHCQJmFYCJUa90Uak5R6q6tsXvGHmDlUIx7PzUv53X+/GzSRRFN1i8jgq5M2c0Q5JWDwzDEYZDH1qHWoO06IVOVGGByvjY47YaDL/qt3MJ1SB5rxlIZECSnAdORI1/euTXHN9DM6uiDKNOOpg7xXXOOE8pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691010; c=relaxed/simple;
	bh=Mphq9/KDK896zJ8hNfHQyvVymAB4kyT5mYSfotZ6U2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnZ0lownG+7mLmCBgKMHZ16SRGz1XKplzMjMxQhcb4d+rQsUBj4FhAvW2SbcitkRP9HgmGrVOfUOGhDXWUFyu2l0TN6i0u7pLtLS3InBL7shsEW3S2fHBEb6gIyKwYS4UpBkDnHQvcT9BXRn2hT6u7AednHy/QHOcoiqrLEPnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOp+rSPt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691009; x=1770227009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mphq9/KDK896zJ8hNfHQyvVymAB4kyT5mYSfotZ6U2Q=;
  b=FOp+rSPto3awqV08pk8Nlm6EW+MwkE2BuxQSzI1AEQ/5ouclY8BgygVy
   lR0FAoiHVesh2mtU19lUWqpnIbPiS7w8p8amc8xN/ENs4Z9BWoxt409Fi
   1Qx/Cxbba/E8OM8Q7D2Vx9ASlTVRCtQdZNl5W6emd/vTan8t2O5yPDWXl
   fe0mPL6fJvPkctXpKJK224pdL4ubxqtrm5lwxC7PVb8GQIOf4PHFDisTT
   dyeEtK95cnnCf8m0/i/SWc5vDu8l/rHrFLnnrZHtYK/02q4OGsuOAik/0
   cfPaZYPItN4YJEBNzrTZZATLbk/iLDkbP2KgRwybkPaFoVppExQoS56mJ
   Q==;
X-CSE-ConnectionGUID: D/sdaWyoRzinxuvB2aJEbQ==
X-CSE-MsgGUID: z7Xio+00Qv26d3jGNiDyfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585409"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585409"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:47 -0800
X-CSE-ConnectionGUID: OpfYSQLzTZGMn4VYlMEVFg==
X-CSE-MsgGUID: f+ecYP7KTXGL1i0xWE5OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696749"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 08/20] wifi: mac80211: add strict mode disabling workarounds
Date: Tue,  4 Feb 2025 19:42:05 +0200
Message-Id: <20250204193721.5f523513d171.I4a69617dc60ba0d6308416ffbc3102cfd08ba068@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a strict mode where we disable certain workarounds and have
additional checks such as, for now, that VHT capabilities from
association response match those from beacon/probe response. We
can extend the checks in the future.

Make it an opt-in setting by the driver so it can be set there
in some driver-specific way, for example. Also allow setting
this one hw flag through the hwflags debugfs, by writing a new
strict=0 or strict=1 value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/debugfs.c | 44 +++++++++++++++++++++++++++++++++++++++--
 net/mac80211/mlme.c    | 45 +++++++++++++++++++++++++++++-------------
 3 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a3a0de4a5d63..398d4e30b0db 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2852,6 +2852,11 @@ struct ieee80211_txq {
  *	implements MLO, so operation can continue on other links when one
  *	link is switching.
  *
+ * @IEEE80211_HW_STRICT: strictly enforce certain things mandated by the spec
+ *	but otherwise ignored/worked around for interoperability. This is a
+ *	HW flag so drivers can opt in according to their own control, e.g. in
+ *	testing.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2912,6 +2917,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
+	IEEE80211_HW_STRICT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index bf0a2902d93c..69e03630f64c 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -492,6 +492,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DISALLOW_PUNCTURING),
 	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
+	FLAG(STRICT),
 #undef FLAG
 };
 
@@ -524,6 +525,46 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 	return rv;
 }
 
+static ssize_t hwflags_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[100];
+	int val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (sscanf(buf, "strict=%d", &val) == 1) {
+		switch (val) {
+		case 0:
+			ieee80211_hw_set(&local->hw, STRICT);
+			return count;
+		case 1:
+			__clear_bit(IEEE80211_HW_STRICT, local->hw.flags);
+			return count;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations hwflags_ops = {
+	.open = simple_open,
+	.read = hwflags_read,
+	.write = hwflags_write,
+};
+
 static ssize_t misc_read(struct file *file, char __user *user_buf,
 			 size_t count, loff_t *ppos)
 {
@@ -574,7 +615,6 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
 }
 
-DEBUGFS_READONLY_FILE_OPS(hwflags);
 DEBUGFS_READONLY_FILE_OPS(queues);
 DEBUGFS_READONLY_FILE_OPS(misc);
 
@@ -651,7 +691,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 #ifdef CONFIG_PM
 	DEBUGFS_ADD_MODE(reset, 0200);
 #endif
-	DEBUGFS_ADD(hwflags);
+	DEBUGFS_ADD_MODE(hwflags, 0600);
 	DEBUGFS_ADD(user_power);
 	DEBUGFS_ADD(power);
 	DEBUGFS_ADD(hw_conf);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ca5eaa0bd6ed..704fb0369cde 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -168,6 +168,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	bool no_vht = false;
 	u32 ht_cfreq;
 
+	if (ieee80211_hw_check(&sdata->local->hw, STRICT))
+		ignore_ht_channel_mismatch = false;
+
 	*chandef = (struct cfg80211_chan_def) {
 		.chan = channel,
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
@@ -388,7 +391,7 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* make sure the AP is consistent with itself
@@ -448,7 +451,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* Need to go over for 80MHz, 160MHz and for 80+80 */
@@ -1313,13 +1316,15 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	 * Some APs apparently get confused if our capabilities are better
 	 * than theirs, so restrict what we advertise in the assoc request.
 	 */
-	if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
-		cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-			 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	else if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
-		cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	if (!ieee80211_hw_check(&local->hw, STRICT)) {
+		if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
+			cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+				 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+		else if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
+			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	}
 
 	/*
 	 * If some other vif is using the MU-MIMO capability we cannot associate
@@ -1361,14 +1366,16 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-static void ieee80211_assoc_add_rates(struct sk_buff *skb,
+static void ieee80211_assoc_add_rates(struct ieee80211_local *local,
+				      struct sk_buff *skb,
 				      enum nl80211_chan_width width,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	u32 rates;
 
-	if (assoc_data->supp_rates_len) {
+	if (assoc_data->supp_rates_len &&
+	    !ieee80211_hw_check(&local->hw, STRICT)) {
 		/*
 		 * Get all rates supported by the device and the AP as
 		 * some APs don't like getting a superset of their rates
@@ -1584,7 +1591,7 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		*capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
 
 	if (sband->band != NL80211_BAND_S1GHZ)
-		ieee80211_assoc_add_rates(skb, width, sband, assoc_data);
+		ieee80211_assoc_add_rates(local, skb, width, sband, assoc_data);
 
 	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    *capab & WLAN_CAPABILITY_RADIO_MEASURE) {
@@ -2051,7 +2058,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	 * for some reason check it and want it to be set, set the bit for all
 	 * pre-EHT connections as we used to do.
 	 */
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT)
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT &&
+	    !ieee80211_hw_check(&local->hw, STRICT))
 		capab |= WLAN_CAPABILITY_ESS;
 
 	/* add the elements for the assoc (main) link */
@@ -5029,7 +5037,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if (!is_6ghz &&
+	if (!ieee80211_hw_check(&local->hw, STRICT) && !is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
@@ -5165,6 +5173,15 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				bss_vht_cap = (const void *)elem->data;
 		}
 
+		if (ieee80211_hw_check(&local->hw, STRICT) &&
+		    (!bss_vht_cap || memcmp(bss_vht_cap, elems->vht_cap_elem,
+					    sizeof(*bss_vht_cap)))) {
+			rcu_read_unlock();
+			ret = false;
+			link_info(link, "VHT capabilities mismatch\n");
+			goto out;
+		}
+
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
-- 
2.34.1


