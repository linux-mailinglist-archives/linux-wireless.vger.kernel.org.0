Return-Path: <linux-wireless+bounces-28787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0BC46FC0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153CD1884C69
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0E24887E;
	Mon, 10 Nov 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="ZFs7jJbP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65326F297
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782133; cv=pass; b=Hd2tjuBjKhmvTLwfkbpedixySchEIZAv9s0wOccbL4MbOUC7NHa3mN5AieBnfX3IadtMd6reJgE2X585OoOjImoX/Q9BW0fVs4Gvu46edxPMOLTMdezB/PJ/hOOBS8TKNKAOHwIPahrOoBGgP94d8sJOfz9DTgYebwely59zyz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782133; c=relaxed/simple;
	bh=2WTpY85EFaEr6a1j+v52Z3oYfP4KXlz7XwQN5d+0TDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fENzO61EUdqBv6QnRqzfp9Z5axMYhmUTx7fSVawT68KgNfEr4cghklndN+ReJJrk9gkwc+8dGI+cMHiAyOkawXw6LljV88UJFFF59y8zrsxvBman6GAniL/XLYBMNbXJ1SQoIqhsPCGX+z/VPIjk/EvwX3jh7TsWJQepNgWPEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=ZFs7jJbP; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762782129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ITzkwsEhNeLdivMULU68Wxy5fpwxG9ia77fVWXmfjizGmVi6PXR6dFpFVj0mUy3boVRocHkwVhzFthBc4gqOl4kWilP8h+qwhyjgnqXwalbHbLgdG0C8nWJJpJiFu/SgbbEPX321V8xfp0CP9MAaPqG8qrOvYz+igcDWK1QY3hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762782129; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0FetTw4ElXagapk8UndX0Yhq4NIKbjuGVsx2yne25QQ=; 
	b=Q+7EmsO6+sY8Z+60kb+Fy8pPmVGVpPA/45nGVyl89Hi8kMt/TniEzvtwtTFgu6l1gCQXBDi2f51XyYO/eHYr3sfJIMYEghkQyGm1LRM4CMsjF6y0nWabvUY07QqkFaa6etydQweftCV4xVqG7rSHmjVKZnkgXed6E/zt3iaKu0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762782129;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0FetTw4ElXagapk8UndX0Yhq4NIKbjuGVsx2yne25QQ=;
	b=ZFs7jJbPCKr+qvHshQn7uxv6Ztj78pm/iIojxLZfHhsVJvPYHPA+umxQlZgk4i82
	VazRifizn61scDCSvhiwTbPdbErqLUG4jFm36gXKqBzltYocDqdzO4pn/xu6eDTXDC2
	tIELMsVnhS0W88ozFVTqZ6su5jHZMh7QOMUtvxso=
Received: by mx.zohomail.com with SMTPS id 1762782126026128.72526927529486;
	Mon, 10 Nov 2025 05:42:06 -0800 (PST)
Message-ID: <8156f2cf-a39a-43d1-94ef-48a315b65364@xv97.com>
Date: Mon, 10 Nov 2025 21:42:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: mac80211: remove an unnecessary copy
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251109140450.118106-1-m@xv97.com>
 <20251109140450.118106-2-m@xv97.com>
 <e340d3d08e945df144110b9da2f272cab8a2c40b.camel@sipsolutions.net>
 <0ed7eb21-a261-45b5-b3d2-9b9bb63d688d@xv97.com>
 <6a84990ab74953fff19daed71db79988f56a6fe5.camel@sipsolutions.net>
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
In-Reply-To: <6a84990ab74953fff19daed71db79988f56a6fe5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 9:35 PM, Johannes Berg wrote:
> On Mon, 2025-11-10 at 21:33 +0800, Chien Wong wrote:
>> On 11/10/25 3:34 PM, Johannes Berg wrote:
>>> On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
>>>>
>>>> Compile test only.
>>>
>>> You can trivially do better than that, say with hwsim + wlantest.
>>
>> OK. I will test with hwsim and update commit message in v2.
> 
> Or just remove that and add it in the cover letter, but anyway it seems
> you _did_ even test it (to some extent) since you can't test just patch
> 6/6 by itself? :)
> 

OK. I will remove them.



