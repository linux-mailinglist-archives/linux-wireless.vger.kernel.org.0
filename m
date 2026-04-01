Return-Path: <linux-wireless+bounces-34255-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODwIBnzOzGlFWwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34255-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 09:51:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76040376479
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 09:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B00A302410B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A94386C31;
	Wed,  1 Apr 2026 07:42:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A13806BE
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029347; cv=none; b=nP3gjpywXpRA4ORHyCEqEmVyXj3Ev/hZ7hQIsdGQSrPyQ2OHg3YGgfasD+2QBvob9d1JfDgU2bGXxXIByObMN0Kcp4C+85JI6bYGTlRlWTlICZo1lxPqN+Id3jUFE18Ajf2pGS145FrHS0IPzm7n9R+D+3CByfxzTw5QjP7jmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029347; c=relaxed/simple;
	bh=txXUfYvaeQJYycp0fUA9LLKONMLQ2GKqQcMKym2NH8s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XZ48zWzJbSkDBxIqsKMnGMdn6x8sWAtD51Z9Ms8nYbmaOY/FyjmrmFOrE8Datlf0pxPBJbpEh81XOJTKDX9DDSgD2Cl4qMkMR21SX5t3oXXPn51B7xMuLFFKnQQHJNocj2pGND9BnGsGThDk+E5I4/6fFbzz9+khqRpS7yG/Y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-462a9191720so16659530b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 00:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029344; x=1775634144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3gTuXpKCN7VYI+q2l2Hi9gL9Ghm548UsftJe2Z4drE=;
        b=Ut592X9a0wNg+0DaTjas1drBEr0JXBQDAGvfz0tDfPVcOgOzwvw0mF9Fd4J82zUANF
         VY5hexU+2CsT2ja72TQpk0lMEpUsaWxm2YmoAOB7u4CDj9/bh6Rn2/GDSsL2Jyqab/4s
         qxTCfUudiX+M3LOwFEo3/cRy7zIVsvBA8O9c95zAtVFxUZn8AXbTAYsEKOhCQe+wJ+Ak
         z4cI93XSq/GlA5KzQBAuGNXLQPXOYoP37Yn6s/KBHTp3p5y+L3kc5Mf8eGS056YAAHln
         xzPteOeH6fYe9Eu9hyy4B/k97fv6Pzpp+Ug61aJMBJU9O91ql6RKfS2VDidZK6c9dzpq
         tnBw==
X-Forwarded-Encrypted: i=1; AJvYcCXzul4xzQPwvkhVZMpspEqNuLvqP1Pu3DA4rS9+VlH4RWsTWIr9+d7twFYWCmfwY11OkXddP9tlmqatnUvwyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ebh8832xu0UWkk9uFLwYZf7vwxDE3KANTMN0G6B7u7U2lGui
	PeU4BnVqNBs9J7GpflnPia1xP2DuANyO+ynEqesLXP+GBAT7Q9BYCgee+p/BPQdB90JWd/iS676
	HFkH59QPe+remnoXiVJA4S/CaTtrAlmS0ddfOcKSCaAzK2/tsztTTDJ5I1QU=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1745:b0:67e:fbc:de68 with SMTP id
 006d021491bc7-67fabc08953mr1169405eaf.26.1775029344454; Wed, 01 Apr 2026
 00:42:24 -0700 (PDT)
Date: Wed, 01 Apr 2026 00:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cccc60.050a0220.183828.003f.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Apr 2026)
From: syzbot <syzbot+listb52ea0a54d3fbb4630b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34255-lists,linux-wireless=lfdr.de,listb52ea0a54d3fbb4630b8];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76040376479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 2 were fixed.
In total, 51 issues are still open and 174 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  28045   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  14590   No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<3>  10607   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<4>  6950    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  872     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7>  810     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<8>  790     No    INFO: task hung in netdev_run_todo (4)
                   https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<9>  719     Yes   WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
<10> 619     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

