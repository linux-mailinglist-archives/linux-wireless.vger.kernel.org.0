Return-Path: <linux-wireless+bounces-36173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABM/MHDvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724145065A3
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF8ED301A419
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3C64;
	Sun, 10 May 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/qpDJ3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31D3385B2
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446150; cv=none; b=igXgq5aWQYslKhkFnKWeLcf6OBshj2YqL4MKMLE6m3NaN7h2aa6Ls4Wi91zfFDAY7+cpfdrsG2+IqgvgHpbCNqndy5ddaGgIusN1XFysZqY0TL/L2gIxtt1N9z+hjaMB5qlmbKyB6DTyvRrGrwyyNjvl8A4dBVe+gGAIBEELwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446150; c=relaxed/simple;
	bh=TZsyUkkdADgmeM85Ou4w5h0FerOFmCgh/Gszzq1dsSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1PEuXSU/8K+XKHSxrvWvzOROXISQRiVPw5ElClHIHGw4zvGtEfvatpiEzmkqkTXpKh7/w+9WFFiheShEhNYi/1QhX3mamNE0bK3xSPBwU1nVNx/dZRre3ORCy0fDuIbdZAiK6VOOed4bAIvI5WsU8dTufl+1FylSBa+NW8Q5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/qpDJ3R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446148; x=1809982148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZsyUkkdADgmeM85Ou4w5h0FerOFmCgh/Gszzq1dsSg=;
  b=D/qpDJ3RLU7GWlVARxz8NDa2TeqHnRTmAmtzm1psLXCxxNlvwXSTyX8+
   Ea9giyVw+mQYMpzullZfdXGMwWBDiKcZBtatTYOwIxTC2SyNUWGruMLen
   TExYgx7B6+ocqZpzo5go3NeNSCmt6JWVXrgvUDz7FLpHV+/AJFU8pI2Ja
   1wq5DejxFVwUzQtHmWsXiovm67vcVsNNMQUKXPUQGMtmtOSOHOt8QnpA9
   rdl4JUp2MIfZiXzpPaNuDN2nwDv9B16j5T5o/SCYogqwU5wt4BPyy67Zn
   DjQNKB8w1hVOsbI9twD4iy/5Kk3nAqtUmp038Z7dZMlsqFCJkkBXjYojr
   w==;
X-CSE-ConnectionGUID: zao6Xb1HT/uoUsUn6qSRdQ==
X-CSE-MsgGUID: mn3W0j9oRzmi6kkTzveZeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904759"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904759"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:08 -0700
X-CSE-ConnectionGUID: mD8IJLVjQ6ek+3MmnVWnRw==
X-CSE-MsgGUID: wTH8codCRl2HsWQlNIjkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095067"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 11/15] wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
Date: Sun, 10 May 2026 23:48:36 +0300
Message-Id: <20260510234534.26f8653d44a3.Ib8b9769e7a598b01f6285bd0782aa3bf13f144a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 724145065A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36173-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Instead of hardcoding the number of supported antennas for Tx/Rx, set
them according to hardware capabilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e76421a8a8e6..4ad1d55fd646 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -290,8 +290,12 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 				      NAN_OP_MODE_PHY_MODE_HE |
 				      NAN_OP_MODE_160MHZ;
 
-	/* Support 2 antennas for Tx and Rx */
-	hw->wiphy->nan_capa.n_antennas = 0x22;
+	hw->wiphy->nan_capa.n_antennas =
+		(hweight32(hw->wiphy->available_antennas_tx) &
+		 NAN_DEV_CAPA_NUM_TX_ANT_MASK) |
+		((hweight32(hw->wiphy->available_antennas_rx) <<
+		  NAN_DEV_CAPA_NUM_RX_ANT_POS) &
+		 NAN_DEV_CAPA_NUM_RX_ANT_MASK);
 
 	/* Maximal channel switch time is 4 msec */
 	hw->wiphy->nan_capa.max_channel_switch_time = 4;
-- 
2.34.1


