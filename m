Return-Path: <linux-wireless+bounces-37533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EvFCJNPyJmrWoQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 18:50:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE149658EBB
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 18:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=gByIDUOw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37533-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37533-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4922F3378444
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F840B38C;
	Mon,  8 Jun 2026 15:01:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD040B394;
	Mon,  8 Jun 2026 15:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930864; cv=none; b=RZMflG0aFQF78iaktua7ryVY9fQ6HJgT8+zVx2gt2ErI8AQE0D59ZYmSHECR8Zci8NxtLB5UNsf1sbyz35Z7XhX6OLvbzyEqg5IoWYffWK9oJR8WA7kuBn56eekXTbc3FEoXn0s128cbE+WzPtjlRPeeUKJoGAF1/tQ2tspZ2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930864; c=relaxed/simple;
	bh=qKrhQOYPL1jH+FwHjWkUDK+oj4AaexvsWle+enQ79p4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTvhhgojGdUghs0uzq9Q5iACqULewTUroUSaGpZjO2Y6kJuinBjhWPA63ibaeNT4bXV9L4ShCg1KMXSFmPF23YZoXVwyPQ2O1j/QpZpPirEdG8o3cPqoYz6TjVv0J8CA02e7XXd0M1eq2AinjZxtswipFKi5aQtwXRLLPbvPsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gByIDUOw; arc=none smtp.client-ip=45.254.49.198
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41892486d;
	Mon, 8 Jun 2026 22:55:44 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Mon,  8 Jun 2026 22:55:43 +0800
Message-Id: <20260608145543.3443390-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ea7bb841d03a2kunm97a81824f7dad
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaThkYVkIZTx5KGEgZTkoeQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=gByIDUOwfE1q/8PPm6NMu+yqRxDlyRm6k+SWBu7qCqf3ZS0S7EKWbelVGZMI6SYq8NKgg8dkwF2Ug88gQYcy1HdWloZUa4SG66TjDWt6y3bv0/C2kpY76wjpaCUZJhYtqXygz+03X/Q7DT+IaVt718pwXowlI4fBtllou0sM6Ac=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=kw/nDUG2zASFV5Qd6ti1o6r7oZc94QWLD2pNKq9DU5o=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37533-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE149658EBB

If kmemdup() fails while copying supported band structures, the error
path jumps to fail_rate. This skips rate_control_deinitialize() and
leaks the initialized local->rate_ctrl.

Fix this by redirecting the error path to fail_wiphy_register to
ensure proper cleanup.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
suitable mac80211 device/driver combination to test with, no runtime
testing was able to be performed.

Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f47dd58770ad..9306e0af3b5f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1599,7 +1599,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		sband = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
 		if (!sband) {
 			result = -ENOMEM;
-			goto fail_rate;
+			goto fail_wiphy_register;
 		}
 
 		wiphy_dbg(hw->wiphy, "copying sband (band %d) due to VHT EXT NSS BW flag\n",
-- 
2.34.1


