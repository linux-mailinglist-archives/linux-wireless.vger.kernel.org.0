Return-Path: <linux-wireless+bounces-29427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF95C93D44
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6F342700
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFA2E7621;
	Sat, 29 Nov 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aHA4GqDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA24278E47
	for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764417570; cv=none; b=sAWjyh/bDRo6pWDksyUDJPVPEr0Pc2u95yQ7anoLEG3Q1qAVF4cXUp5S378TiZmnPqMP3rkrKNHwb2G+v5ZyKrBbLk8piBzLN6ilO2F8hDz4EMcJ4FGNL34E1cGwP4OLAbPSR7Lxx6qk59kTapk1tqRBi3K7p9FBfVbVeez3Cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764417570; c=relaxed/simple;
	bh=U1Ssw4lZ2jfp1OsVrnw2M/14omKMBGMOxTLKnTRh4hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlfMzNFAEQnaitAUaUt2VHvpETW18y8IrnsGfaZ7FmGSxzFf027r5p83gmySJbSYb6fE79kvGz1tz2qnwCOwjqxEsxQBhbxzvi5LuurI/uZPh79DQFYxUbe8SJY7zw8rr/SIS8/fsmAGxYd/8rJireNiSwQdjj8bO+bQ+0O9qJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aHA4GqDL; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-640d43060d2so1987347d50.2
        for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764417567; x=1765022367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMuZ4MA+cOuMgeux+0oZSodeGOO8PZYtmnxDebxkm7o=;
        b=LXkF/oHVZs+pbaULo2h8Rb6SGw8L2o/qjv58L1mb0JwEoppUF3TOxjyp5b+79cNuG2
         9KaFETmRDHUAb0k5MxGyfJniMthjCl51/A38XVrS16ebCtsoa/g1ir1gCfZwwQfoxy0m
         mlHio1pnzen/kvaforhnsrdksTizVmflzeccV5uRJxEy3vQRgsMPoNDjyLguO9AfsFKD
         o3+gFtKNk4LKbGOtwlP6NWZIktF3VwD5hCUNbq4kulN/aQRJStLK0o2hMxwlU8XrN2K5
         B2zU9QoaG5peHA42j8UrxETkabYHDhl3+ge24E40wYzGBH1fy73UQJWbC+VPaKWfNHE/
         wLlw==
X-Forwarded-Encrypted: i=1; AJvYcCXeNobeVqphVyr+tlS1ivPltjbcPMQa4llj3I5ml9hgG8kvtdqz/WIkSi3q7qYkmZnvfDcVLpazsGgteH2wcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67ZLR/yJyO9psreaDxGBEgIYmSlx9emepZzp8VxYIvJVTw9pV
	w1ufYRYClc7DHOBsuFZn2xCPhsWdSx9Cze9t53C2exnBjSX+nQAOqdLZkSVsbbaolbPdn5kRjbD
	lfykyIXEIwshRfmivcHzTMXZywy3nySZNbzkyPXQ+iifWzO1TsF9kHQV9YXblLYcDakiCJ/ZDyH
	XiyZxLtYzTYe1R/9bBaerqWweFKhpcEwhq2tzs8G9ZQD6rkFZNf10rprzWjqQ1G78XAvVjE87c+
	5MzBSDS4MRhXgTw8IWqKEg6/ldE
X-Gm-Gg: ASbGncuKF6saz0qcNELrfYFgLnvxS/a2M6jZezh+BhaUwG7WL5tJI5fPvBzdEtmlA6R
	a1Y2WIfIuUe5I2w6/q0PxmZDzc+TFGtJpWwC/QZP0JOevGDiBeBAalEyBuqdlHelOXkWI+NrfAd
	iw85n4IEids7K+JU2AFCCe41DF3r9p+PvUmNNNAbPC4JXD9CCzyZBpyXPLGctq3c7oOCh2LXH6j
	Ffr7EnRTtF/p9jvVSnu5mOnBEkYM0xX1S0D9XyppkEbhgtQxB9cmg5jsUETinwByc6N0Dp2/Cos
	0jxenFBVRCwF4yj4SKoop8Sdr5MZYPmltL5X3SnSvAfj4BBL1OIIFhhpqWj7n+KupRLu9DGdUhD
	HtBJX17vqA0DTps+73CnAuQPBzp1gyB1L70yeF4W4bgKcRVp2GJUgEy7KUOIQU8iiE0uP21gHIx
	zDc07If/8a6xaw/v4zz3iAkzUIc6TDtyrPBSUYD9vVlBJ90PFt
X-Google-Smtp-Source: AGHT+IEo5m5J2TLI5sM7FpGyNCcs9o97WUbGQQAA3AQSiIvrveRBJiBxs+tLmq4T67Mr5oLbZPSn5b6roWp8
X-Received: by 2002:a05:690e:148f:b0:63f:b8d0:7e2c with SMTP id 956f58d0204a3-64302a2fe8dmr21610062d50.2.1764417567492;
        Sat, 29 Nov 2025 03:59:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6433c44c5b4sm640523d50.9.2025.11.29.03.59.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Nov 2025 03:59:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b259f0da04so483819785a.0
        for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764417566; x=1765022366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AMuZ4MA+cOuMgeux+0oZSodeGOO8PZYtmnxDebxkm7o=;
        b=aHA4GqDLuDbRsf0rMCnWzKLCYBe077oywFM5wK1SuPih8tNSX76AhYwuTbQU02Knj3
         raOmaTnROwVxr0SNVwPKSd6d42lfVBal7jLs8cXfzFCc9qkjmGAWCLYiUPqakArpsRVR
         8/o+RrUW38eWUyOzKydqnNKg7mnNLmjCcLNBM=
X-Forwarded-Encrypted: i=1; AJvYcCX1A5nMru+NQhT8vfVyrURI+KRm7iU2o/urSabD98DYZnvkJMkB+tYhIdxgVPyavLlwC4f/uJZ/IInYLk3ucw==@vger.kernel.org
X-Received: by 2002:a05:6214:c84:b0:880:80b3:e29c with SMTP id 6a1803df08f44-8847c489816mr497530956d6.14.1764417566539;
        Sat, 29 Nov 2025 03:59:26 -0800 (PST)
X-Received: by 2002:a05:6214:c84:b0:880:80b3:e29c with SMTP id 6a1803df08f44-8847c489816mr497530696d6.14.1764417566188;
        Sat, 29 Nov 2025 03:59:26 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524fd33fsm46223966d6.24.2025.11.29.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 03:59:25 -0800 (PST)
Message-ID: <73783333-658c-4d84-ac73-e9932fb22d64@broadcom.com>
Date: Sat, 29 Nov 2025 12:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: fix/add kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20251129073803.1814384-1-rdunlap@infradead.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251129073803.1814384-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/29/2025 8:38 AM, Randy Dunlap wrote:
> Correct or add kernel-doc comments for:
> - an enum name typo
> - missing struct member comments in struct vif_saved_ie and
>    struct brcmf_cfg80211_vif

Thanks, Randy

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: brcm80211@lists.linux.dev
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

