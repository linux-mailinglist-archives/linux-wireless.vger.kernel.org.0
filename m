Return-Path: <linux-wireless+bounces-39032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XoGRENkbVmoPzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DD753D96
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JZh9c04t;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39032-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39032-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C7E313F4B4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD43630AE;
	Tue, 14 Jul 2026 11:20:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9F382299
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028032; cv=none; b=TJh9IjmOysoczj7+/4p0jN8YP6QxyYznY5Du8AnA1YDimE9kJ5teu4hyO+xrOonvl7wMw/Pi6EAe9IaCt3/QoPTg2vXbty00liUdDHr9Xxhx9lmS5DRIO+PkyjxArkyaHUlw+cOeqwt0TJA6jKenjo5Sz8838RdTwmma9E5UUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028032; c=relaxed/simple;
	bh=S9V2CGgXTfY9sZnVk5ism3Adjgx7xGDoqZ/ZT7D46C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXysYsp7exgxOfSUMsqHQ9oxI+Sa6AJMhMBfEDeJYR6ozYUtq/PzrwKz6jckmqoylnjTBcYkSrMw2VSyy47T/jfN1zK2Z+H43kOFxUKB356ckBK1gJrUrBugrYQdpIwm1x6qo9rvc/9aYNVKr89Vx/UDnXVFxolZ+ZbRrsJyzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZh9c04t; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028031; x=1815564031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9V2CGgXTfY9sZnVk5ism3Adjgx7xGDoqZ/ZT7D46C8=;
  b=JZh9c04tU3x8yboja/lK80sL0YCJg1Rzuc7dVZnU4NUpXD2iqTLCDNtK
   ZI4PrdzHD6I3BjCB7Yh8ySleBcdHZ9ddJsOJqoSW8/zkmmtwfaZx9jebo
   LRD5Ew1hV1OAna+XTBA03+ARPOBIhMTJ8EryTdcoVzCJFxeuGDL9B6o6w
   /nOqeQ7ecnvHExyKlfioPLWxVTEDHc+OgBXbLOT4h4FLEF8Y+Wn1fyMK+
   cjrddX3ampGJJulwESqSKtF9Pdn/wSt8ne38VsX/jOx0Yrqr5yqZvKmco
   UFVqOCfDf4Lad6j1OSYiaRObXSYc29qxrttkFq/ElYHTFbMkb/jFH1I/V
   Q==;
X-CSE-ConnectionGUID: i3Wdh85KQdO11KqR3NprrQ==
X-CSE-MsgGUID: 8opIGKt8Q+esVSr850cm9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200306"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:31 -0700
X-CSE-ConnectionGUID: /6/A7ghdQKaSZcHO80X6Ug==
X-CSE-MsgGUID: W6QzuAhZRfiJOv2d6D1aMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250156"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 05/15] wifi: iwlwifi: mvm: fix the FCS truncation logic in d3
Date: Tue, 14 Jul 2026 14:19:54 +0300
Message-Id: <20260714141909.369588f93c6b.I1a4d13f276c7e75514ab2032ae387873337470b8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
References: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39032-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B20DD753D96

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fix a harmless mistake in the wake packet management code in the d3
wakeup flow. If the FCS is truncated, we want to detect it, but we
cleared the icvlen before updating the truncated variable that holds the
number of bytes having been truncated.
Fix that.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9a74f60c9185..d7ceb385ae0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1539,8 +1539,8 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 
 			/* if truncated, FCS/ICV is (partially) gone */
 			if (truncated >= icvlen) {
-				icvlen = 0;
 				truncated -= icvlen;
+				icvlen = 0;
 			} else {
 				icvlen -= truncated;
 				truncated = 0;
-- 
2.34.1


