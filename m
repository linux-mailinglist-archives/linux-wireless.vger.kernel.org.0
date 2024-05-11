Return-Path: <linux-wireless+bounces-7504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D08C31CA
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C30B2105E
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8E5339D;
	Sat, 11 May 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqM1BgWD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21748CF2;
	Sat, 11 May 2024 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437074; cv=none; b=TrusXJgXp2L0+FTVX0Tk06NjevQh5BShwWpcV5xWxaPD3dDhcSpUxi2jAgWWA+W4LgoTo+AzaBT+U1sUGt3dUGljxKtQf9oRY0kffBGTvvoV/9AGxdgpCI0Yig9fwc+YhJ/H3lFM5cdqyPLfV49XttL/rU2U6QUtZQXdxTLwL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437074; c=relaxed/simple;
	bh=EEBCqK5E1wZs2A/4KHOy61zV7Y1b/PZvFjgpu25QQqE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y+5D93uarAeznVoyF8CAJSjoDGWLOSVm7PXozMJt1LZW8CgvFZVKxw8iO1m7RlPDOLKTVI63Umq8ffYa0w2Xu9xIehGHAKXsL7XlRhMOf7Y/ybhAh+mIVtdEDLln/JH4+ukXQA9fFu89tzzFDfqLKqIg7gx5BNRUIoUcuLkYRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqM1BgWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948D4C2BBFC;
	Sat, 11 May 2024 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715437074;
	bh=EEBCqK5E1wZs2A/4KHOy61zV7Y1b/PZvFjgpu25QQqE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TqM1BgWDA0KdcYSZvtLpJgrd/7d+I/gdzuPjuhtqEadAjSKu0O00IKqatTDB1CBEK
	 KnmvK9WyEIN5Idc/2G/IU0DSsgObFsy70Nsvy2dbXO/py7MFovEmBtbWUKaYw3HjPm
	 cpE4f4MY/gpFvNIKs7esFqd+saBi1L6WpueGOI5v23gY4iBNC3YO3TmDweLNFfdOeX
	 2dpqh3w0g7/2tKgBYgPpbKuyq+IV9O3OmLB44fBKQrPTGo39NISa6q0s7g14pwMqpF
	 D8x5Gus2pWumffpeeX4kV73iK/hBbSmqcZQ9qSEdqawKlb/7zYTdkdtS+Ee7jHuD/w
	 lq8kWMF2f4qGg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  <linux-kernel@vger.kernel.org>,  <ath10k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,  Sebastian
 Gottschall <s.gottschall@dd-wrt.com>,  Steve deRosier
 <derosier@cal-sierra.com>,  Stefan Lippers-Hollmann <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
	<878rcjbaqs.fsf@kernel.org>
	<648cdebb.5d0a0220.be7f8.a096@mx.google.com>
	<648ded2a.df0a0220.b78de.4603@mx.google.com>
	<CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
	<87v83nlhb3.fsf@kernel.org>
	<7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
	<cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>
	<663e2bd9.5d0a0220.d970d.cbf8@mx.google.com>
	<a56bd4f9-d76b-4924-a901-554d71ea17bd@quicinc.com>
Date: Sat, 11 May 2024 17:17:49 +0300
In-Reply-To: <a56bd4f9-d76b-4924-a901-554d71ea17bd@quicinc.com> (Jeff
	Johnson's message of "Fri, 10 May 2024 07:54:23 -0700")
Message-ID: <87seyojuuq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/10/2024 7:14 AM, Christian Marangi wrote:
>
>> On Thu, May 09, 2024 at 09:48:08AM -0700, Jeff Johnson wrote:
>>> On 5/9/2024 9:37 AM, Jeff Johnson wrote:
>>>> On 5/8/2024 9:50 PM, Kalle Valo wrote:
>>>>> Sorry for the delay but finally I looked at this again. I decided to
>>>>> just remove the fixme and otherwise it looks good for me. Please check
>>>>> my changes:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>>>>
>>>>
>>>> I have a question about the copyrights in the two new files:
>>>> + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>>>>
>>>> My understanding is that Qualcomm's affiliation with Linux Foundation via Code
>>>> Aurora ended in December 2021, and hence any contributions in 2022-2023 should
>>>> be the copyright of Qualcomm Innovation Center, Inc.
>>>>
>>>>
>>>
>>> ok it seems like Kalle's v13 had:
>>>  + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>
>>> and Ansuel's v14 has:
>>>  + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>>>
>>> So Ansuel, is your work on behalf of The Linux Foundation?
>>>
>> 
>> When I resubmitted this at times, I just updated the copyright to the
>> current year so I guess it was wrong doing that?
>> 
>> As you can see from the copyright header this patch went all around and
>> I think at the end (around 2018) the Linux copyright was added as it was
>> submitted upstream. (can't remember if maintainers were asking that)
>> 
>> So me watching the old year and resubmitting it, just updated the date.
>> 
>> Soo I think we should revert to 2018?
>> 
>
> Yes, in this case changing the Linux Foundation copyright back to 2018 is correct.

I changed it now back to 2018, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5eff06bef76b6d4e1553c2d4978025c329d8db35

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

