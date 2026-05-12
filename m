Return-Path: <linux-wireless+bounces-36331-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pt9LO2AA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36331-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F60528AE9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3843048F2E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8735F16C;
	Tue, 12 May 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVeVnZNz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91235CB6E
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614500; cv=none; b=ii7Mmbq64RRDHIkZBDUeAFa8K5cpKfG+VGIs94fQWYrOvQBPcNQv9DZslfYqDXJlFeBfnGwy6+15XYb1waviAN8ZQXBNop5GWmWkqwv8ARX6AyRA5IJrS0vDek5KSX7qrXL7CxDSvFelv9Zm6CalERgds1T3O6wjvUFRCLodJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614500; c=relaxed/simple;
	bh=Cv3CoGR+fm9ZVAfqV2VxHs8huWnan5e/B/cAJsEo1QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJOZnUq/2cibrOsoegMuuPHFvKiJXXx3PYqEOOcPc9CbzVXURfTS1bLlUTa83dj/zz0tYmAEYgLoGEoCcr1e5g9/CK7a45zUdCnt9fph54gWQDRx3QJGrXqKYRJXWCYWwZ4FTjjAxolXfsmh7u/fcMtV1aTxhNI6UjAzYf0yZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVeVnZNz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614500; x=1810150500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cv3CoGR+fm9ZVAfqV2VxHs8huWnan5e/B/cAJsEo1QM=;
  b=nVeVnZNzJus9dP3uWnvgwoCAHQf4bAwjBRsbud2tpOx0I/HoC8uD7abz
   GKj9v0RyDuDRGZH/qFc6yWSIhFIVeR6P0M9Dy1YxcLaUaX0FwWh4Zvldp
   apTIvWYawVJzNidTWaFhiwAaaNmSXz1EzpBhTI+CMicjf85iZ1D6fkAzD
   xC8t8h+rbDcRTpl60C3rvApqXy01snjD6ZoJpDIBPtNodlkmQTBy3ZdVg
   zqoNW2OvJAo9bhdEp2uJlyXkmtfoXzWh2e6hTGqIMpHOPZxu6OB2pH20c
   K3YtaWQ2NlS43wftO4hnuwAVvi9fwNx1SWiOxmHC73QkkDIP70u8uwHZl
   Q==;
X-CSE-ConnectionGUID: pz1mwamITWuRZie6nhe5JQ==
X-CSE-MsgGUID: rAOBVprnQSOPj8uXkWAuhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148777"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:59 -0700
X-CSE-ConnectionGUID: WU19pgOwTiKdyeRd5TkWaw==
X-CSE-MsgGUID: ZzhEzEzqRWWt3pdiQQvbiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471706"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: set state to NO_FW on reset
Date: Tue, 12 May 2026 22:34:30 +0300
Message-Id: <20260512222731.cdebf264f5e1.Ia31783c74df0d4b66816a1b34d3771b9a717048b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25F60528AE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36331-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

From: Johannes Berg <johannes.berg@intel.com>

On debugfs reset, set the transport FW state to NO_FW
so that the restart won't attempt to send commands,
which of course fails because the FW was killed during
the error dump.

Use iwl_trans_fw_error() now since that's effectively
the same as the old code plus setting the state.

Fixes: e5d110fec068 ("wifi: iwlwifi: pcie: fix locking on invalid TOP reset")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 9f4c99dca195..e3603571bdd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3201,8 +3201,7 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 				return -EINVAL;
 			trans->request_top_reset = 1;
 		}
-		iwl_op_mode_nic_error(trans->op_mode, IWL_ERR_TYPE_DEBUGFS);
-		iwl_trans_schedule_reset(trans, IWL_ERR_TYPE_DEBUGFS);
+		iwl_trans_fw_error(trans, IWL_ERR_TYPE_DEBUGFS);
 		return count;
 	}
 
-- 
2.34.1


