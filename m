Return-Path: <linux-wireless+bounces-21092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DCA7923E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA173B45D6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB028382;
	Wed,  2 Apr 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FKNGCy23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640710F9
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608112; cv=none; b=V1gX6XGjXE+MW6kroB/rekF9aDb6raRMc7nR6u0z03braRAIRYz9itUaSVuzQyHMvIWpMtP+mrHusZjOMl3NcwO27qGSZRotj8DQllAesolTZP26OUzmGpeacX9txZn7FrT0Z5+k8ZW4gsHYZl6OgUkiTeDgg+Y6uul8cGMuTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608112; c=relaxed/simple;
	bh=1U55AuNF9Zw5tptF5+2WY9llHsrHeffahgoSOBnxAVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pomdp9q4mJUMbs/5BWIsGlEbAh9vGKJ7FOr218VzISIgBDZ+3QQGPdf4COsLmLzU4cYIsqQZt/69w6llaTd047Et5aXuzGLl8+UhduZNCrI31geYWvj74CODSZSpayKGcbFmBuFv13Y3MKOzx2xToUV5Hu+2BBHiVR9KafUT+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FKNGCy23; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.235])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A034E60159;
	Wed,  2 Apr 2025 15:35:08 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CFD55A800B7;
	Wed,  2 Apr 2025 15:35:04 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3A17113C2B0;
	Wed,  2 Apr 2025 08:35:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3A17113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1743608104;
	bh=1U55AuNF9Zw5tptF5+2WY9llHsrHeffahgoSOBnxAVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FKNGCy23K0a4xEaSzzcSYqgSH09WZCtvAGtFgaQp4azFqE83HSLqedAIzrNKKWcYn
	 BIXeY7u3zYMvn+Ga/vju8Wp1jwq9DCC4+IjRcnLrx/fie38H68g6MUvvISOSjr45ZA
	 HYBmfbBTi7VpKtIkmITebmR0z49GQRDHVlBC7ZOw=
Message-ID: <90f222c1-518d-90a2-6ae5-47cb13692c8b@candelatech.com>
Date: Wed, 2 Apr 2025 08:35:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check
 for mt7990
To: Ping-Ke Shih <pkshih@realtek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
 <20250328055058.1648755-10-shayne.chen@mediatek.com>
 <59abf964667144b0ab10220e41b6b821@realtek.com>
 <29344a3f054368ae948415d6183365a09d1fe6d5.camel@mediatek.com>
 <44832c3d3a74429aaa095bdba4573391@realtek.com>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <44832c3d3a74429aaa095bdba4573391@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1743608106-awR-MG-B6MkV
X-MDID-O:
 us5;ut7;1743608106;awR-MG-B6MkV;<greearb@candelatech.com>;6f4ef9b9d2914700e150fb80c2b35f23
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/1/25 18:30, Ping-Ke Shih wrote:
> Shayne Chen <shayne.chen@mediatek.com> wrote:
> 
>> On Mon, 2025-03-31 at 05:55 +0000, Ping-Ke Shih wrote:
>>>
>>>
>>> Shayne Chen <shayne.chen@mediatek.com> wrote:
>>>
>>> [...]
>>>
>>>> +
>>>> +bool mt7996_eeprom_has_background_radar(struct mt7996_dev *dev)
>>>> +{
>>>> +       switch (mt76_chip(&dev->mt76)) {
>>>> +       case MT7996_DEVICE_ID:
>>>> +               if (dev->var.type == MT7996_VAR_TYPE_233)
>>>> +                       return false;
>>>> +               break;
>>>> +       case MT7992_DEVICE_ID:
>>>> +               if (dev->var.type == MT7992_VAR_TYPE_23)
>>>> +                       return false;
>>>> +               break;
>>>> +       case MT7990_DEVICE_ID: {
>>>> +               u8 path, rx_path, nss, *eeprom = dev-
>>>>> mt76.eeprom.data;
>>>> +
>>>> +               mt7996_eeprom_parse_stream(eeprom, MT_BAND1, &path,
>>>> &rx_path, &nss);
>>>> +               /* Disable background radar capability in 3T3R */
>>>> +               if (path == 3 || rx_path == 3)
>>>> +                       return false;
>>>> +               break;
>>>> +       }
>>>
>>> The indentation of close brace looks weird.
>>
>> Will fix it, thanks.
>>>
>>> Since -Wdeclaration-after-statement is dropped, I think compilers
>>> will not
>>> warn without the braces. But note that it is still not recommended to
>>> put declarations in the middle.
>>>
>> Since those variables are currently only used by mt7990 case, I think
>> they can be putting there for the moment.
> 
> That looks not very natural though...
> 
> In fact, the declarations either in beginning of this function or at the
> mt7990 case, the frame size (stack) are the same.

The open parens make it the start of a new code block, so even strict
old c compilers should handle this just fine, and I personally like
variables kept to a tight local scope if possible.  Unless there is a
technical reason to change the code, then there are probably more important
things to worry about.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



