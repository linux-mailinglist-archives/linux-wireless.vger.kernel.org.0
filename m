Return-Path: <linux-wireless+bounces-33430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDbFECoRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637192C2BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BB7C30229AA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0136EAB8;
	Wed, 18 Mar 2026 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxf8bper"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858536F41F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867292; cv=none; b=cnUnhcTO8YCc6nbNRotoe1PnJtH2/dTmkRd6jWlZ1XUcf7M9sH2rNTXaE79wKNagu9TuAihOOuTuhoEQepV1IX+cWNCje0/0tH6EIWrw2ZpqVBr+eZn+oz1kUSXr+1UuMPwy/AI2ERIOx8uML7sRSUWRixXw+zqm8fhJWXfb/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867292; c=relaxed/simple;
	bh=CC4/VtxKmd+Ob47TiVXgkieXlyNUh2oJYcwMlDlkIZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neqDS5X2kga62bI2Fu/kozi1y4wYojvGxZCsflBrP+D2kDhZFNgJjE1RYUSO1Hl4qBisv1sP9m6qHThq79NIf0kDXIK4Ugu0ia4qqLkEYvGBQcI2OpiZb419WHPJqkm2S8KL9LOgL1kzy1P7PO60GYyNQM+VceH6rnXXoFenPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bxf8bper; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867291; x=1805403291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CC4/VtxKmd+Ob47TiVXgkieXlyNUh2oJYcwMlDlkIZw=;
  b=Bxf8bpersE3FCBwFeTQhUKf8solxpYVQev0/+U1Lo0GEk6vYizmlojlE
   oMDH8xS25/kB01GRJRKC1rQFSlETNUNJL140v4RtPvfZylOwELWvIbkmf
   1LOCdP14dH4vH51cAccwBfn0MJuabpuIJ3ixdMKAVQSjFJkd9w1R0pTos
   tudZJBTc2xYZsfQR/tla6KaD+1+47YV6NgsVQRZPhr3M1JHyOp2X5BP0P
   64nsqD9MBs6tLVEpmLu7/zNd/ds7DhJ3J5mGgWwf2nfJl7pJGk9dXPQWT
   7uNwRNtrguwKqk8qf5i1yOZBRIKFBa5UMI2Aah4dSUkjvlMv7oWdmHyDR
   w==;
X-CSE-ConnectionGUID: kNXBiUXqQUOA2sNz6vYV3A==
X-CSE-MsgGUID: a5KJMkPRTP6vui0Amg+qEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010018"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010018"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:51 -0700
X-CSE-ConnectionGUID: LVPUWVwnTX21Iox+5MAQLg==
X-CSE-MsgGUID: lc1197bqRqCXaw6q4chkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793881"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: remove unused scan expire time constants
Date: Wed, 18 Mar 2026 22:54:21 +0200
Message-Id: <20260318225236.4be7221113cf.I13e32d575bb854709af374519332b998bc1fed4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33430-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 637192C2BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Remove the unused IWL_MLD_SCAN_EXPIRE_TIME_SEC constant from
constants.h and its corresponding IWL_MLD_SCAN_EXPIRE_TIME
macro definition from mlo.c. These definitions are no longer
referenced.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/constants.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
index 5d23a618ae3c..e2a5eecc18c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -36,7 +36,6 @@
 #define IWL_MLD_PS_HEAVY_RX_THLD_PACKETS	8
 
 #define IWL_MLD_TRIGGER_LINK_SEL_TIME_SEC	30
-#define IWL_MLD_SCAN_EXPIRE_TIME_SEC		20
 
 #define IWL_MLD_TPT_COUNT_WINDOW (5 * HZ)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index f842f5183223..f693f92e42b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -110,7 +110,6 @@ void iwl_mld_emlsr_tmp_non_bss_done_wk(struct wiphy *wiphy,
 }
 
 #define IWL_MLD_TRIGGER_LINK_SEL_TIME	(HZ * IWL_MLD_TRIGGER_LINK_SEL_TIME_SEC)
-#define IWL_MLD_SCAN_EXPIRE_TIME	(HZ * IWL_MLD_SCAN_EXPIRE_TIME_SEC)
 
 /* Exit reasons that can cause longer EMLSR prevention */
 #define IWL_MLD_PREVENT_EMLSR_REASONS	(IWL_MLD_EMLSR_EXIT_MISSED_BEACON	| \
-- 
2.34.1


