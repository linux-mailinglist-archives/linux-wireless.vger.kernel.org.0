Return-Path: <linux-wireless+bounces-33770-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FCiHoFcwmlKcAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33770-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:42:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC0305C58
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA84F304D725
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DC38656D;
	Tue, 24 Mar 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELdj7Gmc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0983D7D8C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344824; cv=none; b=JOZ5G3XOUioyYhAVI8pmVmXDW1Fx13KZWj1wpFQwDfjdCK/tZ7QqahFc4fhTj992Y+9Dx1kYHMSwKz/JL15lyC8Hc0D7NSI5lq9889W7vsoT7CfSbSZF+sHlQkiWRPi7iqnKMa9N33wCEgyV5ae0UBiYdI/UlGe2rTf7QUX+xDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344824; c=relaxed/simple;
	bh=rqggTOV5SAxJReEM6cQUnSmEdYWIxDyHRuQmWizw5Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZZqg4SMPXwJMq+0Nj+Jbn5eZKsnM66D1Z0VkorBofeyww9kNzTrUHqGDMYE/bcs2gyMCU9T7J0uL0Pd2BA6+B7lNF5yEQNmATtk5I690coDpdjKGxNnQ+Z5J4Db7HdrN/Os7TLnB5hf3Nykp8gDQfDLzttBN7UVys28nEagCiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELdj7Gmc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774344823; x=1805880823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqggTOV5SAxJReEM6cQUnSmEdYWIxDyHRuQmWizw5Cw=;
  b=ELdj7GmcfDROw1zTD4LEgFptRhaFWngfPtUET4ujZMV7dS/86wD4AF4i
   ew7ZaEdGuYA8k8+zxgeuCjKTz4kP71pJ0agME79Qi7AcJB0JzMP2nf2q/
   FTSoYh6MTTJrk/mwCcZqqcTYz+kEmo/2snqMvAXsUdIovjzW0vTLZQq0J
   l5cTTG5iZjii+x7lZCfDhs9ajSstX3Gt1OWU6oawURUp66jjC0p07vfT5
   M9XZhtnAhZeEBQZYi+S9/36AO7KSOx5S9+ElUMiknGwysM0YEJUs12EOU
   wfZNX93mN8K1n2X0WxZFJod8YRsYDJkfNqUXvwOCELmJSiSbVbYIsB7Yf
   A==;
X-CSE-ConnectionGUID: TJXUvDE/RWmKmA0OEneM8g==
X-CSE-MsgGUID: zKcBJmqpSoicrrlsx6GmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75239819"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75239819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:43 -0700
X-CSE-ConnectionGUID: QgPhSXIqQKeuWjR+fXoG4A==
X-CSE-MsgGUID: ubnw9GUtS/mAXQKtq9EyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224302425"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 2/3] wifi: iwlwifi: mvm: don't send a 6E related command when not supported
Date: Tue, 24 Mar 2026 11:33:25 +0200
Message-Id: <20260324113316.e171f0163f2a.I0c444d1f82d1773054e7ffc391ad49697d58f44e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324113316.4c56b8bac533.I6e656d8cc30bb82c96aabadedd62bd67f4c46bf9@changeid>
References: <20260324113316.4c56b8bac533.I6e656d8cc30bb82c96aabadedd62bd67f4c46bf9@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33770-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 08EC0305C58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

MCC_ALLOWED_AP_TYPE_CMD is related to 6E support. Do not send it if the
device doesn't support 6E.
Apparently, the firmware is mistakenly advertising support for this
command even on AX201 which does not support 6E and then the firmware
crashes.

Fixes: 0d2fc8821a7d ("wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220804
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 43cf94c9a36b..6cc78661116e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -470,7 +470,8 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 
-	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210 ||
+	    !mvm->trans->cfg->uhb_supported) {
 		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
 		return;
 	}
-- 
2.34.1


