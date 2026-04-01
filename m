Return-Path: <linux-wireless+bounces-34281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI3tJAJazWkRcQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 19:46:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86937EC73
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 19:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E193930BF52A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328F3DD526;
	Wed,  1 Apr 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOpt7ms/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89D3DEFE0
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065412; cv=none; b=LLHTNXOm/tMFyuEHO/5g6zxqgwRBq9n+4eCUgOEwTXKGa8Nenk4Z0luk0GPadOQhN78PJoRLr+IAvsWBLtt8liyujAdpSrlgQGzbf1Imqtb7aIHnsFp6HguBNfKwo7WpH2JUC529n9dKodWLoeTeS7Ex6T6yzSzztrMCJZiuQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065412; c=relaxed/simple;
	bh=M2PTvMIWNwglM5IRtzt7CmJXai+0enUMlMZ6jT4o34I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=QAMCcK4pGK+rjA2VWRijFn6jRV93VqetjPmues8HnA7n1/fTIdH1wPtjI9kARdSZql+d1tk/tCmuJzehsVhVQqJ92RxchdOsM24WMTZCCE3XK8ZP+RVRwnos5+S/GAt/lcWTDnGUWbtSbnxDJbBKI1uuImjDpIeZo3HzJy4xn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOpt7ms/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48704db565eso87846605e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775065409; x=1775670209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaI/OIQrNpeQjaeEVNFFVCUQads4q+o75svaH52EdCQ=;
        b=iOpt7ms/JSSWBuU5GpcW0LhNUiEnXII2/ePQtqzWcx3yQZ2q/W7+asQUGTSo/lAV0j
         yEtnubrn4rabs05YRHqRgq0peo8SvEKs/IlmI4jOtV63LtjNRzNvg7zaWToAHnvI2rYL
         FAdbTzTg4MrqDRNVjbjZO+GH7GKyzHJfYQJM+/91C3L/CHrjdeFeMPd6W+wcDX1AfHq4
         6JebwyJzmBjiVsC8A5ZpGSGtBkEE5QmhoHPdiMSEi+afTGEi5VMdB8zvBZ4uejMBqMuM
         DxzuK140NLDIs4ZQjnqdlLeBLepmRoWka/8xOnLSlp4SHU7oT3qD3VnVakYsHM6A/tiA
         +7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065409; x=1775670209;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaI/OIQrNpeQjaeEVNFFVCUQads4q+o75svaH52EdCQ=;
        b=qtn99fhZGGky1Hx6y+AOg3/wxHJt66pxlwtpZWBNCpSmvVx85DI8w0/5dOzGyV52lA
         aqXkjqiI/OXKtQ3DAv2Oi8HRB8V1V38sEbU/7m2ynS0TqgdxPsDyKbFs58PekWvRYssf
         c7yEXUkMIiUKhMpYIXl/93Q+iQjpJxMVT2a/ZCXc2GFqHlOluO25vWmlAG/MQzH96jsi
         inH5BDOluoVhbvrlaRS/4uhvVXT5SsszO55G/7WIGAskynN4L/AFsll4Ud5lpUnSJeYv
         qfD6wEc3KnzBjOc1Fjq5GN5kVdQCldnOKSQODw5tY8Iiyhusd09ZVyJ9wXwjgAtnFgB4
         6kCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcYvCT+bX8GbVGJsTy8SCQB8E+qM3OqKU5sRi5+nHr7VsFz0mCTQs4dhgS8UZSUD6vSnBTeLD9qyxIpEIFSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmi67iQzQqxrMG8cN1gjdX0gov0nsOCG26+UXrmZf7HjQyw9cS
	3RSbiYJwoCHJq7c/ISlUbWso26AkKJMuggc68HQJ3Mg15r2kF89Uxp212GhcaQ==
X-Gm-Gg: ATEYQzyx8hfa2NgfrT8WscuOUyzZ3ebAMBhhcP39+nzGhSLJG6zhKEEp4BfZMEQVYKE
	BZCyU8f5HcDlNnEgG7D5mf3WE6oTxBidGTVpr2S4Kf6IYm/zFWL2Lqh1byt2rbb/9biJykfR0Li
	B6eOtivhiaGWMMaWvLsnZS2W6ZgX4ZFaIXP2Pp2t75zvQngyGJXx48i3UDTsEwhMfs6ChbppuZ0
	SFWiO7qJPJxa7puIcw7c2qOmvrak3qQqinEvuvDuLXQwcyUyH5pF3H2STAD9+4CabYscDkqDNOH
	2rf9A04YZZ1EPHn66JPvXM5STW+5FQoSljlifnMjrhaINwKk9zIC6nwtQ8/Q3Vbo0ObepF8/G+C
	zNtpgoIhWqnByXbWuOHp8/+pxI7xh6ZoCV4a84/AP+++ZTxgAaBPA9JeUEX4lRKCgLFQXAAK5Ce
	sPWJph5oAwpphzsPslbBh2865YAAw3bg==
X-Received: by 2002:a05:600c:638e:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4888b769917mr2412745e9.15.1775065409400;
        Wed, 01 Apr 2026 10:43:29 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm163614125e9.0.2026.04.01.10.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:43:28 -0700 (PDT)
Message-ID: <a90f22d6-bac0-4c76-86fb-517e7e7bf441@gmail.com>
Date: Wed, 1 Apr 2026 20:43:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <25781f4aa6cc427caf396374ca46d380@realtek.com>
Content-Language: en-US
In-Reply-To: <25781f4aa6cc427caf396374ca46d380@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34281-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E86937EC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/03/2026 05:53, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Often one or more of these messages appears when the chip powers on:
>>
>> [  +2.167037] rtw89_8922au 1-2:1.0: failed to wait RF DACK
>>
>> [  +2.942749] rtw89_8922au 1-2:1.0: failed to wait RF TSSI
>>
>> [  +0.019006] rtw89_8922au 2-4:1.0: failed to wait RF PRE_NTFY
>>
>> [  +5.985900] rtw89_8922au 2-4:1.0: failed to wait RF DPK
>>
>> It's unclear why.
> 
> RTL8922D done RF calibrations by firmware one by one, so driver should
> wait for previous one done, and trigger next one. However, it'd be
> well to just do waiting at the last to wait for all calibrations. 
> 
> Try to enlarge waiting time in rtw8922a_rfk_channel().
> 

I was convinced I tried that already, but no.

After increasing all delays a bit the warnings are much more rare.

>>
>> It seems to work well anyway.
>>
> 
> If you can yield the highest rate (MCS13), I'd say it is fine.
> 
> Ping-Ke
> 

Testing with RTL8832CU (Brostrend AX8) in AP mode, the RTL8912AU can
reach 1.5 Gbps (MCS10) RX, 1 Gbps TX.

I used the RTL8832CU because my router is not working well with 160
MHz.

