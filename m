Return-Path: <linux-wireless+bounces-9932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1E9263CB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C54282C55
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A6177980;
	Wed,  3 Jul 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utB47ehA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE1172BCE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018161; cv=none; b=lldXTZAoLaVD7XiMKDcxdbJc0B6w3c+NEDG7NOdPjJuiW6uXynkanYtgW3qPrF2bArAfp+RaUb3ujJYq9JYTRhpUdi6ZTyewNak0eeOjVHMRVxJHk9GwL+lW31HtJS5rwAxNc/wrR3PyRC9OcrarOAXOpWNqkA/z4LzXQinDg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018161; c=relaxed/simple;
	bh=3qGCR7+SBUm0FxhtBeKATCWdj80vH8KA2M7mFHfT9MQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PpE95fiIEophieyqWG0IgElPuqREorTlBIaE2Bju6Qet2kzxQ1dw33phW+cFoEeLs+1xHMGieQacFV4rSEWZNwpfROvuuD/It2/XUgYsyLrDcEEufghCXMtSqHvpmFblzXhuJnelEzhW3XrMWS6reENOeRvvicZ7erXm9RPJ6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utB47ehA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36948C2BD10;
	Wed,  3 Jul 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720018160;
	bh=3qGCR7+SBUm0FxhtBeKATCWdj80vH8KA2M7mFHfT9MQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=utB47ehAKXfW5KdU5w4FYs1vdyLdbV73y8Tn5/4+Vd8mX80/KFN5eJ/1mVK9iEfNP
	 VYhPkeb5+WZYd1WIpsFkGc8kv8t3qa6auaM9lGzjxOJIS6K5GQJM+XKd2hKCMMVd3Q
	 GDskOojtlIKEJT2TacfYvC29W1e8zTAjGXpBVPwqJxm4Njwt5tr9DCNZHYU1HXFkWm
	 q2LqIeSnnc1BZprus8chHKQQ2Ck/TBOZyliiee3cbIaaAJX7mmK/XDpnxW50iHp1Af
	 8VV09LByYxcXT32SdkItBtezldYNlukh/bCAxbWEQtWNWFVT3GYX2apUNXafg5iRL6
	 m5bJvnLZClchQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>,  <ath10k@lists.infradead.org>,
  <ath11k@lists.infradead.org>,  <ath12k@lists.infradead.org>,
  <quic_kvalo@quicinc.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: pull-request: ath-next-20240702
References: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
	<87zfqzdkgh.fsf@kernel.org> <87v81ndk13.fsf@kernel.org>
	<5b98e939-bfea-4a16-a116-5a00d3497190@quicinc.com>
Date: Wed, 03 Jul 2024 17:49:17 +0300
In-Reply-To: <5b98e939-bfea-4a16-a116-5a00d3497190@quicinc.com> (Jeff
	Johnson's message of "Wed, 3 Jul 2024 07:06:58 -0700")
Message-ID: <87jzi2edjm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/3/2024 12:14 AM, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>>> I see a weird warning from gpg which I have never seen before:
>>>
>>> merged tag 'ath-next-20240702'
>>> gpg: Signature made Tue 02 Jul 2024 05:55:42 PM EEST
>>> gpg:                using EDDSA key 3F9AD487CCF522D7A21F0C492C15BBA0898CCB7B
>>> gpg:                issuer "jjohnson@kernel.org"
>>> gpg: Good signature from "Jeff Johnson <quic_jjohnson@quicinc.com>" [full]
>>> gpg: WARNING: We do NOT trust this key!
>>> gpg:          The signature is probably a FORGERY.
>>>
>>> It first says that the signature is good and then claims it's a forgery,
>>> odd. Is this a problem between using different email addresses or what?
>> 
>> I did 'gpg --refresh-keys', now your key contains your kernel.org
>> address and I don't see the warning anymore.
>> 
>
> There had to be at least one issue with my first PR. Glad you sorted it out.
> Key management is still a mystery to me...

This wasn't a problem in your pull request, It was just a problem
between my chair and my display ;)

But I have to say that I hate PGP, "user friendly" is clearly not part
of their vocabulary.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

