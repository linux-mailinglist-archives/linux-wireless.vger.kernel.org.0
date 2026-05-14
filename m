Return-Path: <linux-wireless+bounces-36428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGMPHmYmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC15467A0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160F2306B391
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED953A3838;
	Thu, 14 May 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU2an8Lv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB53B3BE3
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787902; cv=none; b=Qpd702p4XXjkCkNXbVitzHobo3lYe4fgp7b823gWC+Bk2xn7eiL175pY2QGVzcZN/Sw3d7bvAPsbNKjSaZAnvcpPMtEuBebuVYChaKYDpYrOTQ1UA+WAZXeBFnU9TMuRjN7zMKif31YNBVXZ91/n+0xP+WxiNgIoBD5a8W8en90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787902; c=relaxed/simple;
	bh=Wr5pX1y94a1//aXoJapahlSqY58OZNE6MPEMJqU6HTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVzAuQ4Bgw3YtYU+CfH24904DRsdd2oP9KKpxmjvJydkgXzcRQEoc4DqrpbsQgruD3pdGtVjHR40D501l+14B2Lb4859dhyXmHZbK7yefmZd8jVg92kweW4lQVgqRNH5kwwUBq2O0dr0i6YfvwLC2DGKlRg4QWjLJTQoCi1lwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU2an8Lv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787902; x=1810323902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wr5pX1y94a1//aXoJapahlSqY58OZNE6MPEMJqU6HTs=;
  b=VU2an8LvaI1SXOYs//ix3pkRqiJbjQgCDxzPOnAa1JE/k/5Xzjg1Vueq
   iKmFpf+9doc+dZh7DvhzJr1uIKjoiEDgb065lhq/aA087Wy7b5J57bcXZ
   eMotsOC36u5QpgNJQ6Su9lDxnQbkdArCQte4+/HTV60ITP3nBEvAaatTv
   1GvV2X9HN3z3qMcPVn62wCcnE9xbt3bbqdjdGNe78yiPTQCb6E86DBk3l
   lg3nkUbXxDGGc0BwasrPLBsBgxg1EzZ48b6jeVO9sqY0BMGjVw8uHNal+
   MA35tRhxRjUPvzA63xOXAuhPlz7ttcMOpZKMxew+tn33Lyh6y3pyIpefl
   A==;
X-CSE-ConnectionGUID: j3/nO8rLT1+u6qT0aorUuw==
X-CSE-MsgGUID: WTIuWpuySMyP3IPpQrpWkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352590"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352590"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:01 -0700
X-CSE-ConnectionGUID: HR7Zx4TgQuePlKcGs2Mlxg==
X-CSE-MsgGUID: VTYSWNX0TnWpHafhaem2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616297"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: Disallow using a per-STA GTK for Tx
Date: Thu, 14 May 2026 22:44:27 +0300
Message-Id: <20260514224230.b004744087cb.I25fb83f9e3dc563d122a160da150d793155513fa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DADC15467A0
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
	TAGGED_FROM(0.00)[bounces-36428-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

When a GTK is configured for a station, it can only be used for Rx
and never for Tx. In such a case, set the IWL_SEC_KEY_FLAG_NO_TX
flag when the key is installed, so the FW will not use it for Tx.

Specifically, this is needed for per-station GTK installed on NAN
NDI stations associated with NAN Data interfaces.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/key.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index a6454d90d0e3..bf80b4770b5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -49,6 +49,12 @@ static u32 iwl_mld_get_key_flags(struct iwl_mld *mld,
 	if (key->flags & IEEE80211_KEY_FLAG_SPP_AMSDU)
 		flags |= IWL_SEC_KEY_FLAG_SPP_AMSDU;
 
+	/* When a GTK is configured for a station, it can only be
+	 * used for Rx and never for Tx. Thus, set the NO TX flag.
+	 */
+	if (!pairwise && sta)
+		flags |= IWL_SEC_KEY_FLAG_NO_TX;
+
 	return flags;
 }
 
-- 
2.34.1


