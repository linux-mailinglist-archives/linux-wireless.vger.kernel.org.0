Return-Path: <linux-wireless+bounces-37027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFjfFpZOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC05E9E29
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E390C301E993
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E043B4EA1;
	Wed, 27 May 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbx9s3SN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B23B5851
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912331; cv=none; b=npqyFgtdKIYGa6UpeJCNU6Ln3GQ4X5RUd9b83O9m75yfIwwaGq/t8VK+IaHMWQ0qrHJsDEpnoQfCeikul7cZhQDNyowXYj/xJDq+GjwQ0nyjPgkI+GRPvBRrSkAlRTMzXuY/t3DcB9qg7mLV+H5uD7EDgnLcbZITq0RF0a7TSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912331; c=relaxed/simple;
	bh=raYIVRyfBQOy2O2nP0RSVEpCkxGZ8F0TuWQ1wqzdH/M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKLuJ4pyzHT5HApy0E2l1KT8GfFfLPh1exXP5FotSyxdidhoHrxos3H+1XqYld11pu5nGYzkrlPxq7dICHG9nJhTSIJZCXKdqUT03uSwXcecMm/b5NbgBIDlv5AK7TCjLHePPNOImGjo5Xgk6s3p34qDf7FZDkYXH8mYy+1qlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbx9s3SN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912331; x=1811448331;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=raYIVRyfBQOy2O2nP0RSVEpCkxGZ8F0TuWQ1wqzdH/M=;
  b=mbx9s3SNWZSN0r7XCz4ulcDxtbTz+Eu82v2RKDne52STigpYWonwe7s8
   5jdi0Ku2QS8o+AnCGIUXCaKbXTPEe0RQWk4j4oiIaYbky0QN7yqGLIXIS
   k3c16WgKb4SR1JPIiOA72DVyajLl41yukceqnHezKf9/UWGHhJMBNUxly
   BKnQfk3w/BPlAgfVmzT6wq2jADbgFKqo6Sv1+WDE5wxm7CzsFc1y34nTT
   UL+67ZK1k8AU1o6hCNqXG5YhBlCJoOdXoSSimqwb825iq0VHyDyBn+Bsl
   621XkGJAsNObSD4NrK+uiZVJRwXBTxkKzxo9GRJsMcYQpADedKFbMXgfp
   Q==;
X-CSE-ConnectionGUID: bVbT4AU8T5+R3P7vQ0FIoA==
X-CSE-MsgGUID: Etlvk36QTkueotYAYVaWHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940852"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940852"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:31 -0700
X-CSE-ConnectionGUID: HXtoE/zNRLSKqMylKgGRxA==
X-CSE-MsgGUID: xl/uNKyxTeGswWz8fSEe8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286950"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: remove stale comment
Date: Wed, 27 May 2026 23:04:59 +0300
Message-Id: <20260527230313.ae42da7924ec.I1a92266621dc0033afa80f022d4c45e91674fedb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37027-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BDC05E9E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iwl_pcie_set_hw_ready still returns the return value of iwl_poll_bits,
but the latter one no longer returns the time elapsed until success, now it
returns either success or failure.
Remove the comment entirely.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 40fd5f3fdeb7..976a47ef6d0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -521,7 +521,6 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 
 #define HW_READY_TIMEOUT (50)
 
-/* Note: returns poll_bit return value, which is >= 0 if success */
 static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 {
 	int ret;
-- 
2.34.1


