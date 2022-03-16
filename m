Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB74DAE1C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbiCPKPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiCPKPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 06:15:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD78652E4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 03:14:10 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nUQfP-0006BV-64; Wed, 16 Mar 2022 11:14:07 +0100
Message-ID: <023e90a9-01bf-4334-a69a-259705ffa55f@leemhuis.info>
Date:   Wed, 16 Mar 2022 11:14:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Nico Sneck <snecknico@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-wireless@vger.kernel.org
References: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
 <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info>
 <9312eb18-840f-9a1f-bcb0-8e3a43e45239@leemhuis.info>
 <236d45a6-8b88-c02e-a61d-ce1773fdb0ef@lwfinger.net>
 <02ef7552-67f5-dbcf-ece6-87b5b49e1bb5@leemhuis.info>
 <CAO_iuKHQ2DdLvSegcoezCzRVHqNFg+HM8qk1fr1n=s9cMz8QFA@mail.gmail.com>
 <877d96xlbk.fsf@tynnyri.adurom.net>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <877d96xlbk.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1647425650;b8fdc041;
X-HE-SMSGID: 1nUQfP-0006BV-64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07.03.22 08:39, Kalle Valo wrote:
> Nico Sneck <snecknico@gmail.com> writes:
> 
>> Sorry I'm a bit late, been really busy with work lately. Haven't had
>> time to continue bisecting, hopefully I can find some time this
>> sunday.
>>
>> I still think this is a kernel regression - I don't believe I'm using
>> the driver from Larry's repo. This is a stock Fedora 35 installation,
>> I've not installed the driver from Larry's repo, and I don't believe
>> Fedora packages it by default.
> 
> It's not clear for me if you are using a vanilla release from
> kernel.org.

FWIW, in the initial report Nico mentioned he tried to bisect the issue
and there mentioned a few git commit id's which are from mainline, so it
seems he tried mainline. But maybe there is some DKMS or akmod package
that is interfering.

Nico, it would help a lot if you could clarify the situation and maybe
try another shot at a bisection.

Anyway, this seems to be one of those issues that progress slowly, so
I'm marking it as "on back-burner" in regzbot to reduce the noise in the
reports and the UI:

#regzbot back-burner: root-cause still no found, reporter slow to respond
#regzbot poke

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.




