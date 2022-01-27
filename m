Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74F49E8B2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiA0RSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 12:18:14 -0500
Received: from 2.mo583.mail-out.ovh.net ([178.33.109.111]:43889 "EHLO
        2.mo583.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbiA0RSN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 12:18:13 -0500
X-Greylist: delayed 4193 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 12:18:12 EST
Received: from player774.ha.ovh.net (unknown [10.108.1.146])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 1215F23E0D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 14:50:49 +0000 (UTC)
Received: from gk2.net (82-65-221-177.subs.proxad.net [82.65.221.177])
        (Authenticated sender: gerald@gk2.net)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 7F7A726DDBEBD;
        Thu, 27 Jan 2022 14:50:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001d88b8f7b-42a2-4739-b5ea-8b5cfa3f3c0f,
                    7BBB4ECDC12A14F10EAF31C2B2D8AAE1BDE7D8CD) smtp.auth=gerald@gk2.net
X-OVh-ClientIp: 82.65.221.177
Message-ID: <849ea3f2-a6c1-8814-3713-4d8b14db5029@gk2.net>
Date:   Thu, 27 Jan 2022 15:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
Content-Language: fr
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        James Cao <james.cao@nxp.com>
Cc:     Prashanth Ranganathan <prashanthkrishnan.ranganathan@nxp.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Josh Boyer <jwboyer@kernel.org>
References: <edeb34bc-7c85-7f1d-79e4-e3e21df86334@gk2.net>
 <fe75e8f2-6f12-052a-81ed-38122b87f1f6@gk2.net>
 <20210926104306.xocctztsuspx6oji@pali>
 <CA+5PVA4AGa09+X2A4zPU2MKWburCtiddb3cpSJh9H-JTO=fJKg@mail.gmail.com>
 <20220114170051.sx2p6m2ihrv3ojzt@pali>
 <AS8PR04MB9192076DB3CB59EC049B7B9CFB549@AS8PR04MB9192.eurprd04.prod.outlook.com>
 <20220120193041.fmmmd77ingjvyqe4@pali>
 <AS8PR04MB8419C8377C9458ADA340AC24E0209@AS8PR04MB8419.eurprd04.prod.outlook.com>
 <20220127121514.daptjsxkgrt5zlov@pali>
From:   =?UTF-8?Q?G=c3=a9rald_Kerma?= <gandalf@gk2.net>
In-Reply-To: <20220127121514.daptjsxkgrt5zlov@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12774460345581886293
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfeefgdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefirohrrghluggpmfgvrhhmrgcuoehgrghnuggrlhhfsehgkhdvrdhnvghtqeenucggtffrrghtthgvrhhnpefgkeehtddvfeetjeevveegffettefhkeeiffdufeelffduvdeftdeuleekhedttdenucffohhmrghinhepohhuthhlohhokhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeihedrvddvuddrudejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrghnuggrlhhfsehgkhdvrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Héllo James,

As Pali wrote, if fimrware requires signing NDA, I can propose my own 
collaboration to NXP !

I am still okay to help, in anyway, with testing or more...
Please, feel free to contact me.

Gérald Kerma
CyberMind.FR
gandalf(at)gk2(dot)net
00.33.651.27.66.88

PS: I add my answer which was lost for some of the CC... (sorry)...


Le 27/01/2022 à 13:15, Pali Rohár a écrit :
> Hello James!
>
> Thank you for reply, but this is something which we did not want to hear :-(
>
> There is an issue in the latest pcieuart8997_combo_v4.bin firmware file
> which NXP sent to linux-firmware repository and it is really needed to
> fix this issue. It was sent by NXP, so it is expected that NXP do it.
> And because it is binary-only file, people outside of NXP cannot do it.
>
> Would you be able to look at this firmware issue as the last thing?
>
> Or as Gérald wrote, could NXP provide source code of that firmware? So
> people outside of NXP could look at it? If firmware requires signing NDA
> (either individually or via company), then some professional skilled
> kernel developers can do it.
Le 27/01/2022 à 02:13, Gérald Kerma a écrit :
 > Héllo James,
 >
 > Was it only ever supported ?
 >
 > May be NXP can free and share the firmware source to the community, 
and let anyone who care try to debug it ?
 >
 > As far as my tests shown, the mwifiex driver never has work 
correctly, and none version is sufficiently stable to be state as working.
 >
 > Please, NXP, take cares of your end clients !
 > Be simple, be smart, be respectuous, give us the source…
 >
 > Thanks in advance,
 > Gérald Kerma
 >
 > [%]<\@~{
> On Wednesday 26 January 2022 23:28:48 James Cao wrote:
>> Hi Pali,
>>
>> NXP doesn't have a plan to support mwifiex driver anymore. How should we handle this kind of retired project in upstream?
>>
>> Thanks,
>> James
>>
>> ________________________________
>> From: Pali Rohár <pali@kernel.org>
>> Sent: Thursday, January 20, 2022 11:30 AM
>> To: Prashanth Ranganathan <prashanthkrishnan.ranganathan@nxp.com>
>> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>; Rakesh Parmar <rakesh.parmar@nxp.com>; Cathy Luo <xiaohua.luo@nxp.com>; James Cao <james.cao@nxp.com>; Linux Firmware <linux-firmware@kernel.org>; Linux Wireless <linux-wireless@vger.kernel.org>; Gérald Kerma <gandalf@gk2.net>; Ganapathi Bhat <ganapathi017@gmail.com>; Josh Boyer <jwboyer@kernel.org>
>> Subject: [EXT] Re: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
>>
>> Caution: EXT Email
>>
>> Hello Prashanth!
>>
>> Thank you for reply. Did you have a time to check this issue?
>>
>> Gérald did a great testing which shows that version W16.68.1.p195 and
>> higher of pcieuart8997_combo_v4.bin firmware does not work.
>>
>> On Friday 14 January 2022 17:11:18 Prashanth Ranganathan wrote:
>>> Hi Pali,
>>> Please allow me to check this and respond ASAP.
>>> Best,
>>> Prashanth
>>> ________________________________
>>> From: Pali Rohár <pali@kernel.org>
>>> Sent: Friday, January 14, 2022 9:00 AM
>>> To: Sharvari Harisangam <sharvari.harisangam@nxp.com>; Rakesh Parmar <rakesh.parmar@nxp.com>; Cathy Luo <xiaohua.luo@nxp.com>; Prashanth Ranganathan <prashanthkrishnan.ranganathan@nxp.com>; James Cao <james.cao@nxp.com>
>>> Cc: Linux Firmware <linux-firmware@kernel.org>; Linux Wireless <linux-wireless@vger.kernel.org>; Gérald Kerma <gandalf@gk2.net>; Ganapathi Bhat <ganapathi017@gmail.com>; Josh Boyer <jwboyer@kernel.org>
>>> Subject: [EXT] Re: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
>>>
>>> Caution: EXT Email
>>>
>>> NXP people: Sharvari, Rakesh, Cathy, Zheng: could you please look at
>>> this issue? It is really serous!
>>>
>>> On Monday 27 September 2021 09:47:23 Josh Boyer wrote:
>>>> On Sun, Sep 26, 2021 at 6:43 AM Pali Rohár <pali@kernel.org> wrote:
>>>>> Hello Josh, Sharvari and other from NXP!
>>>>>
>>>>> On Saturday 25 September 2021 19:23:48 Gérald Kerma wrote:
>>>>>> Correcting old marvell address to new nxp...
>>>>>>
>>>>>> Le 25/09/2021 à 19:19, Gérald Kerma a écrit :
>>>>>>> Héllo All,
>>>>>>>
>>>>>>> I made some few tests on EspressoBin-Ultra from GlobalScaleTechnologies,
>>>>>>> because of problem with the WiFi.
>>>>>>>
>>>>>>> I have done some quick tests on all the firmware of PCIEUSB-8997 using
>>>>>>> the pcieuart8997_combo_v4.bin on OpenWrt 21.02.x
>>>>>>>
>>>>>>> Here is a summary of the tests :
>>>>>>> - W16.68.10.p159 = KO
>>>>>>> - W16.68.1.p195 = KO
>>>>>>> - V16.68.1.p145 = OK
>>>>>>> - 16.68.1.p140 = OK
>>>>>>> - 16.68.1.p133 = OK
>>>>>>> - 16.68.1.p97 = OK
>>>>>>> - 16.68.1.p70 = KO
>>>>>  From this user test result can be seen that last two versions of
>>>>> pcieusb8997_combo_v4.bin firmware file for 8997 wifi+bt card with
>>>>> official mainline linux kernel driver mwifiex were not properly tested
>>>>> internally in NXP and are causing serious issues which make 8997 card
>>>>> basically unusable.
>>>>>
>>>>> Sharvari and other NXP developers: Do you have some internal testing of
>>>>> this pcieusb8997_combo_v4.bin firmware for PCIe+USB variant of 8997
>>>>> wifi chips? Or are you aware of this issue and do you have in NXP some
>>>>> workaround for it (e.g. at driver level)? Could you please look at this
>>>>> serious issue and try to debug firmware and release a new version, as
>>>>> this is obvious fatal error in firmware itself?
>>>>>
>>>>> Josh, how you in linux-firmware repository handle such, I must say,
>>>>> "fatal issues"? Wait for vendor fixes or revert problematic commits? Or
>>>>> something else?
>>>> We can revert if we need to, but I think it's not quite that simple.
>>>>
>>>>> Because when users starts upgrading linux-firmware packages in their
>>>>> downstream distributions then basically wifi cards on this 8997 chips
>>>>> with official mwifiex driver stops working.
>>>> The first broken version was committed in Feb of 2019.  That's
>>>> approaching 3 years ago.  Given that this is binary firmware, I have
>>>> no idea what else may or may not be included in the updates in the
>>>> meantime.
>>>>
>>>> josh
>>> Josh, as Gérald wrote, current binary in linux-firmware repository is
>>> unusable. And there is no reply from NXP for 3 months.
>>>
>>> You are right that nobody knows what is in firmware binary, but working
>>> binary is at least usable than non-working binary.
>>>
>>> So I would really suggest to start reverting non-working firmware files
>>> if NXP does not respond in few days.
>>>
>>> Gérald, what is your opinion? Do you see other way how to make mainline
>>> linux driver work (again)?
>>>
>>>>>>> REF (and all details of tests) :
>>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FNXP%2Fmwifiex-firmware%2Fissues%2F1&amp;data=04%7C01%7Cjames.cao%40nxp.com%7C09714bf302224e66a34c08d9dc4b5bb5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637783038495772224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Y6a7lP%2B%2FXwPWGZARx3c99qV3ZFundY0QtfjmC1mYn4%3D&amp;reserved=0
>>>>>>>
>>>>>>>
>>>>>>> Broken firmware :
>>>>>>>
>>>>>>> Version |W16.68.1.p195| of |pcieusb8997_combo_v4.bin| was included into
>>>>>>> linux-firmware repository by this pull request:
>>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FCA%2B5PVA5yQbjg3vaT7F8120B6ngLn7%2BsZC0OWt0KoUiQR9hS4FA%40mail.gmail.com%2F&amp;data=04%7C01%7Cjames.cao%40nxp.com%7C09714bf302224e66a34c08d9dc4b5bb5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637783038495772224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nbzs6YB%2Fyjdp9zJR1PQyZ2prUtPOjthVewIhBCwcqdg%3D&amp;reserved=0
>>>>>>> <https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FCA%2B5PVA5yQbjg3vaT7F8120B6ngLn7%2BsZC0OWt0KoUiQR9hS4FA%40mail.gmail.com%2F&amp;data=04%7C01%7Cjames.cao%40nxp.com%7C09714bf302224e66a34c08d9dc4b5bb5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637783038495772224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nbzs6YB%2Fyjdp9zJR1PQyZ2prUtPOjthVewIhBCwcqdg%3D&amp;reserved=0>
>>>>>>>
>>>>>>> And latest version |W16.68.10.p159| of |pcieusb8997_combo_v4.bin| by
>>>>>>> this pull request:
>>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-firmware%2FCA%2B5PVA5on7%2BCRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg%40mail.gmail.com%2F&amp;data=04%7C01%7Cjames.cao%40nxp.com%7C09714bf302224e66a34c08d9dc4b5bb5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637783038495772224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=6wktlFLItFxzOdYcgTI2Rs9x3PamVJyfWtaNJU0o0bw%3D&amp;reserved=0
>>>>>>> <https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-firmware%2FCA%2B5PVA5on7%2BCRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg%40mail.gmail.com%2F&amp;data=04%7C01%7Cjames.cao%40nxp.com%7C09714bf302224e66a34c08d9dc4b5bb5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637783038495772224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=6wktlFLItFxzOdYcgTI2Rs9x3PamVJyfWtaNJU0o0bw%3D&amp;reserved=0>
>>>>>>>
>>>>>>> Olders looks to works better.
>>>>>>>
>>>>>>> In quick tests, they allow more than 1 clients at a time !
>>>>>>>
>>>>>>> I am still testing the V16.68.1.p145 and report the results after some
>>>>>>> longer use...
>>>>>>>
>>>>>>> Hopes it will help...
>>>>>>> Regards,
>>>>>>> Gérald Kerma
>>>>>>> gandalf(at)gk2(dot)net

