Return-Path: <linux-wireless+bounces-25930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66FB0EF95
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6223A61A1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B9280A5E;
	Wed, 23 Jul 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/cw2kKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E43286D4C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265846; cv=none; b=ca5RkOTR30hgEvONCDlBkxholCks255WhKu7kUZSiPAjUCBlxCeErZL+AHWXuXPKR8b8bRvUUrIp0vP4FxSc+9w5iihWokNPwvh3S5cScGFnrCUMLyI5zcGIu2Cipd0yIZB2rFbX1ytS79PkbL+U/XJA+z/QN6Vwzk0rE3iZw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265846; c=relaxed/simple;
	bh=0FWkjxUMoHwv3AQfgH23fqkY7ym36SwwU2RaJykt4jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISFVRcBviwYwbnxpWbuvMCeVeeKbq2xNF2n120x/Byq8A22nEIKvo8xxU8DTck0UU56Ul5NekuV30Ao2pNGMaiY2uSgQESQ6D1CuNwt68lOAQA8t6UNtqtLqW34psEqWomioIHS1HnOHG/YOfijp5z4JZYEC53k7r+qCzEJjn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/cw2kKb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab92d06ddeso92766291cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753265843; x=1753870643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJfe0U+u3u72GvAm5az+oPpJij7n1bwHFfIVuB9iyks=;
        b=H/cw2kKbL7oZUBphi1UHAXC8fXh4DLfbJuGDx3TCaPGNb7kzyuh7+EUvA+/jjvyC8A
         WQ8FXz5c0LidIdDpEbViPv6S5gJy4EywlkosmirN3WGVvNfnD+75HENACYQAq6Pf9mNL
         m25I296HNM6pggEYNTibdxLWXeJBt2f771wsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265843; x=1753870643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJfe0U+u3u72GvAm5az+oPpJij7n1bwHFfIVuB9iyks=;
        b=SfeR0ZVePAbUlKzHimUQpSxh7e24KPPIzvNmz9HaqekksM0URvuVrvXun3owVczm1m
         XJEkBmKv1MRfcQXD2bdMMivqp1eWA0qePoRM1aZRhh76QxmAzj/hQUDFf9UmJnk3mU3E
         LK/0jUWVa84BnU2Pw0Cu8CCXkneW2AA4hsjPxusgU2eI3Xu8nIMjVqGmI5sc50ZauqEl
         GrgwgKTOdBWKeE9Lu9w+BWmJOSiy7Vs2U/FBvdfaAl/6HdGhQxWZXpI853DOIcF1YVey
         E0wxNmDNrVoojQQq58zKj+RdQPtvRCIRTY5tyDzhyO27Fnzwa7xPLSSrZ6xxFGJ0yrW5
         Kv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTfm7THcC7SjHutjU+O/q6rLCdOuOpAzKVyp8NNY0PyLIqfJ1OeRGpPkZWz4+9UNlZoRIQMhT4DNPTj6oxcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RjE/YJKXq0awlofApKQ/u+xICxeUpPGiQJ2Ht/CPXkJP9Lxu
	4ZTIb6WCZ5UuHv4k23wlfL7e/QKuWmWBWWiJsHyFgZnEXiM3AGNMH2Wl6PGcwtEqPg==
X-Gm-Gg: ASbGncvl/ESoth/cXQzFbxr2T+KnEA3Bsv9KwTjLSdB4GJq/umkhv5yo+ySoT2Z4ej8
	XuuKLA8W9W7/g2crrbeXK9AKxYF3Rwzay2VmbPlio2OjZ+597ePld2Oj8nEGTN8zh8xRQ8d7Fai
	THWDJghGTITdXQ/n+YsXhGt/L01wg/BQ7101jAYsq+W1jttyTLAxQdBOi6E2stVY+mGvRRjUAjw
	OrfnippQHidQMMBzU1G2M0uo3Wu+0Tct0rIdqs/p+rLy/ywfLn/wiFbEeAROpDLqMMkerN8FmTt
	g2O+v09qyk1Kmyfow/jbtOztimvor0MWypvbJL6eFtbXqzGhGQvM/tmUcjV9VbO8lpQwzlOJVSj
	ewObEBCgXltBzVwMkdaUhqWjmVbqBTFzHXTOLyBEliwJlafw6rAhU
X-Google-Smtp-Source: AGHT+IGPC76h0wm+3k9n1XTW4Rb7SXd7kFL770EuSfku4pFTU6QqODky5+n4jn+mNVWWzLJ2wjdbZQ==
X-Received: by 2002:ac8:5a41:0:b0:4ab:cf30:187d with SMTP id d75a77b69052e-4ae6de8696bmr37910481cf.19.1753265842520;
        Wed, 23 Jul 2025 03:17:22 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b3106bsm65670351cf.60.2025.07.23.03.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:17:22 -0700 (PDT)
Message-ID: <af4d556e-d917-498b-80a9-ee18e51a72fa@broadcom.com>
Date: Wed, 23 Jul 2025 12:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmsmac: Use str_true_false() helper
To: liu.xuemei1@zte.com.cn
Cc: liu.song13@zte.com.cn, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20250723173004776P6QSjcW7NrlpGYLTFM-yP@zte.com.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250723173004776P6QSjcW7NrlpGYLTFM-yP@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2025 11:30 AM, liu.xuemei1@zte.com.cn wrote:
> From: Liu Song <liu.song13@zte.com.cn>
> 
> Remove hard-coded strings by using the str_true_false() helper function.

Fine by me. It makes me wonder though what the motivation is to have 
these helper functions. Does it reduce the amount of string literals in 
the kernel or is it purely cosmetic? Anyway ...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Liu Song <liu.song13@zte.com.cn>
> ---
>   .../broadcom/brcm80211/brcmsmac/mac80211_if.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)

