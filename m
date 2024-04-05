Return-Path: <linux-wireless+bounces-5904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4042899D77
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311541C223B1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D216D318;
	Fri,  5 Apr 2024 12:46:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657A13C673
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321182; cv=none; b=jsaBgr1zpZtvDGZ4aJfEvRALTZuHe8bLvJZXO79L0GJToikJ0mWiA4/zCN67RJHEuO2cR/u2kxJKTDq4DIrqM8e/sdoh2bulhvD4wp/Z8hbsrgLW6qUkd6sDMwfzhQfNfW2PoQJLZgIrokgCrKwzKo1D/6No8eUvaXc+9gTdTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321182; c=relaxed/simple;
	bh=WRsBuSjHUzTQxBfLyZla+hkSSKIsEqFIsaME6OB+fEo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YtwE9EVVQVDYk41p4r4l6ZRtu0WsTIObDvfXfdLpEf/BbFeXbpOjjjJFxVQKa077vJTOa3av1+jaOBi2jW9bboeUa10o1NCGAkg+WiNTUv0GvhrUjkjVJcBPip7Q/DtGFwjqvkmrjOUukgayuY8+rMJ/FRRSg2QZcXSvAoMBpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc764c885bso233752039f.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Apr 2024 05:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321180; x=1712925980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12OUjT4o2BmUoPYzd0RNRensS2gycfoa6iSCUdJDBjA=;
        b=ncwkv+H5amFSj7SlCgcb/aQlW1cMCvJWTydvoXt3+dRiavLuC6fDmA4rohdXwlZewX
         hPqZ8bu2SgM5EBHvS5Sv0Dv6rZiGyOC15gW+Bbe/lUWhCVq06PCoOKAOFznnwsKD8ndU
         HZFL3t8IFO7N9Mq1BkwUQEzmmTZY5v9mggtJeq0oGTzJEOunzsFiWETkzg6VAqalI9wN
         1nlEvs/3feY/99714gnTO7EgmzQuhzYrRccaKqVF+YmbJ3BUF80nJrHe0ZYsIpCA+fys
         tT0djCaRpfnpqksZe6WYZjp8VT5CNJfl+S37dEPX5Wyyctf+l3zkSg7Zw4y+xs3cEygF
         /LNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjG16RyGNzHq6cbmyhOOqPOum2+Uwc/93QnBbBAMdau2f4ePgudESDDQ7d9xHFw1cGsbXU0t2Z/1d/VquXgiJi6NX61700Dan4MW8fYB8=
X-Gm-Message-State: AOJu0Yxs/CdkMULbFNQx05ztuGrDqkgd35fCtS+tlNwZSGvfCBt81fyP
	0KQ/eTr/YWxBZOhaqa8xcPdAsK029Hh97jQylDPCEHTPDmdecZQezISS7pCsS7D/49V6ymgQiPv
	6tS2A+mVkYBix8jvL4KFdJnu3F6/i9XJP0G6/Co9XbQ4xOgNVj3mMzP0=
X-Google-Smtp-Source: AGHT+IHUSX+UTWlSb1AR/cJOIfpFBOJBQ8I/qjxG90HqOzL/9/H8NsvcgYdPdnTHg42wBEgpmd6txjF7jo0+6QOsy/mwLPFP5/lx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c7:b0:7cc:342:72f9 with SMTP id
 l7-20020a05660227c700b007cc034272f9mr29400ios.2.1712321180474; Fri, 05 Apr
 2024 05:46:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4284f061558d73c@google.com>
Subject: [syzbot] Monthly wireless report (Apr 2024)
From: syzbot <syzbot+list390ce5482b806d5e0aeb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 31 issues are still open and 122 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7813    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<2>  7129    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<3>  4419    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  925     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<5>  862     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  761     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  47      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<8>  39      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f
<9>  7       Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<10> 6       Yes   WARNING in drv_remove_interface
                   https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

