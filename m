Return-Path: <linux-wireless+bounces-25934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1293B0F0EF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C8B188532C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9826CE20;
	Wed, 23 Jul 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nl9VYkZc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B62571AA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269185; cv=none; b=tEkFOhKiI9Ju9BG7uHTbnWNe2n2I/sUVpJkm+sat8fPEQNItj0NEhPZZsvG4Owjufn1+yykmDovJTS3IwvhedSkALTeAkkFSxpfUpvTD8MlIZsa/fvHYt3m480jOL4BPUVm9CHdLAD4TkFPSrQdvLPUYSga0P1X9BybFEZsEnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269185; c=relaxed/simple;
	bh=MPAX2RnsTcW0xXiyDmHG4NU6qmm1/0XOsZ82B8R6zzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKDngyRG/8XNKo1jJBLqZfXmJ+JCZp2EPIug3XfC5uYHlJVaENqKayzwUTsS6MddlRNROcjwM+XxdYiN4aiGw/zWDlxW35EnYtr6NSIDZkYJUd2GFKUWLJ7mXZKyPjnJeZjg3MWJqpEGBN3MX85W8QkvMlTmabXFax4zmwtoH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nl9VYkZc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab5aec969eso120268741cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753269183; x=1753873983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HytRhaegPRtNUdHVSaCnhiMj9eX1oCCXU5COax0hlbg=;
        b=Nl9VYkZcn/iz5ZV2RcVXnqylRQaYyoHIb5NDMRFRLelnd7tzcXHtNirx8AYj457/Vk
         DDCJlD/ipmd6SmfH4Gq148EP3V9Uot7pCUz4J4oftL1Rq5Tv8JLUDBgFbgrOn0eDfpZj
         uLCwZGA3oSnWWWM9wBjABqbuhr5jAeJPuxQZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269183; x=1753873983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HytRhaegPRtNUdHVSaCnhiMj9eX1oCCXU5COax0hlbg=;
        b=eYGCxNB9k+AxaWdyXn9XX9B5hJT08Aw7u32VpY03zcxQFAWFqbWLZDW20DlItuW41M
         s7HIvRGHaAgXu5baRdF/1VzKV6a8fCzmUO3xRdojErh4qyRnQleP7nMXmYZf3dgID+Xq
         cKzUXnZiq/UonGz/WnTRRa+YUt7JnF2jCjsQJp5Ptj8OMyxILi1gbTwrD5q7Y3BDk1Er
         jD11B6WKnxONDPNMguJ1oclN39VnGc7HjhCFNi4172x8BjlUdH/2Xuq7ngK5HhPvrJnC
         uHqIfec8o42bZl8XwEYUiVO9tD4cfFRO5bsGJIZPNQN1IoNYdUtv+OzbQ6hB5hZchNwW
         qSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHqOwQXKuFAKRnAV8cTewBedyyx3Kt4ac3QG/7/5DgYvt593s3N1qj+KXEygE+s0cmQI/XrW+/B0pq4yBDXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvO7W7dhWYkYSe1Uq9SPGFSbjr4pEzAzB7Ix8RXdKnr690r20S
	tlKpsDocpLmI/+1hiDHb26WRV69rj3wgkC4hx7QAwA//rRNsJkkbXzmbU4PYwOOqiA==
X-Gm-Gg: ASbGncsfTsprziwOI6zBUpZq+SMPShX60pz83QaTC37YpV9nW0B0taYqP3PHIK7vYV4
	jE3BBeNB4rrNDPiPHyvFxZgxRJAmPeAZOntgbnfhiGq2DwBLSWA83IuK9nxIsptvfsXlcT2se2A
	fYbdv8nz/eQWHCKGKVfs1VI+3VYxfzCRonKZ+FRF5Dr0DSeH5sWsgwqIvxLsZ7FgzLQ5p8u/SE2
	9APRVhUGTsn/0wV3QOtdd4UjEnUu9lWKN9b3GCaVgQagU6T8E2AnRDmQbL/JgB58KgxrwwkXUil
	aa9fzhSHXYXFe2+RodqoeSdip5O+zrlGjfjxz8uyBOy51cI9pQ8QpKrRvbXuB24PtS2mkKloyEc
	pIquZP/GeaMpNK7kVQQiUpJC8mskvq0WtQYNEfrE6Q9os7sr4GfIx
X-Google-Smtp-Source: AGHT+IF3h2F7JQLYHnJObVwTaoPJg3PNc1Ms0PHHT8Xq6utf7IeAwcG30GcnVb+4+s+XP9N23Qq/Cg==
X-Received: by 2002:a05:622a:5813:b0:4a9:8ddf:83ee with SMTP id d75a77b69052e-4ae6dfd22cfmr39254691cf.46.1753269182626;
        Wed, 23 Jul 2025 04:13:02 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49802efsm65616941cf.7.2025.07.23.04.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:13:02 -0700 (PDT)
Message-ID: <8bad525e-420c-4870-a6dd-bd28dfd4708c@broadcom.com>
Date: Wed, 23 Jul 2025 13:12:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: brcm80211: Remove unused functions
To: linux@treblig.org, kvalo@kernel.org, linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20250626140812.56700-1-linux@treblig.org>
 <20250626140812.56700-2-linux@treblig.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250626140812.56700-2-linux@treblig.org>
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
> Then remove two more functions in phy_n.c that were only used
> by the ones just removed.

Tested on BCM4313 card.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 128 ------------------
>   .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |  11 --
>   .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |   8 --
>   .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  19 ---
>   4 files changed, 166 deletions(-)

