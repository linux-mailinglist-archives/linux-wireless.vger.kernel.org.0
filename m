Return-Path: <linux-wireless+bounces-34481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODszLFYo1WnB1gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:52:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1313B1589
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60E2D3036B59
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104F3CFF6C;
	Tue,  7 Apr 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="yJIhOaHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087273D093A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576863; cv=none; b=Tsdf1PmP/YxhwworeCVwdDdJeB2S6P/7s2vVShKWSuvyiI0Xih6T1E1Ld1LZvB3bm9Dl0verHbqMjeOtpDlWdhtHNwuj8JRUdnqR6RUfdnWuGg8Ar4lV6ld65PQXPeBty2H7nFRSb/7VjkN43EZKtWRgnWkIosbMGXZWPvEEzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576863; c=relaxed/simple;
	bh=RWQ8MNiQiq0WBg2Der6b9sv6NAFsXk33bvQd4GWOuig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8NUSLFmRjbymFIETJ/8cFfU6cJFF6Qh1k1mKPWwU5UfachV8j49/TA8vX4OTBoXKFLxc7Jh/ZT0zv5fN8bHv7OmfTWJWzoX53UOd85CPRRgb3Dr0benmQXWgtSl/7IhRbcPYj4D5mgiTU1SFToDzKSnSaXE6Z8F4oG8w9vPMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=yJIhOaHZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888375f735so48022445e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775576850; x=1776181650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bgBHOzhyQ4BkLS8IOkMQOk4W86mqjiLwT/q5jIAW5g=;
        b=yJIhOaHZJuEpqHC/mqnjyWT+GZP+xpeHQyNV6w2hyOvmbKsT5RXITsT2/GO1jXHJm1
         yTiPH00V7Jsgak70Q1EaYnji8UMF25Tr2KCupn3B/q4XFAuJnBn4f5NV5S+KlgITfoyv
         GKVGWoYi/5fzhTeNNa1xJ5vQyiUuIRhYjoCWLc9wlWcQhVOkZ3pc1+8GfK22fqGsI7ac
         QPHgRUBtd3wyz6ZWUoCIyEcbO8qb0/Xo/lGNjyNVD40AA3aaslEcJJKpqab5DvU/emog
         Tdilqe05N7MUuQ8GCiQE9H56oFjgpu7oqWd/8L9pZR6SFDT8zVDlG0ltv/QdRYa15i+r
         b2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576850; x=1776181650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bgBHOzhyQ4BkLS8IOkMQOk4W86mqjiLwT/q5jIAW5g=;
        b=dvp+IIPqVg8T/YT6EoRQhH+PNVMy3adpQOeGvYgg0pZm4WogQiRD9pIaUte2eGMlM2
         u/ljKUPsbvUf2n/VF0y1wQ36sEHCE2gOisItLjhyiLDrWOdv1Yud9XT9W+8Y8Jxqv1Xi
         iUHPLt3rvlTqh/OjxivloG83PerRpiIkF/GdnRvOS2G+RGYIUp0wVWn4K+LU0++MPhaQ
         BkLkcee+xkdmI/dOFifCXGj+nZUDhumjO0+qugUPZb+VeOfoQxumgdb5lDlX3vCs+ap0
         PoCjrz9hW6Pr9ivO9ekiryTtMxp6VW8hu6wdT7Lam4Vz/TX1UkM0HIE/MczofKLQ1B88
         EKlg==
X-Gm-Message-State: AOJu0YwlqoBUprlu9B+pMLCdge4T183x4FEQnBZMklAMTxbiku/JU1tu
	L5Un5ayUgtOqAI4lRBsA1/pFPIAayScsa9Sf19uNaPTLcwv9Vt+CRtpbhYPUJNUmFQAWSaY+Jyv
	dfi+J
X-Gm-Gg: AeBDiet2azwX+jhr6bc4SFVz0habkyuT6RDc6h0oP3zcLWuD+FXKKOmB2w3W3pQFFoV
	UFEs515l3aR499AhKd7uZu2BjRgDz311DF6VtlXCDitSKokbtZPjIiJUfgY/5T4KmAMuqxGBbUC
	mlnQDAk0dVnkYLPBO5gbczqueAAsX/LP31HUsKhwul2wsSY1wQm+OoqiSInFN1jP0LrQpuWvKrT
	SZr1f9zlW2AMpCt2dmORGk4LbBlSq6GslOFrIhEwy3p1FthNNlvx2xO3Z9aoaUidJkGL7VCIodk
	pDn3trD5u0+XmpU73jY+/tE3qQjR75wvVIETi6M8v/g/6oyNJhAy1DGZ+Gz5HkoxOI1K2Xlsuhl
	PKY4gHGx7wfmhmktRBbBAZ1fvbVFuWMktEJR8mzhiW96B55h5v8YwSxaxYyzYgs2IYl749gKBFj
	gHIY4QivUyvMRhW5O0zEJrf9a+BrJ5JfXztb2AZGFlNxeNYj0bxMaSxrvtf78scqN7
X-Received: by 2002:a05:600c:1c21:b0:488:b87b:3052 with SMTP id 5b1f17b1804b1-488b87b3508mr81294905e9.29.1775576849883;
        Tue, 07 Apr 2026 08:47:29 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e46284sm951865e9.3.2026.04.07.08.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:47:29 -0700 (PDT)
Message-ID: <822a3036-1cc0-460f-ad04-d711606afd4c@freebox.fr>
Date: Tue, 7 Apr 2026 17:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: Transition/Padding delay subfields are for both
 EMLSR and EMLMR
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
 <20260327201135.905852-4-pmartin-gomez@freebox.fr>
 <6900294c6c10fb7336e8ca6c7217e970db2cc3a1.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <6900294c6c10fb7336e8ca6c7217e970db2cc3a1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34481-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,freebox.fr:mid]
X-Rspamd-Queue-Id: 3C1313B1589
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 16:00, Johannes Berg wrote:
> On Fri, 2026-03-27 at 21:11 +0100, Pablo Martin-Gomez wrote:
>> -#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
>> +#define IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY	0x0070
>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2
> 
> I think this is confusing. You have the "EMLSR_EMLMR_" prefix in the
> definition for the mask, but not in the values, but also the prefix
> itself gets very long, not sure what to do about that. Maybe just
> ..._EML_TRANSITION_DELAY even if it doesn't match the spec completely.
In the standard, there is two different tables to convert the field
value to a delay: 9-417j for EMLSR and 9-417l for EMLMR. E.g. if the
field has the value 1, in EMLSR mode, it's a 16 µs delay, in EMLMR mode,
it's a 32 µs delay.

As no driver implements EMLMR, I was expecting the first one to
implement it to create the defines:
```
#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_0US	0
#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US	1
[...]
```

If you prefer, I can implement it +
`ieee80211_emlmr_[trans/pad]_delay_in_us` but it will be dead code for now.

> 
> And then another thing - I was going to apply the other two patches, but
> really then looked at my git log and saw that no, really, the subjects
> are stating a spec thing rather than describing a change, so please fix
> that too.
I'll fix that in a v2
> 
> johannes

Pablo MG


