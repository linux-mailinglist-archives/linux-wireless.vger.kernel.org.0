Return-Path: <linux-wireless+bounces-36360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE6nFLsPBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F352DAC5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243743073D0E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30752030A;
	Wed, 13 May 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RI0av2eK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA33A6B9A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651061; cv=none; b=okiVXRJXBxz/Mp+3HeILXZkJnBYK0G9AX40gZf7QUUdmXdKGS7+sKBvlbHHJl98KIsutMaKeuRqMeCFBkyL10OOIGxqi40RW1WYN3Lss8z3Uo1D9kHP0FlZpsFD/ihQEEGYOBKyjaI4ZLHVnFtHnAr4V0a+POzC/kFi37D52J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651061; c=relaxed/simple;
	bh=ffxW39t7lH3LsvOj+WmxXSywlEgqyDxk2cXWDwUsZ0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ws0DuKEm2ieOZFzMaPOKQ6kweK9ozBCu9f5u4vNNcKii+uyYqYqd+hCLCsSoYlooMMWOypVorFD7FfXLj1JHxtg+Tpp1+4kSYuC8336Xu67Ag7kZ8cjCpYDzT2rmRgFIck5bLXrrm1j5MPg8QfGkqcDDyMEDiwVrZLQIcDz5AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RI0av2eK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651061; x=1810187061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ffxW39t7lH3LsvOj+WmxXSywlEgqyDxk2cXWDwUsZ0E=;
  b=RI0av2eK5c+G7qsgPI1uyr22tIQGRSSrIcImIG/r8plKkc4c/fQmYUT6
   lpFn3EFFSojnkM3tHUGRVVKueqy0FRZVdo13y8LKCZKmhwOAxTr6TyTMr
   +l4oCV7FREb+T32BkOd9KF+dCDH+/D1BVpIa/jovrL76/Apssm+r23J4O
   uhqReW8dmWRGZwJMb86BQ/41lAzGXUn3lTXMYe3qpdHcqUXKds33gWJSV
   gK4ArFuoHu5ai13xmt8MwkVF8NRBH/vsdqOu801PRieUGZ533uXHg0vTp
   BsrWtnx8lg3jm7k5eWfv8OJMNLMOOIV4HBh8kNIfcpY9D3YKYlPMYkhLU
   A==;
X-CSE-ConnectionGUID: f3O/n1ExQWCt7cIP2hPkqA==
X-CSE-MsgGUID: wgC0LVDiQ0ap14/vPPz+VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552809"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552809"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:21 -0700
X-CSE-ConnectionGUID: WKiQx+19R+2HnxdY/xiIkA==
X-CSE-MsgGUID: kyKMkGVHTeqnPaG6Qlt7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: max_event_log_size is needed for iwldvm only
Date: Wed, 13 May 2026 08:43:50 +0300
Message-Id: <20260513084215.a83033e43988.I8a55f8ff0e7bc5f42a49b15facd8558708b7d880@changeid>
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
X-Rspamd-Queue-Id: 020F352DAC5
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
	TAGGED_FROM(0.00)[bounces-36360-lists,linux-wireless=lfdr.de];
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is used to set init_evtlog_size and inst_evtlog_size in case those
are not advertised by the firmware's TLVs.
Those two fields are used only in iwldvm.

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
index 0ce8d6229bab..563c596240b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -28,7 +28,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 256,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL_22000_SMEM_OFFSET,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index c55995fdf1c7..1be72d71fccf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -54,7 +54,6 @@ static const struct iwl_family_base_params iwl7000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.apmg_wake_up_wa = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 182a8bf5bcf0..834aa520ab0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -40,7 +40,6 @@ static const struct iwl_family_base_params iwl8000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.nvm_hw_section_num = 10,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 55db225a02fc..2954434ce851 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -31,7 +31,6 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL9000_SMEM_OFFSET,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index b355384ee210..ee24ded67069 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -23,7 +23,6 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL_AX210_SMEM_OFFSET,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 589bc88727a5..1b14ba5a09f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -23,7 +23,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL_BZ_SMEM_OFFSET,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index ecd48aac4e2a..afde84ad0493 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -24,7 +24,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL_DR_SMEM_OFFSET,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 75a9a1c56dd3..52a08105d0c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -29,7 +29,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.smem_offset = IWL_SC_SMEM_OFFSET,
-- 
2.34.1


