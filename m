Return-Path: <linux-wireless+bounces-32301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NpWN3HVoWlcwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:33:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51D1BB803
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4DD31AB0A1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575335CBDD;
	Fri, 27 Feb 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIrng+XE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4C35A3B2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213345; cv=none; b=MKQk4KLEQykJVXG0A1mfFKM5WUnSehrTDzP83Y0H9UPbnChDdnUHwAnub6u9lroThA4x0r5f7DpCPTurNBmav5FiAq9Te414isEcfcCsjtq29tcAlggEaeNzyzwqpv7xvmPQ/+dopmWLTgped0B725x8E+VSf+egGp8GtLY1oE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213345; c=relaxed/simple;
	bh=paX6hCqfa444BwUEfU2EdTiAhRg9mR92oqCFN+XN27A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=op90FkJU40Y4KpGQriCAfgfI1wOyUigHXWqUa4/0XCjJApBiM/KmUPkNUkB8QMmzvAHhLgFvzeRWftPvWRXLZePqbjvOwR/IrTIx0Vl8IAN+Tl3TOPuyGL18XA21HBElA40VisSKg8lMol7Y0KDhZWwK+e/wl0HCc7aMo7mpIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIrng+XE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so935741a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772213343; x=1772818143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVkc6ZPyuoqOkhwVhzdZ8Ion5jcRGNGi3A9fSjWSfmA=;
        b=HIrng+XEIr7mcsC2lqlQJoWWEwiwucNaEjGy++YtSllYmcVJNMrEsN0io+9ACB+YM0
         K227Bk3xE9WTKOBC5KSJ24XPPnoRIMFw1MhUAnLDYgnVQO/eKPbS+VN6Tx972RHCZX6I
         PWmjG1CaYyOyPnZUgVE+afj1R7g2tjbPJXnSy9wnzu583oPx9x7bHW/uC7lrCSu8sEQR
         Hoqc7dDIH2SQavFhYcVPhUWbF/hz06X/4lTzNiawhb8iKYKpOgPWj96y4Vd5rmAhiEvn
         irUE4f7wBouOsnWAaIHqJ29muWHS59El33PIEraPAeCIDLGMxrwf21/hS69WZ2GaS6/4
         eUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213343; x=1772818143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVkc6ZPyuoqOkhwVhzdZ8Ion5jcRGNGi3A9fSjWSfmA=;
        b=sOd5RG4dBN2LHmwdBJJ+Dvas3l+gcrSggqFN8TFJxJ401DxOWqq0NKvaXvnjWoiJBp
         efc4acVASarHmzg25IntT2LVzYaEXFMnr2q7PARjTCDMSEizT4wcXCe+LeykRkX7dB2u
         UQZqk+qoxp4VjvoMVlR99s4+EymqVbsRmuj8HmfQXESpEObiTHWtlb34JVHvS1O+mj0C
         VkcBSENfVvHEVacVIToMMAASm8MyUmZN3gh1FATXNVLhwDL8Tt9B4lJu0XaHeHP2nhG+
         7Xod/d9MgRpTqSghvHX+B68GpgwUbPfi5QvKWa811HktD2p0OKs/pVCRVDtXgMHBw8d8
         gZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx9x0xLpnddULabRtl88LNPHu4FumbwaV6/6QVfS+4etznIL1n4WcQsqWGaPL2TeqMNjwdLCQj9GqEjm0dOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2Vn2U5VqQhaCETC7RbOom3tub5k+UCGtglRwmgLTFK5NuvZg
	49sMuRFJwpTSiY+JhBUdPq0iCSZ8TLXwn04/ZPrNc0jYKIY1mLG6KFwy
X-Gm-Gg: ATEYQzyjXbv+BD1+ndaMoSL2wJ8wtV5w0S6So4wFNCAZS7aeFwJO1TnP0QrjMlgj0M9
	evE6k973wmWTYV6RczZbXhm/+27o2NViJObU+1ITAgrZrLNkpfJPRV0RmdGOYvBdBlicdkjuuso
	04X9sSybJWMzjsO5XqidrtWkG8AxAhmvFOxRME07F35TzT6AkT/bAIbPz8CUKFTxRz1LySEIB0n
	VAuV6VxPEc38SbG6fY56buut9wiCQQyIUcp/vv4IwqeYC17Afjz4XTiFNv0M9UgHUXf2PaXNOmq
	3T855RVTU2It4O7agH+YJp+9SswrVTz/RcuR4lDRT1n/5mLFJdVfymBIVpi/gWwIbLIdt8dY6Uq
	hFnXQ+FfL7T6WK6Ev42oLj4+EJvzgNXTo+MO9muE+BaeBP92DX+iFEH7OojBcmOBncLYQZ2gfLl
	LiwPT2hdRZt0c+iGbYqxtwOVQt5F3NuVKFrd5xIEHLzHjdGCW714gDWFed
X-Received: by 2002:a17:90b:1f8a:b0:356:22ef:57b9 with SMTP id 98e67ed59e1d1-35965c280e5mr3850766a91.3.1772213343243;
        Fri, 27 Feb 2026 09:29:03 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359019780bfsm9638243a91.8.2026.02.27.09.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:29:02 -0800 (PST)
Message-ID: <2e2818e5-ec6f-4bd7-8d2a-41f65652593f@gmail.com>
Date: Fri, 27 Feb 2026 09:28:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Richard Acayan <mailingradian@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
 <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
 <8b468ad4-39e3-401f-a2f2-7484759137df@oss.qualcomm.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8b468ad4-39e3-401f-a2f2-7484759137df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32301-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D51D1BB803
X-Rspamd-Action: no action

Hi,

On 2/25/26 6:59 PM, Baochen Qiang wrote:
>
> On 2/13/2026 1:56 AM, Jeff Johnson wrote:
>> On 2/11/2026 6:11 PM, James Prestwood wrote:
>>> On 2/9/26 6:12 PM, Richard Acayan wrote:
>>>> When sending DELETE_KEY, the driver times out waiting for a response
>>>> that doesn't come. Only wait for a response when sending SET_KEY.
>>> We've run into the exact same thing on the QCA6174 and have been
>>> carrying an identical patch to this for at least a year.
>>>
>>> https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com/
>> Baochen,
>> Were we ever able to reproduce this?
> unfortunately no
>
>> Do we normally always get a response to DELETE_KEY but in some instances it
>> comes very late (or not at all)?
> In my tests, I never hit this issue so seems can always get a response.
>
>> If we remove the wait, is there any concern that a late arriving DELETE_KEY
>> response might be processed as a response to a subsequent SET_KEY command?
> I would suggest not to remove the wait, but instead reduce the timeout to like 1s, just
> like the patch "[RFC 0/1] wifi: ath10k: improvement on key removal failure".
>
Is there a specific reason to require a wait? I would be more ok if the 
way was sub-second, like 100ms or frankly even less (no idea what a 
"normal" amount of time is to delete a key). The issue is this effects 
roaming, and will delay roams by e.g. 1 second which is not ideal. I've 
also seen a 1 second wait cause issues with configurations that expect a 
very fast reassociation time. Even 1 second was causing a deauth.

I dropped this patch a long time ago and replaced it with a similar 
patch being discussed here. So far, no issues, though I realize this is 
a limited test with specific hardware.

Thanks,

James

>> /jeff

