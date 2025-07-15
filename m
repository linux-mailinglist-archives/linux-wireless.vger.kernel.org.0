Return-Path: <linux-wireless+bounces-25428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16189B04DDC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A76716CA7A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F122C3761;
	Tue, 15 Jul 2025 02:33:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF124E019
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546787; cv=none; b=PhmNNxXDvwbGIvEe86kap6fezANTncbBuM+/AXWMM+OumZ7xeQSks7RRrSfSA33HTUyEqi4xN29yXQCgO9yx9s5HHXhw9USqXvocBwTVfYdmZYxA/j/rdU6sYs5lS1iG7iPOCCmutLgu9cIlIzLFea1QXlM+WZFY/2RX6tTpcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546787; c=relaxed/simple;
	bh=7AndiXTD4sbV5agjvgEfYoTGkIYfFDWFjpNYdv3Xtho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTFHPJvR/63R+4zALwOYWkY7EhWc+vVK5fTvm3AA68EfUsMUaGs+LCFZyCKsYzGBATq4wRJFzAzdXrRZ/a1neWatEglM9xk/PNqth4l+YRngDMtz5VnDPaQSRX7WdRrSsytj4p6nPyW9j0p+aRpWqnp4Ua0EfVK45MShTtSba94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso44025505ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752546784; x=1753151584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yE4JhMmA44lV+WjxvtXYki/dvYzl3IpMsCSep6EbVg=;
        b=dBIckFNXcqKVlq0umkGE8j7TKVjcVX0a8bI+abtO+bCf3tPl4L6AJhWOBNcCtYtEW2
         0zlYD4lbDhQocpVhH8lwUXcvoj94WDJlzk88oDbUwaBDXbys1StFiil2zFoNnYIo4HJV
         gaDBPv8iOaaZZTLaNWOFP2kANNb3x4kvThZy5lxJJq/ZrllakESYzB2BlxPKA7O0kxZi
         OGoEHiI5QGaaX7f4A8idbPQwZc2/po8UJAKDVHw1rn4MT9MeGiqWKwzvA4SbA3huA0Ty
         7KV9wnwfnpn6mKGglleAHg+yHcNdZ7kIMlcFK1o+AIkdaGWDQ43B9CcHF45AbMLw0pro
         iDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+sIEvh7vF9Ns8DTNil4FCw5dA1uewuMDiccABigQnv1g526ZI9A9rfy9Wyb27JnnpPYb91MpmMX7DBusRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/DB4D4G2Q4K1mg0a4NSL7r0v0Q9gtC/1W5V8IsMM/U6ITAMt
	RxrVqpeRGGqidbP16PIdVYtMLTUCOozDF6UkSwjRConQ8JVf+SS3/b1QieIwaWLLZYVkuQFVr1G
	3b0hwI0gCvCOpXQoLrBDqpAG/fXA4ruwJcZRv1TQhWJpxFr06kyMdnZROAPs=
X-Google-Smtp-Source: AGHT+IF2UUDClpYWB6viGBXYp28+nczoOwxL4W6ADfPyApY+NBZpSA62Hg8TL78bt20h7n3z9+OWCwAApBxgMoMd2psNr7we5eog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3e2532fc02bmr34673265ab.14.1752546784316; Mon, 14 Jul 2025
 19:33:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:33:04 -0700
In-Reply-To: <CAF3JpA4QvNvdx-tq-5ogMmmaOuZuYq8Q=JZjQj0egWGE-=Nogg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875bde0.a70a0220.5f69f.0008.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper
From: syzbot <syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Tested-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com

Tested on:

commit:         0cad34fb Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad518c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37db4c8907581400
dashboard link: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1183718c580000

Note: testing is done by a robot and is best-effort only.

