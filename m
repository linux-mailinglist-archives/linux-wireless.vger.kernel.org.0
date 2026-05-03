Return-Path: <linux-wireless+bounces-35795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO3LJ40O92mQbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CE4B5046
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ADAD3006985
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07CB3AE18F;
	Sun,  3 May 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ3zxbAN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D23AE19B
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798781; cv=none; b=O6BQs1yGvr4BFelluCbpo7vNLK7kOYlKrTyeNetvtLuBv7C8B+EHCn2JB1yn88ULWRH3DI2x72AE/7VZ7E+HAq3iuk2J/cwYdbXnJaL1oM2S+jDkYcv6X5LWt8bd7UrGWMXppQwpkuTzctEMhnnJerO0131n+asyDCLU7GobDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798781; c=relaxed/simple;
	bh=mdmEgJNtLKlQOcjaaX/tyMcZMSYSgaFNlZyPsrNvBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3D5Os37gg1zac401b49phxL5IogwvFRiA5pViWS0c6JQbK7nm3vKROpv2HLXGHDfSoJh7CfawAQcfO8K81IaIgqsV+CwUsII96WW9mCJph7oet/xcCrJuDf5T9dOV/MmOjhG2W5/stcMM0NDbU76VKQtMrXf9ufICAzbjrB5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ3zxbAN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777798780; x=1809334780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdmEgJNtLKlQOcjaaX/tyMcZMSYSgaFNlZyPsrNvBN4=;
  b=dZ3zxbANmQOvE5CG57xSuKqYTmDtcnrUoAd2ltSOKUEKRTGnwRfsBoW7
   naXVTSPPgbPJ2fXotIGwe+iGLO769dgFlOz6Dx/A4ceZrrJnF9SuutuOW
   /kItbb5Uwk5qatJbGgexNvFbMT4M/QTd9tKDDw47YArZWvbTi+QIaDx+4
   YFSLHU8Lj6RrZ/raiimBZsn5FRimtHC+7Ebz4ApQL3kpK5sA8EmHRmVr9
   P9QLv7dvhKgX0/B6+Yxg2QbnWk7f0Q9sro06tlezPpKfYuCkVKnS1zIK2
   ASXQsBoZrA/6qRHzWI789qMEtBMkwdlnQV9k4mqnJGl9rWSTBnmin4dfW
   w==;
X-CSE-ConnectionGUID: VO3CmkD3Qee378cbr7ak1Q==
X-CSE-MsgGUID: S7OOKfZQTqycUXcXpfq+2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="89380423"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="89380423"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:40 -0700
X-CSE-ConnectionGUID: inSliYDsT5i11N/+F3Fk1A==
X-CSE-MsgGUID: b4CQZ6+TQXKkOkPVubnLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235123838"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 wireless-next 15/15] wifi: mac80211_hwsim: switch to use TXQs
Date: Sun,  3 May 2026 11:59:07 +0300
Message-Id: <20260503115440.03ef27f6ba5d.Id3e629770663c44de00faa3ff9bac9c6b87459c6@changeid>
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
X-Rspamd-Queue-Id: B12CE4B5046
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
	TAGGED_FROM(0.00)[bounces-35795-lists,linux-wireless=lfdr.de];
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

Simply immediately TX all available packets on the corresponding queue.

This removes the HWSIM_TM_CMD_STOP_QUEUES/HWSIM_TM_CMD_RESUME_QUEUES
feature for now. It should be reasonably simple to add it back if it is
needed.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index c6d1f841c04d..e510357c1411 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2198,6 +2198,17 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
+static void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
+					  struct ieee80211_txq *txq)
+{
+	struct ieee80211_tx_control control = {
+		.sta = txq->sta,
+	};
+	struct sk_buff *skb;
+
+	while ((skb = ieee80211_tx_dequeue(hw, txq)))
+		mac80211_hwsim_tx(hw, &control, skb);
+}
 
 static int mac80211_hwsim_start(struct ieee80211_hw *hw)
 {
@@ -2943,11 +2954,7 @@ static int mac80211_hwsim_testmode_cmd(struct ieee80211_hw *hw,
 			goto nla_put_failure;
 		return cfg80211_testmode_reply(skb);
 	case HWSIM_TM_CMD_STOP_QUEUES:
-		ieee80211_stop_queues(hw);
-		return 0;
 	case HWSIM_TM_CMD_WAKE_QUEUES:
-		ieee80211_wake_queues(hw);
-		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -4051,7 +4058,7 @@ static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
 
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
-	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
+	.wake_tx_queue = ieee80211_hwsim_wake_tx_queue,		\
 	.start = mac80211_hwsim_start,				\
 	.stop = mac80211_hwsim_stop,				\
 	.add_interface = mac80211_hwsim_add_interface,		\
@@ -5530,6 +5537,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, STRICT);
+	ieee80211_hw_set(hw, BUFF_MMPDU_TXQ);
+	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
 
 	if (param->mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
@@ -5588,6 +5597,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->vif_data_size = sizeof(struct hwsim_vif_priv);
 	hw->sta_data_size = sizeof(struct hwsim_sta_priv);
 	hw->chanctx_data_size = sizeof(struct hwsim_chanctx_priv);
+	hw->txq_data_size = 0;
 
 	memcpy(data->channels_2ghz, hwsim_channels_2ghz,
 		sizeof(hwsim_channels_2ghz));
-- 
2.34.1


