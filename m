Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97027BFFD6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJJO5L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjJJO5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 10:57:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C2B8
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 07:57:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A9B9E41EC4;
        Tue, 10 Oct 2023 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1696949822; bh=P/f3XdP28f20iuuj36uSrQM3o1wChLmi8Y2pRwWmDdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EXc+v5um6Pqjuvb41ClwI3LH1PrlUr+XLEzVreG83Q/NJCo1rBXIj8bB8Qb9iYoh5
         pPo4RLRnzQ03gy9rIy8VMgnmid/3/Q39buhXhCkc9ESwifCpb3lDLeTsGhL4uXLiQt
         VEvGuLZ0qw/kshig98OGPI7mQZ+ueV8jwE0420OqwF+1bLFRhwnUMVLOpP5n1+YF4O
         1cJenJxnz2fSNDvIvd25uefxt4UJyUiAKWua2wvdKdhZSmJAEMSvZEBRyypWVXC2gX
         c/Sn4hCq4fzLm9jSCIpID9BEjYqRt+19nnYin5VNRZeyPUq4+apEMJVOlLicTj06Gf
         WiB8u5uCCtQaA==
Message-ID: <97e68d20-2b5a-417f-8c8f-15e84ef24447@marcan.st>
Date:   Tue, 10 Oct 2023 23:57:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Arend Van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <cd9e71c8-2884-427a-a394-756f62ab09ba@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <cd9e71c8-2884-427a-a394-756f62ab09ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023/10/10 5:22, Arend Van Spriel wrote:
> On 10/6/2023 2:21 PM, Kalle Valo wrote:
>> Julian Calaby <julian.calaby@gmail.com> writes:
>>
>>> Hi Dmitry,
>>>
>>> (relevant people and lists CC'd)
>>>
>>> On Fri, Oct 6, 2023 at 3:16 AM Dmitry Antipov <dmantipov@yandex.ru> 
>>> wrote:
>>>>
>>>> Kalle,
>>>>
>>>> what's an actual status of brcm80211 driver? It seems
>>>> that the relevant MAINTAINERS entries are no longer
>>>> useful, and [1] states that Broadcom is just "disappeared".
>>>
>>> Arend hasn't posted since February:
>>> https://lore.kernel.org/linux-wireless/63f72045-e51d-d9a4-a0ed-c221bcdcee03@gmail.com/
>>>
>>> Franky is still reviewing things as of early August:
>>> https://lore.kernel.org/linux-wireless/CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com/
>>>
>>> Hante hasn't posted since 2018:
>>> https://lore.kernel.org/linux-wireless/4f6223b8083ed69432493a37d4f45b69@mail.gmail.com/
>>>
>>> Hector Martin has a bunch of Apple-specific patches downstream in the
>>> Asahi Linux kernel and has been looking for guidance on how to
>>> upstream it without any real answers:
>>> https://lore.kernel.org/linux-wireless/181af6e9-799d-b730-dc14-ee2de2541f35@marcan.st/
>>>
>>> There's also speculation that the Raspberry Pi people have downstream
>>> patches too, but I haven't been able to find anything concrete in a
>>> very brief search.
>>
>> Thanks for the research, that is helpful.
>>
>>> Finally, the Cypress / Infineon people appear to be uninterested in
>>> discussing the driver.
>>>
>>> I think it's pretty safe to say that this driver is nearly
>>> unmaintained by Broadcom, definitely unmaintained by Cypress /
>>> Infineon and Arend is unable to answer questions relating to anything
>>> beyond the code as-written.
>>>
>>> Kalle, should this driver get orphaned?
>>
>> We definitely need to consider that but let's first wait for Arend to
>> comment.
> 
> Using my personal email account to comment. Broadcom has pulled away 
> most resources from the brcm80211 drivers as there is no business 
> interest for it and it turned into a one-fifth man show as I was granted 
> to work one day a week on brcm80211. Nice theory but in practice other 
> work always takes priority. So "nearly unmaintained" is no exaggeration. 
> I probably can not meet the expectations some people in the community 
> have regarding driver maintainers, but I can still review patch 
> submissions although I should keep a better eye on the list to do that. 
> It would not be my choice to abandon brcm80211, but if my contributions 
> are considered insufficient than I will accept that fact.
> 
> Ever since Infineon took over Cypress wifi business things turned quiet 
> soon. Their website still claims brcmfmac is the driver to use. Earlier 
> this year I did have contact with them to hear whether they were 
> committed to the driver. At least I got an answer, but not much more 
> than that.
> 

Okay, so pragmatically, this needs a new maintainer. Would you be okay 
with adding myself as a co-maintainer? You could leave yourself as a 
maintainer or downgrade yourself to reviewer.

We should also remove the other two Broadcom folks from the maintainers 
list if they are effectively gone.

I expect my patch submissions to be reviewed by someone (in general); if 
we do this, that could be anyone (not just you), therefore unblocking 
upstreaming of Apple hardware related changes.

 From my point of view, pragmatically, the most useful things that a 
Broadcom employee can do to help this driver out without being an 
outright maintainer are:

- Answering questions (about firmwares, compats, hardware revisions, 
debugging, etc.) in a reasonably timely manner
- Testing on a wider variety of hardware

If someone can at least validate that my firmware version gates and such 
are done properly, then there's a chance we won't randomly break other 
chips. If someone can actively test on other hardware, even better. If I 
end up being the only one keeping the driver afloat, as I mentioned in 
my other reply, all I can promise is decent support on chips Apple uses.

- Hector

