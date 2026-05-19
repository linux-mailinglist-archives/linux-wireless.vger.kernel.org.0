Return-Path: <linux-wireless+bounces-36629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG9nIiwHDGodUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14A5784B6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142823019809
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF277399001;
	Tue, 19 May 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSAe/XwQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F191E25F9
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172829; cv=none; b=gvcmHh3JaBNTqo3HsrNwvwSzEs05B3OAv1+cyGjDcg6hYBhedGNGA6jUvqejE0U/az6yCTBLtJMoWLLZDrpgIaSUO+MpBfucscejA8+UtZYY4T/zmuOZC8y5/DyqCaf0Tqj6r8aPSmSKV4IVNKtL8MzCc5vmtX8wvYhYMUFOs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172829; c=relaxed/simple;
	bh=bASnDFVYsoyhbZ3qQBZTNSL8hsEIfREDnMMwtqFlHlw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6jY9r2HPgJgAQAk35dbm7HrV4s20T6gy/Ispg3YC7HeCvr0it5jaQgY34UEiOP7S4c/oohkb1kzkQlwhdy8TtnJOeoXpC8Nlb+20rtskZeYKdELDEuy+dUgTbLrSQRuo03Pf1IddfpAZP1yKZ4GRUsUkagiTFj7nU/GrBuankQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSAe/XwQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172828; x=1810708828;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bASnDFVYsoyhbZ3qQBZTNSL8hsEIfREDnMMwtqFlHlw=;
  b=MSAe/XwQoKykbVJzEp1SPwqhkteBFo6IkKJiOLb5cwN8siE6EHDgVC20
   oe8FBZeyN466/+xgJEEToQ9mTuHLdR9E5a1Uf+2FoLXl3OCmlyOydljc6
   pFjJUI0ZE0rVBmo540Qx5gJFbgmkvyOuROFh04rzNk7kwN5EFCcmte2Dz
   +7fWm3zpLSpWcckD90O1JextRHmL2xPnicuVYMd4QsYLXIVNrMHc4fakN
   prpncqtfrL2Yofvbl297F6Np+2nMxoYXPLBMuKfrGMBbEWSAz9G8Z89HV
   q+ZeZ/9eZFJgIH3w6xf+UkP/zF0dJQjCVDO+gW4hxQOfyfnqyRE3vWXRD
   g==;
X-CSE-ConnectionGUID: TkZJvr/ZSLmS67aT4sVkWQ==
X-CSE-MsgGUID: XheCjrW4TUiN/JJyrtmu1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605638"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:28 -0700
X-CSE-ConnectionGUID: esOyYszbQrCIonWrhknCtQ==
X-CSE-MsgGUID: kGscSBMJRZiJtoiA9E5r4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227277"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v3 iwlwifi-next 03/15] wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
Date: Tue, 19 May 2026 09:39:58 +0300
Message-Id: <20260519064010.549003-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36629-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DB14A5784B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Start supporting Core 105 FW on these devices.

Link: https://patch.msgid.link/20260517100550.8674feeafcad.I3d3ae3a7acb976a947cd7e65a8d7fb8199d2e1ab@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 51d7c599e998..ecb4f81a99f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	104
+#define IWL_BZ_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 76fbc120a092..e8968b3051d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	104
+#define IWL_DR_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index db7858b2cb74..6aaa49aeec99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	104
+#define IWL_SC_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MIN	101
-- 
2.34.1


