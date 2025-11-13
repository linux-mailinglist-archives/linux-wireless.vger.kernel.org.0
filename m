Return-Path: <linux-wireless+bounces-28908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11DC57B63
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2874050297F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BA351FAB;
	Thu, 13 Nov 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="ss46DMXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2C35292D
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040299; cv=pass; b=ewHkRPDpHv2XrqDrc4FX2GQiDKQ/Q5mngIwlvunzCiTyQQyIx4E5yJs//AiDMM+9PHVG5DPkJy39KX0q31CWIGJcXWY1PbmPFIBYPfIUZmUahhntxNVdmQPJzgJm+knDohMR+LbCCbkg1aANED6S0iM10fwwoVLx6pfmqBHYm54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040299; c=relaxed/simple;
	bh=EvrqCJQHjMxlDRyPcPYA2oTjV2oHrqkMYRgHuJyjRFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXrq8FgLfxLimn1UE3AGi5jXUq8FP+HC7eKtLeRbNQAkXFapVbaLG3etGDRMjRwvULLhYyonQcFap4xZmI9jjCZz3ff1fiflWdNzpvOy8gkazBGWqLRzVZnUXASeEVIFFl2KE8VWvhOLLk75b0rw14W3iWXEi6nhoKhv3DRpEPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=ss46DMXu; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763040294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D15IQ54CkUIdPt0tk+fD2TgCKn+afWassOUsRgEBIvCoUJL0Tcuibcy6r/QXP5uuuGhj5yqudt3N7aNaNpONGUT2ySufC7XUNaJK2ZPS4MXi5EY/VSixsIvYNuI5UFN457b/dKBrPmK/n1UJTxKYQ6L2DXLINqEFgy7Rw/b1NLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763040294; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0p/D9Hv/2SWUXk4NIfbgaFp2HkMJRzDnEE+qfeDAbzc=; 
	b=WCPAiSATHopYyWvXxVoAENy1VhpTEe/gfcuDF5YjzH3w211Tb/utEWxhj7/XRGFUSX0He1SWeKVTmF99nSXnPIX3rUuV1aqi1ASWIwVFs4YbV3E36HGriq4JRfnCsnJI8NC3gAVgw7cho4tF3yVfm+hiMwHvUS6z3Sd79AHPkGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763040294;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0p/D9Hv/2SWUXk4NIfbgaFp2HkMJRzDnEE+qfeDAbzc=;
	b=ss46DMXunMr6vnK5VdAQZRrP2b7Y/n9Sy7kLutap0uKHd0gFa8SlNd8i9viRkVsR
	KT/Kem1PzcoGaXeuFvWTwq7/Q+6B8um4aPm1CvE3DVLTYitDDL+aX5dY6dU2PdLCIRw
	Z2PmrnKcM012zr+zrfQQDBr0kgTv0prV+LpNNG1Q=
Received: by mx.zohomail.com with SMTPS id 1763040292842845.715490259449;
	Thu, 13 Nov 2025 05:24:52 -0800 (PST)
Message-ID: <42040151-af35-4483-aa0e-425af22600e6@xv97.com>
Date: Thu, 13 Nov 2025 21:24:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] wifi: mac80211: refactor CMAC crypt functions
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251111145759.111691-1-m@xv97.com>
 <20251111145759.111691-5-m@xv97.com>
 <080a729f1b10f767aa1b407f454667b83f5ee917.camel@sipsolutions.net>
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
In-Reply-To: <080a729f1b10f767aa1b407f454667b83f5ee917.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/12/25 9:19 PM, Johannes Berg wrote:
> On Tue, 2025-11-11 at 22:57 +0800, Chien Wong wrote:
>> ieee80211_aes_cmac() and ieee80211_aes_cmac_256() are almost the same.
>> Merge them. This removes duplication.
>>
>> It should be noted that the refactored ieee80211_aes_cmac() permits
>> 8 bytes output for CMAC-256 and 16 bytes output for CMAC-128. In such
>> cases, it would generate result correctly as expected.
> 
> I think you got that the wrong way around? Or I don't understand it.

I mean that the functions do allow caller using in uncommon ways and the 
behavior is not changed after refactor. Anyway, this is obvious from the 
code. I'd remove the words.>> All references to the refactored functions 
in the tree are adapted.
> 
> Not sure what that means? You also had that comment in another place? Do
> you literally mean "I had to change the callers"? That seems obvious?

Yes, I mean I have changed the callers. This is obvious and the words 
should be removed.
>>   int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>> -		       const u8 *data, size_t data_len, u8 *mic)
>> +		       const u8 *data, size_t data_len, u8 *mic, unsigned int mic_len)
> 
> could trivially keep that in 80 cols, and that would even look better :)
> 
Sure.>>   {
>>   	int err;
>>   	SHASH_DESC_ON_STACK(desc, tfm);
>> -	u8 out[AES_BLOCK_SIZE];
>>   	const __le16 *fc;
>>   
>> +	if (mic_len != IEEE80211_CMAC_128_MIC_LEN &&
>> +	    mic_len != IEEE80211_CMAC_256_MIC_LEN)
>> +		return -EINVAL;
> 
> I guess it's a bit annoying that we need this, but OTOH this is not the
> optimal path (it's SW crypto...) so I guess doesn't matter.
> 

I feel the same. Validating parameters is unnecessary here.

>> +	if (mic_len == IEEE80211_CMAC_128_MIC_LEN) {
>> +		u8 out[AES_BLOCK_SIZE];
>>
>> +		err = crypto_shash_finup(desc, zero, mic_len, out);
>>   		if (err)
>>   			goto out;
>> +		memcpy(mic, out, mic_len);
>>   	} else {
>>
>> +		err = crypto_shash_finup(desc, zero, mic_len, mic);
>>   	}
> 
> Arguably, since it's a SW fixup path, you could also just always copy,
> using the mic_len == IEEE80211_CMAC_128_MIC_LEN path (since it copies
> mic_len).

OK. The little optimization here is unnecessary.


