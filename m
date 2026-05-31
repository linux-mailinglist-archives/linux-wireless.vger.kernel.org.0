Return-Path: <linux-wireless+bounces-37197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG+/BTETHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3AE615A86
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDF93034660
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F344376BC6;
	Sun, 31 May 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfYef1iJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808E376A06
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224807; cv=none; b=SkmM6ey0Ijtn1wQZdcTjeRTx6cwQz1Aqi7fU62nYHoN4vmuJr5+4dkB7fUueB3tTdmal5lXE4eAH81JinvZfzIKZ5iTYJi0j20mD5z6UmLAbJHrlmcG3veWDrKbPW9rcUq/7yYnse3QymHiubBhC7UQcgfYvspXJcvgxSJoPiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224807; c=relaxed/simple;
	bh=eaW/XWNrKZj4Hi88CTUqYqSSMqU519P8mlh+BUhlnrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMfkLknCet+322fQnMGRytF5XI7aLtp4Zf/FeyAjkaweknHvmOeDQKv3Ohu7h4uOMtk1F+jYrpLuGg6Fukv9Ls+oYgqb3Ri+mrmeEgwJuWChPOlo2wnMGcs0+bncoyc8brRkcQPvIFEpvwFBpUIuSjXhWcl415KfABkOkMSa97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfYef1iJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224806; x=1811760806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaW/XWNrKZj4Hi88CTUqYqSSMqU519P8mlh+BUhlnrM=;
  b=UfYef1iJknubvzuwySH1pmAni4v1xRxtaVizfFtMto4YCMpGZWCRlXMv
   BfGNn0nBPni0jpO9ixVi7CRSBWU1eL1pKmeco9eTzt9k6rJkawHmElV4v
   1KCQ7wUnFt/9ERq9vIL4OzM9gQBMfpIRszmQfEl6SZG+Y0NZJdML7Fvh/
   7rjJ2Nve52C14pAqfKYESwWxjI5iA7cMFi+OojO5qrKlrKFOZTJ+qPp/E
   zscF+LCBsQxb/OHq7BqlUmALP9KfPX+4IRiwXOdtWqF4OrKOsgl/fC2aX
   TOEPkx6k+oXSrSIoD7xNDvwgZRARSZ3zM/niF+EmC9GPgf5yeJZHATtpf
   A==;
X-CSE-ConnectionGUID: TrV+Uw7wTU2/sZEt4xDcKw==
X-CSE-MsgGUID: GpZ52FF7QwO9UdVnQ/NwXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039662"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039662"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:25 -0700
X-CSE-ConnectionGUID: +ndvbdgJR8CmU9FmUzZuVw==
X-CSE-MsgGUID: lS8qY9pcQ2+PhF24AtY1vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240295989"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/10] wifi: iwlwifi: pcie: fix write pointer move detection
Date: Sun, 31 May 2026 13:53:00 +0300
Message-Id: <20260531135036.87ffbeab298e.I4fae41383b6756bccbed250985e0521b68a40d0c@changeid>
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
	TAGGED_FROM(0.00)[bounces-37197-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC3AE615A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Ever since the TFD queue size is no longer limited to 256 entries,
this code has been wrong, and might erroneously not detect a move
if it was by a multiple of 256. Not a big deal, but fix it while
I see it.

Fixes: 7b3e42ea2ead ("iwlwifi: support multiple tfd queue max sizes for different devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 976a47ef6d0e..28b276c65952 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2590,7 +2590,7 @@ int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 	struct iwl_txq *txq;
 	unsigned long now = jiffies;
 	bool overflow_tx;
-	u8 wr_ptr;
+	int wr_ptr;
 
 	/* Make sure the NIC is still alive in the bus */
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
@@ -2613,7 +2613,7 @@ int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 		overflow_tx) &&
 	       !time_after(jiffies,
 			   now + msecs_to_jiffies(IWL_FLUSH_WAIT_MS))) {
-		u8 write_ptr = READ_ONCE(txq->write_ptr);
+		int write_ptr = READ_ONCE(txq->write_ptr);
 
 		/*
 		 * If write pointer moved during the wait, warn only
-- 
2.34.1


