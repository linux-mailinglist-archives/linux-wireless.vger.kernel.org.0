Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC83C1D1975
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbgEMPb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:31:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48327 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389006AbgEMPb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:31:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589383886; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=G4oACTu5Rt+yPeW1zopQEBIpMAR4ZGvXZE0H6V4O+bU=; b=YWIog7V+4GggoXEizU39wHnyEA9rVScz20Nj8Ao0AUux+i+IxajvvY0RIxrqIf2BtUopmzI/
 5a/6EK0Z+STMtfmSm+KmlyupLKR6/JNXsGlw+KmI52FUDGIBdA6y4RO2SBplg10QcVrU8ld7
 sjFXFgn3tJnbn7A70lpQa4zjsRQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc12cd.7fef615607d8-smtp-out-n04;
 Wed, 13 May 2020 15:31:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27545C433BA; Wed, 13 May 2020 15:31:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 827A9C433D2;
        Wed, 13 May 2020 15:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 827A9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
References: <20200509120707.188595-1-arnd@arndb.de>
        <20200509120707.188595-2-arnd@arndb.de>
        <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
        <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
        <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
        <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
        <87zhacrokl.fsf@kamboji.qca.qualcomm.com>
        <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
Date:   Wed, 13 May 2020 18:31:19 +0300
In-Reply-To: <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 13 May 2020 15:45:47 +0200")
Message-ID: <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, May 13, 2020 at 2:57 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> > On Wed, May 13, 2020 at 8:50 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >>
>> >> Kalle Valo <kvalo@codeaurora.org> writes:
>> >
>> > At least if it fails reproducibly, it's probably not too hard to drill
>> > down further. Some ideas:
>> >
>> > * I'd first try to reproduce it in qemu. Since you don't even need
>> >   any user space or modules, I would simply try
>> >   $ qemu-system-x86_64 -nographic -monitor none -append
>> > "console=ttyS0" -serial stdio -smp 4 -kernel arch/x86/boot/bzImage
>> >   I tried it here with an x86 defconfig linux-next kernel but did not
>> >   run into the problem you described.
>>
>> Thanks, I'll try that but I expect it will take few days before I can do
>> it.
>>
>> > If you share your .config, I can try reproducing with that as well.
>> > Once there is a reproducer in qemu, it should be trivial to step
>> > through it using gdb.
>>
>> I have attached the .config I used with GCC 10.1. If you are able to
>> test it please do let me know how it went.
>
> Yes, I see the same problem now, but have not investigated
> any further.

Great, so it's not a problem due to my setup.

>> > * There are still two prerelease compiler versions on kernel.org,
>> >   from February and from April. You can try each one to see
>> >   if this was a recent regression. It's also possible that there is
>> >   a problem with my specific builds of gcc-10.1, and that the
>> >   compiler is actually fine for others.The gcc-10 packages in
>> >   Fedora/Debian/Ubuntu are probably better tested.
>>
>> I'm still using Ubuntu 16.04 so not sure how easy it is to find a
>> package for that, but maybe this is a good reason to finally my upgrade
>> my laptop :)
>
> I checked with the gcc-10 package from Ubuntu 20.04, same
> result as with my version, at least that indicates it's not my fault ;-)

That's good to know as well. And now I can delay my laptop upgrade even
more ;)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
