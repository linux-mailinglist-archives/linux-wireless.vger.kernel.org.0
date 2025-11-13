Return-Path: <linux-wireless+bounces-28906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675AC57AB5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC823BF702
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A71351FBA;
	Thu, 13 Nov 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="VtcPZZCJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0993502B0
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039717; cv=pass; b=r3dlaTqrGO/HhrQQAcNlELh8UlHaud0LqU2rpmCTiUGUB3r6fqRCq2RBtJaj4gt7laWpPk3lTcfllDkcpBuP+ODotX1qMJRpaAO5befDc4v91baeak47tgN1NyHjmwauSDspoW8FuAKwvm0rdHM700TiydWynlFJGZruKGfb6Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039717; c=relaxed/simple;
	bh=5/uFnpE6MqfEIVfu9vUcAnaaGB5MTWm6uVw0plBVr94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDAyEXhsecOElCJmQ9faPixZmGab1z8zUdMKO4M36hBE/vU/TI0x0uo8eDqwXQev6p42AE+OGqf6R4CPb4HKqCh49xUtctG9kzG19LjBhdarDM9HK3ODd7HemzEFMTPOkqQ6B8Rx6plcJyUfsdDj5oLJHPVl49cPmN/ls3g2gFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=VtcPZZCJ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763039712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JwJkytp+rPelCHAjns5rKm8cmwkrG8vCKsL1GCgsej3T4bRRiwL00L1QBnRWMF143WCnrZfaRGlqWh6NG5v5R4zxc9pkfFUN+YmPjomN/BzBxT6pJm4s2FbVvYV5Y82USz6a4xE/q/WR+7MAyGP/x69ilnevtxOeGIzWB2Wq/OE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763039712; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VObLLea6le576NNVSTWxIXZ8D1CpDaBYQu3x8XkWVRk=; 
	b=dujp2KeSDO8TQ5PwQMw8T8/7+5nkoQuJm0JfMSc8wpWcUDSZ97C3WSf2O9b4Y7JUXrKNp5GVa2EaeS574W9HHTdkNUsSbhccWMg1BR7dbichorjAuFkTsJZM+1QIe8cWcB6UA5668aJ7B4aO+RF4OxnpIzC/UsmfdAdsj1MNZdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763039712;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VObLLea6le576NNVSTWxIXZ8D1CpDaBYQu3x8XkWVRk=;
	b=VtcPZZCJy+0EX6CcWzArT8QboDtEWDaSaKN1otUsY4nzfL3yb672RD1FNwh5xkft
	AxKgDPTFMxEphoZ8WzyycxKshkLuecHsuUGfJDXnKg6Nzonhi7gpBps5jydNvrtNjLg
	sKNVELbX+1gtqi3V9Hw3RxLb+H+YaqCXxD7zsm/E=
Received: by mx.zohomail.com with SMTPS id 1763039710584713.3216487969229;
	Thu, 13 Nov 2025 05:15:10 -0800 (PST)
Message-ID: <48c01418-12b7-416e-aa48-ca0cc567bbd1@xv97.com>
Date: Thu, 13 Nov 2025 21:15:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] wifi: mac80211: fix CMAC functions not handling
 errors
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251111145759.111691-1-m@xv97.com>
 <20251111145759.111691-2-m@xv97.com>
 <8fc455467e9f510e70816df1e676e297defd49b7.camel@sipsolutions.net>
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
In-Reply-To: <8fc455467e9f510e70816df1e676e297defd49b7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/12/25 9:11 PM, Johannes Berg wrote:
> On Tue, 2025-11-11 at 22:57 +0800, Chien Wong wrote:
>>
>> -void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>> -			const u8 *data, size_t data_len, u8 *mic)
>> +int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>> +		       const u8 *data, size_t data_len, u8 *mic)
>>   {
>> +	int err;
>>   	SHASH_DESC_ON_STACK(desc, tfm);
>>   	u8 out[AES_BLOCK_SIZE];
>>   	const __le16 *fc;
>>   
>>   	desc->tfm = tfm;
>>   
>> -	crypto_shash_init(desc);
>> -	crypto_shash_update(desc, aad, AAD_LEN);
>> +	err = crypto_shash_init(desc);
>> +	if (err)
>> +		goto out;
>> +	err = crypto_shash_update(desc, aad, AAD_LEN);
>> +	if (err)
>> +		goto out;
> 
> 
> Not sure all the 'goto', without
> 
>> +out:
>> +	return err;
> 
> anything other than a return is really better than just returning early?
> It's not like this code will change soon again and need more error
> handling ;-)
> 
> johannes

OK. They will be change into simply returning.

