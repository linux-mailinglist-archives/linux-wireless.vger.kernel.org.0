Return-Path: <linux-wireless+bounces-34103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOh1CIuzx2mZawUAu9opvQ
	(envelope-from <linux-wireless+bounces-34103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:55:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A234E1E8
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F0A301BEE9
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B337268D;
	Sat, 28 Mar 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlspkpdY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f101.google.com (mail-oo1-f101.google.com [209.85.161.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE5375AC0
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695279; cv=none; b=pxeeQtyYGxa8ggUfbb8hITuUXu2NQr2dXcVG142wvVEoeUPfTajTXIpB0KNJEt4t9tNKWI+Moax/x5ewkztInb/dF1DAx7HyHyUPdnONyeOQLf2hg7xClHnaGzbPjdIaZppYW97yytpRm8me/wx+PvAIKEK3CNhqwbBShCP7DsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695279; c=relaxed/simple;
	bh=PspH/X4KJAHkqtDhj/K1jV42/wju9Xfv45eoFPuzSFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsrPm1l8HzaYlvuzfWsS0o09DsXN5/DOmEKFUrlnrGGViXnFT+xw9N+dT542G5I073L7hX9aPQ74jmZ52R/m897HEkwpsA8UJwINzPkntE3KaJU8OWGVg4GZcS8MJKITMQl5yBKm86rXCJ6fnk9O7BmzbZRwYud1FrvF4ys/Q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlspkpdY; arc=none smtp.client-ip=209.85.161.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f101.google.com with SMTP id 006d021491bc7-67deb70bc76so1718081eaf.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774695275; x=1775300075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=qlR8/jI9u8FN7fIQi5/DLeyA3sVEgGCZ0WBexSOO09aTuvmoDXrHyHliJx5Ca5gKVs
         dln/Ya1Xm08KwUFRz/daPYQ0QLPh5gU+UN+p/LvpfRsP8wIvNY0ATnKPn2rEUofuZJbp
         JZftox67Hbocm0FgM8piSrRQD6pmR3+KvRdVytZRK1Ng3uHfQeTu5yEAGsLu57m1mOrB
         yTaQfAE7FTzNYX74q8EnPhS84Rd/3hq2W/2tEelpfgkfaulzTX23qTIfbHIN10231KRT
         kDcWzb2G8lE58vp5f6B8hS/PJToTrIUvY8YleaIRx14i1wLrwaVD4NjVuS8G+tN3lUnc
         KB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxsgZ4O2OhjCPI7fr9XqEWvLRl/FDygVz12BydkLBXxxnqDj3ZCk41cETFVTd5uZRK1MOABarFGpIyuEKhdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVSfetdi2o1tFsC2JLPWAvzYBwbWGVJMftcCfwUA9WbOTiOhK
	qsR8/lYnJYLiqVFN8hcHKcKlyKWWIuSzUVT/KqM/k3QvlXeZM4YcPcSIqbuyGMKPasKdIsemHQv
	4PGIiceN21BtwyZtralUQaKvRk2Y2F7oqQuqMuqw4ohWjLFi+kHAL/GaqNYlQJZYi6WPZIMgvWB
	80WwO4TNr9pJr9LeGA8hOXvWCFTE4SFml/I+vWNnJdejJLj/Ak4Ur7IYVMkQwFU09YZfJBWqr5A
	bFtLBHBRprk8CRH8PgBP3l/iriwmc0=
X-Gm-Gg: ATEYQzxAc9aPQQJN8XoMeN/RoGU3GEvokQ1mqlEpftqDQixx3PrODQhmbH/gFIOD4c7
	T94AjoYQVhPdLDuy7f3YRdzcO9/N6H88yDbyIxj8PpN2iTbz86fjCJOfX5n/QK+GLCnOWQ3ia/m
	N95tiq8Ds+qDvxBO1ULvJX62w/BxXWzyUnBSoo2kfISpMeJevBTyDbD/N5nnmRKZXbt7CYXKsgj
	ZcfViL01jOyYUD1Fu7G5JQ4Culhqd9aie2WmT059JYWWKQc8BdmUKcnzrj1KgXiqqKObXKZw2A2
	BeMPWQHnYze/k/I4XW0aZny3oUy3o4MfjATZ2mWUc2Vta8wUWTRhoSaJ5KfsZu4d+48i51kBzDo
	m2r9RPuHNCQz1nOPKUUgQQqIx6MHP14LeBN4vht8y8wDRHC8Lw0PEqPfv90/2T9LoC8RGHltjSg
	GDhOSylDKE
X-Received: by 2002:a05:6820:1992:b0:67e:29a8:7fd1 with SMTP id 006d021491bc7-67e29a880d5mr171177eaf.50.1774695275325;
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-67e2312ccaesm189476eaf.5.2026.03.28.03.54.34
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b979930aafeso368406366b.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774695273; x=1775300073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=UlspkpdY+zBWLNr99upvLJ/qKgWjdJleYmDzINwWbPA6XvkvxgZBjFok+G5B1Mihq/
         AeK3aCYlIVdXUtmB6+F0NMPokApC00SzoZDTK8BTPHsjfF7iVY5fpbsNKyzPvBC4QXGI
         qfNyA63o6Wu3xrKDLLiu58zMkK5YDbi1ze+2k=
X-Forwarded-Encrypted: i=1; AJvYcCX0W1xSnNL94OC8wesztH/W/QzgL6KJGhXYDsyFauZYLtt+uNEug+2YdM/IlZlOE+SidWPz+31S9rlr5kmLjg==@vger.kernel.org
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363012666b.3.1774695273394;
        Sat, 28 Mar 2026 03:54:33 -0700 (PDT)
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363010966b.3.1774695272862;
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b801bf80fsm56205866b.0.2026.03.28.03.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Message-ID: <ccd8a143-7467-4b3b-96b7-e5c3e0a2fe0a@broadcom.com>
Date: Sat, 28 Mar 2026 11:54:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] wifi: brcmfmac: fix use-after-free when
 rescheduling brcmf_btcoex_info work
To: Robert Garcia <rob_garcia@163.com>, stable@vger.kernel.org,
 Duoming Zhou <duoming@zju.edu.cn>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pieter-Paul Giesberts <pieterpg@broadcom.com>,
 Piotr Haber <phaber@broadcom.com>, "John W . Linville"
 <linville@tuxdriver.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34103-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 785A234E1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 04:14, Robert Garcia wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
> 
> [ Upstream commit 9cb83d4be0b9b697eae93d321e0da999f9cdfcfc ]
> 
> The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
> flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
> runs as timer handler, sets timer_on to false. This creates critical
> race conditions:

[...]

> To resolve the race conditions, drop the conditional check and call
> timer_shutdown_sync() directly. It can deactivate the timer reliably,
> regardless of its current state. Once stopped, the timer_on state is
> then set to false.
> 
> Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Link: https://patch.msgid.link/20250822050839.4413-1-duoming@zju.edu.cn
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [ Keep del_timer_sync() instead of timer_shutdown_sync() here. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

What tree should this go to. This looks like a stable patch so probably 
it should have been CCed to stable@vger.kernel.org?

Regards,
Arend

