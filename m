Return-Path: <linux-wireless+bounces-36252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLfPM9UaAmofoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133751413D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A97131E8A81
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0C4657C8;
	Mon, 11 May 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbTaGm1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41146AF1A
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521025; cv=none; b=fvtSii5dCOCl2UvFaOdwo+OJCLMtbqH0TXDN99I2ljAXBKtK0S0ycuuuWsMLW54Jy7GuYpBYFVGYxHNdgoJ6v9D3ckzMXUzWnE8j8sAnrFdg70AuU1me7QAqyxsJv9QbHuyNYnOjlBHPwI6I3Ct+seE2PdlCL6rAk8paymT6lTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521025; c=relaxed/simple;
	bh=y0sobE/aSisDiEmtqon+dKwHCupSqkybIVTFjrhqe+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyoQyM2KlQQDXSnGALbYtzNmYbm9RofOaJIldJVvIvjlZ0mDV9BihEDRdKSPBW7PVaEo/BkqJIIdnL5tnFw2S7p5tKIqDyAwtuXyokoYjfFYAGvo5HqNhef+3iU0VGXtA+fmwu0/gyVQPDw2VG9Ob86JFMC3RVOyE+K4g6Nn0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbTaGm1e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521025; x=1810057025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0sobE/aSisDiEmtqon+dKwHCupSqkybIVTFjrhqe+U=;
  b=gbTaGm1e5zkUVE+90s/kzJPzf7Fu8dGdKSW7ICjuRsEM1PXq8wtuCPaM
   0CE+RBuOTWVjnKbzeC1EtwZrKV0kJJcRBDnYDUoq2QdkKplVIqLUJlUNe
   2u3KOjOVBd+DMhnfCcidKtP3ZkyaQw+NduIDTpVZIYl1WhJHAqA1LQVN3
   wt/Ly2p8KSU6JDsEfuLBTPTmOVoJHrrSniXVXWn7mVDzZaDAbfRbdm+li
   0MJM2K9qRcd5JcFUfiwIAopK2uCYxU5ERiSMdqpXUZ6M/Pq/hBHoe+Dku
   ldqoHswmFLismvNp6/V77+0Dum8qahmc6mhMU4jz3g/t/gBC+Xnqxmblz
   g==;
X-CSE-ConnectionGUID: 2WKFqV4/SZai4Sh5UDudgw==
X-CSE-MsgGUID: v21V5iuFT9W+jeyZgQUZSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314848"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:04 -0700
X-CSE-ConnectionGUID: NUnwzFEgQSuHBfnFzic7vg==
X-CSE-MsgGUID: 7DJ5vHcVTseI2MBQ8os4jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004949"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: don't report bad STA ID in EHT TB sniffer
Date: Mon, 11 May 2026 20:36:27 +0300
Message-Id: <20260511203428.b23984f12a46.Ia25014392129d5815facaacec78ea8ba7f35d9a0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3133751413D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36252-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The field being reported here is part of the EHT union, and not
valid in EHT TB. Don't report it there. We could probably report
the station ID we're following, but for now just don't, since it
appears nobody really cared.

Fixes: 92e87cee465c ("wifi: iwlwifi: mld: update to new sniffer API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index b270cf87824d..a9f08f984633 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1206,6 +1206,13 @@ static void iwl_mld_decode_eht_non_tb(struct iwl_mld_rx_phy_data *phy_data,
 	iwl_mld_eht_set_ru_alloc(rx_status,
 				 le32_get_bits(phy_data->ntfy->sigs.eht.b2,
 					       OFDM_RX_FRAME_EHT_STA_RU));
+
+	if (phy_data->with_data)
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN) |
+			LE32_DEC_ENC(phy_data->ntfy->sigs.eht.user_id,
+				     OFDM_RX_FRAME_EHT_USER_FIELD_ID,
+				     IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID);
 }
 
 static void iwl_mld_decode_eht_phy_data(struct iwl_mld_rx_phy_data *phy_data,
@@ -1314,14 +1321,6 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 	if (likely(!phy_data->ntfy))
 		return;
 
-	if (phy_data->with_data) {
-		eht->user_info[0] |=
-			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN) |
-			LE32_DEC_ENC(phy_data->ntfy->sigs.eht.user_id,
-				     OFDM_RX_FRAME_EHT_USER_FIELD_ID,
-				     IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID);
-	}
-
 	iwl_mld_decode_eht_usig(phy_data, skb);
 	iwl_mld_decode_eht_phy_data(phy_data, rx_status, eht);
 }
-- 
2.34.1


