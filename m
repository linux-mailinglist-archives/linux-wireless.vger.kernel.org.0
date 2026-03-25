Return-Path: <linux-wireless+bounces-33838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJNmMY/Hw2lKuAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 12:31:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570D323E89
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 12:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9368C3149E09
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66533CD8A2;
	Wed, 25 Mar 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="WMxIgCMn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B73CE48B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437692; cv=none; b=nwPLPT4o3HfwkYIVXLv+X+zxPnI/0YOZ6Lk2etw7IQrfng7t+FplNkvmxwnf8R205ExRPAfcHZMr3aejqSiJ8myO1mrukuuiQvWTyxhbed+xRaad3WxnHti8qz+N7OuLIY2eoC3LIyfh2qKC3KkyWR5d+Ppsmm37yuC/GakafKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437692; c=relaxed/simple;
	bh=IIQYmTMM0Nc+VfhCZCPnAbMFQW+7p2rjFDKfu/A08iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjXpNgwcpNJwxKHeWLNd3lptpxO8plRsZImRhWHtO1Od3sABSzVDISlHwvPO/Rdo7G/HjGBalPuTeHBNWyPD4TUAPrrTzuoRk18mTVwn/M346GpgoNNAn0WfUUbXoPSFnE3MVsCnHbDeO9MNz8Vp6T/vppak4H5jO9qqLpAuYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=WMxIgCMn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso22369095e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774437688; x=1775042488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlyH3EeEIeeZnEqsaaYMPX/bc+fGaraM/nktAjp2qYw=;
        b=WMxIgCMnJ9WvLkj0ta9NPTOmZfy/rLtQoGndN+YZcf5meRPoyarIe1iGmQEljovhYV
         a4v7aK5j6+lPVBjC1F7P//+E16tnocRC62rFjcF2aBUMWhgjZeJWiHTGvSR2EDAyA4U2
         VX6OOMEIUdfyeZYAyHMPpqpfKRWrcZv98exTmBnL1bVyb8fQcRCLE7ccL3FOJkC3/4DE
         s7iX8GaUIdpPVG4Gp7JRPA58l5cc3Si5P+bU0WQX0E1+RgKmAAVF2BQT0pGD6SZzjifo
         acNmSUniLg7QgtiYHieM5VVyRUuDy+KJyHN9MRY3izS894YTsEEyCzMg0H983XXa+0YS
         0T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774437688; x=1775042488;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlyH3EeEIeeZnEqsaaYMPX/bc+fGaraM/nktAjp2qYw=;
        b=aN7SREDn97tDzT5WIJpMcYRb4EJnEnBDUqmdQdvQ9V188aB9UWhMXbLNSraaR7OYwu
         AY3USzJuk+hm304C5Q/Yo1RR4O2Kw3eGm/Tp7UrffnFLlBlMpHpO49Y7GFNnn+uE0Mcz
         JFNUdLaqp5pWQkR7Wgsi2qKO/DuffOSjUzl3lVIGI/3VpUoK6qx60jm25PSHBGqJs/bJ
         vA59gBH/kzWtFdPKoyVS0Ov0gKYmMTzNlFZc6P2yhTDQvQ8x76El5YO8ZXkti7BzeFpL
         CXXVrynAHX45S648x2A0qOi7xDkWPSserMaCIgLw/y+lxrzGI8cXkPAA4h0iRfHd1rGU
         sjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ2j/7nKrbZ3+5p0rE7AbXy93jbdF3K94uP7sVsUO2BjgyEbFbwhqE8OkSDWYnWeogy0CKYftLrJ/ATlxdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAxzMNX0HHF2S9nmMvMAryOjWbDgoV5cOyMtLvkqa8nTa8juP
	dNPObzKbCRQw56gXdyo+c2fBPbGKxBAG3AGzm2896fCcTZ3VYPK19WfSV/w5vAN87CRyYl58WOU
	hFTyi
X-Gm-Gg: ATEYQzzzovBMFk2hGmC/Ad4pk0BOlAbX/ZR9x3/A2fFWPkSZffUcVnLp1N5xvu9aFuW
	7wDpS1Bqsx7BoGec7LdlUDK2oqYdhq8vKGygTGJkZmERKqdOAJAQqVetR6Rb5+WCyB4T3sKfHJV
	i9/T8XWbkSdvSRrz89cXJwIEWJwoajPJ9/D3xY9cPpfHwq0kDKDlJi5YRafV5WWy/WQr6m3D9kS
	SRZctOMtZ9TSHUhSbFAyRh5rjk+jI/xNMWfOVg2f0cPnlJJ5TiyRSheqSxLi9INGgo5toLAqSLE
	GIGJvgk/tbpNziKdliJnLkdvkvX3wKcC6oovV4JrBY5oQKjSRf9jnZ49pQYgOAwaaFd95HtMyWl
	Uyg+/6E6H4x2SyAxi0FOCajs98aP71USOkLceaRUyE+EY3kgWwzev3QzR/uHkVgXqJPRUi7SM4K
	8CkbHbfVI8SnRC7C7/A7hkB8PNmHOI2GEGOa2Ct/a8zlzJDMzxb+u3RQ==
X-Received: by 2002:a05:600c:4e0e:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-487160a63eamr44972205e9.29.1774437688212;
        Wed, 25 Mar 2026 04:21:28 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f39dsm107684195e9.11.2026.03.25.04.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 04:21:27 -0700 (PDT)
Message-ID: <0bbe540f-6a48-4d70-b6ca-4498f715963b@freebox.fr>
Date: Wed, 25 Mar 2026 12:21:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mac80211: factor out part of
 ieee80211_calc_expected_tx_airtime
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20260323101954.874299-1-nbd@nbd.name>
 <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
 <0f56f76d-7820-4392-88f7-78f24b9ff421@nbd.name>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <0f56f76d-7820-4392-88f7-78f24b9ff421@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-33838-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox.fr:mid,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3570D323E89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 04:58, Felix Fietkau wrote:
> On 23.03.26 17:00, Pablo MARTIN-GOMEZ wrote:
>> Hello,
>>
[...]
>> I know this patch is just a refactoring, but I think this moved code is
>> bugged. If (and it's a big if) I understood correctly the chain of
>> macros and the comments, `ieee80211_get_rate_duration` return the
>> `duration` in 1024 µs of an average packet (which would imply
>> 1f38b8c564b8 is wrong) and the (PHY) `overhead` in µs for a (average)
>> packet. So I believe the code should be:
>> ```c
>>     duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
>>     duration *= 1024;  /* now duration is in µs */
>>     /* the agg_shift calculation has to be fixed */
>>     duration += (overhead >> agg_shift);  /* for one packet, we
>> "assign" a
>> fraction of the overhead */
>>     duration *= len/AVG_PKT_SIZE;  /* we multiply by the number of
>> packets */
>>     duration /= 1024;  /* we go back to a duration in 1024 µs*/
>>
>>     return duration;
>> ```
> 
> The overhead (preamble, signal field, etc.) is a fixed per-frame PHY
> cost that doesn't depend on how many data bytes are in the frame. In the
> aggregated case, agg_shift amortizes that fixed cost across the
> estimated number of subframes in the aggregate. So the correct order is:
> scale the data duration to the actual packet size, then add the
> amortized overhead once.
My bad, I didn't understand that `len` was the byte size of a MPDU.

So I was wrong on where I put the overhead, but (a priori) not on the
rest of the calculation *if* my understanding of the units is correct.
If 1f38b8c564b8 is correct and so `duration` is in ns and `overhead` is
in µs, then your code is correct, but the commit message is wrong
because `ieee80211_rate_expected_tx_airtime` is returning a value in ns.

My snippet fixed if `duration` is in 1024 µs:
```c
     duration = ieee80211_get_rate_duration(hw, &stat, &overhead);  /*
duration of an average MPDU in 1024 µs */
     duration *= 1024;  /* duration in µs */
     duration /= AVG_PKT_SIZE;  /* duration in µs for a byte */
     duration *= len;  /* duration in µs for the actual MPDU */
     duration += (overhead >> agg_shift);  /* duration in µs for an
approximate PPDU aka airtime */
     duration /= 1024;  /* airtime duration in 1024 µs*/

     return duration;
```
[`ieee80211_calc_expected_tx_airtime` has to be fixed too]

The current patch:
```c
	duration·=·ieee80211_get_rate_duration(hw,·&stat,·&overhead);  /*
duration of an average MPDU in ns */
	duration·*=·len;
	duration·/=·AVG_PKT_SIZE;  /* duration in ns for the actual MPDU */
	duration·+=·(overhead·*·1024·>>·agg_shift);  /* adding the overhead in
µs to a duration in ns to get PPDU duration: overhead [µs] == overhead *
1024 [ns] */
	return·duration;  /* airtime duration in ns */
```

> This is the same pattern used in ieee80211_calc_rx_airtime:
> 
>   duration *= len;
>   duration /= AVG_PKT_SIZE;
>   duration /= 1024;
>   return duration + overhead;
> 
> Your proposed rewrite would multiply the overhead by len / AVG_PKT_SIZE,
> making it proportional to packet size, which is incorrect, because a
> 512-byte frame and a 1500-byte frame have the same PHY preamble duration.
> 
> - Felix

Pablo MG

