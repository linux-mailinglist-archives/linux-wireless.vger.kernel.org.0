Return-Path: <linux-wireless+bounces-33735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG2zE6CrwWmUUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:07:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2722FD955
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE293078C29
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CB1372661;
	Mon, 23 Mar 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHCby0bs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2663372ECA
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299787; cv=none; b=iRcvG6yEMqR4h0mrRBCAbaQUrF84gqXJiN771Bpr9OJFXxEmRcNPdG8mHRjrP10rjVgg5hPJNRlJYvXW1UKC548VGDMSYUqxMszL08n6s5NaZXOazweeNzSiZgrmPQH8PeYnbrYz04MyJ+Azxe0xGm5C042bvfEWzgqg61wuPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299787; c=relaxed/simple;
	bh=Hk871Q9nGks2H04+DQgFaQ9XM6NpJ2VNoWQio0sVQaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsiQjxaVguYF7mHzWfnvU3iEuTSHFWiXEzuczufuMPNUfrIAzoEhZaHACaRuWN/kesDYE4tLJDgS1vlfBEMRF33aIjSAnK+/FAyCrBRcC+dO7YRgyxNmdpU5WXMpfQXb3nnI5+Bx4O2RIOJ/NlzrHqjlU6tY8IObXpWy9AMtZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHCby0bs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299786; x=1805835786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hk871Q9nGks2H04+DQgFaQ9XM6NpJ2VNoWQio0sVQaM=;
  b=aHCby0bsz1oRa+kj7LR3rp8SOWzunQh3sZKvILRbK7HsusNB0iWKyDC9
   Hm3Bah395I4F0/jNbyl+LWCXrkOIlxEAEuQJ8bHK+reikby6FJngm8+sV
   2reUKJeIIUB81NYjZQqCGu8fAG1nwtWZrgpRpCOanz0tgrN4AiYRlUw5H
   c62vtKv3VD2QpCOeR9fB5FIz+8xz/xOy3rVJ3SNlzrxVOU37wPJoo72ne
   Tlaonr4YhHPO+bFRxkQ2qdWkuyvRT1Z7melL7yinVG2qqtrI+MfpX13Ue
   D9ZgG64NU0QTWqdoYc4oPASIqMwuPV4QT1MQIQZVz90icM6YXOijA0yiK
   g==;
X-CSE-ConnectionGUID: JFYpOV7fSJOcPESPAZyBQQ==
X-CSE-MsgGUID: WmVUtKeCQtKRiQZKlKD4Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92882517"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="92882517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:03:04 -0700
X-CSE-ConnectionGUID: sWgvXdG6RPy1e+gr/wpp1w==
X-CSE-MsgGUID: gU64avE+ShayG2UFOq8kYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228206218"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:03:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: Add support for additional 7 GHz channels
Date: Mon, 23 Mar 2026 23:02:50 +0200
Message-Id: <20260323230242.072942e8e55a.I20eba7b534c6402d5e55f862865ff1e6fef64d83@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33735-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB2722FD955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilan Peer <ilan.peer@intel.com>

Add support for channels 237, 241, 245, 249, 253 and support
for additional 320 MHz segment.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/chan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fa0764ede9c5..2dcf18f5655e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -317,7 +317,7 @@ static bool cfg80211_valid_center_freq(u32 center,
 	int step;
 
 	/* We only do strict verification on 6 GHz */
-	if (center < 5955 || center > 7115)
+	if (center < 5955 || center > 7215)
 		return true;
 
 	bw = nl80211_chan_width_to_mhz(width);
@@ -325,7 +325,7 @@ static bool cfg80211_valid_center_freq(u32 center,
 		return false;
 
 	/* Validate that the channels bw is entirely within the 6 GHz band */
-	if (center - bw / 2 < 5945 || center + bw / 2 > 7125)
+	if (center - bw / 2 < 5945 || center + bw / 2 > 7225)
 		return false;
 
 	/* With 320 MHz the permitted channels overlap */
-- 
2.34.1


