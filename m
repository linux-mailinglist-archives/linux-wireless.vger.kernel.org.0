Return-Path: <linux-wireless+bounces-33571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEGCHpICvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D136A2D7120
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28005310B07B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4C37187C;
	Fri, 20 Mar 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UftBDx2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78E37B3EC
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994187; cv=none; b=LxHyqNeo7Bmnsty98vfbZeBJv5CAwqh7z5yRoONWbdS1RUQV5iIfKu02Btihvkwv3OE3bvXdhUSLujmf8pz3C5/fvCZRuqRYSwkLvQGyS+4HvqclfAgjM85YHrmRGII2wGbDdOl1jAPr281A0sd9+rJr1o807/hF/QQQUgxAgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994187; c=relaxed/simple;
	bh=aiOKOuVZ3Un9pOzs2Vpulh3UgcYz2zifFdp4veuv/Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTtlnpTN+67DMTtUN15Z6+WP7yAJrJ9P2Ia04mpYWCH3tichgPBKJGddQ975Azez2R8xMTVm4ofuZZuM+2LG8IPBWa/V3EY3BNzyR3pHOBfBs7QUr1B5J8ZmMfmcPYN+iQfxqGTkYwm7xe0HRU/F4FDucL+/LDTm8qP7jYzwYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UftBDx2j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994185; x=1805530185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiOKOuVZ3Un9pOzs2Vpulh3UgcYz2zifFdp4veuv/Bw=;
  b=UftBDx2j+uEOuiU+D/d8zBsHoEqmBTBTVuUYI542mOXeimwoURYb5P9Q
   yacdgE2x404iPpBcBFUNzuqEuuMuTTA1YxhM7FDDszP6mB0CwwmB80YQL
   Kdxhyi/9PFJZPlgtkAu+X/AANBRib4YrvCItN2Lfn/PhnbvHK1iv54Nvr
   dDe+vZCXvvL5UUxXMlcJe3ONqTQrEDXQlR19s5yqmaayj2e7aO2b6nBUW
   00exk3PxWUeIm2ZuE/lG8Oo7gk/ohPW0fPsGte09A+ovskMWiGSexWdIe
   v4H4T1c8J9MzoN8B91EnJfxJ77vter+8MqthZHGIycpsuntMLQjVX2t9M
   A==;
X-CSE-ConnectionGUID: p4jFc29cQUiNE6x+dw+d+Q==
X-CSE-MsgGUID: UeZKmdMPQ6a+ZfV6Rb6epA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154144"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154144"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:45 -0700
X-CSE-ConnectionGUID: SQYgykHKSXaUptVy0vsJqg==
X-CSE-MsgGUID: yuY1R8xXTDyHh5ZAKdEaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692601"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: validate the channels received in iwl_mcc_update_resp_v*
Date: Fri, 20 Mar 2026 10:09:13 +0200
Message-Id: <20260320100746.0e83cdd88cea.Ic86852e622ed3ec06110f9e6525f72679236cf1e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33571-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D136A2D7120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check with IWL_FW_CHECK that the FW doesn't send a channel that we don't
support. Otherwise, the center frequency will be 0, leading to a
warning since is_valid_reg_rule will return false, of course.
Although the warning is verbose enough, the IWL_FW_CHECK will spare some
of the debug.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index e8f7d258b622..b78805ef3c8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -23,6 +23,8 @@
 #include "fw/api/commands.h"
 #include "fw/api/cmdhdr.h"
 #include "fw/img.h"
+#include "fw/dbg.h"
+
 #include "mei/iwl-mei.h"
 
 /* NVM offsets (in words) definitions */
@@ -1737,6 +1739,11 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 							     band);
 		new_rule = false;
 
+		if (IWL_FW_CHECK(trans, !center_freq,
+				 "Invalid channel %d (idx %d) in NVM\n",
+				 nvm_chan[ch_idx], ch_idx))
+			continue;
+
 		if (!(ch_flags & NVM_CHANNEL_VALID)) {
 			iwl_nvm_print_channel_flags(dev, IWL_DL_LAR,
 						    nvm_chan[ch_idx], ch_flags);
-- 
2.34.1


