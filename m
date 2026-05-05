Return-Path: <linux-wireless+bounces-35926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHGYIzge+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD44D1873
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA29302AF3D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D894921B4;
	Tue,  5 May 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awtv+Jeu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAE38F23F
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999357; cv=none; b=EO/t54k99wPgZJ6v2313Jve59RIvaqNdCa8PCN3Q9+XSuGCbwKrAsXkxf+ZyqOCRS77f9JJR/qxihbLutLjo1TTv9SdS2dEu4UTIobSHIZt7XORQtUX9Voh/bHJhuLtUy/Ta8DiQVS51UE9fmhJrFjMDOVSeWwOCFi8rgTtxa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999357; c=relaxed/simple;
	bh=mWCjFnEtTRIJ7E6VkXi8bdx5HddtP1ejCNTrJqH02W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+FPiw1eqJ1tHPDAXkvwLGsV4Mw5j/vpRrj0BXiPKqBbY5SDwb0JkrjMnogWANHPLvTxHMmvvTS12zVL3uqKMf0KvOo0RZCoag9i/XfRaDIZklhevM5Asm8p24fTB8bSBS1HcWMUcAd9aoOZFN8PhDZthzFrgbGrrfsvBt2wHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awtv+Jeu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999355; x=1809535355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWCjFnEtTRIJ7E6VkXi8bdx5HddtP1ejCNTrJqH02W8=;
  b=awtv+JeuHT+jvfqWkjsBiKX7Kys8awClL9izwHUVhOPynaqV00amKUk7
   cDEPxPZr1RIpJ4E5XznKgo2/zMTxaYReJacKIZ61BUJaijbz511NA5fEe
   vIgJLe0Wb3ksTtVNK+q0T6/6apokLnZIC+oUAxUS9akixHpWqWMAECyhp
   5iMLr/Ce++5NmiflueRDhMD1IGK2tIQ+G2POQgKU3w1zSIFqgRJxAY/pc
   tvF6T/gsfvfrYk3kp+5qcA71G/y1pOicOf5syOk5+0+V3AWbcHl1AmR+o
   Tz39u4DCouB6dEylk2UCVMLJhZviN3phUe+tHAUn6moWXSplF8f4S6M1N
   A==;
X-CSE-ConnectionGUID: kLWriS9iS2erDREv/CtvyA==
X-CSE-MsgGUID: 0uGeB2naS96xzDs/64kurQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898963"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:35 -0700
X-CSE-ConnectionGUID: s8wTjVsaQra0+4aKHO5hQw==
X-CSE-MsgGUID: WVZaLNsUT4yOQYCrFmwbqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206357"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 02/14] wifi: mac80211_hwsim: select NAN TX channel based on current TSF
Date: Tue,  5 May 2026 19:42:07 +0300
Message-Id: <20260505194007.c235b5a78b98.I5ec4076a8a9445233dc414c6ecaa39f32f1e9595@changeid>
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
X-Rspamd-Queue-Id: 0BDD44D1873
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
	TAGGED_FROM(0.00)[bounces-35926-lists,linux-wireless=lfdr.de];
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

Move the TX channel selection into the NAN specific file and select the
channel based on the current slot.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c |  6 +-----
 .../net/wireless/virtual/mac80211_hwsim_nan.c  | 18 ++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h  |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 6740504b30e6..f0f6cb7fa894 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2084,11 +2084,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	hdr = (void *)skb->data;
 
 	if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
-		/* For NAN Device simulation purposes, assume that NAN is always
-		 * on channel 6 or channel 149, unless a ROC is in progress (for
-		 * USD use cases).
-		 */
-		channel = data->nan.channel;
+		channel = mac80211_hwsim_nan_get_tx_channel(hw);
 
 		if (WARN_ON(!channel)) {
 			ieee80211_free_txskb(hw, skb);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 22805c3723e6..10bbac9a4b55 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -310,3 +310,21 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 
 	return true;
 }
+
+struct ieee80211_channel *
+mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u64 tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+
+	if (slot == SLOT_24GHZ_DW)
+		return ieee80211_get_channel(hw->wiphy, 2437);
+
+	if (slot == SLOT_5GHZ_DW &&
+	    data->nan.bands & BIT(NL80211_BAND_5GHZ))
+		return ieee80211_get_channel(hw->wiphy, 5745);
+
+	/* drop frame and warn, NAN_CHAN_SWITCH_TIME_US should avoid races */
+	return NULL;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index 6a0780797273..796cc17d194e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -39,4 +39,7 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq);
 
+struct ieee80211_channel *
+mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.34.1


