Return-Path: <linux-wireless+bounces-37865-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id feRjOL6FMmrL1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37865-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 13:32:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C506991A3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 13:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=E1s8+Qgz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37865-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37865-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E16B31B4C64
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779093EF67D;
	Wed, 17 Jun 2026 11:23:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566343EAC75;
	Wed, 17 Jun 2026 11:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695400; cv=none; b=aYKbov84uXxrlbu0lfdNTIGtsPGlh97sUVRTS69RZBjJdB0TXkwVIEAXpTb67eTb8DHUxF7rd4h7OMJlZWJIpqoHSeOn7beT161rl/KZWFyKLe+bQzD55q+HQDnl7mzFTPWYjVn9bDgi+NEYMqLPgMJ02TNA5TOByZq/44n4d2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695400; c=relaxed/simple;
	bh=ADETP/5rknY2UjBxNiyrsJCYzC5BqaPaUNbks176lQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVYZ0apqGniWgK5B+EqYPhvTTPh9lLvKDcCfz7EIfKrBqw9SyOzF5QO8F3IwpztEQ836Rr3sxjT2W/pBGVAAAonzYK0Rh7TEuUbYE8cm6f3ecLokjC0+pVE1KJmPeaPKkAOu84utAg2ONtzTYez15ejujXKE8uKLT+cproSJUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1s8+Qgz; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781695388; x=1813231388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ADETP/5rknY2UjBxNiyrsJCYzC5BqaPaUNbks176lQw=;
  b=E1s8+QgzZEG+7wKcqeml49if5eCKc2MOTXuiqCEhFE4+X+CEZopkLPsZ
   /agddaGEglUaLCDfAS/jPOCu3kavxiAuPDhXgYooJ7ydhBMByzluPd9DL
   IVRaHxLVcSRj6i/ird1wULBezMIKKk6pw/Zd7tUMNx3TLoXkbCLU0H6wJ
   AYkBI2Kz9z9AmX3T6Ti2lhpfoGYApi+TAmRji0EYI2ljzVawWoN2nG1vw
   1Pc9eYQQwIquNzsBbUr63omSHz4XwGvyUPWuzrlNRBmBeHbu9/rtYIRrG
   sIMP3tXE8Z9NY+NvQTI7OE93jz1bp4F2RGMiOlMffuXSueMqvmBCs5F85
   A==;
X-CSE-ConnectionGUID: xGRCgwu/T8+Eo1Z2RjXlhQ==
X-CSE-MsgGUID: dNNTUyokSEul6KzI9mkUvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100048615"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100048615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:22:58 -0700
X-CSE-ConnectionGUID: kEnLJ2iLTK+RnrCRShVrdg==
X-CSE-MsgGUID: 9ogJGVmcTAWezYPsqjp0Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="271756531"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2026 04:22:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 76FAF95; Wed, 17 Jun 2026 13:22:55 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rfc, PATCH v1 0/2] overflow: Convert size_add() to take variadic arguments
Date: Wed, 17 Jun 2026 13:12:35 +0200
Message-ID: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37865-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84C506991A3

This is an RFC!

We have already users that want add sizes of up to 5 arguments and
I know about at least one that also wants 3 or 4.

This is brave move to make size_add() to take variadic arguments.
The second patch is an example of use.

The implementation includes a case with a single argument on a purpose.
In the future it might be extended to take an array as an argument,
something like

	int sizes[21];
	size_add(sizes);

where the first element is amount of entries in the array (the same format
as used in get_options() call) or other possible variants. This can be
distinguished by _Generic().

But it may be dropped and we require always two arguments at minimum.

The RFC just to collect opinions and perception. Note, array3*(), min3()/max3()
and all like that also can use similar approach.

Andy Shevchenko (2):
  overflow: Allow to sum a few arguments at once
  wifi: nl80211: Call size_add() only once

 include/linux/overflow.h | 37 ++++++++++++++++++++++++++-----------
 net/wireless/nl80211.c   | 11 ++++-------
 2 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.50.1


