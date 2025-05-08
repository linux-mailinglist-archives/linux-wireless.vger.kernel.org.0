Return-Path: <linux-wireless+bounces-22754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91646AAFF89
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 17:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAED517E392
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A4F2798F6;
	Thu,  8 May 2025 15:49:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5B22C321
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719346; cv=none; b=JJ51KDr1UQJLqcZT+3FHT0hn21bz29b0Z2qbeBmPCO2xyuX2OAlFFhTZxz7Q6nqndqba//eNLJ3VZLFMQa+4gX2gHyLnst4GewEp3wldBm3nVLmNRDpIVOQsr60x0Lf/2b5CkFCcR9a7nFdhnxwzhgXn97MjRUgffRnFXzzZDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719346; c=relaxed/simple;
	bh=CThFNMFKx4HWp2XE28KqxH2Y1BwNwB82Ka51sKvSg2k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mUo64t8J2PNA+r784QP59idRVFdljXaP8GutDq/Qh6I7JIsdK7lfclPopgk+AnfYAb/fnjPS8eImpXTI2fmsERrlr4r5wJzH+lPdQVNkfQ5AI1dvCBzzKDhM3OFf+17CBKMk9pBGxr1cu1yaACmF6tIDCxAqvzWGm/hPZY/zDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86465e3f1c6so221322539f.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 May 2025 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719343; x=1747324143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD+jxVgbrfQVFDofzdatQtArk4oPWbWikKud7IOptlA=;
        b=GskqlLLcZp/rIevHPRgKGzWl73xUMY87aZKK70sTee3xvNs+XenloTnFwETJGDfjoU
         tsw4vMihYkKA8IXoSWjgTuhKfggqDcvZAYKCX9diE2tZsGlW+YSxxGpyfu60zlsE5kFb
         dVzeYRy9p13ETBGZWZhqv10ObLObs99B9g3/p5bpxZgq4/YIoNQMMEexRbNlSC3V9ZtW
         z/Epq+0ocayPfAO4ZAY04uNqx4nTLedAOEnd1QFU6NznGaKamuSJxmhBRoclSRhyX2n2
         zvw2D0ZP2Fe8QCDkI7oxHbcqWiomJvNw7p2xwDpRubFpohiJO6iLueqBR1Xj8FwIOmSE
         zeFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkNZ3LVSCfasvGt7acn5T34IMGAhGT4Bi20OvfP/5AfO+4DfQRZx2BI6ODZZ1AxSyFrtMBkC50tmMbRZWcHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lZfNcjqcnfgG7hu+pUl41V/gVIlhLQ5PXeaAX7sDRm5//4VX
	sLa9meI84U43fzYOPOZ1qdPHaTcs5ces/E+Iw3+F8fETEwAyi/QwsBDBxS+WvQ/EfOWtdsgIc9A
	g45Lqeu8yu4Yz7D2/X7JCoVsWv05DY8aeO8w4LLI2WWsOBgZycIs5Dj4=
X-Google-Smtp-Source: AGHT+IFZWx+Z2aq+RnZG+0pCjh3GKc6ah8W6E1+BJ41KJTho9rKRkt85qUUCAas8WRzaxK7EdGyTRM8BLnJDYWP9m2RcKnrwtHLE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:3d3:fa69:6755 with SMTP id
 e9e14a558f8ab-3da7854f6b3mr43699355ab.5.1746719343684; Thu, 08 May 2025
 08:49:03 -0700 (PDT)
Date: Thu, 08 May 2025 08:49:03 -0700
In-Reply-To: <00000000000054bc390618ccb092@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681cd26f.050a0220.a19a9.0116.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in minstrel_ht_update_caps
From: syzbot <syzbot+d805aca692aded25f888@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, m.lobanov@rosa.ru, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 16ee3ea8faef8ff042acc15867a6c458c573de61
Author: Mikhail Lobanov <m.lobanov@rosa.ru>
Date:   Mon Mar 17 10:31:37 2025 +0000

    wifi: mac80211: check basic rates validity in sta_link_apply_parameters

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101444f4580000
start commit:   0ec986ed7bab tcp: fix incorrect undo caused by DSACK of TL..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=d805aca692aded25f888
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fb56e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17490685980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: check basic rates validity in sta_link_apply_parameters

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

