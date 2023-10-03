Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F127B684C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjJCLwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 07:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjJCLwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 07:52:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEAA3
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 04:52:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qndwu-00069f-HO; Tue, 03 Oct 2023 13:52:24 +0200
Message-ID: <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
Date:   Tue, 3 Oct 2023 13:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Microcode SW error since Linux 6.5
Content-Language: en-US, de-DE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     ilan.peer@intel.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>,
        linux-wireless@vger.kernel.org
References: <87ttrncuc8.fsf@angela.anarc.at>
 <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
 <87jzsf9dme.fsf@angela.anarc.at>
 <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
 <8734z29jx7.fsf@angela.anarc.at>
 <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696333948;69d3ac3c;
X-HE-SMSGID: 1qndwu-00069f-HO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing the regressions list]

On 25.09.23 21:03, Johannes Berg wrote:
> On Mon, 2023-09-25 at 14:39 -0400, Antoine Beaupré wrote:
>>> Did that patch help?
>>
>> I haven't tried, to be honest. It's been years since I compiled a
>> kernel, so I haven't actually seriously considered it. But I can
>> definitely put that on my list if it would be useful for you!
> Heh ok. Well we can also try it I guess. Or reason our way through it,
> but I'm pretty sure something like that should be done here.
> 
>>> Yes, you can ... but I mean, we still do want to consider this a bug, I
>>> think, since we explicitly built the thing to load the older firmware.
>>> It just gets _far_ less testing.
>>
>> Got it, happy to play guinea pig a little further if that's useful.
> Well you might want to go for the extra stability instead :-) I'm kind
> of thinking along the lines of "if you can download the next wifi
> firmware with the current one, that's probably good enough". :)

Well, that's not how Linus wants things to be, as due to this "no
regression" rule things should continue to work if people update the
kernel without updating linux-firmware (as also explained in
Documentation/driver-api/firmware/firmware-usage-guidelines.rst).

That's what I though when I saw that message initially, but I thought:
well, not worth a comment, the reporter apparently doesn't mind that
much. But since then I saw more and more reports that looked related to
my untrained eyes (and thus might not be related at all!).

https://bugzilla.kernel.org/show_bug.cgi?id=217894
https://bugzilla.kernel.org/show_bug.cgi?id=217894#c6 (same ticket)
https://bugzilla.kernel.org/show_bug.cgi?id=217963
https://lore.kernel.org/all/f6448719-14e2-4962-ac3d-1be3c19156ed@dolce-energy.com/

Gregory, Johannes, is there something wrong here with 6.5.y? If yes: is
anything already been done to improve the state of things?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
