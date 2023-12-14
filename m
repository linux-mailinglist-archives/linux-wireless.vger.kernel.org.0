Return-Path: <linux-wireless+bounces-802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C11813504
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746AB1F2176B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2F5B209;
	Thu, 14 Dec 2023 15:40:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80957B2
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 07:40:40 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTP id C047361093;
	Thu, 14 Dec 2023 18:40:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YemF5C2oNW20-3dQWKKMp;
	Thu, 14 Dec 2023 18:40:35 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass
Message-ID: <21b0fc55-6b5d-404b-88d1-3ad2b7acbbcd@16depo.xyz>
Date: Thu, 14 Dec 2023 18:40:34 +0300
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
From: Kirill Matvienko <me@16depo.xyz>
In-Reply-To: <CAGb2v65V==YE=NLYyE=2ApN04jPeuFFc9d6bfTaQYBUsXoFWsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have no evidence to why bandwidth restriction exist in the first 
place, and my main concern in not power or bandwidth, but number of 
channels. Now most wireless vendors use only UNII-1 and (less often) 
UNII-2 for AM regulatory domain, but this decision from regulators will 
allow to use UNII-2 extended and UNII-3.
The document that being amended is N-169 
(https://www.arlis.am/documentview.aspx?docid=76877), and there is only 
this passage about 5GHz:

5150 - 5250 ՄՀց, 5725 - 5875 ՄՀց ռադիոհաճախականությունների շերտերում 
աշխատող, մինչև 100 մՎտ հզորությամբ, լոկալ ցանցերի սարքավորումների 
օգտագործման համար (միայն շենքերի ներսում, ինչպես նաև օդանավերում` երկրի 
մակերևույթից 3000 մետրից բարձր թռիչքի ժամանակ), 5250 - 5350 ՄՀց, 5470 - 
5725 ՄՀց ռադիոհաճախականությունների շերտերում աշխատող, մինչև100 մՎտ 
հզորությամբ, լոկալ ցանցերի սարքավորումների օգտագործման համար 
(օդանավերում` երկրի մակերևույթից 3000 մետրից բարձր թռիչքի ժամանակ),

which translated as:

Operating in the radio frequency bands 5150 - 5250 MHz, 5725 - 5875 MHz, 
for the use of local area network equipment with a power of up to 100 mW 
(only inside buildings, as well as in aircraft when flying above 3000 
meters above the earth's surface), 5250 - 5350 MHz, 5470 - 5725 MHz for 
the use of local network equipment operating in radio frequency bands 
with a power of up to 100 mW (in airplanes during flight above 3000 
meters above the earth's surface);

Anyway, if you think that we can't use wider channels, please, change 
only frequencies and power.

On 14.12.2023 18:02, Chen-Yu Tsai wrote:
> On Thu, Dec 14, 2023 at 7:04 PM Kirill Matvienko <me@16depo.xyz> wrote:
>>
>> Source:https://www.arlis.am/DocumentView.aspx?DocID=181829
> 
> This only justifies the power limit change. What about the
> maximum bandwidth?
> 
> 
> ChenYu
> 
>> Signed-off-by: Kirill Matvienko <me@16depo.xyz>
>>
>> ---
>>    db.txt | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/db.txt b/db.txt
>> index fdc2c13..0708039 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -80,8 +80,8 @@ country AL: DFS-ETSI
>>
>>    country AM: DFS-ETSI
>>        (2402 - 2482 @ 40), (20)
>> -    (5170 - 5250 @ 20), (18)
>> -    (5250 - 5330 @ 20), (18), DFS
>> +    (5150 - 5350 @ 80), (100mW)
>> +    (5470 - 5875 @ 80), (100mW), NO-OUTDOOR,DFS
>>
>>    country AN: DFS-ETSI
>>        (2402 - 2482 @ 40), (20)
>> --
>> 2.34.1
>>

