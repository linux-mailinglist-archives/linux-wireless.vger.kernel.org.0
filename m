Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90D669D58
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjAMQMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 11:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjAMQLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 11:11:40 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A45C930
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 08:05:34 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pGMYe-00059A-LL; Fri, 13 Jan 2023 17:05:32 +0100
Message-ID: <18fe16c6-ebba-8387-100e-34e5688b9638@leemhuis.info>
Date:   Fri, 13 Jan 2023 17:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH wireless 3/3] wifi: mt76: dma: fix a regression in adding
 rx buffers
Content-Language: en-US, de-DE
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20230113105848.34642-1-nbd@nbd.name>
 <20230113105848.34642-3-nbd@nbd.name>
 <ce9a1141-810a-491a-1293-67beb46efb1f@leemhuis.info>
 <87sfgebf6q.fsf@kernel.org>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <87sfgebf6q.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673625934;576a5696;
X-HE-SMSGID: 1pGMYe-00059A-LL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13.01.23 16:57, Kalle Valo wrote:
> "Linux kernel regression tracking (Thorsten Leemhuis)"
> <regressions@leemhuis.info> writes:
> 
>> On 13.01.23 11:58, Felix Fietkau wrote:
>>> When adding WED support, mt76_dma_add_buf was accidentally changed to set
>>> the skip_buf0 flag for tx buffers on the wrong queue descriptor entry.
>>> Additionally, there is a rxwi leak when rx buffer allocation fails.
>>
>> thx for working on this
>>
>>> Fix this and make the code more readable by adding a separate function for
>>> adding rx buffers.
>>>
>>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>
>> Many thx for taking care of this. There is one small thing to improve,
>> please add the following tags here to make things easier for future code
>> archaeologists and give proper credit:
> 
> I can add those.

Great, many thx!

>> Link:
>> https://lore.kernel.org/r/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/
>> Reported-by: Mike Lothian <mike@fireburn.co.uk>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216829
>> Reported-by: AngeloGioacchino Del Regno
> 
> But the email is missing for AngeloGioacchino.

/me wonders how that happened

Sorry for that. Here it is again:

Reported-by: AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com>
 Ciao, Thorsten
