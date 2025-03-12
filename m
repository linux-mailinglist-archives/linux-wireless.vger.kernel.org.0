Return-Path: <linux-wireless+bounces-20264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD79A5E596
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 21:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CE517B14B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C91C1F0C;
	Wed, 12 Mar 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9dZ0kST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58669258A;
	Wed, 12 Mar 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812376; cv=none; b=V9PaRo2rYrl07x9qmfZNYQh4o5J6JoRufVfbAR48tv4Sm5n2T1Bg32xZlSvtAYsIE/tX+vqaAFv7sa0SJNarJIVCCZtHj9dTCEmcm/OPciA9hg1pDuWYkBy9PalTH2DoIW2bq4ph0lsWyk47pEC7yyWJpvRmlNrDlmR1N1TdqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812376; c=relaxed/simple;
	bh=ZhAUqzJvHYObpWLH9mLcwnLhiQIQNi1h4k4+f9ZHKY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjI8YbVXGIFXh5kot83qppEBvT6Gif13xQXtBf89f2yUeiV0/I+8IsXfk1TR0Ibt7sOmMuW0kNhlujtnFjO6shKvt8e6bQtU0UpQVxaCmmULsgGdVdff6o+GPuYAYb0ukC3heefKkp4IpcNgiG3KfYVXoCOwJlb7idZeE29QAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9dZ0kST; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913fdd0120so161755f8f.0;
        Wed, 12 Mar 2025 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741812373; x=1742417173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGjJvpLZaNnI/h8nlwQZhmjhWQKA8BlfNqhabRPiDWQ=;
        b=J9dZ0kST0EDisuYT2oDEQ22cr+rjSWq89F+rPC92ogp6VG/abuQmK3hsnvfSoiRVng
         PVk/8IoAZQauxlF45aatw0GWzT0pYi1kog4YpDQ4XjynT9ZauqZ3MyF5aQI0WghexORJ
         OLJkcrvqjMWfxCdZwt0Jlh2zzMdfIe/Cxkr6s9higdV8803k5pDFbNLxDcx4G5DwSt3M
         jeEhVvI9zvaxMaLsdYenkLfxz+reJycqTEkKP/Ir2umlmMqGk8bXS7TmjRafTaM+Ddbc
         BkQoowz0qq3JiwoXoWkigBKa3Y9c8Y84QvDpIbRjbCuG0wWerTtNiI3M5gDRGPSePAik
         L6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812373; x=1742417173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGjJvpLZaNnI/h8nlwQZhmjhWQKA8BlfNqhabRPiDWQ=;
        b=JrfXj8HNKGsdzInRmriG7vco6Scqzd8okXfE2f0a45ORG8N1uKpDGyRQ2xSIpMpdn+
         ZPeIiqXA6jx/+yihBJpRheuOK1Xe2fIE3V1/mvk1FoZ9+PwBvBqgXtmUrj7/8ah6bo1N
         KQcwRzje69wfufnawXx6IsIIhz9G8jPUv70vRVkuCUgnsSwMb8jcGrLNYPet9TeDSDM7
         dvJ+evFqBubGYn8so1UifRibSlq0VxZmXrmS+5EP4bvob/Fm2T/1BA6vz7L/uaMwZxRq
         1bITGZ8NbmId01xGLHKL4PWhF+K0zyb3Z4eLomt34J6FOqp/p6gjhb69RAOKoIE1sR82
         2TQA==
X-Forwarded-Encrypted: i=1; AJvYcCUYr3bPHvUicgJNasyo8f+ZKC5RycTbLl7uNT+XxgEvWHBb7LED37Xl1uMcV1NIETuqeseDeTJLh1+zKw+Vmvs=@vger.kernel.org, AJvYcCVOaZyHl3GZSWqmKOQ8f8oVOfc5IjHkp2M4sATx3jSC5SS+mxqXCWa53xwbnQ9gW+O5kJryrufdRdOm+NvNWMo=@vger.kernel.org, AJvYcCVffZtAtR+oJNDkVsLPwFvevUPHQhTKqo1wsxIsXX2azrQZSn1exeKIcwPcXguPx1Y0mLjGjPDQHMkiJlHl@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzBIk+d7QZX9w9XcTQIprcErcia8VvMrTXoddpUikYVw3fXLq
	b2fOwA4M1lpUHe7vWS/yWLupGsMJlRgyeSHhA4UWQNZCC576aaly
X-Gm-Gg: ASbGncvEXURpoMmfL8VhYX/Iw8EoQJp229kp9ywuu4g/Tg2g5OMSXNtGOL4yWpfFPXa
	aFGR8Mf5pFzWj08twP/0mUu5xE6yfQCX0pvCcF/EdYQfmFXco04DDKgYjAc4u4uguTIRVAMI5Ni
	LI7XI60lmNMWnCT4pRVrngp2srW0kCaoDs7B1CZlw5iXe9/sa9THw6D2NULer5pZSJ3FB0OHrS+
	Yqm6DP9wQcVOj7YcM2xBITVE0L1eT1m0peOtJeKlQSZiJrj88eYUreFfFRDEEOl0yLpgv+PW6sM
	/YRDCcTKUz7WMFS8JTQgx8DRNnzNJooRTLfPLDvBVVLmTbg0LAmuBUXKoGiCy7MqbgsSk+orEcl
	UlpvMHpINy2/OFbc/RLHqbniJEjeagzokenUNPXuXcfBnZcxQ
X-Google-Smtp-Source: AGHT+IFyQpV8UXvbzdZ9eDgW3+95bDCiRDPHybVVQEL8Ud3eER+VffGLX9YUUdh0OfQZ5Nti/qcRqA==
X-Received: by 2002:a5d:5987:0:b0:391:78a:33de with SMTP id ffacd0b85a97d-39132d1ca75mr15430230f8f.12.1741812372578;
        Wed, 12 Mar 2025 13:46:12 -0700 (PDT)
Received: from shift.daheim (p200300d5ff4f150050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff4f:1500:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm21682889f8f.88.2025.03.12.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:46:12 -0700 (PDT)
Received: from localhost.javelin ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1tsSx5-000000006HQ-3F5Q;
	Wed, 12 Mar 2025 21:45:55 +0100
Message-ID: <3793ce70-efed-4c86-8c34-7fe22f8e4b0f@gmail.com>
Date: Wed, 12 Mar 2025 21:45:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: Add __nonstring annotations for
 unterminated strings
To: Kees Cook <kees@kernel.org>, Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250310222339.work.654-kees@kernel.org>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20250310222339.work.654-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:23 PM, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.

Sure. Thank you!

> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>   drivers/net/wireless/ath/carl9170/fw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
> index 4c1aecd1163c..419f5530f885 100644
> --- a/drivers/net/wireless/ath/carl9170/fw.c
> +++ b/drivers/net/wireless/ath/carl9170/fw.c
> @@ -15,7 +15,7 @@
>   #include "fwcmd.h"
>   #include "version.h"
>   
> -static const u8 otus_magic[4] = { OTUS_MAGIC };
> +static const u8 otus_magic[4] __nonstring = { OTUS_MAGIC };
>   
>   static const void *carl9170_fw_find_desc(struct ar9170 *ar, const u8 descid[4],
>   	const unsigned int len, const u8 compatible_revision)


