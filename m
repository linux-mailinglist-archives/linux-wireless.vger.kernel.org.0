Return-Path: <linux-wireless+bounces-37632-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FBpSHjZ6KWoWXgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37632-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:52:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E012E66A6BF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:52:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rLBoMV9F;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37632-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37632-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC0DD32497B4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD773FA5D8;
	Wed, 10 Jun 2026 14:35:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FF413225
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 14:35:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102142; cv=none; b=lc2irOtw5V6CWLnnaWm7x+dyin2O3ap83OErewwYfVZLhOIBUZcjSY6hgYS8CQKd3soMBE8gavIIFl26Y8kFETx/EQ6Rk+2CA8kBF+l0CSnihyz4XHqfslsdMZ3n9DG9BjRfdhA6rCkTvFtzw2K9g3ZaKJoi+KbbLYEawdnrmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102142; c=relaxed/simple;
	bh=q+g7CYzbsKvLvi4mfWg786YFrApIxxHFHFUXr9uKI4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4/CIGWXzGuUxMiIDA/3jZyr280HEkfmNo195TU3/9dEzZBb30xxklkd+fxMiGA2/knG46p5OgM2smaqTsp6sPqsSKxJf+dQd/nPQIgRk2L4e7yJeaMPoaoeZJhP9U4LUnfkJFvyxwqK84Cq/AGiR9YNoZ/afk2rZQihoSN3Gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLBoMV9F; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490e1904089so2163995e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102139; x=1781706939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dpuf4sI5RxpciMojsi135R+tahIgw62q7Ly7Z20Zszo=;
        b=rLBoMV9F0z+nwmKOzEd43gTwY88SN3z/2ZoYltA/QDtgamUBz3yoxbqhbNxPx5XEJO
         OJbnTRXxIvUe/pSl+p8wQZBYsotgpFS3HPrF9OleZAMlYg5QJoY6cZpUf/MXxANJ8VQG
         OrHucIZhya9UG0G7vdoEVsk1aSf6NBwITFIv5SyeK6lTLycXJpDsdSoUooahhf5Wg2DA
         CuUlxAOyPlFy4au8SW+4BS4zBK5lJOJSbaq3kLKVyMYbLubvcZkmWDCyd7TuXZY20VPF
         LHVJZhx3hZ4Oi2KUakdb+UVb2yr5Q8sRs+eY8UbeoQlGOkKnzgLiazJzfH1UIk7KdyJE
         Vssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102139; x=1781706939;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpuf4sI5RxpciMojsi135R+tahIgw62q7Ly7Z20Zszo=;
        b=DyWGLbLp7yEhpBHVW1CAfdDJ8RwHi5lcM8DTn/7TqfxUQZcYzXtyFFTTvwjLH3xxNk
         HrcYU+eV3XDYHbaTlRIUXIif5pAcXFUyV7ohw1ardsikoAddVJ8L5bUQKDEffz4dpfNg
         iarllee0LvJ5+W0+la6Vj6pCyKefU//tS1ZecfVPExnLsQ8wU5+a3qW/rQWCVyEDudzB
         nhHX9rK4U9zymqPrPzCerAzGbS7oefCQjeJzva09dFmLfDIrwTpzbAGoakSr/1617i4C
         OA01rtTbkrvgWMU7A7O2uY0jjd5xjKLGnT9tIB8d2PVTT2wrRmN49kiBbwUZXNnDj9JO
         uDFA==
X-Forwarded-Encrypted: i=1; AFNElJ+ka9WHfAFUymP6hA7WVVT5VSMmjhWiB90vSBdkuwk5TLXliuVz0s5ntbR0zibMuXQoWR4sJR796XFPPNKz3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tA73EAV1O+gVH2lFDsVH70NcXKVmWrMcKYMTUSLL7rD6jX2L
	jO+1G31gcCyshM8pIKACn3jFgr7ERSvtr7M6fHkeoOx5rLpUaknE0wGM
X-Gm-Gg: Acq92OEmV4bBQAylLWdgGBErCjBSrOpu1wXNC/QPbBPbCLXdM5J3dO74DWt2GUySqdm
	RkMiVprEUmYg/MKTsML8VRIenRXwD9RB8vFPvb+KLmbzmuiBGyLh+k3BkH5RP5nL7U21D9cqbW8
	uqbQGFa89kc5FrAKnu1LlkzEeOMjtamC9YxEbcmvMv7Rv2uEPYaGzIx5cXeRllRAvor6DQFwt1r
	OsgndBu0mGZ2b6mRX9jLG92pCoOfX4RFJPbBAXnYMwJOGaGMleW7I2LgoaTIqQ7lXQvt1HhUnYv
	fcRD4sqt0hzlsTYwO19SHkOLdyKE9I9W9tDWKc0U1uhx6f3KNruxQnJkJzcr0anWqbsSzN9SUYU
	xc96k/hGyNDddyUCTRSXKva1NWLYlJL3u5OBn/6qBeVPT6t1X4svYNGiaoZCKsMp9hRLItHDCOQ
	72RjvPMUVgq5ecBvTgzzKsnrOkkFXpBovQeKh5Inv5L1Y60IV8H2SDwLTzwauH9s9XPYzQsgew3
	uG3TaIkIbX/aWhK
X-Received: by 2002:a05:600c:8b6a:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490c26216ddmr382830225e9.27.1781102138726;
        Wed, 10 Jun 2026 07:35:38 -0700 (PDT)
Received: from [192.168.1.131] (59.85-85-174.dynamic.clientes.euskaltel.es. [85.85.174.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fcf5bsm681766985e9.9.2026.06.10.07.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:35:38 -0700 (PDT)
Message-ID: <19a4d71b-cfcc-49c9-a564-5795a0b7a0cc@gmail.com>
Date: Wed, 10 Jun 2026 16:35:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7925: remove code guarded by nonexistent
 config option
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
References: <20260610042429.222717-1-enelsonmoore@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20260610042429.222717-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37632-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matthiasbgg@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthiasbgg@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E012E66A6BF



On 10/06/2026 06:24, Ethan Nelson-Moore wrote:
> A small piece of code in mt7925/regs.h depends on CONFIG_MT76_DEV, which
> has never been defined in the kernel. Remove this dead code.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>


Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
> index 24985bba1b90..ea04e477a67c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
> @@ -74,11 +74,7 @@
>   #define MT_HIF_REMAP_BASE_L1		0x130000
>   
>   #define MT_HIF_REMAP_L2			0x0120
> -#if IS_ENABLED(CONFIG_MT76_DEV)
> -#define MT_HIF_REMAP_BASE_L2		(0x7c500000 - (0x7c000000 - 0x18000000))
> -#else
>   #define MT_HIF_REMAP_BASE_L2		0x18500000
> -#endif
>   
>   #define MT_WFSYS_SW_RST_B		0x7c000140
>   


