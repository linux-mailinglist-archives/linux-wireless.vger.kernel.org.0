Return-Path: <linux-wireless+bounces-30278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB089CEE1D8
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE1B030006E2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF751DED49;
	Fri,  2 Jan 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RafPRW0X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E031E573;
	Fri,  2 Jan 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767348061; cv=none; b=dr6wbx2NJbrhTXXd9gL/7rfjjN4J8i01AE/y5nVIFDWT9Gn7Cm023Sbc4tVUR0n/mqSawNulEaUiaznSSrKFmypXwpXSMLDEOALKRCzhq4TJ3kQnu+0Bez6OhyNR+eWBUi1KtdDygI7nDOGRGd34/vDOoRZ/mdDWxbMAgdKxkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767348061; c=relaxed/simple;
	bh=uO3alF6Zq3I2FUn3PgzZJqkAM48dsLDrTU0qNG9HkCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u7xVsT9Q4nC5yVc7JZUbaWsPV43SfIdqSRrPxDir/P7RFH8Qos4LBL25hqV4gQTf7b6nPChz26Gr9uGlK1wWgdLD0hCDCT7T8JSSn2GOJI+12b41g5dyCt5e2132F+fI7dT8BQeA0FTx3kQbCu86ixqLxt5c0QzoiqD4Gdu1VKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RafPRW0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB06C116B1;
	Fri,  2 Jan 2026 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767348060;
	bh=uO3alF6Zq3I2FUn3PgzZJqkAM48dsLDrTU0qNG9HkCc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RafPRW0XsOmn/eAj96G3HfTALrfVO8gFNBYE5dr5U6RwYxWVottC7pnZDci4MAnD4
	 qdq/g2Gyj8rS/+t8reMou56DNJvMFsRZntTfJROexJSsrCAhs/30cpyj4pLau7TwR+
	 gtbkfTtJcq7jTxns5KrGc9PGkxVjIFqmHCo1ZyveRtmRoCjE9qTDuhnDiT9esLkC/6
	 wQ7FbM2naejXDKx4+p/cp/d1hK+DYdx3XVLontugziQwQaI2krJgRLecvaHkPyToWW
	 hMGCy2xM3rth0M7zAVqmzxbculyQ6Jo2jVo2N3xlkQAEzhjATMK7p+768ZCv/3GDDD
	 EAY3rALpP+REQ==
Message-ID: <d7ab53b2-6b26-4e66-8ae1-cb63d98cee88@kernel.org>
Date: Fri, 2 Jan 2026 11:00:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
To: Johannes Berg <johannes@sipsolutions.net>,
 syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
 <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/01/2026 13:07, Johannes Berg wrote:
> Hi,
> 
>> ------------[ cut here ]------------
>> rtmutex deadlock detected
>> WARNING: kernel/locking/rtmutex.c:1674 at rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674, CPU#0: syz.7.2908/15923
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 15923 Comm: syz.7.2908 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
>> RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674
>> Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 86 00 00 00 48 89 f7 e8 a6 39 01 00 48 8d 3d af 7c 0a 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 10 b3 91 4c
>> RSP: 0018:ffffc90004617710 EFLAGS: 00010286
>> RAX: 0000000080000000 RBX: ffffc900046177a0 RCX: 0000000000000000
>> RDX: 0000000000000006 RSI: ffffffff8ce0bbf9 RDI: ffffffff8ede5760
>> RBP: ffffc900046178c0 R08: ffffffff8edb3477 R09: 1ffffffff1db668e
>> R10: dffffc0000000000 R11: fffffbfff1db668f R12: 1ffff920008c2ef0
>> R13: ffffffff8ad3d599 R14: ffffffff8eb910e0 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000056422df5abe0 CR3: 000000005929c000 CR4: 00000000003526f0
>> Call Trace:
>>  <TASK>
>>  __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
>>  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
>>  rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
>>  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
>>  __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
>>  mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
>>  rfkill_unregister+0xd1/0x230 net/rfkill/core.c:1145
>>  nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
>>  virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:172
> 
> NFC has been issues with this for *years*. Technically, Krzysztof is
> listed as a maintainer but I suspect that's mostly dead.

And I have little time nowadays to do any real maintenance. I am
thinking that NFC should be marked Odd Fixes.

> 
> Is there a way you could route rfkill issues to NFC (and have them
> ignored there) if NFC is involved?
> 
> Clearly they're not useful if nobody is interested in fixing NFC, so
> maybe we should just disable the virtual NFC driver completely and just
> not have syzbot run on anything there...

Great benefit of virtual NFC driver was to show how buggy the NFC stack
is :)

Best regards,
Krzysztof

