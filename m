Return-Path: <linux-wireless+bounces-34802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPI6N6ir32mOXgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:15:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F042405C39
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED5931379F8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F56E3D9DB8;
	Wed, 15 Apr 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="df8Af8PV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE43D8123
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265829; cv=none; b=CJLkRopsxbZY3DKmxza2lXCG4MCj6QsVZMkEkmdC0V1ZmA1Q3ZIitmpJebFsBGTKyC+Ot5DmxhyNJ2t+FeavzrdXopq6HK1m4035uKnVN7PetqCpCfTIAlK/cFPR3uPrHqjYd8zsr5NPtW65DocFKV+5CSgvhZXrWoSABdjKLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265829; c=relaxed/simple;
	bh=XjxyHNCSWUlr8z0LDotP16pwC719syYIaM15xGGnjvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jocmgM48nPt2FoMACO9suDQFRDlLZC0gTghxfIktc7bPrjzUBFPx4RerduUG+foC3YTqf+4QUw+xmwvnE8/xGEpBMwCMpnaH0hIJV1a4fDq6HM0z8bardKWrWgSuFIM/pjxugoKjXduUooN8g7SkKgeTt6/TKG6wVyia5kkfRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=df8Af8PV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso84305735e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1776265825; x=1776870625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjhqjn9UBYaBV0B6eiuSqWwicYDyOVL1jSWpx2FNh24=;
        b=df8Af8PVd6Z4YYHepINcTDX5wb4gmaKKdFgUeSCYGtEDwU1VMQhw24vKvaoloz7ngz
         6GH844Wp3ew9mGWSOI5JB5babnE6s2I+NeloTZVEXEhswE/aIo+5HCyPWcpc3uPEFEpg
         9NU41OwmJ7ugX+mJYPEFzxuDSq5BIUZQltbdWoNovi4AnUKSFcmWT/9efy7kmK4R9w16
         uEhyVua/CYjan18MJyZc3K+sia9oIunsEFEvsw9OU57D/cjRKXrmQcyToG5Jt5YF7h7k
         orXXdr8A++0curhFTYaWYtFnWZZD1vCMhJpcN4FP3a0OMdm3yhdL8v0lS1DX/YcoReH9
         VF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265825; x=1776870625;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjhqjn9UBYaBV0B6eiuSqWwicYDyOVL1jSWpx2FNh24=;
        b=CR8oEx8w7pLQI5Ki+2XiatSDley7HmDd6NHYPtzmO4850w3MA94sopqagSWELyRRTn
         YJ/BvZ6I37ufCZNL740ADOupHESd4NkDyYYkfe305tasGkPchG+NDvGDy8frpTnZNpa3
         Ae4IplbXIm2wTVz27pyrT5nJNZJDabM1uhrr9TOnCEnUBFN0TteAg0JzWw0d5mrZPk1w
         j5ftz9Q+iQnI5Ic+51oxtk4Zo9K9s8tZ8FTv9z0fm3lEzk5D8ePDZgioDhM4CwDWcoK0
         WzuZ8Njh47E104mV0lCNZwjI8aNy7IAwu46KgiNOZV+QmUOTepJ/iKNUdXWUSXodxy7c
         xo4g==
X-Forwarded-Encrypted: i=1; AFNElJ8Op9L5/Pwib2ugYf3L/4YYotwVW9FkKkBw4Yh6n9VVryQb6vJHaeUNCp7Zi1AwMSFPY05UWbeyaCa5Ec4kug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ONlcO6SPHtCvAVi0R4cvG8NQCQdpbK+9H2QQ2k9GhoO1TUKy
	/iiRPoRKrkOxxtoxs6dDensP2s1wZ3n5DMqSIanjilkK3bDEEFyQsTcZgG46Cl3dzHI=
X-Gm-Gg: AeBDietnEV6mA62rVMQtJBhs2PkWroulVeEM7fZaF1KdH9n163ZElFgs6Hs/O5e/mtG
	TkM9cEFU5VbqlRAkg+/wxZKzC9i4DjzfZJnoBoaUTDyskme7LKDYD40VqhyV1z71saeoq4q4BaX
	hNOef/sTd9MNLYviSRaiyxlFQvwM/dso+ykbNsVcfWMIXeY/FjkVPeRT1Qxy/UwoOzsLudLwyVJ
	3K/sglM1oCABctJegAbofHPjLhy86FRajWb0UWsmyhHMPE0Nr/Tzxke7yO6jFClQeV5vZRsvhOb
	sNNu+Qye9d6RADJJFs5H5GlPfxF4LKh3GOpx50bskeYj2o1/gPO5Hao9g5ykkriHr7eGBS6EJcM
	Qm5C8r8PF/O55E77E2h97ZBtREpC5cI4En2XVnZfYzCCIoSvjamVhOHJSILIiFYhPysz2EleIlH
	OcbQJQhQu7eGPiRm6ufPNjUK5+Mi+YMg/dmT+iqw88b8d5wAHmgSO2LofUJm8+v6MR
X-Received: by 2002:a05:600c:3b24:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-488d687adb3mr318063995e9.24.1776265825038;
        Wed, 15 Apr 2026 08:10:25 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a72csm21248125e9.16.2026.04.15.08.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:10:24 -0700 (PDT)
Message-ID: <d0144694-13b9-4d6c-9a6b-59d41a9562bf@freebox.fr>
Date: Wed, 15 Apr 2026 17:10:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: radiotap: add definitions for the new
 UHR TLVs
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org
References: <20260412152605.73e682d0c8c3.I5a0c858467c852b7a2a00f580bd073af29c37705@changeid>
 <e3af2190-3941-4ec8-9c59-91eafc6eb156@freebox.fr>
 <60e2d9cdb781ad0bed35ef664f7d63dfc49fb9eb.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <60e2d9cdb781ad0bed35ef664f7d63dfc49fb9eb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-34802-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jmberg.github.io:url]
X-Rspamd-Queue-Id: 2F042405C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/04/2026 16:54, Johannes Berg wrote:
> On Wed, 2026-04-15 at 15:27 +0200, Pablo MARTIN-GOMEZ wrote:
>>
>>> +	IEEE80211_RADIOTAP_UHR_ELR = 37,
>>> +	IEEE80211_RADIOTAP_UHR = 38,
>> Why are the values 37 and 38 but below in the doc 35 and 38?
> 
> The doc doesn't even exist yet as you say? Other things are being
> assigned to 35/36.
I wasn't clear, I didn't mean the doc like the actual documentation but
the code comments that are used to document the defined value, e.g.
`ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)`, it
should be `type 37`, no?
> 
>>> +/*
>>> + * ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)
>>> + * see https://www.radiotap.org/fields/UHR-ELR for details
>> The URL gives a error 404
> 
> Yeah it's not merged yet. For now you can see the (draft) at
> https://jmberg.github.io/radiotap.github.io/fields/UHR-ELR (etc)
Thanks for a working URL :)
> 
>>> +enum ieee80211_radiotap_uhr_known {
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_SPATIAL_REUSE		= 0x00000001,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_GI_LTF_SIZE		= 0x00000002,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_UHR_LTF_SYMBOLS	= 0x00000004,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_LDPC_EXTRA_SYMBOL_SEGMENT	= 0x00000008,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_PRE_FEC_PADDING_FACTOR	= 0x00000010,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_PE_DISAMBIGUITY		= 0x00000020,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_OFDMA		= 0x00000040,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC1			= 0x00000080,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL1			= 0x00000100,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC2			= 0x00000200,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL2			= 0x00000400,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_INTERFERENCE_MITIGATION	= 0x00000800,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_NON_OFDMA	= 0x00001000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_NON_OFDMA_USERS	= 0x00002000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_CRC	= 0x00004000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_TAIL	= 0x00008000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_DRU_SIZE		= 0x00010000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_INDEX		= 0x00020000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_DRU_RRU_ALLOC_TB_FMT	= 0x00040000,
>>> +	IEEE80211_RADIOTAP_UHR_KNOWN_PRI80_CHAN_POS		= 0x00080000,
>>> +};
>> In the other radiotap fields, the `known` fields are (as far as I
>> checked) have the same order than the data, but here, for example,
>> `PRI80_CHAN_POS` is before `INTERFERENCE_MITIGATION  ` in `known` but
>> after in `data`. Any reason for that?
> 
> Any reason you care? ;-) I think I just assigned them in the order I
> needed them, and in this case you really should look at the radiotap
> spec for it too. Some of it may also be due to having copied some things
> from EHT and then filling gaps with new bits, perhaps. Since other
> people are already working on wireshark support etc. I don't think we'll
> be changing this without a good reason.
Just the little brain of mine that likes when things follow expected
patterns :) But more seriously, given that I didn't have access to the
specs, the only thing I could use that could point out an issue was
comparing to the patterns of existing fields and matching `known` fields
with `data` fields.
> 
> johannes


