Return-Path: <linux-wireless+bounces-36359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LesLbgPBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BD52DABE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 142C1306CB0D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271A3A48E3;
	Wed, 13 May 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4zzZXON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF52030A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651060; cv=none; b=eEGZCJk1VcucfLZvUBbo+3AT7HZtUMvSufrUxWLdU9cXAbm5e6ZdSHaPAosRQdsdPsaF7T1rkwl7UuAsbw7GctJXMagEJTMZoR/jX75Y+sitWaPGlteeJIhQi9b8nMOABNl3oz3ewWs9NMdDYHQa4msCB0q1nwDDvb9frg/tbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651060; c=relaxed/simple;
	bh=rGXwl6z55b5ieX/mo5YGlLOMgI4MKE+upY++9m84sQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmJUUjxjkw0n1+ox7lVBovgh7GaGZnxGjB6UIniAFRvTWwROiqO0BIuzlD/mOpvRwQKxxVl2sCcz8LfY1Nrqa9pbg1cOV56l18/Fn0eDmxe0tu3n2aXGI7Fy+NVnXXcEvojck24wtRHWyPgaNQGfIGZcnkYCG0qNoeF8NUn/dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4zzZXON; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651060; x=1810187060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGXwl6z55b5ieX/mo5YGlLOMgI4MKE+upY++9m84sQA=;
  b=H4zzZXONEvSe9gczm6fWO2mFwPu62tN5nW4r90Ewbg2spbge0do2Wu7I
   BD82SG1bZjdBg+1PdBTBLiobdbqXy88XdtPfgpM0Tw45hKVnXmyD7j6JA
   rQX1BRNOyesoxlYi1l5U/WO7lDzKO0f1AmvmtYgzqGFXFhjmqG66cCqV8
   4LJO14RedKq/+r1YljCSU8Q4vCHvzyY/pLTPdpZsvY3zLl2r92jL+8Fru
   56/7+AFwDsQeAYpJfjgrF+hL+Y9nWMvh+mN9xsSbN88V0+P2+qoe05Tfb
   eOXfueFHas7esMlg5BoXEcC4z64pcoahnEUCPlnfwenKt4oxUwWao/6/k
   Q==;
X-CSE-ConnectionGUID: QUYYOt5aQrOiMW8YQD2EGg==
X-CSE-MsgGUID: ijIcqC9/RtaRjTWGjN+7mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552808"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:19 -0700
X-CSE-ConnectionGUID: MnIkNG0+QpyyrqEBzzpitg==
X-CSE-MsgGUID: T0y/iyKWSz+7kFPD19Aqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077895"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: shadow_ram_support is needed for iwldvm only.
Date: Wed, 13 May 2026 08:43:49 +0300
Message-Id: <20260513084215.365f3984c554.I29138e178dea6fc371a3907013bb3825c4e82475@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E1BD52DABE
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
	TAGGED_FROM(0.00)[bounces-36359-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Keep that setting only for devices that use iwldvm.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 5b2a5e254d6e..0ce8d6229bab 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -27,7 +27,6 @@
 static const struct iwl_family_base_params iwl_22000_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 256,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 2936ccf1dbb2..c55995fdf1c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -53,7 +53,6 @@ static const struct iwl_family_base_params iwl7000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_16K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 3e936ba7f871..182a8bf5bcf0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -39,7 +39,6 @@ static const struct iwl_family_base_params iwl8000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 7194f681cec2..55db225a02fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -30,7 +30,6 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 1f862748e33d..b355384ee210 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -22,7 +22,6 @@
 static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 7b3837b2a8e5..589bc88727a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -22,7 +22,6 @@
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 12feac3bc0a2..ecd48aac4e2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -23,7 +23,6 @@
 static const struct iwl_family_base_params iwl_dr_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index f82ba1d64b63..75a9a1c56dd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -28,7 +28,6 @@
 static const struct iwl_family_base_params iwl_sc_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
-	.shadow_ram_support = true,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
-- 
2.34.1


