Return-Path: <linux-wireless+bounces-13942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526299CDFC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8761C2150E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9851AAE08;
	Mon, 14 Oct 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gduqPEKH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E539FCE;
	Mon, 14 Oct 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916707; cv=none; b=JDrFX1/AA+jqgoRXBd3YGL1Qv/VlPKzdZWWaKiNuv0IZfzAyNXzyT3lcGZHn7HbKK7MKoMPCoSkv798j1MKDMkDxaknqK6w3TSKYKmzlxth0rpCGIDR+tjsPo7FmC4kHr3XjlQWagEovWFocczS8PjK4HLNZGwLqbsMh+4gnnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916707; c=relaxed/simple;
	bh=rIOk+Vwz/1HL7W9RTMCVy0ZbHehUo9hbp2zs0N4Q2dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRAktu1mKhHJVLBLFZ9uQG7UbRu2XnvqJo2/Qmo9YeFC/x4NOOJJ6+qXgEELWmHZ8+d8bL4Q+EYwEaQan/PVY/YZoEJWPDuWOA7LNZIfWqeyKUHF8+q/n8peE5YbUH3H/X/6a0mYM5DMMzBawyzu1IOuzi6eAHdp/fslR32twkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gduqPEKH; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8012E280074;
	Mon, 14 Oct 2024 14:38:17 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.40.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7F9F113C2B0;
	Mon, 14 Oct 2024 07:38:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7F9F113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728916697;
	bh=rIOk+Vwz/1HL7W9RTMCVy0ZbHehUo9hbp2zs0N4Q2dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gduqPEKHFvPz0L+KhrbZM8DxLBWGIhtif3y1suu/r2qkSBDk4uDoorIbJi6eJttEL
	 cSoXznrhIks3OcWTKODW9xPx0SQBViKHxCsaMhbrYWT06dPt6BDFUbNyGuzwRvtHWh
	 s4vbyNDYUyysyP4B/tKyPRUdH66PdlRQAZzEnbzs=
Message-ID: <01ef8d01-dbcb-4f11-844e-77dc26aba640@candelatech.com>
Date: Mon, 14 Oct 2024 07:38:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (4)
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <6707f07f.050a0220.64b99.001b.GAE@google.com>
 <05d3d02d-69c7-24a4-c2b2-26bdb53556db@candelatech.com>
 <CANp29Y5Jc9VG107iV1jKJuLi4H20TUpYLuLWzddan0=39qwCKw@mail.gmail.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CANp29Y5Jc9VG107iV1jKJuLi4H20TUpYLuLWzddan0=39qwCKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1728916699-2K60TzSXQmLz
X-MDID-O:
 us5;ut7;1728916699;2K60TzSXQmLz;<greearb@candelatech.com>;f36838b540d6b7b03dfe4aef3d303aa8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/14/24 02:54, Aleksandr Nogikh wrote:
> Hi Ben,
> 
> On Fri, Oct 11, 2024 at 11:50 AM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 10/10/24 08:19, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    2a130b7e1fcd Merge tag 'kbuild-fixes-v6.12' of git://git.k..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1206e79f980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f38c36a955431c1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b8327980000
>>
>> This looks like something I saw in 6.11 and 6.10.  My guess was that one of the
>> running processes that lockdep does not print locks for is holding the wiphy mtx.
>>
>> Maybe it would help if syzbot would use sysrq to dump all running tasks to the console, and maybe
>> lockdep could print locks for running processes, even if they are marked as potentially
>> unreliable?
> 
> Thanks for the suggestions!
> 
> We do have an open issue re. SysRq:
> https://github.com/google/syzkaller/issues/4200
> I've noted a +1 to that.
> 
> Regarding the locks -- they are actually already printed in the
> original bug report, under "Showing all locks held in the system:". Or
> did you mean something else?

Notice that some processes say they have locks but do not print them.  Lockep
skips printing locks for running processes that are not the current process.

I have added some local code to try printing them anyway, will see if it helps
any...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


