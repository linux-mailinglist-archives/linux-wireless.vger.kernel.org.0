Return-Path: <linux-wireless+bounces-3212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACB84B19F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3AB1F21F48
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7F12D169;
	Tue,  6 Feb 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC2hARrF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496812D148
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213159; cv=none; b=fxZ3TBv02OU5VgCVluxgu2nDnCdH275S444KLnyz2SxuhfskosVucYkTtxQaDVzOXuIZndSQQx3qMI/k4YzysW4U7Z7vMKN8m52kyQSa53V0/nbf+Jemo6SzhMeNq2cHJe2MjWkI9AR+VFExiY2Z2Xks+696CXggkEWjD7X1lmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213159; c=relaxed/simple;
	bh=b+p8zjmnr16Jk65ZJAFJ5YGzcFg8oIMlI1ka67QX4lQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PdRTHy3a9yNdwDgCsxJZSTudtWIqncIV2LhAyjC8YcNiMs2x6r2tsIY85GTmq1t2hwGoKHAAomUfxv8fRR2ritNo0SAZ5pKCzfeQAaW0yWJW75QvF40QT8YR+eEumVtK+G5UzeNKd1y5RNB6EOYdRdObzqQk0ZCy8JuPZo9zD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC2hARrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD226C433C7;
	Tue,  6 Feb 2024 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707213158;
	bh=b+p8zjmnr16Jk65ZJAFJ5YGzcFg8oIMlI1ka67QX4lQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HC2hARrFbha5PfULz3DckvOgV1s976iyk+o09fYqstunU4RVGN87vbZW3DvT9idRU
	 xclfkxGqIX4z1ZYK+s1y6HaQ72D2R5EE1Gb/uNPyJfCfDkK6+oaU+Y5EHWbMyOYelF
	 3Vq6uI/+5RMhScGShIWSHuXX/A7LyGCQHkokZx6H3shtAXJDu5I6jtzpqpnXGbbsST
	 jQN73REl1bArgr9qVPf+sAdYIM8K2x+kHCEFl3upX3wtEhK4bIwm4irsh6GldC4B28
	 pBMyVFGD8hqxstW/at8idJ8YXl2jmuIQ0w68w60VreKEBu3p++ECbvtdeJ+BjZ2KiN
	 54tIGtuH0bvGw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] wifi: ath12k: add P2P IE in beacon template
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-5-quic_kangyang@quicinc.com>
	<87bk8usx6d.fsf@kernel.org>
	<efda8b8e-0257-4779-b0c9-0903164b58c1@quicinc.com>
Date: Tue, 06 Feb 2024 11:52:35 +0200
In-Reply-To: <efda8b8e-0257-4779-b0c9-0903164b58c1@quicinc.com> (Jeff
	Johnson's message of "Mon, 5 Feb 2024 08:35:07 -0800")
Message-ID: <8734u5syvw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 2/5/2024 8:17 AM, Kalle Valo wrote:
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>>> +	if (WARN_ON(skb->len < ie_offset))
>>> +		return -EINVAL;
>>> +
>>> +	ie = (u8 *)cfg80211_find_vendor_ie(oui, oui_type,
>>> +					   skb->data + ie_offset,
>>> +					   skb->len - ie_offset);
>> 
>> So cfg80211_find_vendor_ie() returns:
>> 
>> static inline const u8 *
>> cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
>> 			const u8 *ies, unsigned int len)
>> 
>> You are casting away the const here. I see that other drivers do the
>> same as the assumption is that the pointer points to the same buffer,
>> but I still don't really like casting away const. Thoughts?
>
> I'm not a fan of typecasting either.
>
> However, the problem here is that from the perspective of
> cfg80211_find_vendor_ie() the buffer is const (not modified in any way
> by the function), but from the perspective of every caller the buffer is
> part of a message that is in RAM.
>
> So you have to decide if you want to change the prototype to remove the
> const from cfg80211_find_vendor_ie() or if you want to keep the current
> semantic to cast away the const.
>
> This is one of the rare cases where I think the typecast is ok.

Makes sense, thanks for the comment.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

