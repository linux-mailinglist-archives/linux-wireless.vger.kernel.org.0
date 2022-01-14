Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF148F240
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiANWII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 17:08:08 -0500
Received: from 6.mo583.mail-out.ovh.net ([178.32.119.138]:48295 "EHLO
        6.mo583.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiANWIH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 17:08:07 -0500
X-Greylist: delayed 11998 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jan 2022 17:08:07 EST
Received: from player687.ha.ovh.net (unknown [10.109.143.18])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 7764622FE6
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 18:32:35 +0000 (UTC)
Received: from gk2.net (82-65-221-177.subs.proxad.net [82.65.221.177])
        (Authenticated sender: gerald@gk2.net)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 290C7264AC403;
        Fri, 14 Jan 2022 18:32:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G0010a3a2227-d285-4286-9c04-f3c8c0383686,
                    191AC0B3D9F265F0EBDA6C7C6CC780C2151EEFFD) smtp.auth=gerald@gk2.net
X-OVh-ClientIp: 82.65.221.177
Subject: Re: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        prashanthkrishnan.ranganathan@nxp.com, zheng.cao@nxp.com
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Josh Boyer <jwboyer@kernel.org>
References: <edeb34bc-7c85-7f1d-79e4-e3e21df86334@gk2.net>
 <fe75e8f2-6f12-052a-81ed-38122b87f1f6@gk2.net>
 <20210926104306.xocctztsuspx6oji@pali>
 <CA+5PVA4AGa09+X2A4zPU2MKWburCtiddb3cpSJh9H-JTO=fJKg@mail.gmail.com>
 <20220114170051.sx2p6m2ihrv3ojzt@pali>
From:   =?UTF-8?Q?G=c3=a9rald_Kerma?= <gandalf@gk2.net>
Message-ID: <494e74b9-6d1e-3c6a-405f-0f7afb6bbeac@gk2.net>
Date:   Fri, 14 Jan 2022 19:32:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114170051.sx2p6m2ihrv3ojzt@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
X-Ovh-Tracer-Id: 13962003273441467138
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepiforrhgrlhgupgfmvghrmhgruceoghgrnhgurghlfhesghhkvddrnhgvtheqnecuggftrfgrthhtvghrnhepteeffeevieeltdehtdfhlefftdehkeeuvdekjefhheeujefhgfeileelheegtdfhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieehrddvvddurddujeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghgrnhgurghlfhesghhkvddrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Héllo all,

Thanks again Pali to get this been up again...

Le 14/01/2022 à 18:00, Pali Rohár a écrit :
> NXP people: Sharvari, Rakesh, Cathy, Zheng: could you please look at
> this issue? It is really serous!
>
> On Monday 27 September 2021 09:47:23 Josh Boyer wrote:
>> On Sun, Sep 26, 2021 at 6:43 AM Pali Rohár <pali@kernel.org> wrote:
>>> Hello Josh, Sharvari and other from NXP!
>>>
>>> On Saturday 25 September 2021 19:23:48 Gérald Kerma wrote:
>>>> Correcting old marvell address to new nxp...
>>>>
>>>> Le 25/09/2021 à 19:19, Gérald Kerma a écrit :
>>>>> Héllo All,
>>>>>
>>>>> I made some few tests on EspressoBin-Ultra from GlobalScaleTechnologies,
>>>>> because of problem with the WiFi.
>>>>>
>>>>> I have done some quick tests on all the firmware of PCIEUSB-8997 using
>>>>> the pcieuart8997_combo_v4.bin on OpenWrt 21.02.x
>>>>>
>>>>> Here is a summary of the tests :
>>>>> - W16.68.10.p159 = KO
>>>>> - W16.68.1.p195 = KO
>>>>> - V16.68.1.p145 = OK
>>>>> - 16.68.1.p140 = OK
>>>>> - 16.68.1.p133 = OK
>>>>> - 16.68.1.p97 = OK
>>>>> - 16.68.1.p70 = KO
>>>  From this user test result can be seen that last two versions of
>>> pcieusb8997_combo_v4.bin firmware file for 8997 wifi+bt card with
>>> official mainline linux kernel driver mwifiex were not properly tested
>>> internally in NXP and are causing serious issues which make 8997 card
>>> basically unusable.
>>>
>>> Sharvari and other NXP developers: Do you have some internal testing of
>>> this pcieusb8997_combo_v4.bin firmware for PCIe+USB variant of 8997
>>> wifi chips? Or are you aware of this issue and do you have in NXP some
>>> workaround for it (e.g. at driver level)? Could you please look at this
>>> serious issue and try to debug firmware and release a new version, as
>>> this is obvious fatal error in firmware itself?
>>>
>>> Josh, how you in linux-firmware repository handle such, I must say,
>>> "fatal issues"? Wait for vendor fixes or revert problematic commits? Or
>>> something else?
>> We can revert if we need to, but I think it's not quite that simple.
>>
>>> Because when users starts upgrading linux-firmware packages in their
>>> downstream distributions then basically wifi cards on this 8997 chips
>>> with official mwifiex driver stops working.
>> The first broken version was committed in Feb of 2019.  That's
>> approaching 3 years ago.  Given that this is binary firmware, I have
>> no idea what else may or may not be included in the updates in the
>> meantime.
>>
>> josh
> Josh, as Gérald wrote, current binary in linux-firmware repository is
> unusable. And there is no reply from NXP for 3 months.
>
> You are right that nobody knows what is in firmware binary, but working
> binary is at least usable than non-working binary.
>
> So I would really suggest to start reverting non-working firmware files
> if NXP does not respond in few days.
>
> Gérald, what is your opinion? Do you see other way how to make mainline
> linux driver work (again)?

I am really lost on this, Marvell do not answer at all.
NXP give me some buggy answer, no NDA possible with me and my own company...
No share about any works already public !
So my only proposal will be poor !

May be we can confirm my own test by some other technical testers and 
look to get the less buggy, because they all, more or less, again to the 
mainline !


>>>>> REF (and all details of tests) :
>>>>> https://github.com/NXP/mwifiex-firmware/issues/1
>>>>>
>>>>>
>>>>> Broken firmware :
>>>>>
>>>>> Version |W16.68.1.p195| of |pcieusb8997_combo_v4.bin| was included into
>>>>> linux-firmware repository by this pull request:
>>>>> https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/
>>>>> <https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/>
>>>>>
>>>>> And latest version |W16.68.10.p159| of |pcieusb8997_combo_v4.bin| by
>>>>> this pull request:
>>>>> https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/
>>>>> <https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/>
>>>>>
>>>>> Olders looks to works better.
>>>>>
>>>>> In quick tests, they allow more than 1 clients at a time !
>>>>>
>>>>> I am still testing the V16.68.1.p145 and report the results after some
>>>>> longer use...
>>>>>
>>>>> Hopes it will help...
>>>>> Regards,
>>>>> Gérald Kerma
>>>>> gandalf(at)gk2(dot)net

