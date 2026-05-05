Return-Path: <linux-wireless+bounces-35938-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBUmNMUe+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35938-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C74D195B
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55E7430A14B2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE4492194;
	Tue,  5 May 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHL++Y0K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D3492507
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999371; cv=none; b=uZ8dTi9hEDifCiDGNY6p6dfnYSTyGc92bSmlUT0DDbCgg2AUlSLbK4NoYx3YRLhWJLlNZrNV+60mE6fqULHqd941WfbrlBK/G2+aFqFBeumZMdzJQpb697MLztFZoZ5Xe680PM86Ba0kO0Y1BT09PCzFw5li6ph9Qq4Ca5H5e54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999371; c=relaxed/simple;
	bh=+NhMWmf5oU+jj+agEV5iId5oNZ4SPvTJ2vNFNCqYhWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfrXXZFCtPGXL4MQsZDG8bQID02fvtod0SNtaOX/19JS15kiVSg8eNk7+hcl3/5xplpvLJH53UE5FE2hgh3ogpk0UQwW2nhANl5XOAyglKJssfikpKX5OdLND/8UoqUk6ZutVR8mEGMB7i1N/mVyHz9jZ0PMjevMT3ptkddH6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHL++Y0K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999370; x=1809535370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NhMWmf5oU+jj+agEV5iId5oNZ4SPvTJ2vNFNCqYhWU=;
  b=SHL++Y0Kk5jOWY+TsrBjg2QnP8/dMDdgnVj6ZRf6ga1WBu/10UyuxAKO
   IfbBqnOHitJQa1qwVxj1H7+l6siNKiF2sYF66ltEd5XWwblUXDlp+UM4+
   RgDVIJhXEzu5czfn0ih9hCZ16FXghvR8o9QDD+VKiIzDvPNCg8ykslidf
   MdbZHT5OSU3aJEyCB+SvQT2u+nDGECkABxcEab3crJAQWvK7SS2DrvywT
   zJ0SdZ2BjjBcSSl32gC7NsMXFyQV95NRce4h9s5LvStchS5X33qn2DmJo
   oiPo/1z6m9HBOamPKZRLzl7ppPk5LrWDAF01S1xbu/3L/eosPQrarjBf6
   A==;
X-CSE-ConnectionGUID: w3BgqF8oRHykiLn2K966CQ==
X-CSE-MsgGUID: V2wRRzoTSBmXt++Hlvlq4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898995"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898995"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:50 -0700
X-CSE-ConnectionGUID: S1uiwGMpRE+8Y3zuf/d5AQ==
X-CSE-MsgGUID: ejzGB0dlSlaGVQ2ePiKEwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206439"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 14/14] wifi: mac80211_hwsim: Support Tx of multicast data on NAN
Date: Tue,  5 May 2026 19:42:19 +0300
Message-Id: <20260505194007.bd349d102475.I3c2de3e456ae092c939e6bfd3d30960fbf2fbeaa@changeid>
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
X-Rspamd-Queue-Id: 676C74D195B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35938-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index f786694b2932..a4ec930d9b69 100644
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


