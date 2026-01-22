Return-Path: <linux-wireless+bounces-31080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK0MIRwScmksawAAu9opvQ
	(envelope-from <linux-wireless+bounces-31080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 13:03:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF8665BC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 13:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 681468CBF4E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084F330B3E;
	Thu, 22 Jan 2026 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ6W94Ho"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D43D34A6
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082210; cv=none; b=Ke4eiIPBzTe6+0aQQgvau+/pAdZwkTJ9ByjceYI0BnErV1wLMeD4eAA93mLbJMqmvL4uK9porTzsMa0ggUcc7HjbcohoZ3a9v4e9OVEfRjryALxotG+rUTFLILpVaTzrHxY7DBeR448c+1z2b//zwmMpcXQJGjjN7mD2obzpitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082210; c=relaxed/simple;
	bh=I1P32dRnlRRlRytuS718Mi6x2CGbWNt6tQn/o7se8tI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dkpuq2/RMfZck4FbxfDGryXVk34ky/S2G2v5VNdBE9n70KM/DSfMw0sU+PsArPohg27KFKbtc3tRbcrlgjoberNQPALy7s0FH66841CDapLNUXr2aQ8Uf6x5SBr6A8zM77Yr7wa9TqW2NdZgVl9KrQXCINnXKPat1cF676dNdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ6W94Ho; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so13274905e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769082207; x=1769687007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vi3eOtlGMdvgIFC1VrsJnTLpPSzBkZyu4ZAigbqhHhA=;
        b=JJ6W94HokGi0hriJnBJWXke2Rv6NfjhuDrW67cs8QVy/oXoOD63+IitFi1CZqhTqeE
         fJwfPM1IABXqK+wNKOdOwGUHorBea00+RBcON/3eKUd1NaQ417yuJ2X57hvAkHGcaRF9
         T8h4aOP6ro0hMUDd7aTxi20Af/Jp4zOhrLsCC+N0M+G27Q4ICm7lpQQ/SuI8GjbVM/F7
         k5syYmnDSfFXWSS5KoAbzk9+Sif7f/pWNYcywNUHhJFiRdY6SatYEQX8t8M6777Vc73e
         8ztc1PF2dslJzDXZkrbyf4c8TIw2a8EfaFVy5RLPN6FHBnLAhuYZR5nS9UP5kd5mtAyP
         LO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082207; x=1769687007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi3eOtlGMdvgIFC1VrsJnTLpPSzBkZyu4ZAigbqhHhA=;
        b=Z19+zFp9j0ABOVak/jqSeIpxvBduvyFmlttpQEYKN+OLvfAkTwrV8IP94eVuYlGFPz
         QCE9zkKBGVhKhQ2VvtdrAHQcee6PwSeun34TfuKooa8A8VEAn+k8FpgwjYkOBXUKGX+F
         4z5eB0ReRypXAk1axKtobpTIXSSyoX17Xc/b/K9pbTJtzcgn2E1KGEcSiK6XhL6XcqW8
         EMH/kBegIsth8ZHlXMd7eHJK3WMrp8t02y0K/By3gOciscHRDn3OPuq3LxWmhjOslIeD
         cfSWWnRXbs+vKjvVtmII+Zhas236m6oKu06NxzuFCyCfEIn6TIad5YDJSOStVxbyAsf5
         wpYw==
X-Forwarded-Encrypted: i=1; AJvYcCVaw5ICvFkcckTtP9/pMTgdWcREKXFZE0P+nISU0qerkXoMafbm36HdN56LnbycaiMMO/6touBE4XWhQWpDdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4drn0I/nY9N3pE0AsNaCJ7aLyicnXeOGYem3QntapkPy6Wt2X
	t4YpkJOLD92kV9+2ECT2KNXjfOOm6jS7Jmcteo45TK8fG+jGPqt+JqID
X-Gm-Gg: AZuq6aL5eAQaqzJ6cn03K+57MdU36hIJDwfvGN5lrPt0ChLXtyQWRM+E+FkNS1amjsY
	cR5SgH6TufQEr2VChqXtJ7JUbrXYEHpU4IDWnYFveWToKVb3S+aXmc1bNOKFOH2PmAGXbHs3Ung
	JpqYX6w84H+lOybOi4hiE2TXaecWVvsyWJtmm1BCkDejnQhPqkvnIwvULSqh+XHK3LE2DJIisGd
	6jFiifbD7sN9aZvCIR4X24fQqe2xeAoLlrzszN+BiRfRfGotvbmu6JFZFAkoC4RqQQ+X4sD08/e
	RUpP3fyFLaW8cviPTLIqkF8vU823ohnbJ0wH6VuR5iG7dNtDgc/D897+RpD/XFDmoQwDVOSu896
	3wtBb6EPrucXvdrn2cgWlC5+W4twBaIQjOlrxlL8A3nyNMJ9tl1JOlJZm2fLkDQjNPS/czehiI4
	tWEbcXpSvVm3TC2vHmo9eSVBNLyhU7xMtoZ+Yf7hHpARDlxJIqiEqeY3LpI2Gcy2KymBy3Zv1wz
	n+emLlV4uclrbB6Gig=
X-Received: by 2002:a05:600c:4fd0:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4804708299dmr23584965e9.10.1769082202231;
        Thu, 22 Jan 2026 03:43:22 -0800 (PST)
Received: from shift.daheim (p200300d5ff09750050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff09:7500:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424b64a8sm54172145e9.3.2026.01.22.03.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:43:21 -0800 (PST)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1vit56-000000016ac-09nk;
	Thu, 22 Jan 2026 12:43:21 +0100
Message-ID: <12dcf657-b8d9-4bd5-9bb1-e760dcbf1b30@gmail.com>
Date: Thu, 22 Jan 2026 12:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH v3] wifi: p54: Fix memory leak in p54_beacon_update()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: johannes.berg@intel.com, quic_rdevanat@quicinc.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20260122085945.444955-1-zilin@seu.edu.cn>
Content-Language: de-DE
In-Reply-To: <20260122085945.444955-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31080-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,seu.edu.cn:email]
X-Rspamd-Queue-Id: 01DF8665BC
X-Rspamd-Action: no action

On 1/22/26 9:59 AM, Zilin Guan wrote:
> In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
> If p54_beacon_format_ie_tim() fails, the function returns immediately
> without freeing the allocated beacon skb, which would lead to a memory
> leak.
> 
> Since no other references to this memory exist, it must be freed locally
> before returning the error. Fix this by freeing the buffer using
> dev_kfree_skb_any() in the error path.
> 
> Note that this error path is unreachable in practice because mac80211
> guarantees a minimum TIM length of 4 bytes for non-S1G devices. This
> change primarily serves to silence static analysis warnings and keep
> the error handling logic complete.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Acked-by: Christian Lamparter <chunkeey@gmail.com>

This will be picked up automatically, right?

> ---
> Changes in v3:
> - Add a note in the commit message about the code path being unreachable
>    in practice.
> - Remove the Fixes tag as the issue is theoretical and unreachable.
> 
> Changes in v2:
> - Correct the Fixes tag to point to the commit that introduced this issue.
> 
>   drivers/net/wireless/intersil/p54/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
> index 2ec3655f1a9c..57a62108cbc3 100644
> --- a/drivers/net/wireless/intersil/p54/main.c
> +++ b/drivers/net/wireless/intersil/p54/main.c
> @@ -143,8 +143,10 @@ static int p54_beacon_update(struct p54_common *priv,
>   	if (!beacon)
>   		return -ENOMEM;
>   	ret = p54_beacon_format_ie_tim(beacon);
> -	if (ret)
> +	if (ret) {
> +		dev_kfree_skb_any(beacon);
>   		return ret;
> +	}
>   
>   	/*
>   	 * During operation, the firmware takes care of beaconing.


