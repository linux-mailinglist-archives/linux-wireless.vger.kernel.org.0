Return-Path: <linux-wireless+bounces-10392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84259378D7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BFA1C21683
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36D143881;
	Fri, 19 Jul 2024 13:59:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D526135A79;
	Fri, 19 Jul 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397579; cv=none; b=OAG4R46VUqVdM9qp5Bl8j5T1sddB+Q3aR5rz3aagd3xsGCfs68IXNYOwZ2DeLQkqGr+4b/aoiptrwB/uNzihbOVd65lUDHCR54TaCY+zpV/6o8wfv1crx9XhsNDia5HGSPu3mok1z9IISHVkVPDCOtVwLCzxLGr5jcxlg6o4D5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397579; c=relaxed/simple;
	bh=CPRQ2AzofVjzVpyIMUJ9syVL0qe638Z9cjHJX8hhcXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=L1tZ/w95eF3ukylIg9o0k2veamJbnEK+GobGr8EYr1CHCkcIayxjkcR15ezrVU5D4zGefvRHJ0ziolUvZklJG6lnPahn6490QDr6nSaqxxY+Eh3FdSS137VtaHvDMNUVCHbDVzxiLJOA90n8kiSyyl5X0jQTujYAhwZ5MRD6ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46JDxKl6097974;
	Fri, 19 Jul 2024 22:59:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Fri, 19 Jul 2024 22:59:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46JDxKjw097970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jul 2024 22:59:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <15930e85-3b82-4119-b1ef-d899ac03fa3d@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jul 2024 22:59:20 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 rfkill_global_led_trigger_worker (3)
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <000000000000114385061d997d9c@google.com>
Content-Language: en-US
Cc: syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000114385061d997d9c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a deadlock which lockdep cannot detect.
Please check which lock should be taken first.

2 locks held by syz.1.2508/23558:
 #0: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #0: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x63/0x2a0 net/nfc/core.c:1165
 #1: ffffffff8f8e1b88 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unregister+0xd0/0x230 net/rfkill/core.c:1149
2 locks held by syz.4.2510/23544:
 #0: ffffffff8f8e1b88 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1a9/0x790 net/rfkill/core.c:1297
 #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down net/nfc/core.c:143 [inline]
 #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_rfkill_set_block+0x50/0x310 net/nfc/core.c:179

On 2024/07/19 22:15, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b1bc554e009e Merge tag 'media/v6.11-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14478ba5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2899dbd4b1c2b65c
> dashboard link: https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c44f53981874/disk-b1bc554e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04c685d98327/vmlinux-b1bc554e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3627aa754881/bzImage-b1bc554e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+50499e163bfa302dfe7b-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org
> 




