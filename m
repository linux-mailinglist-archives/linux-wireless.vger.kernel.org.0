Return-Path: <linux-wireless+bounces-35609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCBvD6Lu8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:42:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9C493ABA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F72E308EA21
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CC3F2119;
	Wed, 29 Apr 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyDi5i6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30493F2108
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462879; cv=none; b=CBFkYQ70sufnlZeAvveKmmcUEahxQvAKLCy86OXb/jaVSHxSnnMnDzwBIYggYhLF05w+zMdgt8W0AfiSWETrFhrILE2IEQb/jTkZ+KDJotxgaM/QsIlw4UsSwprCdko2dNIfTGio/n1kKhMP8p8R9cEOyNeEF/MMr16Gdw+g8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462879; c=relaxed/simple;
	bh=stLQ4dRBv+D4NsJ9En5JoXHgpaUwgRQHUdTylFsByDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmBNt4pP1VB1X7e9iuZM8ytIPXr48ol9r7PRdCf6XcL+IJzOU/T2m2SAI8vMfFKgzixCjBCPkJ4zQqF7PIhn4131EG2TFYKj+IzLuQLhpm4IxqL1lCCFLHyXqZ9e4UUh7qvkWp8Lf6VlT2vv12ZdFNa0igq+ZXXTPwG1JlbeQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyDi5i6x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462878; x=1808998878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stLQ4dRBv+D4NsJ9En5JoXHgpaUwgRQHUdTylFsByDc=;
  b=UyDi5i6xeziUAuxJk/04h+WDzz0dj17UnnBYTY3dK+S+aS0PN0hNtD9Z
   qGffyGH7AvR6QxTMmQHpm4lrjJJXa8J8fOw/A519y4CkR+AcV/0huFFYk
   grvxER3gdQADPw3dEnsoYgBInBojCJ5tgNvVUBfkHX1zv6Il+g2BfjXIx
   uzvX+OupU35SPsr0cJOt7aAquzYrAa9hto0CPRgUk3+UT68HifOd/gH8C
   kac6uFZw2Ci+U2HiaHxkMbdQYHiNQXD8MO51wHqj990/d60FC3ZKlOObT
   XZq0tSLMpMzs7H3gDVUwPoMg6DrAwMfpbeDN5C93/T6+Z7znCa9V8rq6i
   Q==;
X-CSE-ConnectionGUID: k5Ba7RqfRSKgcrPyhpvvIQ==
X-CSE-MsgGUID: 2yn3qfyqTxqUgTDMyj18cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986129"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986129"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:18 -0700
X-CSE-ConnectionGUID: 4GFjtjhORCGBMUYZWgQpFQ==
X-CSE-MsgGUID: vWXawtVQQS2XzDycCFUkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505149"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 11/15] wifi: mac80211_hwsim: rename and switch simulation time to boottime
Date: Wed, 29 Apr 2026 14:40:45 +0300
Message-Id: <20260429143813.4a22a32e3036.I2ef047f3cdd6dc52af4bb7bf747368fb78014f18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
References: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4E9C493ABA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35609-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

The mac80211_hwsim base time for the simulation of the TSF was based on
the real time of the system. This clock is subject to unexpected
changes. Switch it to use boottime which is always monotonic and also
continues to run through times where the system is suspended.

Also change the function name from tsf_raw to sim_tsf to better
differentiate between the TSF of the mac and the TSF base of the
simulation.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 4ad2c6f38663..3bda5532ab62 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1211,22 +1211,25 @@ static netdev_tx_t hwsim_mon_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static inline u64 mac80211_hwsim_get_tsf_raw(void)
+static inline u64 mac80211_hwsim_get_sim_tsf(void)
 {
-	return ktime_to_us(ktime_get_real());
-}
-
-static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
-{
-	u64 now = mac80211_hwsim_get_tsf_raw();
-	return cpu_to_le64(now + data->tsf_offset);
+	return ktime_to_us(ktime_get_boottime());
 }
 
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	return le64_to_cpu(__mac80211_hwsim_get_tsf(data));
+	u64 sim_time = mac80211_hwsim_get_sim_tsf();
+
+	return sim_time + data->tsf_offset;
+}
+
+static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
+{
+	u64 sim_time = mac80211_hwsim_get_sim_tsf();
+
+	return cpu_to_le64(sim_time + data->tsf_offset);
 }
 
 static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
@@ -1778,7 +1781,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_rx_status rx_status;
-	u64 now;
+	u64 sim_tsf;
 
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
@@ -1831,9 +1834,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		rx_status.boottime_ns = ktime_get_boottime_ns();
-		now = data->abs_bcn_ts;
+		sim_tsf = data->abs_bcn_ts;
 	} else {
-		now = mac80211_hwsim_get_tsf_raw();
+		sim_tsf = mac80211_hwsim_get_sim_tsf();
 	}
 
 	/* Copy skb to all enabled radios that are on the current frequency */
@@ -1894,7 +1897,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		if (mac80211_hwsim_addr_match(data2, hdr->addr1))
 			ack = true;
 
-		rx_status.mactime = now + data2->tsf_offset;
+		rx_status.mactime = sim_tsf + data2->tsf_offset;
 
 		mac80211_hwsim_rx(data2, &rx_status, nskb);
 	}
@@ -2147,7 +2150,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		txrate = ieee80211_get_tx_rate(hw, txi);
 		if (txrate)
 			bitrate = txrate->bitrate;
-		ts = mac80211_hwsim_get_tsf_raw();
+		ts = mac80211_hwsim_get_sim_tsf();
 		mgmt->u.probe_resp.timestamp =
 			cpu_to_le64(ts + data->tsf_offset +
 				    24 * 8 * 10 / bitrate);
@@ -2330,7 +2333,7 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	/* fake header transmission time */
-	data->abs_bcn_ts = mac80211_hwsim_get_tsf_raw();
+	data->abs_bcn_ts = mac80211_hwsim_get_sim_tsf();
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		struct ieee80211_ext *ext = (void *) mgmt;
 
-- 
2.34.1


