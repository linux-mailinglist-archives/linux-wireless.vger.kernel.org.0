Return-Path: <linux-wireless+bounces-36171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDpuGGXvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9350658E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39F4B300AEEE
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567FC33B6F8;
	Sun, 10 May 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkyRVYzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3093385B2
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446147; cv=none; b=OJHsnVg71T/CEldK+57LlweD3JY1WUTG/lw9PmbYzssQbdMx0rPlFrsai24thyTQDmTg31GMkHOMUv9SLOQ9lxV2z0oPWsqkxAGm5GVKXW+bYGYW+b/c16ZWARNJ5WsUeAcQnFtc7qlksoLvIHVlbIuNXPC8+ZjSSRbbQ+QSknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446147; c=relaxed/simple;
	bh=x0W/uEVqsBYVUv+D35DScV6vk7vitJ9pFFKXIIddJ+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl3Kw9CgONhIJ0J/3Yly7oa2KaOdJ4Pnu3jRlaOyFuGtIrPFZSQlanbB/6j8Wkgv/QYzA9D4ivpBDcyLubimX99wQj45Wm0CuAwl8VYQzWqWBbw2M5ypmYjfwMVy8FmPEW46yYdslbrdp+KlJfEgnH3yxkTeVOmCmK56dqeRKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkyRVYzJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446146; x=1809982146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0W/uEVqsBYVUv+D35DScV6vk7vitJ9pFFKXIIddJ+k=;
  b=MkyRVYzJSjXRVVTNxs+qPpIRWjpOMj4byAEsb0833OXULKx4G7yym/Mo
   t53GPyRAo3C7WCQ0iFzGYqhl0BjxEU05ypifcfYLN1/9fG/4ItRqiJHpF
   fUa5Feep5NsVFEbGwdeJSTikxQwNf1vv5d/ii/rOirCs97022EUH2d+1S
   jqo3Gzco8CSH3ZPykr7D5Uka/TR1blBrDGtVaBzsc9vU2FvhBJWG4gLzq
   ww86vQ9M+kFmLeB05QDrd4o1HosDOhszG9YuPef0bIsh9lzHUVFc0KFff
   04TQ85h6JTkOx0IXUBEyoa4rSLLAcV+0UaG3uAAuOCQJrzSiXD/a97pHf
   w==;
X-CSE-ConnectionGUID: gMTVUHmOS5+fKplSxnspJQ==
X-CSE-MsgGUID: 3xWjAQy/S86D7QVzVUecbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904757"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904757"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:06 -0700
X-CSE-ConnectionGUID: RD1xEM1kQVaaQOJnknr4uw==
X-CSE-MsgGUID: Kb8yhmYWTrKab4YxwaPsRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095062"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: mld: use host rate for NAN management frames
Date: Sun, 10 May 2026 23:48:34 +0300
Message-Id: <20260510234534.fb7272ddbb45.I843dba36f52363bc7e9c81f937547ead12147539@changeid>
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
X-Rspamd-Queue-Id: 17A9350658E
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
	TAGGED_FROM(0.00)[bounces-36171-lists,linux-wireless=lfdr.de];
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

Frames that are sent to an NMI station are always NAN management frames.
Therefore there is no need to configure TLC for such a station.
Always use host rate for the frames going to that station.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 7903ce2b0beb..dec8ecd6b805 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -557,10 +557,12 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 		flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
 	/* For data and mgmt packets rate info comes from the fw.
-	 * Only set rate/antenna for injected frames with fixed rate, or
-	 * when no sta is given.
+	 * Only set rate/antenna for:
+	 * - injected frames with fixed rate,
+	 * - when no sta is given.
+	 * - frames that are sent to an NMI sta, which is only used for management.
 	 */
-	if (unlikely(!sta ||
+	if (unlikely(!sta || mld_sta->vif->type == NL80211_IFTYPE_NAN ||
 		     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
 		flags |= IWL_TX_FLAGS_CMD_RATE;
 		rate_n_flags = iwl_mld_get_tx_rate_n_flags(mld, info, sta,
-- 
2.34.1


