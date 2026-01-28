Return-Path: <linux-wireless+bounces-31284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEQ7KJKQemn77wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 23:41:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD8A9B14
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 23:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC1F30727EE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BE345741;
	Wed, 28 Jan 2026 22:39:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285E342CB1
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639979; cv=none; b=RWiLi3w06X3V7TeQZ8+x3e7ZsxThfgXpYJHiAF6xMtuBvo7n+Wr90pUjBY5EGaIoE41pP0C71ZPP9njxumJ0YIjbn1J/dWdVs+2nvup6pFMuwmBAb86IoCFsZdP3TLnRHrET82LmD9fyixLQ04B8D5PWo5VweysYA87kNdKZOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639979; c=relaxed/simple;
	bh=L7LMowbbFe74UE736M0mXofgeYBJ75YSZFR7RyVsQPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CTEtQhyyUxxevjTYCfXbT8ZA/BkpjqpMb2mzezLMIH3BV8SX/jo7k6Vj1BPKoXak3FpuXJUj7pY/uVbUh5RDK1WheJ/pLH98KeNNxO2cwOmWqDkJzrPNo3E9cpMUay2tkl99eyl2nUDxTwAPH/JJc7kvipZPuc9JACBnFAUZRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40450320b4fso990449fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 14:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639977; x=1770244777;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHLvlDBwy9U71exMZeCWgguqy+MJQInJDJn0tuli10E=;
        b=jQxXxml8QReBEY1ko5KyNRWqnZ7jHTt3LY7GroWnIz7oV9CyL59BAZesGrVTVavrvY
         plfMBn9UDuJ68ZeblyZF5iVbqrYJcr3Gt5sD7WR/bp40dnsNgDgFQNafCNvB4z7+7WZc
         /SC84JjK/7jP6twX27iEI1WXO1m5qmGfU3H5Ciq8gIfybC/e4jhSTdn6IZxs242I4OTs
         EgVmh2cK8MZp9dMeDKue7v4SOjNAamI48J76w7t/IPpaBIpyvCOFGuKq5jHRPgc+QZ1X
         xrKivGo6Wd3kQWU8tWRrKqdSmoJRl62IuRr2U+PoLedDl7UKT2IWGLA0abQqC8pS80LG
         1nMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdK1yTyRveT6FWLHgHGfaMuBf2rfagjKcopU+6iOEiH7t0V8Cp9893XtLdalRUjr5J+WXeN8TuO+twcvvwdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82EVuyegDlPvgWWLg9NgdbQmkAWDPueMP7oSxndw/qHmFVMB1
	MlhkxY4OU0ZXP/fm/C77v28CAgl2q8Kf1oed18+S2GRJY5TtpbnOd3TTn9tftYUMzLJjdakcpyf
	u9Ib9GqkTsQZuTJ3loj1DrSQgpLbxxPgDdVsrT+ccs1epK+ZPerXXlVJCHlM=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4888:b0:65f:70b5:1a89 with SMTP id
 006d021491bc7-662f20b3034mr3350391eaf.49.1769639976817; Wed, 28 Jan 2026
 14:39:36 -0800 (PST)
Date: Wed, 28 Jan 2026 14:39:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697a9028.a70a0220.9914.000e.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2026)
From: syzbot <syzbot+list6aea27ca2eabd5fa9140@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	REDIRECTOR_URL(0.00)[goo.gl];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31284-lists,linux-wireless=lfdr.de,list6aea27ca2eabd5fa9140];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: C6DD8A9B14
X-Rspamd-Action: no action

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 171 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  25396   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10510   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  7244    No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<4>  6921    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  2111    Yes   WARNING in __alloc_workqueue
                   https://syzkaller.appspot.com/bug?extid=392a2c3f461094707435
<6>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  1026    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<8>  842     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  750     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 648     No    WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

