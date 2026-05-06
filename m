Return-Path: <linux-wireless+bounces-35980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE0tF5G5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:46:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D48384D5FCF
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD21F303A8F3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890652D838E;
	Wed,  6 May 2026 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yf/PGzlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9F2D63E8
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039106; cv=none; b=RCLegQcowN8YGM41nPHB4yxZNAMPmGaNNEGuMzu970CZNu4F4i4VOKph9WFIVc+PfbLPvcyVkxeSdunqycKDiPOHJ6DepqGQ2Edt/HlPb5LsmWFwbt/2F9DNHBBDRBhY12VmgNWF75ERkmjCREfiD3DlN0C4uhKpYCRawLZZjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039106; c=relaxed/simple;
	bh=8UsSbLcMgqZ8GRJ11B0ER3gnTLL36tyucOBc7ukIZIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UV6SZHPJD7TekPyKeT+puhRJ0RfaVfbu3dc27CCdz0iodgt3cFjCO6WcUpEZ1JT4c5d0JTvpW5z9v+Z8LPOA1lDLLoYDA4JnQwoFaaV4iEwEaP9ZjjPodqOpkaPnlFtldpwi/Qn/ebtClLGHagX5R8SVPsrsVJD5IeWiIL98Mlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yf/PGzlT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039105; x=1809575105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UsSbLcMgqZ8GRJ11B0ER3gnTLL36tyucOBc7ukIZIw=;
  b=Yf/PGzlTC55OXPoA3GLaDFXhFM56cRFYWg3OTNYBakgmC6BrNeU/p0a8
   6MpZTrqUHLWm02gkRBK9m6gPy7Jh2BWVjQ3Z1ABDmtJwwBO2VumDia07a
   Bqwityt6rapJ42WKi8KNOkdXxn/TKD5IaB3XJwwcspipjTdD6oEl8TyPJ
   Ledgsp/vRIIhJzN+QUj+4PnqtId9En0QAYhgrPVjiD2DQcCLd42AgfZDM
   5GxQXBqZqJwycxhFnvFMC/kzdmhgwMy6igEm6LtHKoxVp20cX0ah+15cC
   lqE/TGmGs6+nddJ7Q/TFOcIsvyvA0pPHmfL+oqRjsqi8zNOk4rpUEgdbD
   Q==;
X-CSE-ConnectionGUID: UeybWZG5TiKXnoBv2KODNA==
X-CSE-MsgGUID: iF7jsfYaSqKw9FjeaTA/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791308"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791308"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:45:05 -0700
X-CSE-ConnectionGUID: X4rjXeHOTu6kuPXFCLmqIg==
X-CSE-MsgGUID: 1Nt9iFo5Ruq5N/f/MPkUgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777935"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:45:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 14/14] wifi: mac80211_hwsim: Support Tx of multicast data on NAN
Date: Wed,  6 May 2026 06:44:33 +0300
Message-Id: <20260506064301.0af7e24f0df3.I3c2de3e456ae092c939e6bfd3d30960fbf2fbeaa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
References: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D48384D5FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35980-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Ilan Peer <ilan.peer@intel.com>

Add support for transmitting multicast data frames. These
frames can be transmitted when all the peer NDI stations
on the interface are available at the current slot.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 56 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 0397c43724fe..7be64c45babf 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -41,6 +41,13 @@ struct hwsim_nan_sta_iter_ctx {
 	bool can_tx;
 };
 
+struct hwsim_nan_mcast_data_iter_ctx {
+	struct ieee80211_hw *hw;
+	struct ieee80211_vif *vif;
+	size_t n_vif_sta;
+	size_t n_sta_can_tx;
+};
+
 static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data);
 
 static u64 hwsim_nan_get_timer_tsf(struct mac80211_hwsim_data *data)
@@ -1103,6 +1110,42 @@ mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static void
+hwsim_nan_can_mcast_sta_transmit(void *_ctx, struct ieee80211_sta *sta)
+{
+	struct hwsim_nan_mcast_data_iter_ctx *ctx = _ctx;
+	struct ieee80211_txq *txq = sta->txq[0];
+
+	if (!txq || txq->vif != ctx->vif)
+		return;
+
+	ctx->n_vif_sta++;
+	if (mac80211_hwsim_nan_txq_transmitting(ctx->hw, txq))
+		ctx->n_sta_can_tx++;
+}
+
+static bool
+mac80211_hwsim_nan_mcast_data_transmitting(struct ieee80211_hw *hw,
+					   struct ieee80211_txq *txq)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	struct hwsim_nan_mcast_data_iter_ctx ctx = {
+		.hw = hw,
+		.vif = txq->vif,
+		.n_sta_can_tx = 0,
+		.n_vif_sta = 0,
+	};
+
+	/* Check if all the stations associated with the current
+	 * interface are available.
+	 */
+	ieee80211_iterate_stations_atomic(data->hw,
+					  hwsim_nan_can_mcast_sta_transmit,
+					  &ctx);
+
+	return ctx.n_vif_sta && ctx.n_sta_can_tx == ctx.n_vif_sta;
+}
+
 bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq)
 {
@@ -1125,9 +1168,16 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 
 	is_dw_slot = mac80211_hwsim_nan_is_dw_slot(data, slot);
 
-	/* Non-STA TXQ: allow management frames during DW */
-	if (!txq->sta)
-		return is_dw_slot;
+	if (!txq->sta) {
+		/* Non-STA TXQ: allow management frames during DW */
+		if (txq->vif->type == NL80211_IFTYPE_NAN)
+			return is_dw_slot;
+
+		/* Allow multicast data when all the peers are available
+		 * on this slot
+		 */
+		return mac80211_hwsim_nan_mcast_data_transmitting(hw, txq);
+	}
 
 	/* STA TXQ: need peer schedule for availability check */
 	nmi_sta = rcu_dereference(txq->sta->nmi) ?: txq->sta;
-- 
2.34.1


