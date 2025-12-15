Return-Path: <linux-wireless+bounces-29754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A70CBD6CE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C149A300F592
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740B32D0C7;
	Mon, 15 Dec 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g75j1irK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96777145355
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796356; cv=none; b=SLPW/ovNjyKAmNWxvDSImPQzV+0mJQbkzpah7sKBXhBzQpgtnM2ryYUNAJYL+DLdOFw0iGQUcP8fBXcfXFP2NLz3a1zHvZvZBmGU4+22UCob65wzW0qMD50D4VYAc7Elb44orwFzZRn4OT/sTYKvErdp+nUlqlo8guWnl+5x7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796356; c=relaxed/simple;
	bh=WALXRYaSnX2NQo5Zdoa8yuA91lMK6EB0Ik6rvocO8FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0y02DUDW9AT90WmXLzs3diHA42Sv6zZQKIbIhbOHkAINB0D1da/ydF5HSLXKvphI1NRLeS1SBnd+s1/6Vb8T/F7Hi0QPbfQy0wGwngQIGcTzn024OqXHVzfhrLFJsN6gqXEXn7xb4HOjbQz83RJ4atcXp0qWlKmq6hsmEI5kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g75j1irK; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a35a00502so9709786d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 02:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796353; x=1766401153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGPBtN+GRkztVcF7iYTgvUriQdToelq0IYjOfLdYOeA=;
        b=TgOniv/dC/sNUvCJEvJPb9npnu4Ou/v43OMjDt0W/Z/ENS7lvjF4TBh3aq5R3fMp6w
         ypT12PPcDALzMb6mtoORYpYqroAy2nVVO02Z7V9rLax6kuc5SZMSEK7L0x5UQnRy+V7L
         kHk0Lec56Y3RL2oeyvEcH5aLL5gt8dHqzqqJQED92vubdgCZ1zpS6nfeNiF3wPPW3gFX
         YbRBggELjvZGgCrBCJePZ5AnrNR6LkwHo4KvBlKykW6EAqlyP4cEk0pviv8MmhfCjlsP
         7OIhzHDie5KsUwspfSVgZr9zPptthfDUjvcTsLcBvTFHGxavntjMUbYdDi9Xsk00CFlc
         cnUg==
X-Forwarded-Encrypted: i=1; AJvYcCW3vzysz3VMx5OhzEAlOfocvWof0I0Hzt1Ml947BcF5xVRYcEZp7uOAwjnC6rAFOsKOFlwqYW3yAujoUkbo4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQPYBeeNqhMFgoS2biOh21Ul/LuGz0Mr5X2t1JQVWveFwqPn6
	OpkNd06tg+ETVC/sEwsXyT+qqGxlM+28VsZ6umIrH84763QXGB9gl/mTviwEGtNWa96Db26IHgP
	be7fHMQVRM0beYqB553vyHHmXrE1/HrKsEY2smBXb0sq2tJdUimjed7mLaeFBAAYzkgaxnx/x5R
	NBFZOMBglYqiQ5wjRN0eVXziMfRUTFBbkz+r/XJP08I7cQOms9GANqzxV7kn1jX2Uvg8eeR+w0b
	eTvv9RL0RmGhD9svxRP29R8dMW+
X-Gm-Gg: AY/fxX5sInuId8dRboHWRKIUjTWbnntHrZ4N4RrUyy0ZIq0yzWm+vkpJnBsn8ZissrO
	qz37eD8rT8ZI05k9ftZzR1c9QKqwBIv+W7jyHAF8qOX8lViDrEVdrnWOArH+bcdTht3VvKZHzgU
	DK3SnCGIN/PQhkpp0IlpvjPTywGYPGsgsj4i0XTinkE9rB4RQiaSM3UhuQ1KVl978pUNJrzEs1G
	hbZ7OatSUBqvtMBU/xJn8qWSAlFrHbw9mcmGbkxAf9oEDpdjkkrBvtCuv4esoG8Eiw0QjsbLeDb
	fmu2CKVTjE5yEISiZVGRoopb0buh+9se0BECyKt65jLcNe1uM1i10u1k4LiowWEstZ8ODbz0yZT
	pYbrnRA0BHcWZOJah44xELwZf3nxpK4uygVNSz2upqTq4cMNDwXxfuX7Ofh0pVzGGs189XSaMPd
	WIEnJo6ZVSonK2xX0qTpjijnfCSTZluo7hGnAn4q//v48MMrXyZOs=
X-Google-Smtp-Source: AGHT+IG4qtH8wk0yCnB3GUMmpRwEYSO8Z+Elg+h04XNNw+3aJDCXADnL3lYTGpHAf11MH6SeZy4qy8XnbwMv
X-Received: by 2002:a05:6214:3010:b0:880:5193:10fb with SMTP id 6a1803df08f44-8887e44ebd2mr201813966d6.54.1765796353358;
        Mon, 15 Dec 2025 02:59:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8899dc06ac6sm12802386d6.20.2025.12.15.02.59.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:59:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f177f4d02so54277875ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765796352; x=1766401152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eGPBtN+GRkztVcF7iYTgvUriQdToelq0IYjOfLdYOeA=;
        b=g75j1irKy4GAAztntNDv9Sst1zE71KoXa02L4q9vbWmv5cd1hF5FCX/T7h2tPiGA1M
         eRhdCAVrnjUHJmiT0ptAoaDyg9q9oOAwfzmOTe/nh/+/9FP+bnR7/xhAbfw0Qr9K/yUF
         27tQc6ANyTUZB78vG8kqSoazfkhmQRH7EQyUE=
X-Forwarded-Encrypted: i=1; AJvYcCUFi3hJHL6DPWcrjvz/OL4/6JC/fRG64zSvYF1AYrlRGBtOXjdFdFElDX0iDai9wGdinZ5dno8rSDO4hqekHw==@vger.kernel.org
X-Received: by 2002:a05:701b:2513:b0:11b:9386:a3bf with SMTP id a92af1059eb24-11f34c2b670mr6945939c88.42.1765796351961;
        Mon, 15 Dec 2025 02:59:11 -0800 (PST)
X-Received: by 2002:a05:701b:2513:b0:11b:9386:a3bf with SMTP id a92af1059eb24-11f34c2b670mr6945925c88.42.1765796351432;
        Mon, 15 Dec 2025 02:59:11 -0800 (PST)
Received: from [10.176.3.239] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b51b2sm41349925c88.8.2025.12.15.02.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:59:10 -0800 (PST)
Message-ID: <d0a40ba8-8af4-464a-9879-0d7e3a124a00@broadcom.com>
Date: Mon, 15 Dec 2025 11:59:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: rename function that frees vif
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Ting-Ying Li <tingying.li@cypress.com>,
 Chi-hsien Lin <chi-hsien.lin@cypress.com>, Ingo Molnar <mingo@kernel.org>,
 Wright Feng <wright.feng@cypress.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Ian Lin <ian.lin@infineon.com>, Kalle Valo <kvalo@kernel.org>,
 Alex Shumsky <alexthreed@gmail.com>,
 Marcel Hamer <marcel.hamer@windriver.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20251215103817.29598-1-zajec5@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251215103817.29598-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/15/2025 11:38 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Since the commit cf124db566e6 ("net: Fix inconsistent teardown and
> release of private netdev state.") netdev isn't freed anymore in the
> brcmf_cfg80211_free_netdev(). Adjust this function name to match what it
> actually does (freeing vif).

Hi Rafał,

Thanks for this cleanup.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h | 2 +-
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)

