Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23B7B7A29
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbjJDIgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjJDIgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 04:36:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE3A6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 01:35:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qnxMJ-0001a7-Gb; Wed, 04 Oct 2023 10:35:55 +0200
Message-ID: <0c07b6bf-a9cc-4dc0-b71c-a2257e501e5f@leemhuis.info>
Date:   Wed, 4 Oct 2023 10:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Microcode SW error since Linux 6.5
Content-Language: en-US, de-DE
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>,
        "anarcat@debian.org" <anarcat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <87ttrncuc8.fsf@angela.anarc.at>
 <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
 <87jzsf9dme.fsf@angela.anarc.at>
 <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
 <8734z29jx7.fsf@angela.anarc.at>
 <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
 <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
 <42e000913e3af714c77fb7a55dd898733e271be0.camel@intel.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <42e000913e3af714c77fb7a55dd898733e271be0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696408558;a7eacfaa;
X-HE-SMSGID: 1qnxMJ-0001a7-Gb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing the net maintainers due to the related merge request not yet
processed]

On 04.10.23 09:51, Greenman, Gregory wrote:
> On Tue, 2023-10-03 at 13:52 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 25.09.23 21:03, Johannes Berg wrote:
>>> On Mon, 2023-09-25 at 14:39 -0400, Antoine Beaupré wrote:
>>> [...]
>>>>> Yes, you can ... but I mean, we still do want to consider this a bug, I
>>>>> think, since we explicitly built the thing to load the older firmware.
>>>>> It just gets _far_ less testing.
>>>> Got it, happy to play guinea pig a little further if that's useful.
>>> Well you might want to go for the extra stability instead :-) I'm kind
>>> of thinking along the lines of "if you can download the next wifi
>>> firmware with the current one, that's probably good enough". :)
>>
>> Well, that's not how Linus wants things to be, as due to this "no
>> regression" rule things should continue to work if people update the
>> kernel without updating linux-firmware (as also explained in
>> Documentation/driver-api/firmware/firmware-usage-guidelines.rst).
>>
>> That's what I though when I saw that message initially, but I thought:
>> well, not worth a comment, the reporter apparently doesn't mind that
>> much. But since then I saw more and more reports that looked related to
>> my untrained eyes (and thus might not be related at all!).
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=217894
>> https://bugzilla.kernel.org/show_bug.cgi?id=217894#c6 (same ticket)
>> https://bugzilla.kernel.org/show_bug.cgi?id=217963
>> https://lore.kernel.org/all/f6448719-14e2-4962-ac3d-1be3c19156ed@dolce-energy.com/
>>
>> Gregory, Johannes, is there something wrong here with 6.5.y? If yes: is
>> anything already been done to improve the state of things?

> The patch in [1] should solve the issue. The problem was that wrong version
> of Firmware API was used for some older versions.
> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20230926165546.086e635fbbe6.Ia660f35ca0b1079f2c2ea92fd8d14d8101a89d03@changeid/

Ahh, great, many thx for the reply. Two things then:

(1) I wanted to ask why this patch is not in mainline or -net yet, but
then noticed the fix is among the patches of a one week old pull request
that afaics was not handled yet:
https://lore.kernel.org/all/20230927095835.25803-2-johannes@sipsolutions.net/

Guess that one fell through the cracks due to the Netconf 2023 workshop?
Maybe this msg gets things rolling again.


(2) Would have been great if that fix would have had a stable tag to
ensure a quick backport to 6.5. :-/ Made me wonder if this is an
accident, but doesn't look like it:

$ git log --oneline --grep 'CC:.*stable@vger.kernel.org' mainline/master
 -- drivers/net/wireless/intel/iwlwifi/ | wc -l
11

Is there a reason why iwlwifi patches nearly never contain stable tags?
Reminder: a "Fixes:" tag alone does not guarantee that the fix is
backported.


Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
