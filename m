Return-Path: <linux-wireless+bounces-38613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kb7NF+mMSGqprQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 06:32:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FD7069CC
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 06:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38613-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38613-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2429D30074CB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 04:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB538D3EB;
	Sat,  4 Jul 2026 04:32:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B129ACDD
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 04:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783139552; cv=none; b=fYvD3NPoFYN8tSSSLLZMNGATUeKN4dfYKPFBxu98x6T+e4NNZBvNhUz0hqIveDwQzQhA9rOcpsgaTp8atnkM6r0/Kn3Rw7sZJbq05N8oOJfe6mLO1c2z45MkFTnoo6N7km6y+NmIxz+9lqlV4M8rChWLjeWYw1whZfKyGkies5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783139552; c=relaxed/simple;
	bh=DVZrScrCHFw0e9W9NPMorP7NbJVBjjcPdL3WSxs98rA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dPgH+vpmEm+E1N53PtqdAhk0ORgLYgk9tpXKC90mQWcEP13YfNjrRflDcVtRpZmkntdXLRffkV4j6rAamItj9g7aPkzf602F2EGI8BjxlXsAtuqO0idePYa//A0hcmThABbDecqsuSRLc846ayjVLBRFmulfKS+x2jd8+ZLWo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a0e3320c53so1292417eaf.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 21:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783139544; x=1783744344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPiNMJouXk269z6DwL82Ol478mu/GZzWA83cGd2gkyw=;
        b=Ce5xDqCp06SYl2IpDdXONfN8QJ5gYqMocJL66EZQJoArYELzlI2zrwbNTXF47BdQp/
         mEHoGSakQO8OAmd5bTGcDN1oJFrEVJJcB2R5tkjLrIgy3ABvPF5F9tOftNNSHTF4fgPw
         8mIs9rzosuX5UvDY14z3/7Qy0wIK/+j+Zfx4tUZ9EkfnxUgnmNqYxaJYyjSVijzmncBp
         m3VDs7OqKL/eZ9mQkjML6XQkMdnB39VBvpH+SNVcGSqWJvPCdKH7mAzinHWDvtsAsNIv
         FpTX2/49Yih10Xoitw5Qx8HrusWg/s7ZGghIIqbE0mzJaVE0LmGBBh+rAAEJSu6ssN4G
         zW1w==
X-Forwarded-Encrypted: i=1; AFNElJ9OjQQnKciyTbRt4weZ6sLadmuRR5XQBHa33stsaUaLUweapXpVWFQsVxef4+vjSM0oJsuQ7gMTM3wjL0u1DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20oiH5iWkq9OhSgmpsSQOUZvYCIkwl7LDRSYKj0K2XCvdWA1O
	a791dMQCL5yZkbxYZd0xoyHyc6XZGOQfDYihR7WRpt0o3ix5mRU9FueenXutxJ2EsqlPdOp1TY9
	rZOzC5E25vc0EN3lLf8U+kCzyi84jUvXml1SsFOmCpJh9m9YuJ95tfRSq0YQ=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168f:b0:6a1:44aa:86ce with SMTP id
 006d021491bc7-6a32f4c1cbfmr967723eaf.22.1783139544198; Fri, 03 Jul 2026
 21:32:24 -0700 (PDT)
Date: Fri, 03 Jul 2026 21:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a488cd8.b42ede87.8bd1.0008.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2026)
From: syzbot <syzbot+list7ac59e6c13deeebf868b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38613-lists,linux-wireless=lfdr.de,list7ac59e6c13deeebf868b];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 489FD7069CC

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 3 new issues were detected and 0 were fixed.
In total, 30 issues are still open and 178 have already been fixed.
There are also 17 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6964    Yes   WARNING in __cfg80211_ibss_joined (2)
                  https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<2> 1243    Yes   INFO: task hung in reg_process_self_managed_hints
                  https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<3> 327     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                  https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<4> 65      Yes   WARNING in cfg80211_scan_done
                  https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
<5> 42      Yes   WARNING: ODEBUG bug in ieee80211_led_exit (2)
                  https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
<6> 1032    Yes   INFO: task hung in reg_check_chans_work (7)
                  https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7> 204     Yes   WARNING in ieee80211_free_ack_frame (2)
                  https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<8> 44      Yes   possible deadlock in zd_chip_disable_rxtx
                  https://syzkaller.appspot.com/bug?extid=0ec3d1a6cf1fbe79c153
<9> 21      Yes   WARNING in mac80211_hwsim_tx (2)
                  https://syzkaller.appspot.com/bug?extid=435fdb053cf98bfa5778

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

