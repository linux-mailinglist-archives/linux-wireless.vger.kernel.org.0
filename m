Return-Path: <linux-wireless+bounces-25936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A0B0F0FD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B7C7AAA30
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AB2DFA5A;
	Wed, 23 Jul 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HforAuFO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AB2BEFF3
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269237; cv=none; b=YJ31/TdUS/qllrxL81Pp3Uqc1mcWz1HNgExrKgsXwfa+VbHBTAQZSsljsl8cT5TnNph1Er/gBAeICHPE2V3JYEQW5GwNNQxxXAEk1SwUhdwiBROKq+Uu/X0jTs3YOvRSbnJFEU5bXAaLAdy7Ms3iDJ5Leoim8ILaIMc7LFvvgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269237; c=relaxed/simple;
	bh=Rl5FDHcKst3rDIallQV9+lArjzP33DezoICoPNEKjPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpXJsPeqBVKsxVSwJm0je3M2vJQEvF83ctQAo7Axndn01tgP2yzZh/WZV1Wz/6UeZ7eaZ11TK/93bzl+AwBT5SxH8MSI0wZuHCqvOVYQP5F5Ephq8w6oJyELbiy8MRbp6Qh2PIRd1OvqJPIezTRHLQm8mnXyMfEUQUElpTw1Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HforAuFO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e32c9577ddso617214885a.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753269235; x=1753874035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZsZ4ceIkCMjYpv3G+hfUSNyJppKuLhKWJpjluhzw0E=;
        b=HforAuFOriP+RYXzs0MSzeyc1unqBSijQ014tLd+mgnZ9fHtP/+bsE4g37YjGXp35J
         NvI1sM8xUwy8zqQNBDki4tA7g/W6tpsjTOEIGOCldbArN6fOmh3Vi6O+ynW/pxJuUKHI
         d6kS7zp83+D2jv2o1nHi+wiZAG9Gi2siMYh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269235; x=1753874035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZsZ4ceIkCMjYpv3G+hfUSNyJppKuLhKWJpjluhzw0E=;
        b=X/nTf3fi6qIhiyEfExIf5uMzIm3ZNWekuWMVbpXpbnWQrGtChJ7EwGFi4OjOTUqcDc
         ZkW0rzA1h1N0wSTM9Yvi7bPRnHDiImAs+GZ77jxtiwWO3kvyVp/dN502TTOIYBTx6IYI
         zQmiVxJH2g11rEM5gHnXA/k9rBEihQ0VYiWKLcjEiLM8aDioOj42gt6k/a04MQz6FPxz
         TM4a++mjJQqliJJJnfdIS/No+WIPLc2+kjHlp1ADenhen7fa0iLFZzG+x/8JqROoYC5z
         pD7Ssc0wwL6DDZjXYbhN0gnxR2/Lrg/iMr3jknS0yk3rFAL8hJMQBcey/Ph69ehMJAIU
         onBg==
X-Forwarded-Encrypted: i=1; AJvYcCWMzOUkjbtbAF2tR1H9gBvgD8q3a/t/rq/+o6iOfFMLEARUX5X0lgY8qe5aV0LXKbUDHLMancxyYhkuQHR39w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8KrBXcifHb7CdO/qu5BGyPyO4kiFv9FqJYLH8JgO7Sb00iM9
	XpGbvwAqUqq7mDExGsCIElsjLs11s03d2b6a1fmWPYeXV9eC0R7g1ANgV9cZXdCIlQ==
X-Gm-Gg: ASbGncuEj82WLqNWP7tOGePSRDWjNoXSAuGKqw5IcQm9jYhP7TNLAswibbowRHgMQkJ
	S2shamodSunwFqAH3ehfU8wTMACw388Zx+ql8pPigwaH+rn32DeNcMWAjx6beuiMG1Xj8tpcC1/
	SGs4lnl3uMovNtP53IJKD4FP8aCXxOOx5rmvZvYWItAJfT0sC/qTvlFTVBgyDL9Q1PnEBCrSdNR
	ph+2QGD8dY0NdlFERJuG6wyssFTaTZ9i19B+32+r1KWewqoJsEIZLweQTvEksqTfv4/MjwjvzyS
	UpYTBTlo3elYZ8VSyA/4i0eeYI+PUM+h9f/9HyU89yGtzHEFfYmjzCuL7vg2FqexY7bgqotQhKn
	6aWmXjJxUnZkEojBJT/iiNiRNLjcCfZNB87Vg/7UNHgBKjrhcJw+cQwgUPhL075o=
X-Google-Smtp-Source: AGHT+IH4t7/7bepWnmdaXVZK8YVZIBdABuEFNlaTKLC/CcssAnhPsmY0/sDAGGy3Vv1/VtD+rGPoFQ==
X-Received: by 2002:a05:620a:458f:b0:7e3:300d:f1a with SMTP id af79cd13be357-7e62a0fde65mr324852485a.19.1753269234673;
        Wed, 23 Jul 2025 04:13:54 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9155csm630107985a.95.2025.07.23.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:13:54 -0700 (PDT)
Message-ID: <90b48f29-59cb-489e-95df-e3ad36812185@broadcom.com>
Date: Wed, 23 Jul 2025 13:13:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: brcm80211: Remove yet more unused functions
To: linux@treblig.org, kvalo@kernel.org, linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20250626140812.56700-1-linux@treblig.org>
 <20250626140812.56700-4-linux@treblig.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <20250626140812.56700-4-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2025 4:08 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This is a subset of unused functions in bcrmsmac phy_cmn.c,
> They're unused since the original 2010
> commit a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom
> 802.11n wireless LAN driver.")
> 
> Remove them.

Tested on BCM4313 card.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 129 ------------------
>   .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |   4 -
>   .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |   3 -
>   3 files changed, 136 deletions(-)

