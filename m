Return-Path: <linux-wireless+bounces-28845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A38C4E6E8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4EF189E3EF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9C30EF86;
	Tue, 11 Nov 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="NG/5p8Rw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D03009F8
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870747; cv=pass; b=GltHvHNMifRINppseaF8SbxiYdxeMZPfulnT0vqy1nf6R9OqBmZKBYZU7VW6kU3l2TuLoGS9B8rHEKAZcwI41iYYGUQCI24euNEKC/L6VXF2bHQ+hwuwuzk6lgkjAh9ZRblM65wxeYTgirGfveNT4ziBh7nWmF4a+66sCjJfeRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870747; c=relaxed/simple;
	bh=L9SXIgay21CGGcOlJyhwIR8ZD5z3q7yf1he7WasNMZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmfzLGEMQauHDJfhSoe0DWLXb4chTbXxmCII0+jKafWwAhqDBZxKJrwn6TgHGQDAZhxvPv38XvtP5FpOOjRMenYQ1aha69qscaW9peYmyF2egyiojuXTacSsHDAeOdEwNCRzrpu6opdE7mCFdrcacKD1Y/Eu+nXe5+nco41eujw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=NG/5p8Rw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762870742; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EQpdlHMNzAd8HW0tbk1VsgfJmcK6eOE/X+L21/pTPk7B85QncmKhJtGtGXS7Fr4/4U1dpL0Xq9iuM37jN+WJSujeqzlWikD4wb06A9c/AkgOgGr/6puGWynuhsCb+4wTrZVQwNLFIdpZVTtO5RYEQ2EA3qZ5SKTBEnmP572LcJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762870742; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dJtJcghwTTM7TXsLg2uN7pGzDohKh+sZC/fi22NJTOk=; 
	b=WhXZ9FFNqDqcY2ecKa22WUoIBYGlTnItCrxlNWUyz3CEd+wzPdTKhs1QvSEzWxSsAlYmIWvzvJr9p6YVAfWyF3+n0F25Kzq36bRyicvoYhs62KrWihba/aCbWKVHkbpl3DATG76K03l9cRb3s+3gYO4G8NT3qvFK7PbmTDog6U0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762870742;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dJtJcghwTTM7TXsLg2uN7pGzDohKh+sZC/fi22NJTOk=;
	b=NG/5p8RwUdZYFttSiJ3AhHTxHXC4wBHA1T2LdlZ0yXKZkligQAGIE5GrB6iKb2iH
	ewTqNYo7rx1Hdj2LfTwZF+eEJPYevIt4zO/2Xv5eJwT9tDwig3f8Av18F2aeE4I/FBS
	rcyRQ1v85/vZzr4YE+tKBanaqnmZkue01NelkGRc=
Received: by mx.zohomail.com with SMTPS id 1762870740394993.4916197544973;
	Tue, 11 Nov 2025 06:19:00 -0800 (PST)
Message-ID: <c62262bd-8c41-43a6-9f01-dfb73f4b0a24@xv97.com>
Date: Tue, 11 Nov 2025 22:18:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] wifi: mac80211: remove an unnecessary copy
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251110144545.15149-1-m@xv97.com>
 <20251110144545.15149-2-m@xv97.com>
 <ca0cce1b2d4d3d5c920d4d9d300ab175c6691ab6.camel@sipsolutions.net>
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
In-Reply-To: <ca0cce1b2d4d3d5c920d4d9d300ab175c6691ab6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/11/25 6:09 PM, Johannes Berg wrote:
> On Mon, 2025-11-10 at 22:45 +0800, Chien Wong wrote:
>> Using a temporary buffer for saving the CMAC result is useless.
>> With the patch, ieee80211_aes_cmac() just resembles
>> ieee80211_aes_cmac_256().
> 
> I guess I could've looked more closely at v1 ...
> 
>> +++ b/net/mac80211/aes_cmac.c
>> @@ -26,7 +26,6 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>>   			const u8 *data, size_t data_len, u8 *mic)
>>   {
>>   	SHASH_DESC_ON_STACK(desc, tfm);
>> -	u8 out[AES_BLOCK_SIZE];
>>   	const __le16 *fc;
>>   
>>   	desc->tfm = tfm;
>> @@ -41,9 +40,7 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>>   	} else {
>>   		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
>>   	}
>> -	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
>> -
>> -	memcpy(mic, out, CMAC_TLEN);
>> +	crypto_shash_finup(desc, zero, CMAC_TLEN, mic);
> 
> This seems very wrong, it writes 16 bytes when 'mic' will only have
> space for CMAC_TLEN==8. AFAICT, the CMAC_TLEN in the function call is
> the input length (of 'zero'), not the output length.
> 

Sorry, that's completely wrong. Thanks for pointing out the issue—I'll 
fix it in v3.

