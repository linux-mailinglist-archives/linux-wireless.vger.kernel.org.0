Return-Path: <linux-wireless+bounces-11121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF694BA6B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC337B229DA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF18189F3C;
	Thu,  8 Aug 2024 10:01:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA218A6C4
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.28.154.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111271; cv=none; b=DSE3eNyLFCfoiAqp3KqquVEH/33lx3vETil7aiWEzIBVdQN67HQid6UpQ/pfWErgrUC0Pgd3oPI9PudwG0yIOnyiGPn7K+gqWZCcG+1CbCxkH2K+16mcGmaiNpcZeONTkL+l/t/7fTceVmmCtB0IiCTpELPbnv5lk4jMQ6b5xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111271; c=relaxed/simple;
	bh=5iqy1rqk1gncQQfdgv0JaUfiwTZ/d26u4hSD3SvwT1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZJiraFmmKqF2+NTmy3MjsXuCZ4H6xqvKZ0O5tEOkOTAXl0qQ7mZq4hXHavTfo0RDHwTC8hnMcTZUrAe7MH3gjX+hOVgODE1oqL1Ob0phGAwwyWD6ggg1JoyXMR5iFIkxC6xAXLRL6SWnapTP8CYP2roVSCvxgiqWt5CmmLxQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=maciej.szmigiero.name; arc=none smtp.client-ip=37.28.154.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maciej.szmigiero.name
Received: from MUA
	by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <mail@maciej.szmigiero.name>)
	id 1sbzbI-0004Ix-1B; Thu, 08 Aug 2024 11:38:28 +0200
Message-ID: <6d1667d2-c86f-4b80-bb32-9ba01164480b@maciej.szmigiero.name>
Date: Thu, 8 Aug 2024 11:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
 <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
 <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.2024 14:20, Bitterblue Smith wrote:
> On 31/07/2024 03:47, Ping-Ke Shih wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>> On 30/07/2024 09:33, Ping-Ke Shih wrote:
>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>
>>>>> In AP mode, the firmware stops transmitting beacons if it receives
>>>>> H2C_CMD_RA_INFO for macid 0.
>>>>>
>>>>> Leave macid 0 unused in AP mode. Macid 1 is already reserved for
>>>>> broadcast/multicast. Assign macid 2 to the first connected client.
>>>>
>>>> Seemingly we missed to set mac_id in TX desc for a long time.
>>>>
>>>> +#define RTW_TX_DESC_W1_MACID GENMASK(7, 0)
>>>>   #define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
>>>>   #define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
>>>>
>>>> The mac_id should be from rtwvif->mac_id or si->mac_id according to
>>>> operating mode and role.
>>>>
>>>> And I suppose mac_id assignment for AP is mac_id 0 for broadcast/multicast, and
>>>> other mac_id can be used by connected stations regularly.
>>>>
>>>
>>> What about the concurrent AP + station scenario? Will the
>>> station vif use the next available macid, whatever that is?
>>> Just wondering, I don't use concurrent mode.
>>
>> My basic idea is to assign mac_id to each vif when adding vif. For station mode,
>> sta->mac_id will reuse vif->mac_id. For AP mode, I will dynamically allocate an
>> sta->mac_id to a station, and vif->mac_id is to send broadcast/multicast packets
>> that are not belong to a sta. For example,
>>
>>                    vif->mac_id      sta->mac_id
>> vif0 (STA mode)        0               0
>> vif1 (AP mode)         1               2...
>>
>>
>>>
>>> Also, do you mean that you will do all this? It's not clear to me.
>>
>> I can do it. Or are you interested in this?
>>
> 
> No, no, it's all yours. :)
> 

It would be nice to have either this submitted fix or alternative one merged soon
since the AP mode is completely broken otherwise (at least on RTL8821CU).

Thanks,
Maciej


