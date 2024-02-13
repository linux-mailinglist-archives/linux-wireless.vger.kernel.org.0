Return-Path: <linux-wireless+bounces-3538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7A853206
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400B0B20BB2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105956449;
	Tue, 13 Feb 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRN/dxdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EB56444
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831269; cv=none; b=dwkxHWXlqhKx4aAn+GEbm+5C7mJkcD7sSN9BnFmKC3rZ3KDTUr0M1ihSiM8J24USSL+ggsdi3kR3ckWv4XhUc+6mPk1HI/u1mXCj96MmSNKOz4eJJRyNkKk6qyo4Qnr+LAliPqElyyK9wO0omLLVYoVRa4N8gs4A/VxdetwHlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831269; c=relaxed/simple;
	bh=mzILAccp2oFxg0jhbYliXAZk3k9+AW1+PHMuTrO/z5Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A2kPQXHL2NS0mzTPoU1MxyYMV6KZMqPJ0Bwl0jSV0MmMkNGbqIbTtS4p3X5hL/1GIYIorVgkDMDIO2y0RD7AT0N4tEJFyGiLx4lMNmf+dg9O6J7OKG3XwYG1k89janspG24i5Wmh3rppOBXwWvNbGjhKK4eHpEGHl5kOEjCOim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRN/dxdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DDEC433C7;
	Tue, 13 Feb 2024 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707831269;
	bh=mzILAccp2oFxg0jhbYliXAZk3k9+AW1+PHMuTrO/z5Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hRN/dxdc9ylJqb8HRcC3b2XkgoU/ZIxwANbFDrvjKD8RhP919RjqxhUb349oMm++6
	 KvOK4wccf9Ara3QmZXx74U654PkqorMP6aEU3zKI3FSVzZZ1dYuTpCYnDdDyNSza8w
	 zsayA1uRzZkQ7eTlH7Sp2LTqrJjwOREL12BdxRs5I4Gk7vTsWiqw+Py3rGh8QaR8Ek
	 O85/lhVoJJH5+Nu3Z1c1OlKhACJVqGLHTa9fMoSuuum1+Fh3uAAL7m6m5LXpKs28Hx
	 rGSaLMmDpr3dW7hGMUCTWFFQzjxuBmkAB7QBHuMVuEh/ofCjqtHFzoTdaQGhJ2moyC
	 ND0gjdjko4KPw==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
References: <20240208085121.2430-1-a@bayrepo.ru>
	<170775233602.2851594.8173116143852900695.kvalo@kernel.org>
	<9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
	<87cyt1pt4x.fsf@kernel.org>
	<18d9e33a040.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Tue, 13 Feb 2024 15:34:26 +0200
In-Reply-To: <18d9e33a040.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Mon, 12 Feb 2024 17:43:20 +0100")
Message-ID: <878r3opjx9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On February 12, 2024 5:03:14 PM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On 2/12/2024 4:38 PM, Kalle Valo wrote:
>>>> Alexey Berezhok <a@bayrepo.ru> wrote:
>>>>
>>>>> In 'brcmf_cfg80211_start_ap()', not assume that
>>>>> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
>>>>> an explicit check instead. Compile tested only.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
>>>> Patch applied to wireless-next.git, thanks.
>>>> f20073f50dfd wifi: brcmfmac: do not cast hidden SSID attribute value
>>>> to boolean
>>>
>>> Alexey,
>>>
>>> Can you do a follow-up patch addressing my comment? If not I will do
>>> it myself.
>>
>> Sorry, was I not supposed to apply the patch? What did I miss?
>
> Nothing serious. settings->hidden_ssid value is used as-is to
> configure firmware. I wanted Alexey to address that in a v2.

My bad, I misunderstood your intentions. Luckily this time it wasn't
serious.

BTW to make super clear to me I would prefer that you (Arend) use
Acked-by. It shows up in my script like the number '1' here:

*[  4] [next] wifi: carl9170: Remove redundant assignment t... 1 - - 2   5d Colin Ian Ki Under Review     

So if I don't see your Acked-by then I will not even look at the patch :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

