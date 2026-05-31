Return-Path: <linux-wireless+bounces-37200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKolLEUTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22894615AA5
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E601930151C2
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87F376A06;
	Sun, 31 May 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHya9BQt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEC376A02
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224810; cv=none; b=HpwI/h/zlXwCmf008RsHKeoQnygo/ppS95kjMWMBD8NpOkS8KN28gE0alvlCXbeeWzt9kAPgPagEPeFnQzKt9Mt51IZKUqjHK1iE73Nf65RBCa1uqoMT5F6jtyTpT+y+0ln7Gge84Mu0IHrg+KtsZb3mx04a+I4TNFuk3eDyUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224810; c=relaxed/simple;
	bh=88EPVfBXzYBsug3bcjYY73quFie3p+s5vcYJcSrIFEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pl6CElmM42cznoJh9UZ8EyESp1RTYn1MuVHeMRJ4QmouUl801uShr457FD2jmA5NsF8Y0FOr4dJuHqqwCfRMFrLkCujVstM8eMgfKUx00KmHb/Ml188SLKkka9WeNHXHP5rM8mFWtdzQRKqlJdLKxCIuHdFk0fOS7nBhs5cbaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHya9BQt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224809; x=1811760809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=88EPVfBXzYBsug3bcjYY73quFie3p+s5vcYJcSrIFEA=;
  b=XHya9BQta3oBo+Bcp0U66duWFZw3MDv1IG/HTUk4RgAXohHDJ+oDALjS
   ErBwkA13pxC8nyB6pslsSSVD4WZ2uP6D4+4dEKZGTsawg1tXwuFJE9hRX
   /wSwX4SjNxl0EeYpAf8ocSSUJuzySpCHxg2zjzub6mjIXBX1xaXLpQfA6
   gahjZd1T09NZVJSRvH8VjD+4yPRxNGPca1lOoe+OmR+rUDo4V82MIo1SC
   E/Tu+gPRlevDPwISKhtRJCO8tPL18bPAlDcDxmImhkpfEdQHpm8iQyCgs
   Jtuy5awfQp7abVIAunH0z11C4KkJ0P88UY1j3E6UCkItpfQBSToGXJ9lA
   g==;
X-CSE-ConnectionGUID: RgMKOQc5R1CG4LFTAKzdHw==
X-CSE-MsgGUID: rsoUl8H6TY2hZDoTZErLQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039665"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039665"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:29 -0700
X-CSE-ConnectionGUID: jJj9wpdpShqH8O9qar1cXA==
X-CSE-MsgGUID: bdZsA5PHSYWhEcZ4NqWVKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240295999"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>
Subject: [PATCH wireless-next 04/10] wifi: iwlwifi: stop supporting core101
Date: Sun, 31 May 2026 13:53:03 +0300
Message-Id: <20260531135036.4ece89be11a9.If00f9c7e011ec75219d28a38ca2077a926afc70e@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37200-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 22894615AA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

BZ, DR and SC no longer need to accept core101 firmware.
Raise the minimum supported firmware core from 101 to 102 so
these families only match supported core102 and newer images.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 9cdc4f142c7f..1542cbc3bb22 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MIN	101
+#define IWL_BZ_UCODE_CORE_MIN	102
 
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index e8968b3051d3..6a5870619411 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -12,7 +12,7 @@
 #define IWL_DR_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MIN	101
+#define IWL_DR_UCODE_CORE_MIN	102
 
 #define IWL_DR_A_PE_A_FW_PRE		"iwlwifi-dr-a0-pe-a0"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 6aaa49aeec99..f8913293ccef 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MIN	101
+#define IWL_SC_UCODE_CORE_MIN	102
 
 #define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0"
 #define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0"
-- 
2.34.1


