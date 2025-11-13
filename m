Return-Path: <linux-wireless+bounces-28907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD12C57C95
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466E93BF772
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C53134FF6C;
	Thu, 13 Nov 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="OejTwmmn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com [136.143.184.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B92C21D8
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039790; cv=pass; b=OHBuct4wIN3wrHPa+t7o74YnhET/XakWEwXyJg0QzWGSGVV84Lqb99Vaz3xyWL/OzrJvIkno8un7g3tAG37+ajoMwxLCwbftBcGzko+NpPhCG2+HcWlIdfUNwi3SD2V0SiVkjnWZS8YycGAO4afSALgfNVOWfBYEIODDmNq2sQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039790; c=relaxed/simple;
	bh=rQ84tW0crj4a57Fq7FDv+e7JPvtYBJviAu0u0PNBKfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taW5WRgguXBkjy1KpPqgoX2uYj5YxnkMiV7hA4XcB52I+oFMu51z5fOtPOsivHmO95sdb3O/DCuobD3ioe3hkbZrktBZnfZJHumk6ukxtt+oMa1X4JVwoy/Z/g/H/bcmtmO50bDowq8i9tuhY1cCIfw30meRFd86UmYcLDLADVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=OejTwmmn; arc=pass smtp.client-ip=136.143.184.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763039786; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RgSxGB8KaQyJv/PZepesXv5Frvj8ZMFCEATEog6QOrOfyA5aMhnnDLCuDLRGzAzW86diQKjjNZaQcDlDrm6I22V12bjT5lQf1mliSlu++iVuHNgUZ6wTZpaE+QDDrifDAfvxRtXpCuLahnQxNpmQIBhlfoxL3Vfs9S3Qa8z+P4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763039786; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dKnwmkiJfHg6LtTt1JiGGyQGjM9FAv0Igl4ZImNekoQ=; 
	b=GhIN2xYhtmb9NS29aYeYmzJR9son1TKXjt1G542FvR9ETN9H8s3u7Qsaf6N/F9nGeOwlhDpRWMx3YGs5Im9TRooVhEB00xjoTApjFjdCYCLdlKY4xZZ2p3T+ycIsODhhW5yhr023F44l+0ld9+Jc0xhVuy6tTA8GkvWq9iNgqlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763039786;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dKnwmkiJfHg6LtTt1JiGGyQGjM9FAv0Igl4ZImNekoQ=;
	b=OejTwmmnuXoJaBG+UMgHz5SrEQQCZaLeVBVsNBlvo33zEKfh+2wEGyZH5hTQX0y/
	p1TynUugB33Q6RnVNfEX8D8PiJyMhE4EavF9oyN81Y9EIifdTxq/mzQ1ry7nnSzdOjp
	6X8k4e/pTpyuhWnS/SKvmPlEgGr6hsWUJ0ppT0hs=
Received: by mx.zohomail.com with SMTPS id 17630397833331021.5277630418944;
	Thu, 13 Nov 2025 05:16:23 -0800 (PST)
Message-ID: <758ff840-c0ee-410d-b5c7-0c46bcf9ae5d@xv97.com>
Date: Thu, 13 Nov 2025 21:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] wifi: mac80211: utilize the newly defined CMAC
 constants
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251111145759.111691-1-m@xv97.com>
 <20251111145759.111691-4-m@xv97.com>
 <0704cd8f81e8cc2bde7957b8134c1bf1fdbaed29.camel@sipsolutions.net>
Content-Language: en-US
From: Chien Wong <m@xv97.com>
Autocrypt: addr=m@xv97.com; keydata=
 xjMEYrGw+RYJKwYBBAHaRw8BAQdAYXRqCQnACPka63iaZ2Lc9u8qPBNaxew6PdbvpuPvkIXN
 F0NoaWVuIFdvbmcgPG1AeHY5Ny5jb20+wpYEExYIAD4WIQRhWIfCT4U86RkflE5cpYo5+kEi
 rQUCYrGw+QIbAwUJEswDAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBcpYo5+kEirQtx
 AP4uJuD0ufTDXmEotuOUiI+86qWvc3jNsUhWYW8wHN8zEgD8Dli09jo/TsTlfWIXWjIs/6Pp
 b96j9fho6xNpETu8ZgnOOARisbD5EgorBgEEAZdVAQUBAQdArBbkcgnrIZ6XnmGUAA9XYA+i
 tf8afTv75UGa2c0YkwoDAQgHwn4EGBYIACYWIQRhWIfCT4U86RkflE5cpYo5+kEirQUCYrGw
 +QIbDAUJEswDAAAKCRBcpYo5+kEircrLAQC/yXFAHzoG9bnsw+hsiVfEbYMa04UiDEFkTd9Q
 kA+I2gD/VCzYkTizWTiXsbcGhB05Q+mI5tX+ehhtpcrIAaBxnA8=
In-Reply-To: <0704cd8f81e8cc2bde7957b8134c1bf1fdbaed29.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/12/25 9:12 PM, Johannes Berg wrote:
> On Tue, 2025-11-11 at 22:57 +0800, Chien Wong wrote:
>> Make use of the added constants to reduce duplication.
>>
>> Signed-off-by: Chien Wong <m@xv97.com>
>> ---
>>   net/mac80211/aes_cmac.c | 4 ++--
>>   net/mac80211/aes_gmac.h | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
>> index adce68ea0981..01fb8b6c5dfb 100644
>> --- a/net/mac80211/aes_cmac.c
>> +++ b/net/mac80211/aes_cmac.c
>> @@ -16,8 +16,8 @@
>>   #include "key.h"
>>   #include "aes_cmac.h"
>>   
>> -#define CMAC_TLEN 8 /* CMAC TLen = 64 bits (8 octets) */
>> -#define CMAC_TLEN_256 16 /* CMAC TLen = 128 bits (16 octets) */
>> +#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
>> +#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN
>>   #define AAD_LEN 20
>>   
>>   static const u8 zero[CMAC_TLEN_256];
>> diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
>> index c739356bae2a..09378e52c7a6 100644
>> --- a/net/mac80211/aes_gmac.h
>> +++ b/net/mac80211/aes_gmac.h
>> @@ -9,7 +9,7 @@
>>   #include <linux/crypto.h>
>>   
>>   #define GMAC_AAD_LEN	20
>> -#define GMAC_MIC_LEN	16
>> +#define GMAC_MIC_LEN	IEEE80211_GMAC_MIC_LEN
> 
> Might really be better to just switch the code to the new ones?
> 
> johannes
They will be replaced by direct usage in code.

