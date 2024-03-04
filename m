Return-Path: <linux-wireless+bounces-4345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8458870940
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E8DB28028
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B066166D;
	Mon,  4 Mar 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="c2vRzQa5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722160261
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576031; cv=none; b=M9pAqJq95m4AGKiIl1WRWHRsOLC748FHOv3qbf0TVsRst0GiAO/9xEAnjwVyGCQIkhUIsxSKPjmRivsM08uzNw7YcpS4DBOzROUEATupaZkgUzO1TlnF94aGbe2abdMBuXiMAU7lgyFYfCk1HXpmpa/ZHV8A1/2RLCzUziAEEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576031; c=relaxed/simple;
	bh=qrgos5/aIo//urXWtz27jcMyt/Szanc/OFJXp0pKaGY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iL06MQgkQeKkYHSCLYCeFsUTbgbWnAPAx4W9juUGMzadhs0QlXH2x+S+tRanRoJUtFR5+y3Se6+Zf4431uFNYLPeWrpzEOamRfh48aBHFgORRanw8cKfaVtpifG0wSLBI7DK+P63T5viqcsnwV8dmvNt3Iu/zoLTu5ko06ahSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=c2vRzQa5; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2565024007C;
	Mon,  4 Mar 2024 18:13:41 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7A61913C2B0;
	Mon,  4 Mar 2024 10:13:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7A61913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709576020;
	bh=qrgos5/aIo//urXWtz27jcMyt/Szanc/OFJXp0pKaGY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c2vRzQa5Wo1Z8auq4OJPZBwgfdFqmQZVx2shzhwrexZV05R8jH+XKsd75673965su
	 IgpSu41s5Q+FSkAgWnOYDmgPyuD0khyJfuw9O30NnBlVEiXzyNQK+solw/JgPsyUhY
	 b7FT/tFmax39YBV28xXbJhYAW/tXqfu0dxYTUzCY=
Message-ID: <dbf615af-4392-fa74-7b79-9fc7203eb1df@candelatech.com>
Date: Mon, 4 Mar 2024 10:13:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ***Spam*** [PATCH 2/8] wifi: mt76: mt7996: add txpower setting
 support
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: shayne.chen@mediatek.com, "nbd@nbd.name" <nbd@nbd.name>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?UTF-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?=
 <StanleyYP.Wang@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
 <20231102100302.22160-2-shayne.chen@mediatek.com>
 <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
 <8c5fbe88bcc5b55e6d80247144e4f890fd68ef27.camel@mediatek.com>
 <487ef0bb-5930-e998-7daa-6f57d09d682c@candelatech.com>
 <64286e79-4612-9601-138d-e08aa8217857@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <64286e79-4612-9601-138d-e08aa8217857@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1709576022-BYbFFFXnHqWo
X-MDID-O:
 us5;ut7;1709576022;BYbFFFXnHqWo;<greearb@candelatech.com>;0a87ce8853dfc5be48bfe846d29ed5d9

On 3/1/24 12:12, Ben Greear wrote:
> On 12/7/23 13:01, Ben Greear wrote:
>> On 12/7/23 09:15, shayne.chen@mediatek.com wrote:
>>> On Fri, 2023-12-01 at 15:40 -0800, Ben Greear wrote:
>>>>
>>>> External email : Please do not click links or open attachments until
>>>> you have verified the sender or the content.
>>>>   On 11/2/23 03:02, Shayne Chen wrote:
>>>>> Add support for setting txpower from upper layer and configuring
>>>> per-rate
>>>>> txpower limit table.
>>>>
>>>> Hello Shayne,
>>>
>>> Hi Ben,
>>>>
>>>>   From what I can tell, this patch causes STA vdevs to no longer send
>>>> probe
>>>> requests when trying to associate.  I bisected to this in Felix's
>>>> tree that holds
>>>> this patch.
>>>>
>>>> Tested on x86-64, mtk7996 radio.  Specifically
>>>> debugged on 2.4Ghz radio, but I think it affects 5Ghz too.
>>>>
>>> I have done some tests but didn't face this issue. Could you also use
>>> the newer firmware to test if it still happens?
> 
> Hello Shayne,
> 
> I rebased on 6.8, and started adding some debugging around this issue.

I received a patch from Chad that fixes this problem, the cmd size was wrong for one
reason or another.

Thanks,
Ben



