Return-Path: <linux-wireless+bounces-28788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AADC47158
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF68A4EC48C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DE3112DD;
	Mon, 10 Nov 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="J9nrvYe0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08A1E25F9
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783435; cv=pass; b=TbZJLcCQGK+RbdeWux+nytD/+L4Gt7512h2nL7EDXWvJaElTwUfcHAyc+XTiquBukcYcKPZlvR5iK+zVa29JprFdtvDolrSRVfG00JxGzwM1TU722yKL8rGxj0wNfeNPE4AHJrYrhUhkfqkxTySrxnwrlPtp2FVaMFaK2FPgv7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783435; c=relaxed/simple;
	bh=5looI5DLrEmh+caIS8diooUnqBa0f4vXlcLufQ5C6FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6gwW4G/23PAReavgAhrSkM+lxK749iBxjRVeNjOvuJPRWC6qnADGoYdjEGUSBNEIIOfz7BOATOsjZQr8F1KrbySPY6n/m55CR+b4lB5BVJueM5YOS9o5gD8FHTIP3ly/KkLTJ6ZYYkRFaCDJSKwoyGrD7WQ+Ad8cQJdY7+5R/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=J9nrvYe0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762783432; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NQYGP4XoSRqVaMA8IK0m4fGUhfAAdbNSFYR+b6vwPWN3pVU/DU021PVfgbuYyzVsZlMDklhKLyv3J9sTA6pdpC74Iuc6TOwtlST0mwWJom+lR1ILT+c81e+af49v5PzDAMRBj+2xyOOYVYs4sl8JCPHdwxbbqvgL4n0xcUJ/NNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762783432; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e4ZTzEnKFLEgmPhkgYxA7bkm0TA8sNGsBZTsAl+4Ips=; 
	b=TF99Oi25ow4H55lLNz2xGcS6XLJsd5eK+RHEbJ1D5IhoMOza3j+3LVieug67ChbcPT/NbLSquDaS7cy9aS5Gv3GSRhmX31ett20D5dulO4zseo1ULqxU0zouN8UwGaJeVGWCu55Exf6wMigLOqpQhNXvMEIcNmxIsLrn5W4QQNk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762783432;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e4ZTzEnKFLEgmPhkgYxA7bkm0TA8sNGsBZTsAl+4Ips=;
	b=J9nrvYe0xL3G37rn0MdfhmCbg5opTj/7Bzhuo8i0PMru7tKNQCRCChOMbIHBSo00
	fXBAACKicXQBh9aESacGjb82wSXgP5k4W4bssYOjdFHhCk4CsVihQlBaYtV2hOmQFbp
	VDZzkFf69HxMsSzMBlp7UVxQVSSeNJR7Py6dMvhA=
Received: by mx.zohomail.com with SMTPS id 1762783428800579.7110672049679;
	Mon, 10 Nov 2025 06:03:48 -0800 (PST)
Message-ID: <fce44b79-0dcd-4e49-b722-1316ecdc6a55@xv97.com>
Date: Mon, 10 Nov 2025 22:03:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: mac80211: refactor CMAC packet handlers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251109140450.118106-1-m@xv97.com>
 <20251109140450.118106-7-m@xv97.com>
 <f67d8a5ffd57acecda1f2d3bcf53c35135415ef0.camel@sipsolutions.net>
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
In-Reply-To: <f67d8a5ffd57acecda1f2d3bcf53c35135415ef0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 3:43 PM, Johannes Berg wrote:
> On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
>> Merge CMAC-128 and CMAC-256 handlers since they are almost the same.
>> This removes duplication.
>> All references to the refactored functions in the tree are adapted.
>>
>> The comment 'MIC = AES-128-CMAC(IGTK, AAD ...' is out-dated since CMAC
>> is also used with BIGTK, as is the comment for CMAC-256. Simply remove
>> the comments.
>>
>> Tested-on: mac80211_hwsim
> 
> 
> Oh, I see this now - but your changes affect both RX and TX so you
> should cross-check against another implementation (such as wlantest) I'd
> think. Also, that's a non-standard Qualcomm/ath driver thing :)
> 

So far so good.

When testing Beacon Protection with hwsim, the STA's BIGTK rx_spec count 
increases as expected, while icverrors remain at 0.
I have a patched Wireshark capable of verifying MMIE MIC. The captured
Beacon and protected broadcast Deauth frame all verifies good.

