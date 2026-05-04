Return-Path: <linux-wireless+bounces-35821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF6OKA1J+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C94B946A
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49FD6300D6BF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0702DECCC;
	Mon,  4 May 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFWyOkku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADE2DBF76
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879294; cv=none; b=RSshlSohE7BwJvCUFXrHWsGjkuKd3E04+6VvpjXdHp/E/VlxEwD4sQqmVtu3G06+SDOBiMzve8WjdG/BRPZQAjh/mGDtOfshZPA+nxC42IDmvKchRWvS9o7acvzKQlVojViIOM5ssxz+F2qQHDo8Vwglg4whQLh74qSL8uRrYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879294; c=relaxed/simple;
	bh=mdmEgJNtLKlQOcjaaX/tyMcZMSYSgaFNlZyPsrNvBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlbcKytG4W62bjtmqnD010pw4bzLR1TlsrynSKe0w+AKLH5fUg5aS8s/ix3oH6vHjOLVpevngdphUudD+VNadeY6M1W8fk9FEVILt+/UREBMLm+NP6qelGGngj2sSWPVDjv/GbApcXNu7iZhV3LVAphckK7qmw5wtrk6vFo2kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFWyOkku; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879290; x=1809415290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdmEgJNtLKlQOcjaaX/tyMcZMSYSgaFNlZyPsrNvBN4=;
  b=IFWyOkkuCOxS0+PlgOmFs5bkGRssdrbIzycgBS+KVCUhXx0SppJTClkB
   mdXMqxkr071eaCRxMOefoB8Rp1rVsNRzTgNVp+sbLSTm6rctxBCgYPW7O
   Kmx4dRGvO24yCt1Zj5uNP7DmmFMwCnUiIxTgeNBaY26ER59rp4YX1DLZi
   Hld4eeMZwkGWEd1bTpAi5Exag7hZGdr8TCG9j1JADgexJcbtQeZIaw5S8
   GWT9825nWHk/cEi+6H+QLY/deXK04de9trmdtdywqhBFmzP5rB3xQnAwE
   nykG3PV8QbqyOeVDG6PsWs6tIGxUcCEbQIYizG1MxfO1r1neGe8sOrB0z
   Q==;
X-CSE-ConnectionGUID: LwJaM718Tqm8W/92KtziUw==
X-CSE-MsgGUID: jLPAA+2WQrWtWT8RklNh0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398337"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398337"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:28 -0700
X-CSE-ConnectionGUID: vrnXVURnRZeRODt2BsftBg==
X-CSE-MsgGUID: Sql8qi+AQ3eI7YeCCZRXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555281"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 wireless-next 15/15] wifi: mac80211_hwsim: switch to use TXQs
Date: Mon,  4 May 2026 10:20:55 +0300
Message-Id: <20260504101829.c590948c1e45.Id3e629770663c44de00faa3ff9bac9c6b87459c6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 166C94B946A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35821-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]

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


