Return-Path: <linux-wireless+bounces-13055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1FF97D5D0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5774B2364A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49416A955;
	Fri, 20 Sep 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b="CgPFfZe/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957F16F0F0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836662; cv=none; b=gQlydFnLXEB1dXUXI242GHaHPWWT+gczMBEsTIvBoLJu2C1fsXQ787skFAfCPB3+WLEoscgsHk6I4Sfyo/lH8GPxHq6VGx7ZoOVy4vqshR7ohtko+UedcZUJh/gDZNUAi1Rce8pxht5vM5jbJf8I089T0z4AlXp4rZjLf7CRsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836662; c=relaxed/simple;
	bh=Ita0D8YFfERtlRUbb5e1tlbXbt8U+n75gBzvQtgEr8M=;
	h=Date:MIME-Version:Subject:From:To:References:In-Reply-To:
	 Content-Type:Message-ID; b=N3jItVxn54tEJgoARcUswR13APqx1J5WQA6UhIuF/jamqDZNUV128XpPDl1G+YdDKlQ+oRq3VxCv8EGQW4PAxxdFa9I6GflH65iKaIjoFiwKFkefEMl43RU7+nzqKmtYe0+akcArSqUyqv5OU2CJ/GiNuL1KPgshbinzy9IrP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b=CgPFfZe/; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1726836657; x=1727441457; i=dknueppel@online.de;
	bh=Ita0D8YFfERtlRUbb5e1tlbXbt8U+n75gBzvQtgEr8M=;
	h=X-UI-Sender-Class:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CgPFfZe/UEARQA0EYL1oxe6Qqfcn6QW88zPCHr7au5dvf52KGFnufCWsjj3482C/
	 3YKDEt3kBrEcPRsJFjmD6jHeDb3WabfjVKoPos5vDiuPpokQBbH1Z8MR0+aI+Vqxd
	 QIuTae7UQDsrMJGkFT2glz4MKdQ9ifByvjYDCJKRfmxK7KWJ9imFzRTyxwhMsDGVZ
	 co2jTc5LZQDkC1SoUx4g6XkSv86mS0egmXOnYLZaZMXOJlCAGtDCKXVFGPBmNLkIy
	 VLQbQnrPCag7RBHmDHxQ0Ydj1GBvCmYuxRQ/ybHNBPhOZjS1N76GEEdrvW18Giklc
	 nW6BzUBXqZngjdp+hA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from xXx ([87.122.99.196]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MXHBo-1sSmKS1zhe-00YM15; Fri, 20
 Sep 2024 14:45:30 +0200
Authentication-Results: kalliope-7.home.xx;
	auth=pass smtp.auth=dknueppel@home.xx smtp.mailfrom=dknueppel@home.xx
Date: Fri, 20 Sep 2024 14:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ath12k - HTT timeout error with NCM86
From: Dieter Knueppel <dknueppel@online.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Dieter Knueppel <dknueppel@online.de>, linux-wireless@vger.kernel.org,
 "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
 <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
 <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
 <6d3f1f33-2a9a-4b62-a0a0-02e65bd1b461@quicinc.com>
 <eb1c8576-bf2f-4ec0-8651-62e97446e940@home.xx>
 <2271e7e8-2e25-42e5-a162-e79f65ee8798@home.xx>
Content-Language: en-US
In-Reply-To: <2271e7e8-2e25-42e5-a162-e79f65ee8798@home.xx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 6.00];
	BAYES_HAM(-3.00)[99.99%];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Action: no action
X-Rspamd-Server: kalliope-7
X-Rspamd-Queue-Id: BCE5E418A8
Message-ID: <1N4h7p-1rrEib2AJr-01163u@mrelayeu.kundenserver.de>
X-Provags-ID: V03:K1:rEGZ/OAO1ToqEMdc/aLHY7ydx4FhN9t+grX9lVgpojFhdC5OrMJ
 up8KbENl+ISddgqJKg8JvX/ZhVncuvdEMxnMFLYIDFlxJs+NZbCi49WdBS1Kt96JlqYCi2v
 PtoVA1WSJaqycFKlFmqHq9ZdDnR200gCNlgAp64jMYm3p1OWJ8rqmQRuD3aTOVjx3PJT8fm
 60VI2GVUSw+xlLv2atcJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MWjCRK0pw5A=;aMAX3JFVFsFYIAsEKz+wdiVdIjg
 mEqZbGgPEwkBB5FnM0ji2AwOCaceQTeuitR5o10JRM0P/e+yTAmYx+V8N4AfiL1tx0dcx3e4P
 NNJ5ZDRLC8R1h2Vb5UQnSy2k1aK+wQk8IZhmZvIwOaU7fiYEWqakW0L7pjLt26DElexcTczUV
 8IqmEpCNrQa+xcrEkSejGdA/vCk4MNC7WP+BY6FRnDxgvTenS/702aq6v/qktqU3z2XYdypbn
 8VyDXooAK2IHosCerhWr9dCbjWnga5j+s7eCh/PbXaPZYrUcjPqtaCMG//LQyxw/R6AWCHikE
 vyz5CRnrl39Aolm73UjO35djPBnVMt28cfs0PeHrK8m5r9hQFJle/FBiar2RnbbWhA7CRJJB+
 b4D98+f7Trdp+P6zDXY0kfeWV+ar6YQsHojLMr2TqmEqzj5HXL+tgtfK46GV7787aQrEtCqEC
 zSekUSGBL0IWbkgT1n54p+7h/EiURw9u05gHvJN0auyb7ttAtl2/alRlJe5MDuYrVIdNggJ+E
 VN92PEiRgz4CJ59R+IIogRyZzB4HHk2E3xT/L+1b2uYyTU/KpyE0H5k9LxY8gcU1gaYfdzevf
 GKayqdzmHsOWI6yMwPt2vVdcu36/mUAGFfuBXral/lb6sRuyErsmkdr5Gyy7ZzcPjancD5Wys
 LZAY+3LGHqeFQ2cOnxydia+3R5SRAuZwEl7uTtOPMvQkXfsXPMTRznkwny9gZSsdwJZj4bPlU
 MPR3GagV2rVjj++IuCTwBbp95P9nGZMjg==

I'm wondering, is this the correct mailing list for my questions?

I know you are all working on best effort basis, but at least my
questions related to supported HW shouldn't be too complicated to answer.

The information I found so far are almost not existent, stone old,
misleading or even proofed to be wrong (e.g.
https://wikidevi.wi-cat.ru/Ath12k, 17cb:1107 equals HERALD-BE as well,
not sure who maintains this page).

I'm almost at the point moving back to my legacy HW.

Anyway, I would still be very happy to receive any feedback :-)

Thanks a lot,

Dieter


P.S.: Due to my background in mobile networks radio interface, i would
have a good starting point to contribute myself. Unfortunately I'm
involved in plenty of other things and don't have the time for another
job :-(.





Am 19.09.2024 um 11:41 schrieb Dieter Knueppel:
> Minor update:
>
> I just figured out, that even the physical machine with std. Ubuntu
> 24.04 server (before the VM gets started and PCI device vanishes on
> PM) reports: "Unknown hardware version found for WCN7850: 0xf"
>
> Hence the earlier question, whether "MSI HERALD-BE" or "Gigabyte
> GC-WIFI7" is supported, seems still to be valid.
>
>
> Am 18.09.2024 um 19:54 schrieb Dieter Knueppel:
>> Hi Jeff,
>>
>> thanks a lot for your update on ath11/ath12 related vfio support.
>>
>> That's actually bad news!
>>
>> Do you know whether vfio support vanished per accident or intention?
>>
>> I.e. I'm wondering on why the ath11 patch haven't made it into mainline=
?
>>
>> Assume there are no other 802.11be Chipsets supported by Linux, which
>> can be used as AP within a VM?
>>
>> Kind regards,
>>
>> Dieter
>>
>>
>> Am 18.09.2024 um 18:13 schrieb Jeff Johnson:
>>> Resend since I had a typo in the ath12k e-mail list
>>>
>>> On 9/18/2024 9:05 AM, Jeff Johnson wrote:
>>>> On 9/18/2024 7:40 AM, Dieter Knueppel wrote:
>>>>> Dear developer team,
>>>>>
>>>>> I have to admit, the earlier post "HTT timeout error with NCM86"
>>>>> is my
>>>>> fault, sorry for causing confusion.
>>>>>
>>>>> Due to earlier tests with legacy cards, the PCIe slot was still
>>>>> forced
>>>>> to Gen2 :-(
>>>>>
>>>>> Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyt=
e
>>>>> WC-WIFI7" i
>>>>>
>>>>> consistently get: "Unknown hardware version found for WCN7850: 0xf"
>>>>>
>>>>> Which nails down to the question whether any of these adapter is
>>>>> already
>>>>> supported?
>>>>>
>>>>> The M.2 NCM865 card as such seems to be supported.
>>>>>
>>>>> I'm wondering about the difference, as there seems to be no
>>>>> additional
>>>>> logic compiled
>>>>>
>>>>> on one of the two PCIe boards, just bit of glue logic.
>>>> For better support on ath12k driver issues please include the
>>>> ath12k driver
>>>> list (I've added it to this reply).
>>>>
>>>> In your original e-mail you said:
>>>>> I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm
>>>> The ath12k driver does not support running in a VM. Even prior
>>>> ath11k-based
>>>> hardware doesn't support it.
>>>>
>>>> For ath11k there are some manual steps that have made it work, so
>>>> if you are
>>>> adventurous you can try doing something similar with ath12k. Refer to=
:
>>>> https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmai=
l.com/
>>>>
>>>>
>>>> /jeff
>>>>

