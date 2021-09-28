Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8055141AF48
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 14:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhI1Mqz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 08:46:55 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:48817 "EHLO
        4.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbhI1Mqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 08:46:55 -0400
X-Greylist: delayed 4739 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 08:46:54 EDT
Received: from player699.ha.ovh.net (unknown [10.110.115.143])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0DD381AA340
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 13:26:14 +0200 (CEST)
Received: from gk2.net (unknown [37.170.183.88])
        (Authenticated sender: gerald@gk2.net)
        by player699.ha.ovh.net (Postfix) with ESMTPSA id D3C7B229A1034;
        Tue, 28 Sep 2021 11:26:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003cb590aa0-8fc2-4133-940b-2c69e53847b7,
                    8B447295A3246458203B232FECD739CE5D91E33E) smtp.auth=gerald@gk2.net
X-OVh-ClientIp: 37.170.183.88
Subject: Re: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
To:     Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>
Cc:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Zhiyuan Yang <zhiyuan.yang@nxp.com>,
        prashanthkrishnan.ranganathan@nxp.com,
        Ganapathi Bhat <ganapathi017@gmail.com>, zheng.cao@nxp.com,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Josh Boyer <jwboyer@kernel.org>
References: <edeb34bc-7c85-7f1d-79e4-e3e21df86334@gk2.net>
 <fe75e8f2-6f12-052a-81ed-38122b87f1f6@gk2.net>
 <20210926104306.xocctztsuspx6oji@pali>
 <CA+5PVA4AGa09+X2A4zPU2MKWburCtiddb3cpSJh9H-JTO=fJKg@mail.gmail.com>
From:   =?UTF-8?Q?G=c3=a9rald_Kerma?= <gandalf@gk2.net>
Message-ID: <1a47cb59-24e2-3393-b028-ad820d7dad9a@gk2.net>
Date:   Tue, 28 Sep 2021 13:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4AGa09+X2A4zPU2MKWburCtiddb3cpSJh9H-JTO=fJKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
X-Ovh-Tracer-Id: 18146410277556312895
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepiforrhgrlhgupgfmvghrmhgruceoghgrnhgurghlfhesghhkvddrnhgvtheqnecuggftrfgrthhtvghrnhepteeffeevieeltdehtdfhlefftdehkeeuvdekjefhheeujefhgfeileelheegtdfhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrudejtddrudekfedrkeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrghnuggrlhhfsehgkhdvrdhnvghtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Héllo all,

A quick reply, just to correct a mistype sentence about the issue !

Le 27/09/2021 à 15:47, Josh Boyer a écrit :
> On Sun, Sep 26, 2021 at 6:43 AM Pali Rohár <pali@kernel.org> wrote:
>> Hello Josh, Sharvari and other from NXP!
>>
>> On Saturday 25 September 2021 19:23:48 Gérald Kerma wrote:
>>> Correcting old marvell address to new nxp...
>>>
>>> Le 25/09/2021 à 19:19, Gérald Kerma a écrit :
>>>> Héllo All,
>>>>
>>>> I made some few tests on EspressoBin-Ultra from GlobalScaleTechnologies,
>>>> because of problem with the WiFi.
>>>>
>>>> I have done some quick tests on all the firmware of PCIEUSB-8997 using
>>>> the pcieuart8997_combo_v4.bin on OpenWrt 21.02.x
>>>>
>>>> Here is a summary of the tests :
>>>> - W16.68.10.p159 = KO
>>>> - W16.68.1.p195 = KO
>>>> - V16.68.1.p145 = OK
>>>> - 16.68.1.p140 = OK
>>>> - 16.68.1.p133 = OK
>>>> - 16.68.1.p97 = OK
>>>> - 16.68.1.p70 = KO
>> From this user test result can be seen that last two versions of
>> pcieusb8997_combo_v4.bin firmware file for 8997 wifi+bt card with
>> official mainline linux kernel driver mwifiex were not properly tested
>> internally in NXP and are causing serious issues which make 8997 card
>> basically unusable.
>>
>> Sharvari and other NXP developers: Do you have some internal testing of
>> this pcieusb8997_combo_v4.bin firmware for PCIe+USB variant of 8997
>> wifi chips? Or are you aware of this issue and do you have in NXP some
>> workaround for it (e.g. at driver level)? Could you please look at this
>> serious issue and try to debug firmware and release a new version, as
>> this is obvious fatal error in firmware itself?
>>
>> Josh, how you in linux-firmware repository handle such, I must say,
>> "fatal issues"? Wait for vendor fixes or revert problematic commits? Or
>> something else?
> We can revert if we need to, but I think it's not quite that simple.
>
>> Because when users starts upgrading linux-firmware packages in their
>> downstream distributions then basically wifi cards on this 8997 chips
>> with official mwifiex driver stops working.
> The first broken version was committed in Feb of 2019.  That's
> approaching 3 years ago.  Given that this is binary firmware, I have
> no idea what else may or may not be included in the updates in the
> meantime.
>
> josh
>
>>>> REF (and all details of tests) :
>>>> https://github.com/NXP/mwifiex-firmware/issues/1
>>>>
>>>>
>>>> Broken firmware :
>>>>
>>>> Version |W16.68.1.p195| of |pcieusb8997_combo_v4.bin| was included into
>>>> linux-firmware repository by this pull request:
>>>> https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/
>>>> <https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/>
>>>>
>>>> And latest version |W16.68.10.p159| of |pcieusb8997_combo_v4.bin| by
>>>> this pull request:
>>>> https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/
>>>> <https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/>
>>>>
>>>> Olders looks to works better.
>>>>
>>>> In quick tests, they allow more than 1 clients at a time !

In quick tests, they do *NOT* allow more than only 1 client at a time !

>>>> I am still testing the V16.68.1.p145 and report the results after some
>>>> longer use...
>>>>
>>>> Hopes it will help...
>>>> Regards,
>>>> Gérald Kerma
>>>> gandalf(at)gk2(dot)net
Gérald
