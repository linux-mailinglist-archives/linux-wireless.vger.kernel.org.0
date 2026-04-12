Return-Path: <linux-wireless+bounces-34665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMYJNRWM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E93E3BCA
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34554300644C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F137BE8C;
	Sun, 12 Apr 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+ZD8Xqo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AF37BE6A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995913; cv=none; b=uFYmMDEDRgM1MRXIWGk6BDCjqHmameJXmdjg+8GLkDixI8ZLZjb5M21PiRWjkG+H2WlTAnGUAA8dUa0B8UvbnyBYP8ePaxyDduAiN0efbwjhC8FDqFJe9krj/O2P+1UZl173Q1cw3RsvUR0KW6z4b7oa0c7EL/RReCO41cldf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995913; c=relaxed/simple;
	bh=stLQ4dRBv+D4NsJ9En5JoXHgpaUwgRQHUdTylFsByDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDI/0gYQ1bxKT8LwjCxXneplt8D51DoFbPFBpxZtYyN8jEQSnWDlNtOWvCxKA+nmJuogSXGoJMxw1CQ2/esiQmpIjl8VQ6gnP4KkR7gii6wGxSk/I4xsGmbnYe8F8P3DxJSTrbO+GKXgxFnVaOEpANjbmNvY4/fnVrwGs0Jy4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+ZD8Xqo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995912; x=1807531912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stLQ4dRBv+D4NsJ9En5JoXHgpaUwgRQHUdTylFsByDc=;
  b=k+ZD8XqoHJYY2IYW5To5afWnMwP1OYg1IQPV98zMTw0Od5mTISY+R5My
   uV1G23ZMJ5ykaocqAMLuWfyEQ3dv1a1k6Lf1b9Gs4ZjsaEYzeHyfQh71E
   R3MPfMzixI2BQjw5os7m67MIbJlt4dtp+oViUkHPjI7UghBTkdknTDHJQ
   mpY53znOsRUrrHAR1kVbd4RnSJjBi9LvXrS8tSEyyURc5bfRQB5hl5mQz
   1cYG9Ds41azKyfwbckcGYzJlRZZTgsVbzwoXYQlX8en9Q1r0V7NpMHlJG
   L9xDUz3lRIini1MV60SMxMdaSNAcmx8pNCiXpJsFNxdm4f/DGiw9C4WMI
   A==;
X-CSE-ConnectionGUID: naduiFFTSguy+HOZeaMHvA==
X-CSE-MsgGUID: 0Dn0yjLPRzy6gRqPCUInGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028473"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:52 -0700
X-CSE-ConnectionGUID: eMr+GKWoTZuT7Y8PtTICzw==
X-CSE-MsgGUID: cKz7+fv7Tp6Nvi+Javp5Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411933"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: mac80211_hwsim: rename and switch simulation time to boottime
Date: Sun, 12 Apr 2026 15:11:20 +0300
Message-Id: <20260412150826.19116e5847ed.I2ef047f3cdd6dc52af4bb7bf747368fb78014f18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34665-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 801E93E3BCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


