Return-Path: <linux-wireless+bounces-32655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJl2Anczq2n2agEAu9opvQ
	(envelope-from <linux-wireless+bounces-32655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:05:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1222762D
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE2430177AB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDB2F0C79;
	Fri,  6 Mar 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gozaW/3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FB23EA94;
	Fri,  6 Mar 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827292; cv=none; b=O3xjkTXTYqCnaOUzkMkkpqKyql1b1a3zi/j8MnHkXtPZgQ112gxFpCSx7cH5m2cNAbsFxQf6MGNlyqB2CoBf1Dmgw2t/FZ5QNokPWAW33oM82jgoDqbp8ZSNWeCZ49HBz8xvq4VtC+ehg0V7sLUA8qCR7wVGpuY8sqbBrnkhqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827292; c=relaxed/simple;
	bh=wijbcDGTjbMj3PnEJELP2Lf1i/WIuvppNwvDFbUZceE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbcd62Zbx3n0KcQgExcsrn/MZPrymeeYCs+ndgSSO9MILv+pzwev6/R0AIbPaBikqxVsL6geDkugGIDQlOSkchnx1lLsZjdj5hYN3Q2Y5DX391FfOmiZnx2e3eCer49lK2/04SjykfwATHKrn84ToqKB3hbJOvtr3Uqd8YZvd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gozaW/3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958FBC4CEF7;
	Fri,  6 Mar 2026 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772827291;
	bh=wijbcDGTjbMj3PnEJELP2Lf1i/WIuvppNwvDFbUZceE=;
	h=From:To:Cc:Subject:Date:From;
	b=gozaW/3ArbTybX9JO+I1noudTAaGZoKDck+Gq7HfS/kRT/YHV523fun60tU9g4xi0
	 /6BW/R4EJhYCLZmnH3fFLcQ8lNKT3Q5HVUdJHIZqVFXb5e94chGKmKBM1QD0KuG/sN
	 qQxteOQ4zb5f/7Sgiiso06lOQ0i8UVvKqZjf34y9ua6pG86ntfCkgCtTSJ3WNFxybe
	 FF0KuUgfPgr8O2hpC7L0DFpjBOpLCNX2SK6fSv/wEqZ9j1Q4DYCffuAf4BiuZNyb8f
	 tJ8P9R0VxCalBSJbcfxF5ZLxpiudvo0JejbM/E0jVJ7D7Aap5eCx30MtkuZ4EHg1J9
	 mrtM1PrTwJuUg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-wireless@vger.kernel.org,
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: fix static key race condition in aql_enable_write()
Date: Fri,  6 Mar 2026 12:01:23 -0800
Message-ID: <890b1c1e0eec8f97426c1443745853250dc80737.1772827269.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62F1222762D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32655-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpoimboe@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

If multiple tasks are writing to the 'aql_enable' debugfs file, it may
incorrectly call static_branch_dec() for an already disabled static key,
resulting in the following warning:

  val == 0
  WARNING: kernel/jump_label.c:311 at __static_key_slow_dec_cpuslocked.part.0+0x107/0x120 kernel/jump_label.c:311, CPU#0: syz.1.3155/20288
  ...
  Call Trace:
   <TASK>
   __static_key_slow_dec_cpuslocked kernel/jump_label.c:297 [inline]
   __static_key_slow_dec kernel/jump_label.c:321 [inline]
   static_key_slow_dec+0x7c/0xc0 kernel/jump_label.c:336
   aql_enable_write+0x2b2/0x310 net/mac80211/debugfs.c:343
   short_proxy_write+0x133/0x1a0 fs/debugfs/file.c:383
   vfs_write+0x2aa/0x1070 fs/read_write.c:684
   ksys_pwrite64 fs/read_write.c:793 [inline]
   __do_sys_pwrite64 fs/read_write.c:801 [inline]
   __se_sys_pwrite64 fs/read_write.c:798 [inline]
   __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:798
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix it by using the atomic static_branch_{enable,disable}() interfaces.

Fixes: e908435e402a ("mac80211: introduce aql_enable node in debugfs")
Reported-by: syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 net/mac80211/debugfs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index d02f07368c51..687a66cd4943 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -320,7 +320,6 @@ static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
 static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
-	bool aql_disabled = static_key_false(&aql_disable.key);
 	char buf[3];
 	size_t len;
 
@@ -335,15 +334,12 @@ static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 	if (len > 0 && buf[len - 1] == '\n')
 		buf[len - 1] = 0;
 
-	if (buf[0] == '0' && buf[1] == '\0') {
-		if (!aql_disabled)
-			static_branch_inc(&aql_disable);
-	} else if (buf[0] == '1' && buf[1] == '\0') {
-		if (aql_disabled)
-			static_branch_dec(&aql_disable);
-	} else {
+	if (buf[0] == '0' && buf[1] == '\0')
+		static_branch_enable(&aql_disable);
+	else if (buf[0] == '1' && buf[1] == '\0')
+		static_branch_disable(&aql_disable);
+	else
 		return -EINVAL;
-	}
 
 	return count;
 }
-- 
2.53.0


