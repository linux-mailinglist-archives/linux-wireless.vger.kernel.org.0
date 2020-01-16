Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75C513DA52
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPMob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 07:44:31 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:33964 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgAPMob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 07:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=yaWFQWEdLsK+BRJiaIW2aVWxEKjaXXxmCWEQoOkYgis=;
        b=NkMMgLDblp90GI6tsj7Mhdw3koeyxRe4axOdXmU7qiGvbMkfMgLgM/mR3RJlckq8XdkVz5GlzZq68n8gA0RacHL7M8Jb3cPud6hF6UoFeQrqJHoTWEg4FPF47e7XLgYg2FNlDUoYLX0SdS6TzhANkySW/59tenVz9TzgVSk7qpI=;
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD
 cards
To:     Denis Kalashnikov <denis281089@gmail.com>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
References: <20200110132142.7737-1-denis281089@gmail.com>
 <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
 <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
 <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
 <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de>
 <CAKR_QV++azTZKi0dodYXDEgXbkUcUhBqezzMtGc0=dh_ngOqOQ@mail.gmail.com>
 <18634217-2e93-83fd-ec40-9b2a1bf28f56@newmedia-net.de>
 <CAKR_QVLXTYsBztSH2wU3FDfwV5vaaUa0JzN=aQtMGd+CeEKE-w@mail.gmail.com>
 <324ec6fe-4212-a78a-dd48-8e08566719c6@newmedia-net.de>
 <CAKoLU8Pk_6kmi-8NnhD4gvJfa8YQMKf4TwdgKG8Y19K=WNFSLQ@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <3c4d09fe-2540-e24d-e4d5-5a8132751a7c@newmedia-net.de>
Date:   Thu, 16 Jan 2020 13:44:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKoLU8Pk_6kmi-8NnhD4gvJfa8YQMKf4TwdgKG8Y19K=WNFSLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:300:853d:6c61:95c4:6bb4]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1is4Th-0007bg-5U; Thu, 16 Jan 2020 13:42:25 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

habe you checked them with routeros? i mean, routeros should show the 
same wrong values if i'm correct
and in that case you should contact also the official vendor mikrotik 
about it. it might be a production fault

Am 16.01.2020 um 11:44 schrieb Denis Kalashnikov:
> These cards have a very strange eeprom (we compared their eeprom with
> eeprom of the same Mikrotik cards but without these problems). Now we
> are discussing with our supplier how this is possible.
>
> чт, 16 янв. 2020 г. в 11:50, Sebastian Gottschall
> <s.gottschall@newmedia-net.de>:
>>
>> Am 16.01.2020 um 08:46 schrieb Tom Psyborg:
>>> On 16/01/2020, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>>>>>> checking subvendor and subdevice id is usefull. mikrotik has special
>>>>>> values here
>>>>>>
>>>>>> the R11e-2HPnD card has
>>>>>>
>>>>>> subvendor 0x19b6
>>>>>>
>>>>>> subdevice 0xd016
>>>>>>
>>>>>>
>>>>> that i already suggested but it appears his units have zeroed sub fields
>>>> if it has zero subfields it has no original eeprom but a modified one.
>>>> all mikrotik cards with no exception have the subvendor and subdevice id
>>>> set.
>>>> the subvendor and subdevice is is stored in the eeprom. or the eeprom
>>>> could be also broke, but in this case the values should be 0xffff
>>>> i have several original mikrotik cards of this type and this is where i
>>>> got these values from. are you sure that your card is no immitation?
>>>> can he send me a picture of this card?
>>>>
>>> oh really? probably some fools then tampered with his cards and tried
>>> to screw him. your units work without this patch, and tx/rx chain
>>> reads out 0x3 ?
>> yes. i have about 20 - 25 of them in use and the chaininfo is correct
>> and also the subdevice and subvendor id
>> is correct but i'm highly interesting finding out more about this case
>> here. so do we have just have
>> a fake mikrotik card here of a known chinese marketplace or is it a real
>> one. and more interesting
>>
>> if you install this card on a mikrotik board, what does routeros show
>>
>> Sebastian
>>
>>>
