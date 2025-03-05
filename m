Return-Path: <linux-wireless+bounces-19800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCECA4FE82
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FE27AA958
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647B24060E;
	Wed,  5 Mar 2025 12:18:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E39233704
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177139; cv=none; b=FyuERsmIkzcnav9YgHia8m/hwbwIV8HVBtwPln9VOcc5iFHRnMLBsKJLKrnB5nwcD/VphWN2jr6H6OHIk8b285XaMMeZ/fGr7eHayopb3c11R0Ea8bwt1uQ+FQTRqZjkKHq5kE9XBUjeavd6/qRGpVelgs8Zk+aCI1L2YYj4uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177139; c=relaxed/simple;
	bh=+AdsYW9kRwmy2nCmtfymrafVmZqMo6bwINKOLwSxqxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnP5zumlAgpzOyBQn1U5a6vrTXczRYe9Sxw9jH4Ijtu1dcziCnW3SSQCcM+zyHsHlTUNiZtVx400xppu9/JTz4rIR92ze15Egwm2iW9Z5joHNI1D6rEQcqILm4fpje2ZYOYcrm4bk1K5MQONTaRWZOW9w46f0zHOJnxqUvTJ8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.37] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJm8H-1tWDSK0BCr-00PU5n; Wed, 05 Mar 2025 13:18:49 +0100
Message-ID: <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
Date: Wed, 5 Mar 2025 13:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: wens@kernel.org, rmandrad@gmail.com
Cc: Dennis Bland <dennis@dbperformance.com>, Ping-Ke Shih
 <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
 wireless-regdb@lists.infradead.org
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
 <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
 <ff6ad414457e4b1cb68e834978a553c3@realtek.com>
 <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com>
 <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Content-Language: en-US
In-Reply-To: <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TdFC4C+tT5kSz2bQvDxcenP/KJxtth+dF5oAaOfsVs507FhnUD5
 rIZYSJT1jp9RL+zR0s3/+jQwAYy3/faGw4c8oHyqDeJO4cioHwjjcsqhfb9cZBzs/8kfv9y
 2rC/VxZwjqKXCZJz3vKAlqQH4NGMVPzD21vX9q3SU9+84o9lfydkSmVb0fJULz8gmzxLMpL
 CJPHsnVw1oqIaHyMsm5oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UjtVAMrsT9I=;W0dcGmO+rhACtRH/xCQLpth95A0
 y8nL4GpVCXMtraUY1LIWBJN8xJCAZ1pCMxiOAre5vUVIxuE0iOPQ9jIdg+0CqzhmjPeNWrvn6
 9Ku53fJrVhecCCTvA6/KWnvNnCljqzFzzPnE8TFnHwGOT0iC9Rc42Vv1PzKXeZxHcPI++YVfU
 stvyOWCVI69O2IJjVbev9N9acTrC5D+wwyxcr80AvDhtoiChuA7b6CjUh3sjJS5ko1xkmjzNW
 Q4YXce4mgiQOyeyLXWfZknqOpxKQZ9zkNoOaBho8I9BXDhbOMQRPgXSrEr+jyKDfkar3mM0dT
 fPL8zOpUABwUWFZ+I1r0PP45dRDYGwhN/0KBba9633XIqS+T2b5NTS1IaiL+Z9F8+3hZRzUq4
 5FODwF3MywMhYR4gNGtycff3sBn5EMuoq1e9X8cBYFs2RBb1nCFk+DSlOe5NqOZpWZ0mbYrOl
 oli8gj2PlnSnQZD/iP2kCTJ2SJq8Yf3uUjAJO6zl31q/b4ZWI2mjkit6hLygJxWKy1KnAuPVx
 vwhSEmQUQkI5IvNBMHfGjLXo1t+gSfshfGKASWgsNYss9qMkHM24BfswMDSQ12/xEtee8pPtN
 yklLT+j2QMZI5xneZXeoJFaClQxgWe93mwf8GEjTJyYlkhGgmcv3z0bHhDCpN9JjQf+SdnOgY
 2cTbz4NHAQOwKvjUcmqSQSHNNdTmNOXGJZoiSkckYQuliH+b0DrWq56PeUlOeei8GpZdbljwq
 ScoHE6813MoG0/iw7qHoZDkmHWnPmakw9rDbG25AzS/abpnGFXLq+opuXCgtDicvVZOhA7BTI
 85nTtK8alBenSTym3Q+avQm5cSx5UaKRszvdmm4bS4twPzE+1pN1iaso/rn81arLTntsiyQAb
 Jkd53YvsVQg1Ybegz9451bHCnpXma+O15RyDszhjXOzYH0j97bfZ/TpbAzDC9Wrm1v3whrEZM
 /CehGL/amM9fA/K+uvyvU0DvJkzHJ+Sn2UaAnSkK66nl4Bz5+emM1C8GuB4asht0IXwNdntuw
 mPiUNkBBL8Y3HjjGN3pv+geW5YjxySscGzKA2cPuZTGhbKCV1F53xESrtoV2bDSSdnSuaD1Bw
 B4e4BXNYCtytMfm2e5VrJlAH98x8SVjAD1ojtdGOxguc+tHA/FJY4rM2OYYsAcU4qBUVFTVIm
 EdHkZXTn8NaAZwsibwmpk5varolHYZIVjV63xJk8lzznWkhw3qAA0KEJxsocdcBYKwVYM5YuX
 nMg/hqy66BmhoHLIS9ZdA244+j5SUQMvwhLhYWq5Odq5RFdteoQJLtEUw8fn5u7u5Z45jzpLd
 zQZ5bblNgb3GCOjs4xXP9r9fe7PEkr5YCM6GuHJwTzwVCTC3NENoIXqWFpPXV+ilv4K

On 05/03/2025 09:58, Chen-Yu Tsai wrote:
> On Wed, Mar 5, 2025 at 4:23 PM <rmandrad@gmail.com> wrote:
>>
>> That is not specifying NO-IR which basically is denying any 6Ghz in the US what it means in my opinion is
>>
>>
>>
>> Client devices (like phones, tablets, laptops) need to find Wi-Fi networks before they can join them.
>>
>> One-way devices do this is by sending out probe requests. These are little "Are you there?" signals that ask nearby access points (routers) to respond, so the device knows which networks are available.
> 
> Section 122 says: The Commission therefore only permits a client
> device to send a probe request to an access point after it has
> detected a transmission from the access point. The client device
> will be required to send the probe request on the same frequency
> as the access point's transmission.
> 
> I think this translates to "passive scanning only", which is what
> NO_IR is meant to specify. NO-IR was previously called PASSIVE-SCAN,
> and was renamed when it was merged with NO-IBSS.
> 
> Maybe the kernel's implementation needs work? I'm not a WiFi person so
> I really don't know all the details.
> 
>> That is why drivers use the non 6Ghz for allowing clients to identify the router has 6ghz capabilities… I don’t think is for wireless-regdb to take over the HW router compliance and certification which is  what 122.  is about
> 
> No, section 122 is definitely about client devices, which is what Linux
> devices are.

No, Linux also supports access point, IBSS, OBSS and mesh, not to 
mention monitor injection.

If you remove NO-IR, you are allowing Linux to create access points, 
ad-hoc and mesh networks on the channel without conditions.

