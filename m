Return-Path: <linux-wireless+bounces-20965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A1A75978
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C698F7A4A68
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0241A315A;
	Sun, 30 Mar 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZLlD0nbt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68884182D7
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329640; cv=none; b=cJiyGu/GCbaH8a37JfAJjNEfUT0xQ2zLhiUbKIyJzjcHTPLebvifKrObG3kUEPZDS/UZcy1LAtRmuvTmx1ofpV3HhGGHqwjSedfS/7sKFclRLgYiVD8+lZQQO4l9I+rFbW6sxJLWFt2t/gSMTOHhiwjjew8wDb/mFwdhkM38i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329640; c=relaxed/simple;
	bh=5Dn34M3j1J/0yG2xzBOIVJdG+eWKyBdZzWhp6uW6JiI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tBnJ1bYvF/GQ5SwflgEgucYQKI5kf8xIlyYnWXpSIHCz50Z1zFxTk28/rlEeF0wsTcEb9nQHy5HHUgHVKVjZKhHKZnroTcrwoC0kHpCQoU/t1JZJiwvRO2TRhUFE2Yqy2StUMeu9diUTEN27lG/VfIh7BemEO6vlJLs749QZBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZLlD0nbt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so2947518a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743329637; x=1743934437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU9e44tO6FJo/GjHldkKNGDusFlokQ2t2C9nEsto6Fo=;
        b=ZLlD0nbtYKgcPRVStfN40UQt8fjE46Shna1bnIb1gxSE9B6ER4rbB4msA8LvSGsotD
         rDyyJESKgkWv/Sz2Is2vTiOXqumK+ezmg9XYniQztsmG4+6+Je3qFJ0TGS1GVH8rLq+6
         rAFHlwT7btx3CeYRGIyh8K40rg4/8X2fWBWK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329637; x=1743934437;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JU9e44tO6FJo/GjHldkKNGDusFlokQ2t2C9nEsto6Fo=;
        b=byXw0aCNFdVMO2PmJ3eki9eOSJ5PyFEf3moXv2rJRmeEbRzV0PlElGgDdPzmiR+D+w
         08ogM/5n2R/ue+gtwHa1Fr05+rMffdZmwd9zdeYP8rJ1gs0V9bu0Q3E0IJvyuKrLRRhy
         1riud2eSqipRwu4ussbFU2PYTTHmztqERVqVX/iMwR0SnNt6JESIQutk6+3opBV5qUUJ
         dJT6vvq2Gi+ZO2oGgzFeiYnROs95rZpJPV+kK/9rsbJ83KY6/VbQf9e8do6avP7ngREM
         K+rMXHlnqNl1zcFtYRpPC+St4wZnTOrmizspvRWR3u6BR3MUgt1VeOka++sOI3mAaWZ0
         cY7A==
X-Forwarded-Encrypted: i=1; AJvYcCX7nnxkMFeq7Bw/9kfx48fyDkUPhkwQ6SDx5xE0naYe066uQlLzylvKluXPLSQZBLDNwFw3Pj+K7oHxbb2wpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwASXSo5YSLUiWY6/6rXCxmcHMiftNKVi4sPZrTVl7QFo7ObO3v
	rIMxH4nMqL3MuKpVLs597TMZAaGd3fm5psTymLX+Rd8hHDmj2zYGSEYZ5hg+Dg==
X-Gm-Gg: ASbGncv8Ne4NgnEy0TngmjXgZ3W0lkPQV7lQcmAVikHyRukkEKoqHyEJFRrK+zXOiS3
	lPMn+yWNsPPc+2phFM33sMQ5LVUmdN6BAfsaXbFSit/YvuLTjw8CNzntaQR916rebpSN/lSM+2/
	acIEJSUO5/ThGE9TATmRvi5dAeYNombBG6vnQyKbn7KUUEDRozLshP2pstA/+IcOXN2yvMrekLy
	zucFHCljVVP7qJkDzyPOsea30p3L/9zFEwrHIW0nyXPszN1Ok5L2TzpVIypBDamPGbKGKrtD2Oc
	1pQp3NoivZkDz/D5hmHWQ9uRNV4B1YRXfoGdfNbZn1tCg76eMVdQSDfnXZfGSXvODBdUc9kDcTC
	8a8sglV8=
X-Google-Smtp-Source: AGHT+IEhOwFN64RAI12GBOewic8rItD3qND4hzZYF1sIbS+MnHfLx1/+PRibZCWYf0GY0riRMXCk2g==
X-Received: by 2002:a05:6402:3490:b0:5e4:9726:7779 with SMTP id 4fb4d7f45d1cf-5edfcc1f72fmr4865313a12.2.1743329636709;
        Sun, 30 Mar 2025 03:13:56 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17dfc4dsm4084750a12.71.2025.03.30.03.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 03:13:56 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
CC: <kvalo@kernel.org>, <jeff.johnson@oss.qualcomm.com>, <toke@toke.dk>, <jacobe.zang@wesion.com>, <u.kleine-koenig@baylibre.com>, <megi@xff.cz>, <sebastian.reichel@collabora.com>, <saikrishnag@marvell.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Sun, 30 Mar 2025 12:13:56 +0200
Message-ID: <195e68b2ab8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <195e686b618.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <20250330093505.22370-1-abdun.nihaal@gmail.com>
 <195e686b618.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] Fix memory leak in brcmf_get_module_param
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On March 30, 2025 12:09:04 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On March 30, 2025 11:35:41 AM Abdun Nihaal <abdun.nihaal@gmail.com> wrote:
>
>> The memory allocated for settings is not freed when brcmf_of_probe
>> fails. Fix that by freeing settings before returning in error path.
>>
>> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")
>
> Good catch. Thanks for the fix.

The patch is fine, but a minor procedural nit that I should mention. The 
subject of patches for brcmfmac should have prefix "wifi: brcmfmac:" as 
shown in the Fixes: line. Hopefully Kalle can take care of that.

Regards,
Arend

>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
>> ---
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)




