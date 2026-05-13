Return-Path: <linux-wireless+bounces-36386-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFPCGmGJBGoxLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36386-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 16:23:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F3534F8B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7989C3026EB7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B443306775;
	Wed, 13 May 2026 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyvlAjOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050D2F9D98
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681204; cv=none; b=WIXdsLNuIvSg64XuSPA2gUflEJYUZA/9wZWYdcOj+w2YgXD32pjoBt9ANLMiQxe/hlWkUE8l8CMy9flgtst5A09oYuEsAe6ISfYehP3/IPt8/FSZ9vLxkiV8RjFqvC8D+mjQ2X2yBXSdfAtqgeb84xH/UFz9zJMWPh+NFF5aYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681204; c=relaxed/simple;
	bh=L/W/h5hvF9v5cBHWSBQKkZX6UYqAciaCC3oGwUTrbeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAI8oJ8uc1MqgNOuifMVi1720RZ6xGAe1IBsteN5IViUKsSbMbdZPvBQIJ0WrpVj2KLz/lVYdPACrC2fMacVLEfyOflfZja+57nPh1xjBwv4uPjzjzt8Bl2XOT1g1S2oxfBd7Zl5uRuBK70yadwuvDSE5Ma90c5MbhHnCnxBE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyvlAjOZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778681202; x=1810217202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/W/h5hvF9v5cBHWSBQKkZX6UYqAciaCC3oGwUTrbeE=;
  b=eyvlAjOZfagUlVBqRWasPMQ8nuuAfeCYJ63Yl73ad8Ytlls8rGhcfjef
   26A0APstPtVtJtwyo2yjnd0hgbNiNbw7qXxj95hqzVWe4eiuddAP4SP0O
   6LsLyWTiBUO1SJpI+6gVsJ5yHo8XpYoLHANm4GPoXlRbfpXLIGi6r5mmp
   UCFQV7er/5h4hTAtCDfFfOo7BkQtkyrY4ZARM7JKtopAMIDn0TDB7D+MI
   scjE5LLPLv9A+SqZuBgFcYRJ9oHCF69i+m0jYFRSRtgG/kX5/5gCAt6w4
   /ANge8wYMXXaivt/M/6YyA9lVQDDOL+mA84j7Ufaz6CV5LIpkIrg5n2Da
   A==;
X-CSE-ConnectionGUID: sJroYBuBSRmmYyPRKViJKg==
X-CSE-MsgGUID: 4Cp/PEYTQ7em/DiAfMG+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79591431"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79591431"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:06:41 -0700
X-CSE-ConnectionGUID: rn1ekUZWS1u+y6rtiqondA==
X-CSE-MsgGUID: S0YGYFDuTdquks4ILow5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="237990730"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:06:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: don't override max_amsdu_subframes
Date: Wed, 13 May 2026 17:06:27 +0300
Message-Id: <20260513170623.828dbb58c782.Ifd2bfc190c26140e919127adb02ffddd7b551499@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 385F3534F8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36386-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In client mode, the extended capabilities are handled by the kernel
looking at the association frame.  When the supplicant installs the keys
it calls sta_apply_parameters and it doesn't include the extended
capabilities since those can't change after association.
As a result, we overrode the max_amsdu_subframes that we set after
association.

Check that the ext_capa coming from the user space is valid before
looking at it. If the ext_capa is NULL, it really means that the
extended capabilities are not changed (as opposed to cleared).

The default value for max_amsdu_subframes is 0, which means there is no
limit. This value is valid and in case the association response frame
does not have extended capabilities, this is the value we should use.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221079
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b77d57c9f96..f9ee9947a94d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2344,8 +2344,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		sta->sta.max_sp = params->max_sp;
 	}
 
-	ieee80211_sta_set_max_amsdu_subframes(sta, params->ext_capab,
-					      params->ext_capab_len);
+	if (params->ext_capab)
+		ieee80211_sta_set_max_amsdu_subframes(sta, params->ext_capab,
+						      params->ext_capab_len);
 
 	/*
 	 * cfg80211 validates this (1-2007) and allows setting the AID
-- 
2.34.1


