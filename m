Return-Path: <linux-wireless+bounces-15780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F679DB707
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC4FB20AD2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0F19AD86;
	Thu, 28 Nov 2024 11:58:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463819AA56
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795084; cv=none; b=PJedSpHh1pQh4UUOazOezqeDLeyOy1goGpTMhFlmrFt4oVm63e9OP8MGk+avwFGJGL1QFfyncwq5b2JkXv4IXY+NC5WRdQUjOYRj4AYdtSjpDTViQ7WwKjMbQzp9gwTncZjEXkIaIJB3M+Qkini8g8r2NCDsA4sa1JkrjZJUAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795084; c=relaxed/simple;
	bh=OCJWJ+u4Yh9hvmQMZXkM8KRn/EgI9awMfpPqzOpmNeQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1MvDOJMHAr6Hf9IZELsr6I/4qX/ua0C8pgdTHaxfEoYCZE8WCfKAmQFkCJH9e9+3yxz8SpWTBxzJLMXn88typ/YtcUPht+Mo0uZ/BvnxGDBAP4xsa+x2XARZBKRxMlrRyAwPLENY3JjMkuEwLyWHKJDdXYLz02vP27l7J36KXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-843e5314cb8so64715339f.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 03:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795082; x=1733399882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4G4wt0qmrICABsL3fTmVUbz6tUyHRU/aFIpdT35VU4=;
        b=MZBWwo9nd37jY5ujJSXgb3goPxgT6sW9+EpbL1At3hlSnS4OGsuIIOjPaXM+Dhs7MD
         6Q1zUYXBEj8kukNq8ZvV2bu018N9qjDAw0gt/Pd42UEOxaJWkbqZKFQGYuEx/NN9MQO3
         e2S5xK6KaTqnmVzPhYMhHm7ctS6cFFlIJ182c07ECO5Ib9qxqAaZM146h/dYJTCRiqiL
         Azi9XWGa6944+ZkXzgptqpFyoVym0unVVu8dZ5naCOFvnWAz4VQBl+SqH3TbWwcHCvqT
         bdm9XuIee51GhRNoUAEkd95MnbIJ+qdIdztCeyKcIQAXOxlRy3NQi1jdPKapOZ6wXIZZ
         pF0g==
X-Forwarded-Encrypted: i=1; AJvYcCUSaaiieSnseSdO6jbUXsZ+Oe2Pa8+ku0BwRlkoOJXtiUvkFmnoxNGKW33eSpMQ/6IKKflN4eA/ngYTpI1KvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzisAsUNRg4Qh94PyutlRDphqvcWxzA8b25H7V6YN5RfYkjLohJ
	6AzdHI7qvzTbb/ydtU6Jj6ZfS3/EPtFc1fQRepIJUHiuqjFAk71VE4Pov1T0FA85LYmAtbMQFcj
	AUwcAUZtxCu4r2/SCoC7D7bR4IOgenhc1imR55pL1qdcNhPApfcQF5dk=
X-Google-Smtp-Source: AGHT+IEVZ7aUJUgjShFgHR95vCPF7KZvaAgWHrtmMp9hLIBxTo6zaewL/H4pbgsZ6+AQhlvQFduZe6J/eDefsrYwF1fpY7cEo7si
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:6dde:c78b with SMTP id
 e9e14a558f8ab-3a7c55446e3mr62921795ab.8.1732795081892; Thu, 28 Nov 2024
 03:58:01 -0800 (PST)
Date: Thu, 28 Nov 2024 03:58:01 -0800
In-Reply-To: <000000000000ac553b061e675573@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67485ac9.050a0220.253251.0082.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in plfxlc_mac_release
From: syzbot <syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, kuba@kernel.org, kvalo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	srini.raju@purelifi.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124
Author: Srinivasan Raju <srini.raju@purelifi.com>
Date:   Thu Feb 24 18:20:07 2022 +0000

    wireless: add plfxlc driver for pureLiFi X, XL, XC devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15001f5f980000
start commit:   cfba9f07a1d6 Add linux-next specific files for 20241122
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17001f5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13001f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101a59c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bcc778580000

Reported-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

