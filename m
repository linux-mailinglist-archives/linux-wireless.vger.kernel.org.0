Return-Path: <linux-wireless+bounces-4863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A244687EFD3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA260B20A4F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A057200DE;
	Mon, 18 Mar 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfUAskPt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E553C2D
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786977; cv=none; b=jHZCOP6Gj+Turdb41pnGmlHuhvAucUjq12aC9hfXOzK5VcyCEfXBMYb2PQPcCjQvfdjYW7513UphlI3z37jcTnGoVpx4DE+2asjy8Jrn/F6tr347WolCpPGQpO0THk+c3JJ6nMPiUViofj2llJNXb7rI2lrYoskvcI7unk44R2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786977; c=relaxed/simple;
	bh=qTUvLzwfd95RoXDB01Ll9lSqEOSRkGN4C5oDdatz7Z4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WXH/hh8r21jwYp6yohiP74um0OV+/0dxfEvJfnzjFcUIXcgoRyx9Te86+fJrgoKvOqREFVni0zbzs9udbGt6xFAtjtnr4bpteUNbt527SYvAag72pjHaOzaGAOfBIRVKb1ZCSEBxGvtX22csJgooNSBEcxwIhdSpPzvFZ/2zBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfUAskPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FFEC433F1;
	Mon, 18 Mar 2024 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710786976;
	bh=qTUvLzwfd95RoXDB01Ll9lSqEOSRkGN4C5oDdatz7Z4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XfUAskPtE0e0Wf6CQwqcgngxOar//CiR5jn3je3Vmy95isM/3c7Ghfcp1M9m46Gpt
	 vl+TVAcKMhro10d+pkQIHhnMPrBXzAHcxDoa0wkK+VMnT5Il2GwtO629ypmFdp7see
	 HpZ3C/P7b9cV9nMhTMb+S24hoKZpN0WhiL8C1ZEQ7pLwD2NdCrRd+4BExMJ1S+H4Nx
	 5pvfwSR+aVPDYi6fZNXAX/gU67c5YhRP1gpsRH3QVEJHN1o/tkTKq0C0GvOYRu1UFz
	 XjDEBj0XD3MOobAEgKOXbKVSAAaM0Faweih7hvptIDmIF5nrKyAbCQvoqZfbIBtBQI
	 PLUNZhspUMbig==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
	<20240312135557.1778379-2-quic_ramess@quicinc.com>
	<4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
	<3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
	<605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com>
	<87il1qf571.fsf@kernel.org> <87edcef4qi.fsf@kernel.org>
	<f768cfec-d20d-424d-85ef-3576434aca12@quicinc.com>
	<CAOiHx=kx03MKKyMcJPxYPZH=E7krZwfsDqq2xnow8qRB7D-aqQ@mail.gmail.com>
	<f542dbeb-debf-4335-9d49-4d12510f8bb4@quicinc.com>
Date: Mon, 18 Mar 2024 20:36:13 +0200
In-Reply-To: <f542dbeb-debf-4335-9d49-4d12510f8bb4@quicinc.com> (Rameshkumar
	Sundaram's message of "Fri, 15 Mar 2024 01:08:56 +0530")
Message-ID: <87zfuvbd5u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> On 3/14/2024 1:26 AM, Jonas Gorski wrote:
>> On Wed, 13 Mar 2024 at 20:18, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>>
>>> On 3/13/2024 9:58 AM, Kalle Valo wrote:
>>>> Kalle Valo <kvalo@kernel.org> writes:
>>>>
>>>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>>>
>>>>>> On 3/13/2024 5:57 AM, Rameshkumar Sundaram wrote:
>>>>>>> On 3/13/2024 3:23 AM, Jeff Johnson wrote:
>>>>>>>> and guess we have to figure out how to suppress the ath12k-check issues with
>>>>>>>> this macro
>>>>>>> ath12k-check complains about the reuse of ah and index arguments which
>>>>>>> may get evaluated multiple times if its an arithmetic expression, But
>>>>>>> areas where we use the macro in our code aren't doing so.
>>>>>>> Do you have any suggestions here ? or shall we go back and use this
>>>>>>> for-loop inline.
>>>>>>
>>>>>> The macro makes sense -- we'll need to update the overrides in ath12k-check.
>>>>>
>>>>> IIRC it is possible to avoid variable reuse in macros with typeof()
>>>>> operator (or something like that). I can't remember the details right
>>>>> now but I think there are examples in the kernel code.
>>>>
>>>> Here's the GCC documentation with an example:
>>>>
>>>> https://gcc.gnu.org/onlinedocs/gcc/Typeof.html
>>>>
> Thanks Kalle for the references, as Jeff mentioned below, we need to
> reuse the arguments since we write to ar and index arguments on each
> iteration.
>
> Defining local vars using typeof() without limiting their scope (since
> we are defining a for_each iterator{}) leads other issues like
> redefinition of variables in functions where we use this macro more
> than once :(
>
> Also even if we somehow manage to convince check-patch, we'll still
> end up evaluating index and ar arguments in every iteration of loop.
> This just gives an impression to check-patch that the macro is unsafe
> (although logically its not).
> Experts, what is the standard we should follow here. Please suggest.

Yeah, typeof() won't help here as we can't create a local variable. Or
at least I can't come up way to do that safely, ideas very welcome.

I think it's just best to ignore the checkpatch warning for now, unless
better proposals come up. ath12k-check has functionality to ignore
specific warnings (see checkpatch_filter array), I can add this warning
to the array.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

