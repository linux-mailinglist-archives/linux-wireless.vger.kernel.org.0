Return-Path: <linux-wireless+bounces-37201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMsNLkoTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF0615AAC
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B80304413F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76A376BC2;
	Sun, 31 May 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vu3CUC2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3E376A08
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224811; cv=none; b=P0/spnNT4vy54VAyIR92oxPtpmoZCILBBGcqlTuIwhjaH7a0ZPsm78EtVoErc1zIEyB0hjzZu/mqAFdE1jqCsjqVKgLVLID4qc0kMd+GUcRMkRhPViODNmc7LvidzC1mahX31OPIvV3wYaq2DxHg/CMXg2hWqR9UwIkX4Cghrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224811; c=relaxed/simple;
	bh=yJRDC2RXT6qZURtdEl/+iQJQtd1JwDIpIro2YWY5UzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWLxQfeTXYHzGoswtNBTxXOYlnQ2Jgb3X0j+IoWFyCWi+HkG3JRgkqaPSeCrZv5WE4VoQK4huseBJTip7PHcJDl9KK8rGWl3W6fwH/voRRHmsKbdcIZY4w2x6lSkqS9iERWHyyYvLxuYPtDnmiQeUMmdYM4J+sFdMMSJb0EUhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vu3CUC2U; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224810; x=1811760810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJRDC2RXT6qZURtdEl/+iQJQtd1JwDIpIro2YWY5UzE=;
  b=Vu3CUC2UB1SeWrPKO2rkVTRTgpt+UIQnUFiG0GVg8IGU8rNhvFkkToh4
   H309EgRyZGqDCIyBUDKUq+/s7/nRQPQ1yTdl1Ifkl4hC/KCNlk39oOy89
   NER1c1IHAJS+EBsMUVlZ2dAas7+t4CjXgvfbs7Pru0kIndsLkpvh7VZhp
   DIYCW+YBfBYiisLJQ7W6aeUlMT9a7WiwbsmtVtOf6XDvv6kfkUMM/QbjW
   8J8md7BRTIyPzAEW+Dkmvdx0lzu8EUUHthB4pjYv7fI6JtpKc73Kt56Rt
   IV2x3/9x7a3p9DtqwkeZU/GEZ9eTKqL9f0jCts+yo7PHgr0QamOF9aNKZ
   Q==;
X-CSE-ConnectionGUID: SX27zb5eQ9yA8AL4q/eQSA==
X-CSE-MsgGUID: aHC+FcfpTqK9qTpGRo3Wug==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039666"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:30 -0700
X-CSE-ConnectionGUID: zkVPBggrTYSGsGb5eC9d/w==
X-CSE-MsgGUID: xDVK+aF7TR+R5mWocIDSMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296002"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/10] wifi: iwlwifi: trans: export the maximum supported hcmd size
Date: Sun, 31 May 2026 13:53:04 +0300
Message-Id: <20260531135036.2e6b15bcaf50.I027e150e5f25ef2431ab4e212175dc00ca5e8abd@changeid>
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
	TAGGED_FROM(0.00)[bounces-37201-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1DEF0615AAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export the maximum allowed host command payload size to the op-modes.
Note that this information was available to the op-modes also before
this change, this just adds a clear macro.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 914864005704..c581cc8f5bcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -161,6 +161,10 @@ struct iwl_device_tx_cmd {
 
 #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct iwl_device_cmd))
 
+/* Maximum payload size for a non-NOCOPY host command (excluding the header) */
+#define IWL_MAX_CMD_PAYLOAD_SIZE \
+	(TFD_MAX_PAYLOAD_SIZE - sizeof(struct iwl_cmd_header_wide))
+
 /*
  * number of transfer buffers (fragments) per transmit frame descriptor;
  * this is just the driver's idea, the hardware supports 20
-- 
2.34.1


