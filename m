Return-Path: <linux-wireless+bounces-7955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0958CC008
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A487B222DF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663B824BD;
	Wed, 22 May 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXyHFI9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A7824B9;
	Wed, 22 May 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376344; cv=none; b=GEUQfklG2FCdOxrGb505wKVuu9b1wqpohrB/RNZlj3p9w7r/5yCzDgUxn7K+l0YodTMQwRx5yP9n/buMPbZopueMVGkYq+dcey+58kqL47aVxxmaUuZYTQII5y6ssyOhnGn/3fqfRyRRQ2IPb3lKysf+QkrqSRCNmXLSLdVPHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376344; c=relaxed/simple;
	bh=jOYS4lVDbDHFzQ8blB+xqnfwPF6cxxVRwf4UBMki9bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDS5FUb43yd/V3rw+43lF4+PvbPmYvDa2xVd23T19SQIjM5Fwa6Um8y6ZKsNXC4ddGLP7/ycPOe6wW+0g8Vt8utWnlPu5qIPwgXk2vW8irFtJ7Vp8EPAa6fApjwxJ8HoHMLJsFYSOoknkZVzAJfKwn1p1zKCJVUNoPmCqCbEZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXyHFI9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0906DC2BD11;
	Wed, 22 May 2024 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716376343;
	bh=jOYS4lVDbDHFzQ8blB+xqnfwPF6cxxVRwf4UBMki9bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXyHFI9pYfV+yrAxb+1bo/EayQE/+Gqj7N9c+Ty1nc+qpiSZL6Y0X8h4O3GoZYbIU
	 rkA0RFhotbuxReezV9Nip2+8hhBkGDh0MHYYYvxdabch9PAURYIS3LkOV5EREqsb14
	 H4wEFc1P4u37C9dc2rfdDj4MpvmN4rkt1BHDYLJLqgiLvbtc93yqvTsYTe0jY+ShQ1
	 Skz5P7B8y22HSlSN21t/Ys+eWw/AfdIsp+PhyR3jIfZrliELoykjEglHYlH7gt1cE/
	 BbnHITRufDb1j+OFvMl9gAE0F4D8EPWhdFjcRn1ibVWkVsXwaPhZjXf2MqbZ1kiqj8
	 Dt6+jc9yrSRzA==
Message-ID: <f6ee888b-f4de-4b72-8224-aca4236ab220@kernel.org>
Date: Wed, 22 May 2024 13:12:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] Add boot.c, boot.h
To: Breno Leitao <leitao@debian.org>, michael.nemanov@ti.com
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-8-michael.nemanov@ti.com> <Zk2ywFQQ2SuXvPiE@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zk2ywFQQ2SuXvPiE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/05/2024 10:54, Breno Leitao wrote:
> Hello Michael,
> 
> On Tue, May 21, 2024 at 08:18:31PM +0300, michael.nemanov@ti.com wrote:
>> From: Michael Nemanov <Michael.Nemanov@ti.com>
> 
>> +static u8 *fetch_container(struct cc33xx *cc, const char *container_name,
>> +			   size_t *container_len)
>> +{
>> +	u8 *container_data = NULL;
>> +	const struct firmware *container;
>> +	int ret;
>> +
>> +	ret = request_firmware(&container, container_name, cc->dev);
>> +
>> +	if (ret < 0) {
>> +		cc33xx_error("could not get container %s: (%d)",
>> +			     container_name, ret);
>> +		return NULL;
>> +	}
>> +
>> +	if (container->size % 4) {
>> +		cc33xx_error("container size is not word-aligned: %zu",
>> +			     container->size);
>> +		goto out;
>> +	}
>> +
>> +	*container_len = container->size;
>> +	container_data = vmalloc(container->size);
> 
> 
> I got the following error when compiling it:
> 
> 
> 	drivers/net/wireless/ti/cc33xx/boot.c: In function ‘fetch_container’:
> 	drivers/net/wireless/ti/cc33xx/boot.c:76:26: error: implicit declaration of function ‘vmalloc’; did you mean ‘kmalloc’? [-Werror=implicit-function-declaration]
> 	   76 |         container_data = vmalloc(container->size);
> 	      |                          ^~~~~~~

So neither this nor previous version was ever built...

Best regards,
Krzysztof


