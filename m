Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2C13D61F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgAPIub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 03:50:31 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:53210 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAPIua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 03:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=xqvVau9hnLqRJMeswcL86IvudpSzTVxpRTfWX80hO1g=;
        b=qHk0x//bh7ixqAKt8Tbog1b8ODKKqKt2moIjyuy/xLvT0MgBLJnhguFjbAfAHaxuYXCgUOO3XWRZpB9rstBgcDMDezzF9nJpnrjk2VxpeSW1KmOY7hWS/H98cUNvequpwcbFahGA5KG1KDBkT7GhFxm5D2FKlEQTpHXYHnVoEv4=;
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD
 cards
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Denis Kalashnikov <denis281089@gmail.com>,
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
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <324ec6fe-4212-a78a-dd48-8e08566719c6@newmedia-net.de>
Date:   Thu, 16 Jan 2020 09:50:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKR_QVLXTYsBztSH2wU3FDfwV5vaaUa0JzN=aQtMGd+CeEKE-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f10:df00:34e8:ca65:edfc:6be9]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1is0pN-0000gC-Kk; Thu, 16 Jan 2020 09:48:33 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 16.01.2020 um 08:46 schrieb Tom Psyborg:
> On 16/01/2020, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>>>> checking subvendor and subdevice id is usefull. mikrotik has special
>>>> values here
>>>>
>>>> the R11e-2HPnD card has
>>>>
>>>> subvendor 0x19b6
>>>>
>>>> subdevice 0xd016
>>>>
>>>>
>>> that i already suggested but it appears his units have zeroed sub fields
>> if it has zero subfields it has no original eeprom but a modified one.
>> all mikrotik cards with no exception have the subvendor and subdevice id
>> set.
>> the subvendor and subdevice is is stored in the eeprom. or the eeprom
>> could be also broke, but in this case the values should be 0xffff
>> i have several original mikrotik cards of this type and this is where i
>> got these values from. are you sure that your card is no immitation?
>> can he send me a picture of this card?
>>
> oh really? probably some fools then tampered with his cards and tried
> to screw him. your units work without this patch, and tx/rx chain
> reads out 0x3 ?
yes. i have about 20 - 25 of them in use and the chaininfo is correct 
and also the subdevice and subvendor id
is correct but i'm highly interesting finding out more about this case 
here. so do we have just have
a fake mikrotik card here of a known chinese marketplace or is it a real 
one. and more interesting

if you install this card on a mikrotik board, what does routeros show

Sebastian

>   
>
