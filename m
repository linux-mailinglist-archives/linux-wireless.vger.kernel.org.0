Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C013D18F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 02:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgAPBdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 20:33:17 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:35215 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgAPBdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 20:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=TQ+9Zc6C00sz0i3CaaDbkTDF1x+VWewGUVwWmIMahTU=;
        b=scL/K0YoKNKXxTRcargW82COVwlVzjwAPPsSlGZVsHlTIsEj9gx2vpBWlWWJi9nwilViL2jJ5dObY3i7mlmRb9YEV0pwrtAqzq0iOeSNgvDKUWwdu5C16vZ28d7l+q1+weOWsdwleLfseeeeYj2h3F9xZ02ttTXGWIPxuqXgiKE=;
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
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <18634217-2e93-83fd-ec40-9b2a1bf28f56@newmedia-net.de>
Date:   Thu, 16 Jan 2020 02:33:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKR_QV++azTZKi0dodYXDEgXbkUcUhBqezzMtGc0=dh_ngOqOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f10:df00:34e8:ca65:edfc:6be9]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1iru0H-0005TZ-AF; Thu, 16 Jan 2020 02:31:21 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> checking subvendor and subdevice id is usefull. mikrotik has special
>> values here
>>
>> the R11e-2HPnD card has
>>
>> subvendor 0x19b6
>>
>> subdevice 0xd016
>>
>>
> that i already suggested but it appears his units have zeroed sub fields
if it has zero subfields it has no original eeprom but a modified one. 
all mikrotik cards with no exception have the subvendor and subdevice id 
set.
the subvendor and subdevice is is stored in the eeprom. or the eeprom 
could be also broke, but in this case the values should be 0xffff
i have several original mikrotik cards of this type and this is where i 
got these values from. are you sure that your card is no immitation?
can he send me a picture of this card?
