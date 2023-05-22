Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC570C0BC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjEVOMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEVOMW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 10:12:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7001A3
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 07:12:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q16Gl-0006No-C0; Mon, 22 May 2023 16:12:15 +0200
Message-ID: <cd7d298b-2b46-770e-ed54-7ae3f33b97ee@leemhuis.info>
Date:   Mon, 22 May 2023 16:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: MT7922 problem with "fix rx filter incorrect by drv/fw
 inconsistent"
Content-Language: en-US, de-DE
To:     Andrey Rakhmatullin <wrar@wrar.name>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-wireless@vger.kernel.org, Neil Chen <yn.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <ZGY4peApQnPAmDkY@durkon.wrar.name>
 <ad948b42-74d3-b4f1-bbd6-449f71703083@leemhuis.info>
 <ZGtsNO0VZQDWJG+A@durkon.wrar.name>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZGtsNO0VZQDWJG+A@durkon.wrar.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684764741;e4770359;
X-HE-SMSGID: 1q16Gl-0006No-C0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 22.05.23 15:20, Andrey Rakhmatullin wrote:
> On Mon, May 22, 2023 at 03:00:30PM +0200, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>> regressions; the text you find below is based on a few templates
>> paragraphs you might have encountered already in similar form.
>> See link in footer if these mails annoy you.]
>>
>> On 18.05.23 16:39, Andrey Rakhmatullin wrote:
>>> Hello. I have a "MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless
>>> Network Adapter" (14c3:0616) and when the commit c222f77fd4 ("wifi: mt76:
>>> mt7921: fix rx filter incorrect by drv/fw inconsistent") is applied (found
>>> by bisecting, checked by reverting it on v6.3) I have the following
>>> problem on my machine: when I connect to my router no DHCPv4 exchange
>>> happens, I don't see responses in tcpdump. My network setup is non-trivial
>>> though, and it looks like the problem is specific to it, but I still
>>> wonder if it's some bug in the aforementioned patch as my setup works with
>>> all other devices and I would expect it to work as long as the network
>>> packets sent by the device are the same.
>>>
>>> My setup is as follows: I have an ISP router which provides a 2.4GHz
>>> network and another router (Xiaomi R4AC with OpenWRT) connected by
>>> Ethernet to it that provides a 5GHz network and is configured as a "Relay
>>> bridge" (using relayd) to forward packets to the ISP router and back. This
>>> includes DHCPv4 packets, which are handled by the ISP router. tcpdump on
>>> the machine with MT7922 shows that the DHCP requests are sent while the
>>> responses are not received, while tcpdump on the bridge router shows both
>>> requests and responses.
>>>
>>> I've tried connecting the machine to the ISP router network directly and
>>> also to another AP (one on my phone) and those work correctly on all
>>> kernels.
>>>
>>> Please let me know if I need to do any other debugging or troubleshooting
>>> steps. Thank you.
>>
>> Thanks for the report. To be sure the issue doesn't fall through the
>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>> tracking bot:
>>
>> #regzbot ^introduced c222f77fd
>> #regzbot title wifi: mt76: mt7921: DHCPv4 exchange broke
>> #regzbot ignore-activity
>>
>> This isn't a regression? This issue or a fix for it are already
>> discussed somewhere else? It was fixed already? You want to clarify when
>> the regression started to happen? Or point out I got the title or
>> something else totally wrong? Then just reply and tell me -- ideally
>> while also telling regzbot about it, as explained by the page listed in
>> the footer of this mail.
>
> Deren Wu asked me privately

:-/

> if I'm using the latest firmware, and I
> wasn't. I updated the firmware and now the problem doesn't happen.
> The firmware where the problem happens is
> mediatek/WIFI_RAM_CODE_MT7922_1.bin from the linux-firmware commit
> e2d11744ef (file size 826740, md5sum 8ff1bdc0f54f255bb2a1d6825781506b),
> the one where the problem doesn't happen is from the commit 6569484e6b
> (file size 827124, md5sum 14c08c8298b639ee52409b5e9711a083).

FWIW, just checked: that commit is from 2023-05-15, so quite recent.

> I haven't
> tried the version committed between these ones.
> Not sure if this should be reported to regzbot and if there are any
> further actions needed by the kernel maintainers.

Well, to quote the first sentence from
Documentation/driver-api/firmware/firmware-usage-guidelines.rst

```Users switching to a newer kernel should *not* have to install newer
firmware files to keep their hardware working.```

IOW: the problem you ran into should not happen. This afaics makes it a
regression that needs to be addressed -- at least if it's something that
is likely to hit others users as well. But I'd guess that's the case.

Ciao, Thorsten
