Return-Path: <linux-wireless+bounces-20562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C5A68DB7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 14:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB701884B5E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F413255250;
	Wed, 19 Mar 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSUaJR/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003020FABC;
	Wed, 19 Mar 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390518; cv=none; b=NjaAufFVHIlutlFA04u/fwXLdtP6NiNsKf6ky0mGmukMrhrIWt6mQdtSRXkHQuJrDMOoE/iv0fY1uxUYvv2EnndnGKJoE7fjOv53lqNEJgs3BDVt9ri45s/v+mri7/KYxcQbNPB5i1VTuiUM5AwZE/sCxKDmLC6hQYebQCTkNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390518; c=relaxed/simple;
	bh=7do4dHbDSsCUtXU65wPSmJayj7/Ivkk9Ya9bwGX/z5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ntc+4N5Bnm00deu9gEksnBPXdHUTmdH8aPFhiZ5V08ee/fxZqiHS/FJnllk9R4at6ZVXf0SJwL0wCbxdrmEy7sxiw1GDgaNb2dv29HmdmpOSMDxCMZcpbkcYsMUHMoVwMn7STpTJS5JsM/TklpYbHVhuLxTXY5/1/o2QrebW3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSUaJR/S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22622ddcc35so21047115ad.2;
        Wed, 19 Mar 2025 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390516; x=1742995316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAyfH6kqswLWsr6KnxovBzjKHKjRDDiHqO/1jpHfBtY=;
        b=dSUaJR/SZyXLz5S7hrXUZjnaPs0U92L1BVgBDG4y0BTT05YVDEjfE1lj/lqYJ8fVyD
         K/SM0Z1+OwZbs4nvynv7byUBwErfG06f+g+5lFRUSLFgjgowk9oeelnsxVJtM0fYOuMY
         Ll+lusnQTM64DQu4SxcYASLewHodzC4kpti4WxTK5lzg2T7lNKtO40UcDRrcXPhrKF1K
         U6XkI48+8daycuRU8kH0P23rAGAOwp254bgjpcR1zasEtJ0btJyreYXGJq/201FDUWXN
         42/QlVvVSYoV20rTay6zyCBYjSMRKymsVzOQNby5TKB7rDhlM84HR2Bm2JVvr4xMxsk1
         8f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390516; x=1742995316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAyfH6kqswLWsr6KnxovBzjKHKjRDDiHqO/1jpHfBtY=;
        b=fHYTW55uDGEunxf5ZA27sxd5KVxVq9XCeimn2Q10ghvq7j6cgTh+g8af62IXASeiSa
         mj8qTExDscJQK3ERtv4FwZubpiM3ZqyfgV0kYHFYMUeyCdBtkSSa86allvd6dvaE6F6F
         jSX2N7jQxsxcEU5bG2H62kde7nddzG/SDAhxmM8LfrpVS8m1pwIEeLFknk2B9PwiPl7n
         loiZlWobT60y/gy4zZ36JU/6v0U9b/orhtVqI56TQFWquB+yqSWvYELXD+UExmCahTbC
         hCybMEsmzL3w6oyoKGxThziFNgE12VpuwcDqf5IhWOzIWpXU4+2cme5i2MXN37sw9Hhf
         hHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtGtYPP70dlyhl/89mPHEH3x8Nm9svupPtj961JKw3ErEUNBijSiiehwU6huBGJtU3ogJjdM8HP0WVLYZphw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNrhYTOyXPbFvpGWRw2tOsedhgGj7sW0i/YjXZy514JUwY6d2
	ck8QWqhYD4xpgSenP/WFIgVLjFFRx3AT2fbkf9BFHllGW9mhipoC
X-Gm-Gg: ASbGncvpyEizpm9w488Sq8r6BORDPDoiirVabUjkuXOBOUYSf0u90SI68+y1BC66h5B
	P8cB3+kuofxCJIgniybV9mqjhac3/L7mt2FhHaJ3Vjj/QNZ/lBa9fFE5dCqn8uQrPfm3XGumeq+
	4JeYknxD5730AjKnJjgnA/TjkyXhsO0EP6W5qQEPoCjfZNW9j1vZjWpmQgqCS7bOn1DGgdfLYLj
	lLNhvz4EIFuCbQ9TZv+VmfFZ6/MFY+naNFB9Xsb2RC9+vmvAy13NdQb2tLThP1+Sr2oFaPxOFbE
	sKg9oEmocNqsz3TuQQH3MM0fQgypP6Rhu+cXC2xnbbMkmvDS
X-Google-Smtp-Source: AGHT+IHRycCa0/R8HPIzD00TI8PYaiGAbqcuw7nzqP7PTLjp8g9kUh2PAbj+uLvhvMDgivEreZFslg==
X-Received: by 2002:a05:6a00:17a7:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-7376d619c6cmr4925512b3a.11.1742390515740;
        Wed, 19 Mar 2025 06:21:55 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e0b1sm11862295b3a.97.2025.03.19.06.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 06:21:55 -0700 (PDT)
Message-ID: <1560b292-6366-4588-ad4d-654377613b84@gmail.com>
Date: Wed, 19 Mar 2025 06:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mac80211: clip ADDBA instead of bailing out
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20250317163902.1893378-1-sashal@kernel.org>
 <20250317163902.1893378-2-sashal@kernel.org>
 <69c63a19-5419-4bbe-858f-6ca100345a28@orange.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <69c63a19-5419-4bbe-858f-6ca100345a28@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On 3/19/25 3:58 AM, Alexandre Ferrieux wrote:
> When a Linux Wifi{4,5} device talks to a Wifi6 AP, if the AP proposes a Block
> Acknowledgement aggregation size (ADDBA) exceeding its expectations, the code in
> mac80211 just bails out, rejecting the aggregation. This yields a big
> performance penalty on the ack path, which is observable in comparison with
> other OSes (Windows and MacOS) which "play smarter" and accept the proposal with
> a "clipped" size.
Out of curiosity do you have any performance numbers for this, like 
Linux vs Windows vs MacOS? We ran into a significant performance hit 
after I added multicast RX support on ath10k (after ~30 clients were on 
the same channel). After looking into the pcaps we saw many ADDBA 
failures and ultimately had to disable multicast RX. I want to give this 
patch a try either way, but I was curious if you had any data on 
performance improvements.
>
> A typical scenario would be:
>
>    AP -> Device : ADDBA_request(size=256)
>
> Current Linux reaction:
>
>    Device -> AP : ADDBA_reply(failure)
>
> Other OSes reaction:
>
>    Device -> AP : ADDBA_reply(size=64)
>
> Note that the IEEE802.11 standard allows for both reactions, but it sounds
> really suboptimal to be bailing out instead of clipping. The patch below does
> the latter.
>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> ---
>
> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
> index f3fbe5a4395e..264dad847842 100644
> --- a/net/mac80211/agg-rx.c
> +++ b/net/mac80211/agg-rx.c
> @@ -317,18 +317,20 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
>                  max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
>
>          /* sanity check for incoming parameters:
> -        * check if configuration can support the BA policy
> -        * and if buffer size does not exceeds max value */
> +        * check if configuration can support the BA policy */
>          /* XXX: check own ht delayed BA capability?? */
>          if (((ba_policy != 1) &&
> -            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
> -           (buf_size > max_buf_size)) {
> -               status = WLAN_STATUS_INVALID_QOS_PARAM;
> +            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA)))) {
> +               status = WLAN_STATUS_INVALID_QOS_PARAM;
>                  ht_dbg_ratelimited(sta->sdata,
>                                     "AddBA Req with bad params from %pM on tid
> %u. policy %d, buffer size %d\n",
>                                     sta->sta.addr, tid, ba_policy, buf_size);
>                  goto end;
>          }
> +       if (buf_size > max_buf_size) {
> +         buf_size = max_buf_size ; // Clip instead of bailing out
> +       }
> +
>          /* determine default buffer size */
>          if (buf_size == 0)
>                  buf_size = max_buf_size;
>
>

