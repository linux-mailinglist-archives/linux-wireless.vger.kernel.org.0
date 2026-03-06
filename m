Return-Path: <linux-wireless+bounces-32586-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mINsJ7CBqmkHSwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32586-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 08:26:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46321C710
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 08:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 553F53065335
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335862264A7;
	Fri,  6 Mar 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R33urU+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A130F7EA
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781850; cv=none; b=GN4jrt479NblScb0+2Lpa5uznFpOSWy3bthrbkp1wT4z7jtE+cCYKCOEsee7rs4dssYmY6n8IShmR3qteLl6/qQHE2GGdkfbO1Rfk27M2zSKUzSlb9swn2qMy6HWxmaN4Q/bBsNQG9DT0jqhHPvFPCja7Zz5FKVhirQDoD2ZJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781850; c=relaxed/simple;
	bh=wEIWJ2kTRcYulJ0H84vdMW1ci+rHr2L7Oquff4r6WNc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AWZxxcoPtqD6kyz10YZ8SoCQwu+8mr9vyQVBXMxakhCUktdr3SO9x5mVdLTa52vHPQQMlC0sCK+Sl2q8zd8oaYHQpOFYt0tfsA0rlRhrhJ/4p4v5HdVHvMI7HXKJ2VxWvdslQTp838kq+xOPcQpyEcCJeL64zHiWdR8n2LrU2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R33urU+u; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae502a1dd9so67000425ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 23:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772781848; x=1773386648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VbhahzfFKovRH8YTa5ugBlDrP7nAiSq8irUd/ygeRHU=;
        b=R33urU+u9ZqduxqvxiXd2lUpagTig1W2567lM9ZgsquIsbVJ0JeEzLeKKIV9F1JM8d
         wHozP7yuo8WgshRECwuoSWgPr+zuTeHC5nX2GG1DfuH1SeVJQpjVEwzFycptHXHXYPiU
         RxeuG5AMg/cbSOQvHDs5AAhsW7G7/U87Uu/D4yhF0JaZyFATGeqtkt0f1U+tKMs2Mroh
         od5TxUy67siqf2Fp8Wn7AvqPXISegVgw1INMC7XdWEkBVCqfXBpT1TMbtNHbjrykXmO2
         54zujlIyB2PgRUQo7gDMQmRxAOcqPEEY+WrQY65j/cmdqM5iY/0D3h54eAvsDS6UPAGE
         1CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781848; x=1773386648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbhahzfFKovRH8YTa5ugBlDrP7nAiSq8irUd/ygeRHU=;
        b=VzM+o5+iqcrJ34LRQDmcnnRqWsZ7zC6vdP3JO9jy3KhF2NTod3vCtC66yFimuzlSb5
         oiKnyUh52g/QYEW+HzQAe5rdWPSDNGqqEju5kGabLHfebkPMP/Bw/WwUZwABkkpmZBrb
         2hDOgdRZdvFb2/5D5JCklfix+aZmKE/M7cbwe5YXHhmIvTLQCWNSkTgymzKAGm7Dboa3
         Y39YZqeTtQS/4dikkMWdbd3dkJc7UP/UJLZtop9Gb+6ZLqVWc7gHX+ScJc06gaCxIhKW
         FiAjg8+nMb+MVF8o3c22rqpbfgYnKoAv+Q3ixv+wEt14j0Os7HDmIEYGPsb6d6MgRJAX
         QXUA==
X-Forwarded-Encrypted: i=1; AJvYcCXgSPZpIToSK1Ye0UlWdM3vOyBUvJZDf3lOAsyQDLojqtrDvG2TRcyRVsWN+4GEn5jsqzCnSt9jYCX/RtDSig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4RV8u85mvNTpUDnTTv34BkeBcAIHFbSmlfa8FgkE7HPA2F+E
	Ti7KD6bkQrka3do3mwXBI8cO6JECVU8c1AUMx949GiiwNS4lRaa+G3RFg/aQ1F02iXY5zA4OhKB
	aj/FJow==
X-Received: from plq11.prod.google.com ([2002:a17:903:2f8b:b0:2ae:5e9d:8d47])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54f:b0:2ad:dd69:76a2
 with SMTP id d9443c01a7336-2ae824dd0bcmr14991645ad.31.1772781847901; Thu, 05
 Mar 2026 23:24:07 -0800 (PST)
Date: Fri,  6 Mar 2026 07:24:02 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306072405.3649474-1-kuniyu@google.com>
Subject: [PATCH v2] wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-wireless@vger.kernel.org, 
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2E46321C710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32586-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

syzbot reported static_branch_dec() underflow in aql_enable_write(). [0]

The problem is that aql_enable_write() does not serialise concurrent
write()s to the debugfs.

aql_enable_write() checks static_key_false(&aql_disable.key) and
later calls static_branch_inc() or static_branch_dec(), but the
state may change between the two calls.

aql_disable does not need to track inc/dec.

Let's use static_branch_enable() and static_branch_disable().

[0]:
val == 0
WARNING: kernel/jump_label.c:311 at __static_key_slow_dec_cpuslocked.part.0+0x107/0x120 kernel/jump_label.c:311, CPU#0: syz.1.3155/20288
Modules linked in:
CPU: 0 UID: 0 PID: 20288 Comm: syz.1.3155 Tainted: G     U       L      syzkaller #0 PREEMPT(full)
Tainted: [U]=USER, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:__static_key_slow_dec_cpuslocked.part.0+0x107/0x120 kernel/jump_label.c:311
Code: f2 c9 ff 5b 5d c3 cc cc cc cc e8 54 f2 c9 ff 48 89 df e8 ac f9 ff ff eb ad e8 45 f2 c9 ff 90 0f 0b 90 eb a2 e8 3a f2 c9 ff 90 <0f> 0b 90 eb 97 48 89 df e8 5c 4b 33 00 e9 36 ff ff ff 0f 1f 80 00
RSP: 0018:ffffc9000b9f7c10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff9b3e5d40 RCX: ffffffff823c57b4
RDX: ffff8880285a0000 RSI: ffffffff823c5846 RDI: ffff8880285a0000
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
R13: 1ffff9200173ef88 R14: 0000000000000001 R15: ffffc9000b9f7e98
FS:  00007f530dd726c0(0000) GS:ffff8881245e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001140 CR3: 000000007cc4a000 CR4: 00000000003526f0
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
RIP: 0033:0x7f530cf9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f530dd72028 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f530d215fa0 RCX: 00007f530cf9aeb9
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000010
RBP: 00007f530d008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 4200000000000005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f530d216038 R14: 00007f530d215fa0 R15: 00007ffde89fb978
 </TASK>

Fixes: e908435e402a ("mac80211: introduce aql_enable node in debugfs")
Reported-by: syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69a8979e.a70a0220.b118c.0025.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use static_key_enable/disable()
v1: https://lore.kernel.org/linux-wireless/20260304204317.1921550-1-kuniyu@google.com/
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
2.53.0.473.g4a7958ca14-goog


