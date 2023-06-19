Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D723735738
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjFSMtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFSMtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 08:49:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC2E65;
        Mon, 19 Jun 2023 05:49:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBEJX-0004Li-PH; Mon, 19 Jun 2023 14:48:59 +0200
Message-ID: <e3af69f2-d3e5-8039-c6e5-5b00fe066cc0@leemhuis.info>
Date:   Mon, 19 Jun 2023 14:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: MT7922 problem with "fix rx filter incorrect by drv/fw
 inconsistent"
Content-Language: en-US, de-DE
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Andrey Rakhmatullin <wrar@wrar.name>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-wireless@vger.kernel.org, Neil Chen <yn.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>
References: <ZGY4peApQnPAmDkY@durkon.wrar.name>
 <ad948b42-74d3-b4f1-bbd6-449f71703083@leemhuis.info>
 <ZGtsNO0VZQDWJG+A@durkon.wrar.name>
 <cd7d298b-2b46-770e-ed54-7ae3f33b97ee@leemhuis.info>
 <c647de2d-fbb5-4793-99b3-b800c95c04c2@leemhuis.info>
 <87jzw8g8hk.fsf@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87jzw8g8hk.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687178946;12f71e4a;
X-HE-SMSGID: 1qBEJX-0004Li-PH
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12.06.23 14:39, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> On 22.05.23 16:12, Thorsten Leemhuis wrote:
>>> On 22.05.23 15:20, Andrey Rakhmatullin wrote:
>>>> On Mon, May 22, 2023 at 03:00:30PM +0200, Linux regression tracking
>>>> #adding (Thorsten Leemhuis) wrote:
>>>>> On 18.05.23 16:39, Andrey Rakhmatullin wrote:
>>>> I updated the firmware and now the problem doesn't happen.
>>>> The firmware where the problem happens is
>>>> mediatek/WIFI_RAM_CODE_MT7922_1.bin from the linux-firmware commit
>>>> e2d11744ef (file size 826740, md5sum 8ff1bdc0f54f255bb2a1d6825781506b),
>>>> the one where the problem doesn't happen is from the commit 6569484e6b
>>>> (file size 827124, md5sum 14c08c8298b639ee52409b5e9711a083).
>>> FWIW, just checked: that commit is from 2023-05-15, so quite recent.
>>>
>>>> I haven't
>>>> tried the version committed between these ones.
>>>> Not sure if this should be reported to regzbot and if there are any
>>>> further actions needed by the kernel maintainers.
>>>
>>> Well, to quote the first sentence from
>>> Documentation/driver-api/firmware/firmware-usage-guidelines.rst
>>>
>>> ```Users switching to a newer kernel should *not* have to install newer
>>> firmware files to keep their hardware working.```
>>>
>>> IOW: the problem you ran into should not happen. This afaics makes it a
>>> regression that needs to be addressed -- at least if it's something that
>>> is likely to hit others users as well. But I'd guess that's the case.
>>
>> Well, until now I didn't see any other report about a problem like this.
>> Maybe things work better for others with that hardware – in that case it
>> might be something not worth making a fuzz about. But I'll wait another
>> week or two before I remove this from the tracking.
> 
> Yeah, this is bad. mt76 (or any other wireless driver) must not require
> a new firmware whenever upgrading the kernel. Instead the old and new
> firmware should coexist (for example have firmware-2.bin for the new
> version and firmware.bin for the old version). Then mt76 should first
> try loading the new firmware (eg. firmware-2.bin) and then try the old
> one (eg. firmware.bin).
> 
> Should we revert commit c222f77fd4 or how to solve this?

I had hoped someone would rely with an opinion on this, but nobody did
(and the reporter didn't reply to Lorenzo inquiry). So if you asked for
mine:

Hmmm. Tricky. This was the only such report I noticed. Giving that and
the risk that a revert might cause regressions on its own, I guess it
might be better to leave everything as it is for now - and re-evaluate
the situation in case more problems show up.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
