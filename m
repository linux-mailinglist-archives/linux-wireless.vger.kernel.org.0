Return-Path: <linux-wireless+bounces-33139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLABARLysmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF402764FF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6BD730694E4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D13FCB38;
	Thu, 12 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CL2UGWH7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B801DE2D3
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334868; cv=none; b=Q4z/8nmv4/Wpx0Kqv8oCn4+Mu3h3sqVa/eA7JFz1QymQzcSVcxMP+BWTu/9l0cBdzMNzXr7NkXayyNH9hTd7L4ZhLSCMHwJ9jZmjwz09ORZfumOXm5enpAAY9oIMZH5TPaYkqxWQWhr6NU+IRaREp3vIxZ1bCs7HTb6m9YTTRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334868; c=relaxed/simple;
	bh=LHgGdrpEDGO7fhwBZqgu90grTsnu4cD4saQAW1KFAzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeFGck/oi49CkVxSXj6X+O3EyA4JF7YM+QxNJGWI4dGINy95F+MckT0hF9iNpk/kxuKiHwaefHNdZsEAHgyuNQ3ZSE+3z6SGzZ+cP5leaWEjufTdAsr4mFKhzoGpHTcTZ/geP1Y4O3pbJhW3zKmbg2dMyySmBuG9LgqnProA0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CL2UGWH7; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2B7CB60007E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 8D1C913C2B4;
	Thu, 12 Mar 2026 10:00:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8D1C913C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334858;
	bh=LHgGdrpEDGO7fhwBZqgu90grTsnu4cD4saQAW1KFAzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL2UGWH77Nf5Z4789JV5K7N9MEbvaSS4+kOz4cUGcBunTRnr2WoiIek0c65j0mveQ
	 OF8hQ9/abbYFyJZSLuFv4l4KvficFT9jRcVsbBgizEQ2JOtvcAq/C+QAwDjLnrjyzb
	 vgJ10cRCCxFXaoOg3LX8dnh6jsY9hsLg9DSqobXU=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 03/28] wifi: wireless:  Check debugfs create return values.
Date: Thu, 12 Mar 2026 10:00:01 -0700
Message-ID: <20260312170026.285494-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334861-Tl7WMe3Pw8OJ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334861;Tl7WMe3Pw8OJ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33139-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: BCF402764FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Check for error pointers and warn and assign to NULL in that
case so that mac80211 code does not try to use it to create
debugfs objects inside the invalid wiphy debugfs inode.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/wireless/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 23afc250bc10..16cfc249fde6 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1041,6 +1041,12 @@ int wiphy_register(struct wiphy *wiphy)
 	/* add to debugfs */
 	rdev->wiphy.debugfsdir = debugfs_create_dir(wiphy_name(&rdev->wiphy),
 						    ieee80211_debugfs_dir);
+	if (IS_ERR(rdev->wiphy.debugfsdir)) {
+		pr_err("Failed to create wiphy.debugfsdir, rv: %ld phyd: 0x%px\n",
+		       (long)(rdev->wiphy.debugfsdir), ieee80211_debugfs_dir);
+		rdev->wiphy.debugfsdir = NULL;
+	}
+
 	if (wiphy->n_radio > 0) {
 		int idx;
 		char radio_name[RADIO_DEBUGFSDIR_MAX_LEN];
@@ -1887,6 +1893,11 @@ static int __init cfg80211_init(void)
 		goto out_fail_nl80211;
 
 	ieee80211_debugfs_dir = debugfs_create_dir("ieee80211", NULL);
+	if (IS_ERR(ieee80211_debugfs_dir)) {
+		pr_info("Failed to create ieee80211 debugfs dir, rv: %ld\n",
+		       (long)(ieee80211_debugfs_dir));
+		ieee80211_debugfs_dir = NULL;
+	}
 
 	err = regulatory_init();
 	if (err)
-- 
2.42.0


