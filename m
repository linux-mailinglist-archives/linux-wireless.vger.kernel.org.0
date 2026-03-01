Return-Path: <linux-wireless+bounces-32324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHZFCDLbo2kNQAUAu9opvQ
	(envelope-from <linux-wireless+bounces-32324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 07:22:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A82A1CE9B1
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 07:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E28301E20F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2026 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE330FC32;
	Sun,  1 Mar 2026 06:22:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7F2DC762
	for <linux-wireless@vger.kernel.org>; Sun,  1 Mar 2026 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346153; cv=none; b=U0hiHCzPqCQVaKdGyCpaUS8swH7fGHAoQln85hyO3TR/nf4C+m39O88RvDfSnN36OkUAp4aKOt2xtkN+9/rIQOMzf44dZ4xk1Xkxjl8Atu2MIkPLgjv0SGbFFJ9f2S7IbN7faKdCMJeYJLi53jReaUBqfuPh8Zkwg4cGOzPjdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346153; c=relaxed/simple;
	bh=f1FiQs+aGJ//S8Y94Kii5k1eQ7Z3X8sngnQBQI91bmQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kd+TK19sJHT1mu6QRjTs8CHJJe86I3NqDTPbF3/0MSNyKYo2iAc7sNc+TVzJjMjNljnq+KNwQJhRy10GXXr5zxqAvzIrlnsyn5yLKL0MePxvNyjJFi0ByxJFVVoSg/BH6ANkrK3RI5QT1nHmI1deIK7zyEouylQzC+SPBOsG3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c448d15cso54456878eaf.3
        for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 22:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772346151; x=1772950951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCkTIOkqY5tRrpKdFM8F2itNl2AA74quBHKheHKTgHQ=;
        b=OFjYmoXtPWhbt555t2BWlJOQA5Jp/Es0PuGKjOej21cUj8A/xrg8yRP9xdg2b0Vnkx
         xs0DsATGffDFIegcromSjtz+BqynjJ/rLugz6hN2PW2Ui51nyQZwEpb88Zeu81hgZb06
         VCK80rD+r+/F8SXl60WdVeKdZo41MT84AMfE8z0wbXGIfkfpfE/zSsRP942HGOC0IhDq
         LuPUpejo3JbPb2vU+8KdFExcV4lJDIDS2xyyCyD+MhlAWEPyXbnldqjJezsJY1LAeJlR
         C7t0yEcTiRHOODm1wyllgV0KxC63dCwCz+tms+AkjkI2kbqUL596ZF52wZOdnLxYI7hP
         2NNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOV/HiJmFTBDOyIque6kY+eKBxjHFnUJIpwtj5b49rKzLAdSPT9MW3WGdXwnS/Y8mRg8m8nMxOK9Ot0qoTqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzse7m4bkd0TTsYSGzvzauuTrIuBiY5zBTRZGq+OChkQv9aa+x8
	xyUyNjraQMEQQQOZRsF/do27qPbSMkpRSz4LW93b33Nrnd7p55Cd7wkwXtVwLQ2sv79ZUXwakdf
	3e44LIvcKVHCNSQO0oX0lPNJMaHv/1tKu7L6/GIGwSQkMjY3QOhAVm4VkQQs=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b10:b0:672:a49f:128e with SMTP id
 006d021491bc7-679fadbb765mr5581714eaf.8.1772346151442; Sat, 28 Feb 2026
 22:22:31 -0800 (PST)
Date: Sat, 28 Feb 2026 22:22:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a3db27.050a0220.3a55be.0053.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2026)
From: syzbot <syzbot+list618a5750a9ad1341b093@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32324-lists,linux-wireless=lfdr.de,list618a5750a9ad1341b093];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email]
X-Rspamd-Queue-Id: 6A82A1CE9B1
X-Rspamd-Action: no action

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 51 issues are still open and 172 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  26998   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10549   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  10251   No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<4>  6932    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1043    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<7>  864     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  790     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<9>  691     Yes   WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
<10> 354     Yes   WARNING in ieee80211_tx_skb_tid
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

