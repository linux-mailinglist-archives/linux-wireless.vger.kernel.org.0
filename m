Return-Path: <linux-wireless+bounces-21066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BBEA78AC3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CE83A2F61
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BD20E00B;
	Wed,  2 Apr 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="swhh+xKL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0C233735
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584980; cv=none; b=PtPzLYr2zErcLxKb9u0kiNeF72raGTV7ZjKsh98JaX+F81lfabCeCTgjNAN9n1X+M/XIT/qIatngoI60lkLdJQdWNqHR/yykbIZE/mns5EYT9tw8hZJF//eKgsxHYWvWCh33UKKPAL5uinaVsmFpAkEYpERcA5zIvNbsBNOlE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584980; c=relaxed/simple;
	bh=el8F5+0hyx6SJFAmeXpgjJJ6nk93oakrSVrgatc9Mpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9FbPLBc4P3YxcG8a+Ebhcdx6VadtsOvURPlLrfI93bM+lp6TgnuTdX2Auce+XNLLlVMBmf1sXEDEYGCYBHVNrpc+H6rwSvHrzyGfYGSJOQahKVBpqw63WulCYGPscYNaaoTnFVX3KUEhQhCffykqBd/mxRH0566bxJuuFrbW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=swhh+xKL; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1743584966; bh=el8F5+0hyx6SJFAmeXpgjJJ6nk93oakrSVrgatc9Mpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=swhh+xKLlUE3C+ZxX2526sSLIJF2OYtGzJmXl6Y2vHirzob59bD8LAUs0CU2T9kD6
	 0FsPmlnq/8PxVWPWCrMoChBQ8XkukxkEypz4QHRrss6d732OY6Q1yIynEqO93vWGXl
	 /KNi5NPX5k+JlqWCTk43buyJwU5+Cfi0yvKqdzETOT1253Qvv9wLNUtxz4IZk5joe1
	 h6yTKmdbm32Fi2JLBlNlTjeYhSVf9kCGaKdJIyFcTI0DEQGyRcdhxjeyoyxt1cqeWX
	 MYt+CP5T5cMQxbv9QNZMoSda0t+uNYyQznCTdpFzAiSa1ELULXRfYiA8P18UYoqbTY
	 b0NbDSdmWC/cg==
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, rtm@csail.mit.edu
Cc: linux-wireless@vger.kernel.org
Subject: Re: divide by zero in ath9k_htc_choose_bslot()
In-Reply-To: <addca47d-041d-4d2b-acd1-ba457f4a1b1c@oss.qualcomm.com>
References: <87261.1743430651@localhost>
 <addca47d-041d-4d2b-acd1-ba457f4a1b1c@oss.qualcomm.com>
Date: Wed, 02 Apr 2025 11:09:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87msczlyka.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 3/31/2025 7:17 AM, rtm@csail.mit.edu wrote:
>> Toke,
>> 
>> Yes, your fix makes the problem go away for me, and does seem
>> like the better approach.
>> 
>> Robert
>> 
>>> diff --git i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>>> index 547634f82183..81fa7cbad892 100644
>>> --- i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>>> +++ w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>>> @@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
>>>         struct ath_common *common = ath9k_hw_common(priv->ah);
>>>         int slot;
>>>  
>>> +       if (!priv->cur_beacon_conf.enable_beacon)
>>> +               return;
>>> +
>>>         if (swba->beacon_pending != 0) {
>>>                 priv->beacon.bmisscnt++;
>>>                 if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {
>> 
>
> Toke, care to submit a patch I can apply?

Yup, will do.

-Toke

