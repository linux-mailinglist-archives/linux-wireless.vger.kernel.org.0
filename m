Return-Path: <linux-wireless+bounces-36253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F+iKD0VAmr+ngEAu9opvQ
	(envelope-from <linux-wireless+bounces-36253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568B513AAC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBFEE308C374
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC7466B48;
	Mon, 11 May 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REiEj7XD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8246AF02
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521027; cv=none; b=gME3x2GFTKAYC4wERUGOH4KJLie31StJCxGY8qxX91nljpKqkYMA5Fyovb/flXeKGQQuUoa1crKq1fKjdjq1zB5IID9gsB85tpz51gt2JouDqKcHlmjJc3izCudKVAlh/wlyCIixbe/cxG1fDXGxvJB85pU2QnwjvbLDVWEUjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521027; c=relaxed/simple;
	bh=axWT8gcgt5PuWLgtnVzBkva7inYvm2q2PJhZR91lc4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/ME44YZFydgI6gwD0xIE6QdCN6lvD/IjdNVovGMNwlSLrVw89jOOlRXeVFfp7MuyZ3C2r3FGf+a60C58x8ErrhNW2CuorUkr76VlMPeYMdiJ4AkgEarDt5/nvTm5TA8PY8mnvwKl7KuzksmT7QB8TmWnX5fk/ohNGBfU5+esOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REiEj7XD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521027; x=1810057027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axWT8gcgt5PuWLgtnVzBkva7inYvm2q2PJhZR91lc4w=;
  b=REiEj7XDVOD8oYlN04h6fWXd9rA+p+hLLaU43l3sF+jJRL1C4lrwo6gq
   +I9U6T+WJrR2P8nwzmQ5C2e9QKXEpPp4aPBqigFdbruQiIosoYpf+D3f2
   mxFxnmT0lDp+bT4SA+SUvb2f1XDmw1vY2dxwHSc7RPcwFpKdtzqiRezyb
   T/MNM7/GdGCLAWcHpQbPBL/PtBfebMWG8jZuHN2sj5sm8nihyooElvfgj
   RlvFnmcKhm5De/AVqn0/nRq82y5N4JhXrhmgGHrpRyUA4a6Jur6fQQND0
   iz2NvmZCrvPxuFPOwj505pOTH6nC1vY8uSlQo4KfPJxyCFhfFJniferfc
   w==;
X-CSE-ConnectionGUID: EmQ612e9TzOSCR5SrT/wqA==
X-CSE-MsgGUID: yvuP1dfYRxCvBRLw5oTnBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314854"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314854"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:05 -0700
X-CSE-ConnectionGUID: xzdX5YEOQz2s+SPB1ENfTQ==
X-CSE-MsgGUID: YTWJyNPXTdqYtoBe/FKNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261005058"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: api: RX: define UHR RX PHY flags
Date: Mon, 11 May 2026 20:36:28 +0300
Message-Id: <20260511203428.cfca1a7d40cf.I32b51dc6eae98787533c64ccf2a73789409dfcb9@changeid>
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
X-Rspamd-Queue-Id: 3568B513AAC
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
	TAGGED_FROM(0.00)[bounces-36253-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Define a couple of UHR PHY flags in the metadata that carry
information about 2x LDPC, UEQM and NPCA.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index ac6c1ef2cbcd..8ef764787ba4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -263,6 +263,9 @@ enum iwl_rx_mpdu_reorder_data {
 
 enum iwl_rx_mpdu_phy_info {
 	IWL_RX_MPDU_PHY_EOF_INDICATION	= BIT(0),
+	IWL_RX_MPDU_PHY_UEQM		= BIT(1) | BIT(2),
+	IWL_RX_MPDU_PHY_2X_LDPC		= BIT(3),
+	IWL_RX_MPDU_PHY_NPCA		= BIT(4),
 	IWL_RX_MPDU_PHY_AMPDU		= BIT(5),
 	IWL_RX_MPDU_PHY_AMPDU_TOGGLE	= BIT(6),
 	IWL_RX_MPDU_PHY_SHORT_PREAMBLE	= BIT(7),
-- 
2.34.1


