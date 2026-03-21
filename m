Return-Path: <linux-wireless+bounces-33637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDy5AqHVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C12E68A3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C86930143D4
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF4317171;
	Sat, 21 Mar 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcAzhLU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18833B6D5
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114188; cv=none; b=CmZB12BwJGz46CNlSMTF54HlJYBFwtAof9x+3aFQmWIk/uyCzC5fiNWo709karD0SqOA+YqWRZuREfk/TzD4hm2XuVhRBLULIXq6bnNZZZ6K8csgZejFNWXSR/cxruy6dyaoAWntGBY5mFaaFfUtRk4BI+n/Lj0wmMqWEhV47wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114188; c=relaxed/simple;
	bh=qXc81kItrh7pzkjT/hY31rxnYBhQIVH7heRBJQOKjsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGjN3eqnERkn0ITlqK+zr5NciLoCB2RMS3+M4HcKLFi73SOkLsz+Z8KQYaGnn4OTW8vlC/nMHnyfUCTXgpRKUfHqXg+MeYeu5/NPs2fwSdY6a/jZcloJ2Rb30uIzDHdsnSvrNYM818isqATT0ZjcAp0ixXUulQ2Qhvomn+gvjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcAzhLU2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114187; x=1805650187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXc81kItrh7pzkjT/hY31rxnYBhQIVH7heRBJQOKjsI=;
  b=HcAzhLU2g/bxDnXpHrE6Vm6fVShWMvecmQk/xzCnboVp6mX0xhjdLak8
   EBQHqXMvTGwKbjG/RYYSzYvxasZrfBqBiriXwigEISiXtRku5KhYFsF3P
   /ucjmerhCkv0l9FI1nSIfs49s4p8jWcvWO1UfYsVE5eo/KHhVgXk9bM75
   knj6KvX7i2Ra2udyb1eI9/CVzeu3HOohNn5BI5X3g4VlNI6yAYsOi87FT
   k64SkQatGYZ1IPryWaSYaFBtUwZGgDgekcFbdi9wYirkV7cyIu+RoKSQx
   e1jiyqtdNewdOpCwrnZ6Utuh7/MZHE6/GSFonxGmJqmu0yRYpY6dvhdiw
   A==;
X-CSE-ConnectionGUID: JQBlVJjkRj2z8yzZ6OUbGg==
X-CSE-MsgGUID: ua3sdv7oQEi3oI7IvpaMtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244594"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244594"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:46 -0700
X-CSE-ConnectionGUID: I9Win4aHRMO2VNPqOGoBDA==
X-CSE-MsgGUID: +nd7Hd7VTLeEbzkJbWIoyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813600"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: TLC_MNG_CONFIG_CMD can use several structures
Date: Sat, 21 Mar 2026 19:29:17 +0200
Message-Id: <20260321192637.2c0b1adb8655.Id0cc6cb6996df53a224d29fa541d19b9ee2aa479@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33637-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 997C12E68A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Depending on the firmware API version, we can use different version of
the command. Mention them all in the description.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>x-iwlwifi-stack-dev: 324cf6bdf925d4c2d772df044c7e0b19bede0c4b
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 6a6e11a57dbf..06370c161fe4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -56,7 +56,8 @@ enum iwl_data_path_subcmd_ids {
 	RFH_QUEUE_CONFIG_CMD = 0xD,
 
 	/**
-	 * @TLC_MNG_CONFIG_CMD: &struct iwl_tlc_config_cmd_v4
+	 * @TLC_MNG_CONFIG_CMD: &struct iwl_tlc_config_cmd_v4 or
+	 *	&struct iwl_tlc_config_cmd_v5 or &struct iwl_tlc_config_cmd.
 	 */
 	TLC_MNG_CONFIG_CMD = 0xF,
 
-- 
2.34.1


