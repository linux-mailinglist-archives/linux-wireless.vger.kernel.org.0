Return-Path: <linux-wireless+bounces-1244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714281C885
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7501286BB9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5B41773B;
	Fri, 22 Dec 2023 10:47:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376817730
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=16depo.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=16depo.xyz
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTP id D79125ECB8;
	Fri, 22 Dec 2023 13:47:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CkM9uO99VCg0-m0LreQMZ;
	Fri, 22 Dec 2023 13:47:14 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass
Message-ID: <468ebce2-24c1-4a5a-b45c-6c0196840d90@16depo.xyz>
Date: Fri, 22 Dec 2023 13:46:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Armenia (AM)
Content-Language: en-US
To: wens@kernel.org
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
 <a0480e18-7b67-4e16-983e-c8f888c97261@16depo.xyz>
 <CAGb2v65V==YE=NLYyE=2ApN04jPeuFFc9d6bfTaQYBUsXoFWsQ@mail.gmail.com>
 <21b0fc55-6b5d-404b-88d1-3ad2b7acbbcd@16depo.xyz>
 <CAGb2v65RqgpA8RMyTKSq3FrDQMQyKqOi5ycQ8Wu81PwiRyi0JA@mail.gmail.com>
From: Kirill <me@16depo.xyz>
In-Reply-To: <CAGb2v65RqgpA8RMyTKSq3FrDQMQyKqOi5ycQ8Wu81PwiRyi0JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

There is new information. I've found commit that restrict bandwidth 
without reference to any law or act from Armenia regulators:
https://patchwork.kernel.org/project/linux-wireless/patch/1422013872-9732-1-git-send-email-jouni@qca.qualcomm.com/

I would like to remove this restriction altogether from 2.4 GHz range as 
well as 5GHz. Before i make another patch with, please confirm that the 
bandwidth restriction should be removed.

On 22.12.2023 06:32, Chen-Yu Tsai wrote:
> On Thu, Dec 14, 2023 at 11:40 PM Kirill Matvienko <me@16depo.xyz> wrote:
>> I have no evidence to why bandwidth restriction exist in the first
>> place, and my main concern in not power or bandwidth, but number of
>> channels. Now most wireless vendors use only UNII-1 and (less often)
>> UNII-2 for AM regulatory domain, but this decision from regulators will
>> allow to use UNII-2 extended and UNII-3.
>> The document that being amended is N-169
>> (https://www.arlis.am/documentview.aspx?docid=76877), and there is only
>> this passage about 5GHz:
>>
>> 5150 - 5250 ՄՀց, 5725 - 5875 ՄՀց ռադիոհաճախականությունների շերտերում
>> աշխատող, մինչև 100 մՎտ հզորությամբ, լոկալ ցանցերի սարքավորումների
>> օգտագործման համար (միայն շենքերի ներսում, ինչպես նաև օդանավերում` երկրի
>> մակերևույթից 3000 մետրից բարձր թռիչքի ժամանակ), 5250 - 5350 ՄՀց, 5470 -
>> 5725 ՄՀց ռադիոհաճախականությունների շերտերում աշխատող, մինչև100 մՎտ
>> հզորությամբ, լոկալ ցանցերի սարքավորումների օգտագործման համար
>> (օդանավերում` երկրի մակերևույթից 3000 մետրից բարձր թռիչքի ժամանակ),
>>
>> which translated as:
>>
>> Operating in the radio frequency bands 5150 - 5250 MHz, 5725 - 5875 MHz,
>> for the use of local area network equipment with a power of up to 100 mW
>> (only inside buildings, as well as in aircraft when flying above 3000
>> meters above the earth's surface), 5250 - 5350 MHz, 5470 - 5725 MHz for
>> the use of local network equipment operating in radio frequency bands
>> with a power of up to 100 mW (in airplanes during flight above 3000
>> meters above the earth's surface);
>>
>> Anyway, if you think that we can't use wider channels, please, change
>> only frequencies and power.
> Can you send a new version changing not the bandwidth but everything else?
> That would provide a better trail.
>
> Please also included the translated text in the commit log. Sometimes
> URLs will disappear due to one reason or another.
>
>
> Thanks
> ChenYu
>
>> On 14.12.2023 18:02, Chen-Yu Tsai wrote:
>>> On Thu, Dec 14, 2023 at 7:04 PM Kirill Matvienko <me@16depo.xyz> wrote:
>>>> Source:https://www.arlis.am/DocumentView.aspx?DocID=181829
>>> This only justifies the power limit change. What about the
>>> maximum bandwidth?
>>>
>>>
>>> ChenYu
>>>
>>>> Signed-off-by: Kirill Matvienko <me@16depo.xyz>
>>>>
>>>> ---
>>>>     db.txt | 4 ++--
>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/db.txt b/db.txt
>>>> index fdc2c13..0708039 100644
>>>> --- a/db.txt
>>>> +++ b/db.txt
>>>> @@ -80,8 +80,8 @@ country AL: DFS-ETSI
>>>>
>>>>     country AM: DFS-ETSI
>>>>         (2402 - 2482 @ 40), (20)
>>>> -    (5170 - 5250 @ 20), (18)
>>>> -    (5250 - 5330 @ 20), (18), DFS
>>>> +    (5150 - 5350 @ 80), (100mW)
>>>> +    (5470 - 5875 @ 80), (100mW), NO-OUTDOOR,DFS
>>>>
>>>>     country AN: DFS-ETSI
>>>>         (2402 - 2482 @ 40), (20)
>>>> --
>>>> 2.34.1
>>>>

