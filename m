Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2107389680
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhESTVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESTVq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 15:21:46 -0400
Received: from outbound1.mail.transip.nl (outbound1.mail.transip.nl [IPv6:2a01:7c8:7c8::72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254EC06175F;
        Wed, 19 May 2021 12:20:23 -0700 (PDT)
Received: from submission14.mail.transip.nl (unknown [10.103.8.165])
        by outbound1.mail.transip.nl (Postfix) with ESMTP id 4FljPd30KGzRjlT;
        Wed, 19 May 2021 21:20:21 +0200 (CEST)
Received: from transip.email (unknown [10.103.8.118])
        by submission14.mail.transip.nl (Postfix) with ESMTPA id 4FljPb1nVZz2SSZt;
        Wed, 19 May 2021 21:20:19 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 19 May 2021 21:20:19 +0200
From:   Dave Olsthoorn <dave@bewaar.me>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: mwifiex firmware crash
In-Reply-To: <20210515165338.7lqe6nqtkevpc5lh@pali>
References: <20210515024227.2159311-1-briannorris@chromium.org>
 <713286ddc100bd63a9dbefdece39c935@bewaar.me>
 <20210515154042.mscvvyfapuvwdgzy@pali>
 <ec4aa44faf41f2820c2f82317373033e@bewaar.me>
 <20210515165338.7lqe6nqtkevpc5lh@pali>
Message-ID: <61c5c6ef663d01f8505cadba47104bb5@bewaar.me>
X-Sender: dave@bewaar.me
User-Agent: Webmail
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission14.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=bewaar.me; t=1621452019; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=ZzpC85Xv4Cb2bHJAXt44ho3OyPZO3NRrH207lXMuyzE=;
 b=kOWJ6cDuKf7y8GEX4QI0EroFyrhgefjqUfjtqfqgJOqkMY1wLRBVSUr9EmggVf+ELNjrg0
 6T8rjqAfFBWi5EWIwVunPFlTCLPYoSlLJot+feqNL2mwbBuckTVk5nq9gyTKl2v5FdrQMw
 TEbFdGMDnrt8hBqohYy2FMFbs8AiA/qAeDBdhheJyBLd78NBdMCsXgt5Oe8c/4uYoqaDqS
 P/xm2Fw388q4JNMinfQLtcjtZvhP9xRZQMlM9DbxEBnf7m5DtaIBnc9oujAjvjAim4BXHA
 f2mpahM1wS+UDSJUMXG8efEjHUcSQpStw5f8Nf2zJeQHprUf5QREoPPDXmVJzQ==
X-Report-Abuse-To: abuse@transip.nl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'll drop some of the people since this is a sub-thread of the original, 
I'll keep the lists for access to this using lore.kernel.org.

On 2021-05-15 18:53, Pali Rohár wrote:
> Hello!
> 
> On Saturday 15 May 2021 18:32:30 Dave Olsthoorn wrote:
>> Hi,
>> 
>> On 2021-05-15 17:40, Pali Rohár wrote:
>> > On Saturday 15 May 2021 17:10:31 Dave Olsthoorn wrote:
>> > > The firmware still seems to crash quicker than previously, but
>> > > that's a
>> > > unrelated problem.
>> >
>> > Hello! Do you have some more details (or links) about mentioned firmware
>> > crash?
>> 
>> Sure, firmware crashes have always been a problem on the Surface 
>> devices.
> 
> What wifi chip you have on these devices? Because very similar firmware
> crashes I see on 88W8997 chip (also with mwifiex) when wifi card is
> configured in SDIO mode (not PCIe).
> 

The Surface Pro 2017 has an 88W8897.

> I know that there are new version of firmwares for these 88W8xxx chips,
> but they are available only under NXP NDA and only for NXP customers.
> So it looks like that end users with NXP wifi chips are out of luck.
> 
>> They seem to be related, at least for some of the crashes, to power
>> management. For this reason I disabled powersaving in NetworkManager 
>> which
>> used to make it at least stable enough for me, in 5.13 this trick does 
>> not
>> seem to work.
>> 
>> The dmesg log attached shows a firmware crash happening, the card does 
>> not
>> work even after a reset or remove & rescan on the pci(e) bus.
> 
> Similar issue, card start working again only after whole system 
> restart.
> 
> So this is something which can be resolved only in NXP.

After a conversation with the author of the patches, the problem is not 
the power management itself (for most hardware revisions [1]) but a race 
where pci commands are being written while the device is being put to 
sleep. A fix for this problem is included in the patches which make all 
pci commands synchronous instead of asynchronous [2].

After that a the wakeup patch seems relevant [3].

<snip>
>> There are patches [1] which have not been submitted yet and where 
>> developed
>> as part of the linux-surface effort [2]. From my experience these 
>> patches
>> resolve most if not all of the firmware crashes.
> 
> Is somebody going to cleanup these patches and send them for inclusion
> into mainline kernel? I see that most of them are PCIe related, but due
> to seeing same issues also on SDIO bus, I guess adding similar hooks
> also for SDIO could make also SDIO more stable...

The author plans to upstream them, he just hasn't gotten around to it.

Regards,
Dave

[1]: 
https://github.com/linux-surface/linux-surface/blob/master/patches/5.12/0002-mwifiex.patch#L2237-L2338
[2]: 
https://github.com/linux-surface/linux-surface/blob/master/patches/5.12/0002-mwifiex.patch#L1152-L1207
[3]: 
https://github.com/linux-surface/linux-surface/blob/master/patches/5.12/0002-mwifiex.patch#L1992-L2079
