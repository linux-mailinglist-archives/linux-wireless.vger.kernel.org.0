Return-Path: <linux-wireless+bounces-37397-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AdCyHPj+IWqpRQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37397-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 00:40:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3123643D36
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 00:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kuBs0nqB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37397-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37397-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77B9D301A172
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420B36A36B;
	Thu,  4 Jun 2026 22:40:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791D175A7E;
	Thu,  4 Jun 2026 22:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612848; cv=none; b=dDMiER5ljCRYd7Ysvn6h9zVmBmEDnO++p85shkyvIUNb8WCcSg8AG7BqBZRjD11znydEVh7tQZzA32zNHYwqycHxz6xwG+tMgbtr3O4LESkAmzZ7F0xobqL+Z4VInWExgg+oaLVZeWkEq1+QHxBsCCH5olOBD+taug95Tbhm8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612848; c=relaxed/simple;
	bh=EX6csmbrJqEzxCbHsVp7F8OYRVjs7FwhFm2n8H80xew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PbQPxaLpwzmmz3X7kGf1EJMFRqBpPwRdQf+UEqblsUoWLYpQ0dAagatA5Bx2pN2wQrDXPDzVv+ymQkZeNb1imPuf7sWDWtMRU3a7CliCgneGSWp+eACc2LqzRQfae6FO8GDyzEqsANeRXT9d4JPWE68QALQmm0Y27XBX/Z6bBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuBs0nqB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7471F00893;
	Thu,  4 Jun 2026 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612847;
	bh=vNSWf7nSgDH8L2l2DjM7pdv9xwtZIhfH8fKI+ltDrRI=;
	h=From:Date:Subject:To:Cc;
	b=kuBs0nqBArB9Quu4d9LMMxXU2532mvXaQW5vfH8b7Mz0WJSr1+xaXFcY/9AYHvtKx
	 ynlTht61ukSw44QuXtfvRpCOIy3i6+pvxn5xik04n/ppxC24kR6Dvss1XS6VpSyvF9
	 1tFOW7T2H63xJfkpe/iS8UCBfZPSvvwi9Z+HHyP6Al8XVWVqDugcFhYwSVhikX2n25
	 HtFt/jDvSARSgEicgCYvsw1dVMxdFynigu2xG/kv46guRyxRT7dfuSp3NlnyoHv1jY
	 gNxJHJffpQH3osuvb1Ff2VtV4KS4kweTyrA1if9iM6qioLYzTqwxtw+d19ud2p6IMX
	 gieRo4aqn6i2w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Jun 2026 15:40:41 -0700
Subject: [PATCH] wifi: mac80211: Fix -Wc23-extensions in
 hwmp_route_info_get()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-mac80211-mesh_hwmp-fix-c23-extensions-v1-1-25a64d6ce541@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBBF0a2U+XYgiTW0bkVE2snEREgsmaqF0
 r2b6ueBx30rCJfIAudmhcLvKPGZK/ShAQpDvjNGVw1GGausajEN1CmjNSaWcAufNKGPC5I5Ii8
 z5z0geOpHR966zvct1NZUuK5+P5fr3/IaH0zzHodt+wKPv1fwiQAAAA==
X-Change-ID: 20260604-mac80211-mesh_hwmp-fix-c23-extensions-59bdcf6d8f94
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=nathan@kernel.org;
 h=from:subject:message-id; bh=EX6csmbrJqEzxCbHsVp7F8OYRVjs7FwhFm2n8H80xew=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmK/97kXZe4uEZu3ey1/RMrg80+GLq9C6oOYV+abpEgu
 ij0z4LKjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR/mMMv1k+BT11feI34/kJ
 h2ih/7kZtxdO9Vj73VKHIa1XvWxOEy/DP9WFW1u+Jv/00mT+c+nfgZ1botStdRyP7Qn9Fcr4gt3
 YlAkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37397-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:morbo@google.com,m:justinstitt@google.com,m:masashi.honma@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nick.desaulniers+lkml@gmail.com,m:nathan@kernel.org,m:masashihonma@gmail.com,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3123643D36

When building with a version of clang that supports
'-fms-anonymous-structs' (which will be used by the kernel instead of
the wider '-fms-extensions'), there are a couple warnings after some
recent mesg_hwmp.c changes:

  net/mac80211/mesh_hwmp.c:373:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
    373 |                 struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =
        |                 ^
  net/mac80211/mesh_hwmp.c:390:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
    390 |                 struct ieee80211_mesh_hwmp_prep_top *prep_elem_top =
        |                 ^
  2 errors generated.

Enclose the switch case blocks in braces to clear up the warning.

Fixes: a91c65cb99d1 ("wifi: mac80211: Use struct instead of macro for PREP frame")
Fixes: 4ac20bd40b7d ("wifi: mac80211: Use struct instead of macro for PREQ frame")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 net/mac80211/mesh_hwmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 84903737271d..7f962b003579 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -369,7 +369,7 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 	fresh_info = true;
 
 	switch (action) {
-	case MPATH_PREQ:
+	case MPATH_PREQ: {
 		struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =
 			(void *)hwmp_ie;
 		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
@@ -381,7 +381,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 		orig_metric = le32_to_cpu(preq_elem_bottom->metric);
 		hopcount = preq_elem_top->hopcount + 1;
 		break;
-	case MPATH_PREP:
+	}
+	case MPATH_PREP: {
 		/* Originator here refers to the MP that was the target in the
 		 * Path Request. We divert from the nomenclature in the draft
 		 * so that we can easily use a single function to gather path
@@ -398,6 +399,7 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 		orig_metric = le32_to_cpu(prep_elem_bottom->metric);
 		hopcount = prep_elem_top->hopcount + 1;
 		break;
+	}
 	default:
 		rcu_read_unlock();
 		return 0;

---
base-commit: a26c2a22e7e88b2b5afb1349f3994fc564c988b1
change-id: 20260604-mac80211-mesh_hwmp-fix-c23-extensions-59bdcf6d8f94

Best regards,
--  
Cheers,
Nathan


