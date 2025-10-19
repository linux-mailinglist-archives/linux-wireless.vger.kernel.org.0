Return-Path: <linux-wireless+bounces-28089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8BBEEB3B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710263E500A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482620B80B;
	Sun, 19 Oct 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CPwIRTr1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBC57C9F;
	Sun, 19 Oct 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760897961; cv=none; b=lCkE9KhySwz44M6xRjk9966u1Jh+yXGJpDIo0SImIbcX1uz/hm3gdVSaS323H42IeOpOH2j/k9Tfoog0nLyqAwzNQJE7HyWuniv0l4hkulkIw3JHPIRKpyx+5YqsDoV8rAGhPzBcoZzjnqUVEjJT2HR3ysdKBhlWJw/BsAvsL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760897961; c=relaxed/simple;
	bh=d11pgiUBlTDSn8XZdaFMt+akqhMwov8Yt4HpY3gvaug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=to2rUhBQ62UvNDMFzMp/4sKcwZfJH/gH1bGb9dKNN3Iwgc7nH0XW64ANkEppuysCGEmfxqlByJOEs1MA6Kl99RqTKJlrqETpKirQMb1PM009XEj01VMPnSdf3mGWo8PIzXvUWjl5GfGrEduMm0y6pf/WsTYMrj/zuk4k7DGBwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CPwIRTr1; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A656A28007A;
	Sun, 19 Oct 2025 18:19:13 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E397F13C2B0;
	Sun, 19 Oct 2025 11:18:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E397F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1760897951;
	bh=d11pgiUBlTDSn8XZdaFMt+akqhMwov8Yt4HpY3gvaug=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CPwIRTr17+B4Oc/3SpOvEJQmGN4mblNpDjM7OrDyawykWCqxg7OeBOsRFglJxBO6K
	 Gu3w3XNR2LkSscHWH6uU+HhBhWGBAU+drpjW/yhi1gmHnv3BuGO41JQA+X6+WUMB9+
	 4tYFRD4F/5PoWKtFxvc9A5Fkj1nkoLjaNXpGGXzs=
Message-ID: <4f75bb90-25ee-4312-b4b1-3faf0249b05a@candelatech.com>
Date: Sun, 19 Oct 2025 11:18:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
To: Aleksander Jan Bajkowski <olek2@wp.pl>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com, rosenp@gmail.com,
 luoxueqin@kylinos.cn, chad@monroe.io, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251019155316.3537185-1-olek2@wp.pl>
 <fa7befd5-b2c7-4277-ad57-a1577216ba83@candelatech.com>
 <5a529d81-fb4e-4e7a-a132-3b76d26c3696@wp.pl>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <5a529d81-fb4e-4e7a-a132-3b76d26c3696@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1760897955-ofoHgPYxUDkh
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1760897955;ofoHgPYxUDkh;<greearb@candelatech.com>;d5c215dcae166280e85b20da571dd1ee
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/19/25 09:43, Aleksander Jan Bajkowski wrote:
> Hi Ben,
> 
> On 10/19/25 18:26, Ben Greear wrote:
>> On 10/19/25 08:51, Aleksander Jan Bajkowski wrote:
>>> Supports IPv4 and IPv6 TCP + UDP
>>>
>>> In various tests between MT7986 and Intel BE200, I observed a performance
>>> boost ranging from 2 to 12%, with an average of 5.5%.
>>>
>>> I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
>>> MT7922, MT7925, and MT799x are untouched for now and still have
>>> checksumming disabled.
>>
>> At least with  7996, tcp csum only worked on the first few vdevs
>> created in our testing, so we had to add logic to disable that flag
>> on subsequent vdevs.
>>
>> Have you tried creating a bunch of station and/or vap vdevs to see if
>> all of them can still transmit TCP traffic?
>>
>>
> Thanks for the useful information. On all tested devices, I had a single
> AP configured per device. I will try to create several APs for each device.

We can try it out as well.

> I also have a router with MT7996. A quick test shows that checksum
> offload doesn't work on this router. MT7996 is visible in the system
> as a single DBDC device. I have 3 APs configured there. Each on a
> separate band (2.4/5/6 GHz).
> 
> Best regards,
> Aleksander

We have it working on 7996, but the patch is tangled in some other changes we made
with how wcid and such are allocated.  We are still cleaning and testing patches
on top of Felix's tree, should have something to post sometime soon.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


