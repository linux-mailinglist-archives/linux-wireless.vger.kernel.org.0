Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A997197082
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2020 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgC2V0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Mar 2020 17:26:23 -0400
Received: from mx.sdf.org ([205.166.94.20]:57945 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgC2V0W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Mar 2020 17:26:22 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TLIFW9002042
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 21:18:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TLIFVM019351;
        Sun, 29 Mar 2020 21:18:15 GMT
Date:   Sun, 29 Mar 2020 21:18:14 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        lkml@sdf.org
Subject: Re: [RFC PATCH v1 13/50] Avoid some useless msecs/jiffies conversions
Message-ID: <20200329211316.GG4675@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
 <s5ho8sfd2dk.wl-tiwai@suse.de>
 <20200329121129.GC11951@SDF.ORG>
 <s5h7dz3ccea.wl-tiwai@suse.de>
 <20200329175032.GE4675@SDF.ORG>
 <1585505807.4510.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585505807.4510.1.camel@HansenPartnership.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 29, 2020 at 11:16:47AM -0700, James Bottomley wrote:
> On Sun, 2020-03-29 at 17:50 +0000, George Spelvin wrote:
>> On Sun, Mar 29, 2020 at 07:13:33PM +0200, Takashi Iwai wrote:
>>> Fair enough.  But it's still a question whether an open code X * HZ
>>> is good at all...
>> 
>> I'm sorry, I don't understand what you mean by "good at all" here.
>> The value computed is exactly the same.
> 
> I think he means what the compiler does with it.
> 
> We all assume that msecs_to_jiffies is properly optimized so there
> should be no need to open code it like you're proposing.  So firstly
> can you produce the assembly that shows the worse output from
> msecs_to_jiffies?  If there is a problem, then we should be fixing it
> in msecs_to_jiffies, not adding open coding.

Fair enough.  For the two alternative functions:

#include <linux/jiffies.h>

unsigned long timeout1(unsigned seconds)
{
	return jiffies + msecs_to_jiffies(seconds * 1000);
}

unsigned long timeout2(unsigned seconds)
{
	return jiffies + seconds * HZ;
}

compiled with Kbuild, the object code produced is:

Disassembly of section .text:

0000000000000000 <timeout1>:
   0:	69 ff e8 03 00 00       imul   $0x3e8,%edi,%edi
   6:	e8 00 00 00 00          callq  b <timeout1+0xb>
                        7: R_X86_64_PLT32       __msecs_to_jiffies-0x4
   b:	49 89 c0                mov    %rax,%r8
   e:	48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 15 
<timeout1+0x15>
                        11: R_X86_64_PC32       jiffies-0x4
  15:	4c 01 c0                add    %r8,%rax
  18:	c3                      retq   
  19:	0f 1f 80 00 00 00 00    nopl   0x0(%rax)

0000000000000020 <timeout2>:
  20:	48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # 27 
<timeout2+0x7>
                        23: R_X86_64_PC32       jiffies-0x4
  27:	69 c7 2c 01 00 00       imul   $0x12c,%edi,%eax
  2d:	48 01 d0                add    %rdx,%rax
  30:	c3                      retq   

This is the type of code I replaced: code where the number of seconds
is not known at compile time.  Notice how the first multiplies by 1000
and then calls __msecs_to_jiffies.  The second multiplies by 300 and
makes no function call.

__msecs_to_jiffies (from kernel/time/time.o) is:

0000000000000100 <__msecs_to_jiffies>:
     100:	48 b8 fe ff ff ff ff    movabs $0x3ffffffffffffffe,%rax
     107:	ff ff 3f 
     10a:	85 ff                   test   %edi,%edi
     10c:	78 1c                   js     12a 
<__msecs_to_jiffies+0x2a>
     10e:	b8 9a 99 99 99          mov    $0x9999999a,%eax
     113:	89 ff                   mov    %edi,%edi
     115:	48 0f af f8             imul   %rax,%rdi
     119:	48 b8 cc cc cc cc 01    movabs $0x1cccccccc,%rax
     120:	00 00 00 
     123:	48 01 f8                add    %rdi,%rax
     126:	48 c1 e8 21             shr    $0x21,%rax
     12a:	c3                      retq   
     12b:	0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

I didn't try to replace code that uses compile-time constant arguments
such as include/linux/ceph/libceph.h.
