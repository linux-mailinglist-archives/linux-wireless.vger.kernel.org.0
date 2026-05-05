Return-Path: <linux-wireless+bounces-35928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COClJkAe+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4694D1885
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3F23061880
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590149250C;
	Tue,  5 May 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMXgW4/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B84921BB
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999359; cv=none; b=qJ7v6u3EwK5TrPNXaKT8+sNUjwsg1eg2VCzFjENFOpznNFmnKXMwR1G0RaktiTIFVyTN2IS80vDa/36wW6z6RpSvawkb2VuYi2WOhdwzig82p9GG/1kv8BEE8LxiFkM10zQttQ6ZAGbaOrZlpl88Y/SXf7g46yB3Dd34D4RWiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999359; c=relaxed/simple;
	bh=9rFk6sK8Bphu12Kf1flNLsOHh0IumDFoE23qdCHF/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6I5/W6ajPf3H9FoIJxR7kuFk9p3/yK/jUQDSLk6/NHMHD/KdjJKD0ETr6Y0mr/HbTl1y86smIlgiKPg0bJDG0mgcbeOrtO3qNGM1mJfYs2nMc+TPMcjPJsbkMDBQohboDgBMeXvFutj5yx4QtE7/qpZPuMuUmEjPdvCozjWrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMXgW4/m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999358; x=1809535358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rFk6sK8Bphu12Kf1flNLsOHh0IumDFoE23qdCHF/XM=;
  b=RMXgW4/mG9tJgyNg8TsjVVcZ8reOvShboimiS7H2geJz7dh2zrkq94/f
   R13V4p3qJHGgtXlsilbD/U6jajKSlLFTE7/6BC7f+6bXkimcdtD3Mm3F4
   qvqsDi6FOplHVFPfK/Yk34iUzQkpq/8PEyzdtU151Fr4HqcTpR/4Ioes4
   f6BILg/MwBgkcTpwmmW7RFRrNWFyPlIjuLq7goLv+0Ah7xh1anf3Mgj7B
   QKwWd4ft/FRd9MOoVHX1ve+40wN2CGaOG0oUZN9xeOz2lmr0dpSjTc+47
   GvrgfkvB4+yvuLSqSVkocs9xcYv7fYUTbnQpcLivSRE95wqikU4Ns5Y/M
   w==;
X-CSE-ConnectionGUID: 5jFxDr4nTmK/BVFkI+9gRA==
X-CSE-MsgGUID: 0ykk0UKwT5KMMWyBgSgzJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898969"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898969"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:37 -0700
X-CSE-ConnectionGUID: liw/eGPQRByiyC4RwtOrJA==
X-CSE-MsgGUID: g+Z5MAd0TTKQF0dek6QjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206374"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 04/14] wifi: mac80211_hwsim: protect tsf_offset using a spinlock
Date: Tue,  5 May 2026 19:42:09 +0300
Message-Id: <20260505194007.18f36f264eb9.I0da5477220b896e2177bd521f7d9a8f2595631e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E4694D1885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35928-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

To implement NAN synchronization in hwsim, the TSF needs to be adjusted
regularly from the RX path. Add a spinlock so that this can be done in a
safe manner.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  1 +
 .../wireless/virtual/mac80211_hwsim_main.c    | 34 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 5432de92beab..7a6495ea79e7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -102,6 +102,7 @@ struct mac80211_hwsim_data {
 	u32 wmediumd;
 
 	/* difference between this hw's clock and the real clock, in usecs */
+	spinlock_t tsf_offset_lock;
 	s64 tsf_offset;
 
 	/* Stats */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 76f1028bc42e..2de44c5fb1ff 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1256,13 +1256,17 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
 				       u64 tsf)
 {
-	return us_to_ktime(tsf - data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return us_to_ktime(tsf - data->tsf_offset);
+	}
 }
 
 u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 				   ktime_t ts)
 {
-	return ktime_to_us(ts + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return ktime_to_us(ts) + data->tsf_offset;
+	}
 }
 
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
@@ -1271,14 +1275,18 @@ u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return sim_time + data->tsf_offset;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return sim_time + data->tsf_offset;
+	}
 }
 
 static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
 {
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return cpu_to_le64(sim_time + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return cpu_to_le64(sim_time + data->tsf_offset);
+	}
 }
 
 static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
@@ -1293,11 +1301,13 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	if (conf && !conf->enable_beacon)
 		return;
 
-	/* adjust after beaconing with new timestamp at old TBTT */
-	if (tsf > now)
-		data->tsf_offset += delta;
-	else
-		data->tsf_offset -= delta;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		/* adjust after beaconing with new timestamp at old TBTT */
+		if (tsf > now)
+			data->tsf_offset += delta;
+		else
+			data->tsf_offset -= delta;
+	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
@@ -1577,6 +1587,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 	/* TODO: get MCS */
 	int bitrate = 100;
 
+	spin_lock_bh(&data->tsf_offset_lock);
+
 	txrate = ieee80211_get_tx_rate(data->hw, info);
 	if (txrate)
 		bitrate = txrate->bitrate;
@@ -1602,6 +1614,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 							  10 * 8 * 10 /
 							  bitrate);
 	}
+
+	spin_unlock_bh(&data->tsf_offset_lock);
 }
 
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
@@ -5664,6 +5678,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->wiphy->mbssid_max_interfaces = 8;
 	hw->wiphy->ema_max_profile_periodicity = 3;
 
+	spin_lock_init(&data->tsf_offset_lock);
+
 	data->rx_rssi = DEFAULT_RX_RSSI;
 
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
-- 
2.34.1


