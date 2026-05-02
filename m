Return-Path: <linux-wireless+bounces-35768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPvkHgTv9WlAQgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 14:33:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF84B1EA9
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9507A300683A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0C3451D5;
	Sat,  2 May 2026 12:32:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7F33AD8B
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725155; cv=none; b=MGORfCoMHt5mQGnFzazGWmykLjSSKUmEndDf+V5WFE50dXBrGzRQ9ao+CMh3pj2DikCRz98DEYugzJB8QAWQVGF5GWa10U2h0kNKAeCHxmmv+R6fj2s5BxQ92wUEC79Zo+kikIL30HsiWUDVyRrpvwTLGu7hzB5Spe379itU3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725155; c=relaxed/simple;
	bh=sTr2k1p+vYAdc3NlN2mbDcOc2gd7gos7jK7isFMlanc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cJmFlFybU8uWRbVZ5GUL5C2ZJwgGLJIkGrQTeUh562ZU7cbtjXEKB/TLvxyo1o9luUp1V82svPmbgDReJipb3LPA4/8PFqEhDP1W2SRpJqWayY9Gb8HLTmkwjYiiXiMJdVFrlulsi8z94CLbfW4Lg47XUmAa9LgFATxZDwijhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-415e1ea16b4so9688227fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 05:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725153; x=1778329953;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qjec6RlBuMYLsnhjQESjpB9D+UssHcI3JK88LEn7a5o=;
        b=SaFKcaPNieZbLsNYD/LfvprgXp8sq6lAs7O8FCUnLeHDR+bD78sgu9GHGuniDDLYpW
         45/eJ1+6EM0CsSHU4/3QZ8JyGVtJrLgu8L5+/WWPi6ZP0gbMMW4A9mGMLisEi3C44K+2
         7JSHjiN0UDkzKs7rw/0mfGTvJXnLcASArBELH00tLnOf/ZFfXnoR95sshXkFVze2EVVA
         ys3kVaw0IYIxraeBTjwyZOjmd31rh41RvINlKcV/rjRBr3EU7j2lMUlObqtmFwh6eW4l
         mDW21mZTQUDq0MZXtnMkCVu+bJPJy2ol+39TqHBguVZc8zQxbRIdbDmm4P7HIlrcFzwP
         7gSg==
X-Forwarded-Encrypted: i=1; AFNElJ++VfL/cMeNilt97Nn9GXLg3Zy/CyLTphLqRHg/OgcGvZKe56J3J0bFSrADn080amOc74xEdk9etqSW1flBaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/GvnlBpRslZI/s8yQmRaZfrckeCOLdRWetN10NKCVP7sRp+V
	5YsUO43Em3Nu/fJdkPYFZF2QhufhMFW+fopyWfL/7vUC49N+PyQSfzJnz/d+g2utJ2e1qrmX+ux
	JtScUMlcnsLkzOvoauZOANp9+ZychQfH3Y2poH6CBZcOgQvXKib0OYmfbFwQ=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:20c:b0:694:8f5d:3cb with SMTP id
 006d021491bc7-69697e18bcfmr1275076eaf.57.1777725153292; Sat, 02 May 2026
 05:32:33 -0700 (PDT)
Date: Sat, 02 May 2026 05:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f5eee1.050a0220.3cbe47.001c.GAE@google.com>
Subject: [syzbot] Monthly wireless report (May 2026)
From: syzbot <syzbot+list042322f6865e4ba59322@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 27EF84B1EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-35768-lists,linux-wireless=lfdr.de,list042322f6865e4ba59322];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,googlegroups.com:email,goo.gl:url]

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 174 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  28976   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  18964   No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<3>  10661   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<4>  6955    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1227    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1049    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<7>  903     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  827     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<9>  624     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 382     Yes   WARNING in ieee80211_tx_skb_tid
                   https://syzkaller.appspot.com/bug?extid=8bd4574e8c52c48c2595

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

