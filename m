Return-Path: <linux-wireless+bounces-6445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F48A832E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C072835A4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530743146;
	Wed, 17 Apr 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoOT4Pfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60941A89
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357099; cv=none; b=meN9I9B19JF/jB9aFETgRw5HG5itav27zqmEujWOZ4rn1Uh1fFMxBzvcNnIzTBsjK0JXayYjNF/D4Sc+NQvJxBktUTQT5gswxv2WXthJPQCD2KlV6ourfihjG4PbSNiccn+0CV7nFerh9ev5qrlw+7VBX/ks1nBhmsMuLSu5V7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357099; c=relaxed/simple;
	bh=qoIlbssh3Nb1jNtJbH4YLVk/ARMHVmd4BGP+DPNOql0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQRMQwg3TehxwkrGIspWWzh+7+som9uytu044yfWf8rsQWHw13UPobfdX91/0SZi1rfS2EipMFVDsaXMrHq4Dc4RcQ0n0llxiZ57xlYNiZh3X4S8vn3PB+mH6SfR4+MyfHF2phCDKlWMKxTKfl8zVStwmvrJDlBPfd9ecrgy82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoOT4Pfg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea156bee62so278795a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713357097; x=1713961897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6FP/2ClpXaTiUthsKID9Bzx30aESUzU+AMNyJVkfhc=;
        b=SoOT4PfgP9Sf+foA2YKeqDSE/ckkFKdC9+J4QTBpNIlvqgbueZjPQnS3TyFGTU/Qvi
         o9Aza2ieJfBWYuJOagBjHKJOC+eCncElDqDZaNcK7hMH4mIKdJnot+8t2e+dVqZbDabP
         34IbBd+PxU0sdbi2CenlExoUttv4G2CFFd51MbE86nZlFU8ZMMiDrCYnaLc2pKYOkRlW
         vITYchtwa403nQr4n+NWQWqtzT3RhaGAVmRGmp6JzQO7HRrFFu1CWKj+yfUuB5K9IMRT
         O8B5xqZPP5ni75DaxF2Al7r/ac5soXaj36iCDjsE4PIkHmsCpBK0uHP70+GVyj5Dz7wU
         St1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357097; x=1713961897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6FP/2ClpXaTiUthsKID9Bzx30aESUzU+AMNyJVkfhc=;
        b=jwIz9inaUcZHGblmAZrIJADRBp/mw09DnDcQZS/y846MwpZk3jQEEM+dj3akkGC4Kh
         2Z6Z2IyqCuCkY41457doEjgSeoKaZKUS+71+DwskOfCay1UKFzP0vCbT1MIlGzPjhE0K
         WqFb1ovIPcGbzmd5G2lkqSwhVXSmrZMuzYKSLnACPy//nUOQ+alvyBu6ohL0a3lOLsHl
         RYvt9acOs3nzZKaS8vBYZhsPWqWLPgRokxpPZrlsRCpF86UffixcswYjHpabLidiC37f
         xAlScdJ+XkdYphI1jgrQL+lCB03Ykh4ZcjoZXMTKHleGOWvlOnuxnRF4brOJVaDG+m9y
         B3fg==
X-Gm-Message-State: AOJu0YzzE9BZCDHjrAa4k9t6GGfPgV8pGyopQxkVt+iwd8UVE84qrq9t
	zno0/b8eeikV4c90IHKfmTpMNcjDD5zlMWNFtJfFFdcuBzU/LhOt
X-Google-Smtp-Source: AGHT+IE3OE+iAfPHAVKKR3nodfINMck5zYvFu2yQRB8auXscURAAFjoOp/bRcuECCxmeCJ+MEJm1kg==
X-Received: by 2002:a05:6870:d10f:b0:222:8961:43fa with SMTP id e15-20020a056870d10f00b00222896143famr1856788oac.15.1713357097285;
        Wed, 17 Apr 2024 05:31:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id de6-20020a05687075c600b002389f42604asm260223oab.30.2024.04.17.05.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 05:31:36 -0700 (PDT)
Message-ID: <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
Date: Wed, 17 Apr 2024 07:31:35 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: putting future iwlwifi firmware into intel/ ?
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
References: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 06:18, Johannes Berg wrote:
> Hi,
> 
> Since I was just looking at some firmware related thing (files for the
> hardware that might be shared between Intel BT and WiFi), I noticed that
> just over 30% of the files/dirs in the top-level firmware tree are
> iwlwifi-* files.
> 
> While we can't move the files that older drivers might consume, we could
> e.g. change the driver to look up future versions/future hardware under
> intel/ instead? Would that be worth doing?
> 
> johannes
> 

How about moving them all now and then creating compat symlinks for 
older kernels at linux-firmware 'make install' time?

