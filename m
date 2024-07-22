Return-Path: <linux-wireless+bounces-10427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66697938D83
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E01286C89
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02616C861;
	Mon, 22 Jul 2024 10:30:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3716CD07
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644204; cv=none; b=D28Ajv2uUtmBkTHaeo2Qv2+Ik3WqEhPbGnm27g4jDdmYgDyA/AKAQI2h7ZOrLrbxo5i6rY7CNw4vuj96R3xDV5fhAYShme1tSFz1oOJuyIDIMQiGdrHtQrQtbVbPZtY7M6T2dB/PpGTUUO4uTEKERbjRMc3PqAJRi4p+eMrEVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644204; c=relaxed/simple;
	bh=Ur1D8QSGjku8Q7G5VKP6kNkgy6I95SWKMk0a7rsRzXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FoBrei3kKAz1jX5Zy4b2swscqhw9hrkTHw6ttCdPp1MDJJl5w5AReq44JtgqGikyn9sHKkWO7ADQUTHrNIaDnuAeh4Of/C+lmx1d6/PQVuYnHe7/7T8XX6hajhVjUwA3pcoReyRm0Jz8AqY46J3um6+C2zyITGjdRGFd5MCv7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so721566939f.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644201; x=1722249001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVbnRnfiSWMo/y1Phwm1SFR+PjHhye2aSEowClDCq1g=;
        b=dPYWyXLBYAuJgw811PMywQnIaI4NRN/yTLqNqonHXcrBBJ+e5CNmi9y/EEvlBLpSm1
         XjD2h2D5MKLnL2jRcgoJ8gxl+gJ3vGJv1s37ghgMpVga9HK4jsxtqLJi0Aa5VHNgH4cx
         s70W+9LPBGFgLGWjjJEVVm8U7dG51RpFAxUe2v5gt1bcUuwG7UPQowlJAMjK+wUcFrP8
         gHWbvD5wbOfTU7TNYhC5VjkpD6CgS90JFnvoArV5uRcfXTUX+EethSxLQcJ1K+Eg490B
         Am6oOIS8kbJdQ47dbfgdzZpYEkiiiM002N6W4r3k+lainjkWd/L68ff/+ylKyhvxbkSp
         7QOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlSjmdaPK3sgj6Sfzyh0OaKjOB8fjDl73+TOYd3ytQsZ7Wt6nHK2lNBot2e8JHz3eFc9/Lnry2oonmDo5IKjbtEG4a8ieKHWQ6+AUiofY=
X-Gm-Message-State: AOJu0YxUo/G2SeduFSWdIfORmlAeCye4UhWOwZmuysRYngxBk/CBLmaH
	ur3k70VnRLa07iPEFmBkr3csecVDkX06h0j9Swiy9KYUk0iRfgSD6HadtGXnzluIJwrhFnj5qQz
	RvArz+NEG5RFpgiVXjTEwe1KPBFnedEswOxyOzsOMpD+7YXM/FgXLPZo=
X-Google-Smtp-Source: AGHT+IHDXXNaDlcJzkclmypCXUcUHVIyEECRhqINQl0i+kJKGtZvlBOKr1PmAhs3nOlyECxZcDg4kI8y5bz3TrJBC4Rs/7iSWww/
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:397:7dd7:bea5 with SMTP id
 e9e14a558f8ab-398e17ac737mr8390995ab.0.1721644201658; Mon, 22 Jul 2024
 03:30:01 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:30:01 -0700
In-Reply-To: <000000000000fdef8706191a3f7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011de5f061dd387f0@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: clang-built-linux@googlegroups.com, davem@davemloft.net, 
	edumazet@google.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, pkshih@realtek.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9df66d5b9f45c39b3925d16e8947cc10009b186d
Author: Ping-Ke Shih <pkshih@realtek.com>
Date:   Wed Jun 9 07:59:44 2021 +0000

    cfg80211: fix default HE tx bitrate mask in 2G band

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e233fd980000
start commit:   51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101233fd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e233fd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14608749980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178b9195980000

Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com
Fixes: 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G band")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

