Return-Path: <linux-wireless+bounces-4704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9C87B464
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7681F23755
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194C4C602;
	Wed, 13 Mar 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npSbBQaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8254691
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369292; cv=none; b=YGeJQ42Y0/6t8QXFUo7nc+VLEAJG6HEEz8PeEQmd24j6WWncSZayZ4xDx72cwjq150D6ItrlYhdmFnpcdgrkNAq36Y7iYdvI/apAas+uMBNV6jUr2XVSGb8nyfoqQ+jl1OrhtQ/O5moAyJFch58NKKz4Vzq1fQvfumKK7GmC8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369292; c=relaxed/simple;
	bh=e/cc35nw8Z4eW+VhYr3NXHW018qxJb3AgS3T4JMAYIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9rD7xXQKVqvwXrrSf0bhbOxqzFHwbRG6gQ0hVKtUs6qlWdeejkftc2+XSUqNlpkK/Vq7GirLC8A9FIts16Gzk68jX5UE7hegrIzeBBvSwCbuIFmD9jAdsmNsBg5BHN6CB8UEAI/wEIGoNAdirzyF39JjEq5OoBmxhj4HE17/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npSbBQaU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413e93b10bfso2442045e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369289; x=1710974089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Px9dtxft1nvcMxcOPjIgdhacHfUErsgECW7G80gB22o=;
        b=npSbBQaUSQTmPH4ImlbWxCGFhI7X+wouCVc7k3OVD4vJKo6jC7BLrLw6rfPMayb5hz
         0+HZRoQ2qHrcMDgpcLcDfFDzyXQHEshLkLP+YrpL486ID854qvqD+h4NZ3JF5mTXML5b
         VSQJEWoOuzCB6ZtoNtw1S3LY41D3UmU8u+EUNcnDy8zk/XxL2UhjOmQmHTONTQCFTIpo
         Aiq5rgNbq/4v7+vSwO0uKttvm1SkUrP2pQJQyaBr9DxYqr6B+7zUEuA/0Vv4KDRV4ILo
         nd7dwpAqft3QHTxUQbv4ge0VXjsnpYaoPI7NglKhrG5R8mKNrE3TF2wc2rX2C3UoSlyy
         v6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369289; x=1710974089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px9dtxft1nvcMxcOPjIgdhacHfUErsgECW7G80gB22o=;
        b=RYs6aMaKuuEVICQEMjyIrLIkbCppyaL5qIzxKVSSeNtk+JaynYXRfwn0LwSB2+QyXt
         Dait0VJASWtPt8CbJxUmdCKzTHMf8IFMm0jx80Y8a7gqwT3aMzHApygPORJ5x5+zIMqM
         nSPDjHmg66T7kO25aFhfuesh2vj60587mdU/Y5qDMPnH6DSy9S6XgKMS00KvEyK/LqfL
         9HiGtAUqmNDZGLghZqIoRw2CxB07rFFLWrgttv7NYFK6yjpiABdh+m4GsYNi/ywVWdXA
         yiCs+a1iN+m48lyxuM9F6RwLYnFPNUiGNuajpfg07VIMPfQV5R2Vq1/4fj82HaUQwlX6
         ToiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL4JTpE43vwrQs7N+ypTOCT2RT72GdB7miMFGBiWenF/yTswBYLr0w+mis08D+8PGqPkjW9wTrm/jnU7GfD+3SRcTD5tbnUt+mbRLIB28=
X-Gm-Message-State: AOJu0Yx+VISruNnmmtvYDvi5R3lvNWw475o82oaemRWS7tap3//WTqkC
	AInyDbELw91vHFEYS5KdxlYOYdu8wZwgr1JdeFVGVtkatPJQYtKQ0iZkVvi8
X-Google-Smtp-Source: AGHT+IEr3P7XM2Dlst3HYhmGWzxtRKG3ufqBhsggYSMaeeO9aDsHnx4tZqyOq2Ety60T8qttlIGS1Q==
X-Received: by 2002:a05:600c:35c3:b0:410:78fb:bed2 with SMTP id r3-20020a05600c35c300b0041078fbbed2mr93071wmq.19.1710369288641;
        Wed, 13 Mar 2024 15:34:48 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b00412ee7d65a6sm417042wmb.6.2024.03.13.15.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:34:48 -0700 (PDT)
Message-ID: <f50424f4-c478-4d1e-898f-b2f9fc2bf14d@gmail.com>
Date: Thu, 14 Mar 2024 00:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
 <43c344357f564170872501e34490c851@realtek.com>
 <a9a93e7bd7e94870be0f38dd6792ab29@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <a9a93e7bd7e94870be0f38dd6792ab29@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 04:00, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Ping-Ke Shih <pkshih@realtek.com>
>> Sent: Wednesday, March 13, 2024 9:55 AM
>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>; linux-wireless@vger.kernel.org
>> Cc: Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
>>
>>> Tested only with rtl8192du, which will use the same TX power code.
> 
> Because another patchset adding rtl8192du is based on this patch, I suggest
> to send them as single one patchset. 
> 
> Ping-Ke
> 

I can do that, but Kalle will probably apply this patch long
before v2 of that patchset is ready.

