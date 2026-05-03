Return-Path: <linux-wireless+bounces-35792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI3XHogO92mQbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C12264B5038
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68DF53003707
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64B27EFEE;
	Sun,  3 May 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFywAJpB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA830E835
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798778; cv=none; b=AAZdxwRB0nVyNjxdq/Z5OxL9G4GYEB3zqwXQIxGdG37IqoXq4f6NEKrG/+kLJVy1qfhYC3C2q0jvXnxmToTUqw88Q5sTJOEPd2IjkSEL16fp9G0Rso5/aQCiXZOe6o6NhlNGZxYvPJHvc+AEw1cDAF9f28T6qb0TQRuLn6OYxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798778; c=relaxed/simple;
	bh=OTpgdChdFLZFw2d4H6idhTZ6IVZ61nG5YAHP4DlLwAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbeOjzsdN3pr+D8+OTabq7E4O+Eg+5r6fi/8pnFcn3r6YOtpG2MFxWadN2Qpa2UDsy7YhDcCztfouvlkxmCQxMq7MhG1yqkfNSjgUHpyFVwZU4RDzi43p9gl4A4mcaM+PLlVPLfZfNaWdvAcp/ACCkt7dgE1iZW2zkUTvtSO6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFywAJpB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777798777; x=1809334777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTpgdChdFLZFw2d4H6idhTZ6IVZ61nG5YAHP4DlLwAM=;
  b=EFywAJpBTKsUK/RJpnJyCFTMH0FVFLwM7y160WJlAfnWEBs4rhHJl7JW
   dXzqiYUznYPq+0dwp6uYshynxONCiBnEb13QvMbXAB+2y7VNFUIphJODV
   J8NT06E/B6vuNFcB8obi7yTEyozlR5n734yhVrbvtchmHwqUZp+oSFRBo
   wkU0tNyvdwTB/2qFuxNa4LIM++7jfljsquSp5/4y0gkOKgVCTJpo7otyM
   kbdCKA1itw636hgyG/3YiZVVOcXcgNiXPblPRW8Y/nbGgwzy5wt1vaDfK
   FcrXSMWRqMG1EK9peaz/Z1/4bCLuOoJmparC0bA5Z5eXInhGbsO1w0cXm
   A==;
X-CSE-ConnectionGUID: w/uTa1bJR9SJekHPGskGtw==
X-CSE-MsgGUID: XcEghZONTSCKpV8v+XLqVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="89380415"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="89380415"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:36 -0700
X-CSE-ConnectionGUID: Jb2JzbzfR+eG30xkIWu8wA==
X-CSE-MsgGUID: 0WrsM6+DTvWdSvm95gduow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235123818"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 wireless-next 12/15] wifi: mac80211_hwsim: move timestamp writing later in the datapath
Date: Sun,  3 May 2026 11:59:04 +0300
Message-Id: <20260503115440.b2c16aa41f8b.I86810bbbf9b171acc6dbf07f9904ce1686b5167a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
References: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C12264B5038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35792-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Benjamin Berg <benjamin.berg@intel.com>

By delegating writing the timestamp into beacons and probe responses, we
can remove the abs_bcn_ts from the global data and still avoid any time
offset issues. This also seems conceptually closer to "real" hardware
where the timestamp will be written late in the TX path.

Move sending the SKB to the monitor interface to happen later, so that
the frame timestamp has the value filled in by mac80211_hwsim.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |   2 -
 .../wireless/virtual/mac80211_hwsim_main.c    | 110 ++++++++----------
 2 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 741eb08f8a85..b4d0a3869619 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -104,8 +104,6 @@ struct mac80211_hwsim_data {
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
 	s64 bcn_delta;
-	/* absolute beacon transmission time. Used to cover up "tx" delay. */
-	u64 abs_bcn_ts;
 
 	/* Stats */
 	u64 tx_pkts;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 3bda5532ab62..5bf6541498ec 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1523,6 +1523,43 @@ static inline u16 trans_tx_rate_flags_ieee2hwsim(struct ieee80211_tx_rate *rate)
 	return result;
 }
 
+static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
+				     struct sk_buff *skb, u64 sim_time)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_rate *txrate;
+	/* TODO: get MCS */
+	int bitrate = 100;
+
+	txrate = ieee80211_get_tx_rate(data->hw, info);
+	if (txrate)
+		bitrate = txrate->bitrate;
+
+	if (skb->len >= offsetofend(typeof(*mgmt), u.probe_resp.timestamp) &&
+	    ieee80211_is_probe_resp(hdr->frame_control)) {
+		mgmt->u.probe_resp.timestamp =
+			cpu_to_le64(sim_time + data->tsf_offset +
+				    24 * 8 * 10 / bitrate);
+	} else if (skb->len >= offsetofend(typeof(*mgmt), u.beacon.timestamp) &&
+		   ieee80211_is_beacon(mgmt->frame_control)) {
+		mgmt->u.beacon.timestamp = cpu_to_le64(sim_time +
+						       data->tsf_offset +
+						       24 * 8 * 10 /
+						       bitrate);
+	} else if (skb->len >= offsetofend(struct ieee80211_ext,
+					   u.s1g_beacon.timestamp) &&
+		   ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		struct ieee80211_ext *ext = (void *)mgmt;
+
+		ext->u.s1g_beacon.timestamp = cpu_to_le32(sim_time +
+							  data->tsf_offset +
+							  10 * 8 * 10 /
+							  bitrate);
+	}
+}
+
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 				       struct sk_buff *my_skb,
 				       int dst_portid,
@@ -1538,6 +1575,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	struct hwsim_tx_rate tx_attempts[IEEE80211_TX_MAX_RATES];
 	struct hwsim_tx_rate_flag tx_attempts_flags[IEEE80211_TX_MAX_RATES];
 	uintptr_t cookie;
+	u64 sim_tsf;
 
 	if (data->ps != PS_DISABLED)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -1550,6 +1588,9 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 		}
 	}
 
+	sim_tsf = mac80211_hwsim_get_sim_tsf();
+	mac80211_hwsim_write_tsf(data, my_skb, sim_tsf);
+
 	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (skb == NULL)
 		goto nla_put_failure;
@@ -1781,7 +1822,11 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_rx_status rx_status;
-	u64 sim_tsf;
+	u64 sim_tsf = mac80211_hwsim_get_sim_tsf();
+
+	mac80211_hwsim_write_tsf(data, skb, sim_tsf);
+
+	mac80211_hwsim_monitor_rx(hw, skb, chan);
 
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
@@ -1824,20 +1869,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	skb_ext_reset(skb);
 	nf_reset_ct(skb);
 
-	/*
-	 * Get absolute mactime here so all HWs RX at the "same time", and
-	 * absolute TX time for beacon mactime so the timestamp matches.
-	 * Giving beacons a different mactime than non-beacons looks messy, but
-	 * it helps the Toffset be exact and a ~10us mactime discrepancy
-	 * probably doesn't really matter.
-	 */
 	if (ieee80211_is_beacon(hdr->frame_control) ||
-	    ieee80211_is_probe_resp(hdr->frame_control)) {
+	    ieee80211_is_probe_resp(hdr->frame_control))
 		rx_status.boottime_ns = ktime_get_boottime_ns();
-		sim_tsf = data->abs_bcn_ts;
-	} else {
-		sim_tsf = mac80211_hwsim_get_sim_tsf();
-	}
 
 	/* Copy skb to all enabled radios that are on the current frequency */
 	spin_lock(&hwsim_radio_lock);
@@ -2137,27 +2171,6 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 	}
 
-	if (skb->len >= 24 + 8 &&
-	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		/* fake header transmission time */
-		struct ieee80211_mgmt *mgmt;
-		struct ieee80211_rate *txrate;
-		/* TODO: get MCS */
-		int bitrate = 100;
-		u64 ts;
-
-		mgmt = (struct ieee80211_mgmt *)skb->data;
-		txrate = ieee80211_get_tx_rate(hw, txi);
-		if (txrate)
-			bitrate = txrate->bitrate;
-		ts = mac80211_hwsim_get_sim_tsf();
-		mgmt->u.probe_resp.timestamp =
-			cpu_to_le64(ts + data->tsf_offset +
-				    24 * 8 * 10 / bitrate);
-	}
-
-	mac80211_hwsim_monitor_rx(hw, skb, channel);
-
 	/* wmediumd mode check */
 	_portid = READ_ONCE(data->wmediumd);
 
@@ -2291,8 +2304,6 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				       ARRAY_SIZE(txi->control.rates));
 	}
 
-	mac80211_hwsim_monitor_rx(hw, skb, chan);
-
 	if (_portid || hwsim_virtio_enabled)
 		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, chan);
 
@@ -2310,10 +2321,6 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct ieee80211_tx_info *info;
-	struct ieee80211_rate *txrate;
-	struct ieee80211_mgmt *mgmt;
-	/* TODO: get MCS */
-	int bitrate = 100;
 
 	if (vp->skip_beacons[link_conf->link_id]) {
 		vp->skip_beacons[link_conf->link_id]--;
@@ -2327,27 +2334,6 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 				       info->control.rates,
 				       ARRAY_SIZE(info->control.rates));
 
-	txrate = ieee80211_get_tx_rate(hw, info);
-	if (txrate)
-		bitrate = txrate->bitrate;
-
-	mgmt = (struct ieee80211_mgmt *) skb->data;
-	/* fake header transmission time */
-	data->abs_bcn_ts = mac80211_hwsim_get_sim_tsf();
-	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		struct ieee80211_ext *ext = (void *) mgmt;
-
-		ext->u.s1g_beacon.timestamp = cpu_to_le32(data->abs_bcn_ts +
-							  data->tsf_offset +
-							  10 * 8 * 10 /
-							  bitrate);
-	} else {
-		mgmt->u.beacon.timestamp = cpu_to_le64(data->abs_bcn_ts +
-						       data->tsf_offset +
-						       24 * 8 * 10 /
-						       bitrate);
-	}
-
 	mac80211_hwsim_tx_frame(hw, skb,
 			rcu_dereference(link_conf->chanctx_conf)->def.chan);
 }
@@ -6033,6 +6019,8 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	if (!found)
 		goto out;
 
+	mac80211_hwsim_monitor_rx(data2->hw, skb, data2->channel);
+
 	/* Tx info received because the frame was broadcasted on user space,
 	 so we get all the necessary info: tx attempts and skb control buff */
 
-- 
2.34.1


