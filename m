Return-Path: <linux-wireless+bounces-33498-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKS9IzdFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33498-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36B2D14C0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9B53043D40
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38B349AF4;
	Thu, 19 Mar 2026 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bf5CwH07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFF338906
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946155; cv=none; b=mYpX6msOFxjo/btfuoKBnKSfTEM6ZL3Hrn1mhLu8QclzAYRCz9A+0Rwct/GrTr+LIWvci5+VSwK2kIDzKbTCj7INQnbeawCI9PERQZRGQWIMMnaza11v1r/4+UmpO22Y/FuYskBtcA99nmZdxrBCAWxmLnojIuLPfnJ8/hoYwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946155; c=relaxed/simple;
	bh=c5ahbjzf78ZBlKVOTpgcAc08eu3o8kGlw5CWZ8P0CIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqku3QME/+L/QfoZq3EYmKeui3LvwKL+hMbzcWC1CPICUanqILsSucRJcuHHZzdnufWZqwsRzdUFxdwjlNyvfvt/SVzD5XZ02wJG9qDU2BzNpjPW4RLBpPGaTHoz9bLYD7JzyEjM7iNVOXOQ47145opra9jiuDGh+7dTBUQZqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bf5CwH07; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946154; x=1805482154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c5ahbjzf78ZBlKVOTpgcAc08eu3o8kGlw5CWZ8P0CIk=;
  b=bf5CwH07nxta0M9ypyNfzkj17dq690/xQfnMfktTXKyDEfEHpBhNzp6j
   uSgRu4yQAMdgDRRSbJy32VvcLHwDHB/MbmFxz5T/wmt6cltj3fqBeU0sh
   sjQ84jynAF28eWnWQVwXJYysp1NiLAV0IfTviori8JH67E1PulVVb/9uZ
   Drog/V6Sj8voJifmA9VAT77G6ZzDbjCRGWMtgnCCvLTrzEscnB6eXn5B/
   JTVqNRMIzItvuERwrPvl8FYz9FK/UIqCUnOYG7ODOUflhIyBZEW7HAGYw
   /DVoT9xqnLN2xFByCDLNtxaTSpEyFUZtfDwiEdfnOvfzjE9o2rcKypFnq
   g==;
X-CSE-ConnectionGUID: M39t3v0fQdW7FoAL8l/7Lg==
X-CSE-MsgGUID: ukwExrIsRE2aCem0NWkgtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656474"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656474"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:11 -0700
X-CSE-ConnectionGUID: tdBLVEC4SUa7VZWuONAawA==
X-CSE-MsgGUID: mnB58UqESVi2v7xsP9oROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998503"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mvm: zero iwl_geo_tx_power_profiles_cmd before sending
Date: Thu, 19 Mar 2026 20:48:43 +0200
Message-Id: <20260319204647.2d494b0f4692.I9afd0fa6b2ea5a27118144ac4e3bbbedc2089c10@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33498-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0D36B2D14C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Otherwise we may send garbage.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d46715abd7a5..0c643f0b7105 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -908,7 +908,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
-	union iwl_geo_tx_power_profiles_cmd geo_tx_cmd;
+	union iwl_geo_tx_power_profiles_cmd geo_tx_cmd = {};
 	struct iwl_geo_tx_power_profiles_resp *resp;
 	u16 len;
 	int ret;
@@ -960,7 +960,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
 	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
-	union iwl_geo_tx_power_profiles_cmd cmd;
+	union iwl_geo_tx_power_profiles_cmd cmd = {};
 	u16 len;
 	u32 n_bands;
 	u32 n_profiles;
-- 
2.34.1


