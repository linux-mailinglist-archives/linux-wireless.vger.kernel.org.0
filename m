Return-Path: <linux-wireless+bounces-34540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C4FOflr12myNggAu9opvQ
	(envelope-from <linux-wireless+bounces-34540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 11:06:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA2F3C82E2
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FCFB30028D1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188BC3A8736;
	Thu,  9 Apr 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="JvqoFNGZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FB3A874F
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725476; cv=none; b=Mc9KwYtwS2MBgBu/D2cl9VBoW+pNlvbNNFe5Dud9r1e08iDh7UwLbTau/W7c0yPMtYfshBlN9326o9TpKW3GD8AFAGMEZq13DvAL9Nt/AmYzTiib4lNn+KV8y3jQSEZDxyLr79rcZGxsbHF+1ayd/ltolS0zrXjIsz5TgWpBLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725476; c=relaxed/simple;
	bh=0WOTcc00ZiZaAgTL2cOfArbQ3g82cDSAL+sTkXvCcKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVLza7Ea0JfStFFzkpoq9BpyXCkdqqgn+M9qPwsy+iZwYXDqV4L43YD9nkIrNL08hSMJKpD4X2+mns8f59rzQEO0j9+lc6G7+ZSYxkw8bOvySVJii4G3WDPTxni9aMMQ8iCwll/UFVlUZQFDPEjApL/DH6cmq5ogZfcDn8VMsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=JvqoFNGZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4888375f735so6077925e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775725471; x=1776330271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OspDuLkOxeMG8c5hn5Z2Qf6FR87UU6W4b2c9ZJlBVtg=;
        b=JvqoFNGZRFsiQ7GT7BbS4fGo8uXvAXsH0s4tqmsyc6/+NFX7l/qYGlrsW0No2GY/tA
         Sk3jlg4R0K3zMK+p6kITn2ZyKvq7h04TH7ukMcEEZzHEewQ0KvSiEppkq/wubC8qpv+y
         CuCd/SB2PWL7yPozVQlSOx2dsF6fw8A/VqLUUI+hilwXAD1hkjUIzZsnUHzf9c+tBhdr
         ojE6ZFPOO1b0lHTTWs+h6i5rRSiwSA4roWmQGkm9uoZZYwv7aJFn2lwEjMSqiGgoZ/Lo
         3JybuxHScHrglmPVUjoTF4vepFCjuRHNbxf8OUJnt4lLhsCH7DVppt6bTceMwafPaY6r
         a84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725471; x=1776330271;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OspDuLkOxeMG8c5hn5Z2Qf6FR87UU6W4b2c9ZJlBVtg=;
        b=DH6V6lbvfCEMiWQnvLctFM0Lp7AvXw3HmSBAph5a84LvpSD1jhME6IcqQSmbYtRX8Z
         1gJh2yvvpSM5Fc0xqaM7psphJI8zJJ53OZESan6nTFHdvIfLG0WsX05paNzG3/M9EjJH
         dPY7VooiCysYUhHL3p2WJwlQIQS9gZHrPnn3SSpSZlfFghQ1TyZJvnqlVqBq9KYRGebx
         +7gyGZLvv27HG7xd7bWQDq8f/a5L4ccN5MCUfujwv45weZamkfervXVo8Be5rqWyGXs+
         N7G3FYNuj6SLR09FhsRWA9ku9hKTyAGlrpVT36hHn2lMFxw4M3BLM0WoJO867wbkdc8d
         PV2A==
X-Gm-Message-State: AOJu0Yyrpvvfc82/1BmPpMNTqBZvnzJKYJq4UVyuZsyiV3AdeyA0fh1L
	LlANztG6aU4By69eqwwTYPb6UmHs8tEiwQ2hdsoVZ/bnHSB+3xMHO9a3PNsKw/fqr1TDcM+qK6N
	c8PRx
X-Gm-Gg: AeBDiesTtewQtiOgqv8s2I4hapL2PpBWy7qv8au3S53wGSEHWACoDFrhXW26ngNozNa
	vI1GSyO8bLoxwTIRJW3gUex0K3L665pQd04WIxgg4Ys/1OGVSgsiKCw8XCO0oqUsNSWxOjmy4pp
	Ihm6S9q0uKjXJ5a62OXrlynfEyJKUwoZHGzooWEDEYcbo8dhivLuczbbyfA2kee3/Uue3l3dmMQ
	7UuT4gBceK++UYSguS2JfchbaUGNuDS8cGfMIuMxPINJx+Z9yW3EN9CpfNUSbxJX+mJ6PZ+2jRC
	zaBzoba0/fATXTcn6IokbhbD1ixawT13MmCnuK1ShkRfZlshqykHFl1hg5YUMVkCSe8xsb4e/Qq
	Y1YflD9RtRTOwR8bQHun+lIX3K24Ep1t7k+ZAN2jOnrA5QC4OdtKpOwOC0OgRxAg4WRU38OlP7z
	4J5fbSV5SkTdyx1m3/fmOiCWDWf/9Xnem/3oAFhn4XtNlrKw8T430pqb1YKc/OBly6
X-Received: by 2002:a05:6000:1a8d:b0:439:b440:b8a2 with SMTP id ffacd0b85a97d-43d292e3addmr34351249f8f.28.1775725471178;
        Thu, 09 Apr 2026 02:04:31 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm62413584f8f.27.2026.04.09.02.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 02:04:30 -0700 (PDT)
Message-ID: <1fdb014e-9b40-4e89-b90d-b4283338fd91@freebox.fr>
Date: Thu, 9 Apr 2026 11:04:30 +0200
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
 <822a3036-1cc0-460f-ad04-d711606afd4c@freebox.fr>
 <f60497d95314a9a595d0830cf47de8533674e811.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <f60497d95314a9a595d0830cf47de8533674e811.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34540-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox.fr:mid]
X-Rspamd-Queue-Id: DDA2F3C82E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/04/2026 14:07, Johannes Berg wrote:
> On Tue, 2026-04-07 at 17:47 +0200, Pablo MARTIN-GOMEZ wrote:
>> On 07/04/2026 16:00, Johannes Berg wrote:
>>> On Fri, 2026-03-27 at 21:11 +0100, Pablo Martin-Gomez wrote:
>>>> -#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
>>>> +#define IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY	0x0070
>>>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
>>>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
>>>>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2
>>>
>>> I think this is confusing. You have the "EMLSR_EMLMR_" prefix in the
>>> definition for the mask, but not in the values, but also the prefix
>>> itself gets very long, not sure what to do about that. Maybe just
>>> ..._EML_TRANSITION_DELAY even if it doesn't match the spec completely.
>> In the standard, there is two different tables to convert the field
>> value to a delay: 9-417j for EMLSR and 9-417l for EMLMR. E.g. if the
>> field has the value 1, in EMLSR mode, it's a 16 µs delay, in EMLMR mode,
>> it's a 32 µs delay.
> 
> Ouch, good catch. Why do they just want to make everyone's life harder
> all the time...
> 
>> As no driver implements EMLMR, I was expecting the first one to
>> implement it to create the defines:
>> ```
>> #define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_0US	0
>> #define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US	1
>> [...]
>> ```
> 
> That seems dangerous, you have to really look hard at the spec to really
> notice?
> 
>> If you prefer, I can implement it +
>> `ieee80211_emlmr_[trans/pad]_delay_in_us` but it will be dead code for now.
> 
> Dead code in form of a bunch of defines doesn't seem so bad I guess?
> 
> But I still think the naming is confusing. Maybe we just drop the
> "EMLSR_EMLMR_" from the *mask* define, and have it only for the
> individual defines, as say
> 
> #define IEEE80211_EML_CAP_EML_TRANSITION_DELAY	0x0070
> #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US	0
> #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US	1
> #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US	2
> ...
> #define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US	1
> ...
> 
> I think that'd also call out that in fact those are (needlessly)
> different.
What about `IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY`? It also has
two tables for EMLSR (9-417i) and EMLMR (9-417k) but they have the same
content (as of 802.11be). Do I just rename
`IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_XUS` to
`IEEE80211_EML_CAP_EML_PADDING_DELAY_XUS` or do I split it in two
identical `IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_XUS` &
`IEEE80211_EML_CAP_EMLMR_PADDING_DELAY_XUS` to future proof it in case
of a change in a future amendment?
> > johannes

Pablo MG

