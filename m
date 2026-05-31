Return-Path: <linux-wireless+bounces-37202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HxYN1oTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FB615ABA
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5050D3049723
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B83376A08;
	Sun, 31 May 2026 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krTOlPww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF198376A19
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224812; cv=none; b=MoEpROPalABZIOTNvn7V6YMtonGpfhDkMULs09bJyv/K6Hg2Yjj2N/prYu+lwikeyblSmX7rGBqGOAOfQ3eTZHhPBSjx5mlQP5DEene1yZZeg3kSlDFOMCwFA2xezLVFxp8fSQ2fd5dxnP5HTi0XpAjrYjjC4v1saa8vB/srWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224812; c=relaxed/simple;
	bh=We0ECTrarJV9fjuDKHKUU+22t5oARJeZpRUGyBz0fso=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhTDrSSlVxAI6TkkK59Y5iSn/RhQIP9zF1B7/Uolc/RTYQtHlEICEweoqrHNap0pp/26+jdn4YJHp1Ek2KClRmukljVL+schrRUN7z91qmsgwYBZQYeWTP9BKj/a44UZWDYDvSo8iQFskI07SDlZg1No8WEyZvZR8rg2rJ33VnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krTOlPww; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224811; x=1811760811;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=We0ECTrarJV9fjuDKHKUU+22t5oARJeZpRUGyBz0fso=;
  b=krTOlPwwiAUPTbHkZkXHQ/RRsWcMbtrNJ35Odv+Mh34N02FeJNNGxKGv
   nKcyUNOFNOL7TZAikjmlnekSw877Bop2lUJ3penkMuoCm/s39NKTfU+7W
   ER4mWa9ExOF4aQ7xJWELFhyTMAPdBe0BTHThP6yyF+PHxhT5Wd7DI9Cor
   0nHr1+Ia1oXZ7EuFGk16Kxa2QWJSOI0jJKkexQ9RBnj0d08yxBCsIEUpb
   O87azvAvWXpChP4X2cgaYdRIRfDan0+h7TEHw5weWa/e6I8gsrEFQWHwi
   +sHOObe7PBAeM8n0USNREYWHfM5aU850QKbUpU9pdVA2Gy2MHtFtsBi3w
   Q==;
X-CSE-ConnectionGUID: 2PF+6ugVRgOrQiEaMUjsng==
X-CSE-MsgGUID: ElBRP1ecS+On3LS/j9LlMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039667"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:31 -0700
X-CSE-ConnectionGUID: ZSnKVd0IRSKIPSVHsUY5kQ==
X-CSE-MsgGUID: U3bUb+cNQpCJ+bx4oP2r8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296003"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 06/10] wifi: iwlwifi: mvm: remove __must_check annotation from command sending
Date: Sun, 31 May 2026 13:53:05 +0300
Message-Id: <20260531135036.434473c7b29a.I455e0c3f93c25635df708da7d3216c183dbdbbbb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37202-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C6FB615ABA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We don't acually need to always check the return value. For example, if
we send a command to remove an object - we can assume success
(if it fails it is probably because the fw is dead, and then it doesn't
have the object anyway).

Remove the annotations.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6bf71092faa1..683cac56822c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1673,16 +1673,16 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type, u32 *gp2,
 u32 iwl_mvm_get_systime(struct iwl_mvm *mvm);
 
 /* Tx / Host Commands */
-int __must_check iwl_mvm_send_cmd(struct iwl_mvm *mvm,
-				  struct iwl_host_cmd *cmd);
-int __must_check iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
-				      u32 flags, u16 len, const void *data);
-int __must_check iwl_mvm_send_cmd_status(struct iwl_mvm *mvm,
-					 struct iwl_host_cmd *cmd,
-					 u32 *status);
-int __must_check iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id,
-					     u16 len, const void *data,
-					     u32 *status);
+int iwl_mvm_send_cmd(struct iwl_mvm *mvm,
+		     struct iwl_host_cmd *cmd);
+int iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
+			 u32 flags, u16 len, const void *data);
+int iwl_mvm_send_cmd_status(struct iwl_mvm *mvm,
+			    struct iwl_host_cmd *cmd,
+			    u32 *status);
+int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id,
+				u16 len, const void *data,
+				u32 *status);
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta);
 int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb);
-- 
2.34.1


