Return-Path: <linux-wireless+bounces-29635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24ACB37A2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E88311C428
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64622868A6;
	Wed, 10 Dec 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYBbOJXi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA5286410
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384114; cv=none; b=k6dr8wCV5JOix6UMsfs219QdpnEWwqEbqYCUheMoDW7hHl+OwNPypT33CajpYs53jmwZ+mMWL+7tBH4PPBkrMuXC5+QkHt8m/V9qb6kx48S1EYbil5raVFoksOoouKonzBZO/cjoMC/cnkn8SUokZxjUUmct2WnnpPg05fCbvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384114; c=relaxed/simple;
	bh=xrzohiES+lVi8a/LFaAGoO0Gc8lha/ynDoqHhoY8hUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAr1LYP6U6ildsyRNzAFYFH9a3io2kUCV4gC/WhB3f2H16D9SrnKfFCx17SK8k0FXVLjQ0tlt2zX7BDWHrK5PZd4px+FiXOSWfCDg06UhLwhu3ui8+Urfr3x+aVAlfznfbNrcCa1hxTSQN7sZRXPES+s5XIugjiPnG7i2DcKyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYBbOJXi; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c75dd36b1bso34488a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765384112; x=1765988912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJZYQknDSHLvDKguXhtEKNArlWtBipldxLRZyU8kGAA=;
        b=dYBbOJXioCp+LSq5G0NH4ZmCnAD47d0Bija8xq63nFEJZSu0hVMmPktzahwDz5XUE8
         7MEXPzYT+YJdjsfhI+XZNH1D+0CxgNIit2QgoU43+0GNzxdH22sckfWW3/zD5MbayUnp
         d71n+rYcDHoqSZ5smi9LG9eIcpOLa24x2cKc9zt728Y/LJ9DOdl5/RUGb7jhYDQUtndg
         gjZTVFj8c4mYWx0yQyWao93rXVIiQ6powPIzArLwguO9/ghhQRKK5nEsWHbA23WgZhq8
         O15mGYimOXP974XjGbL6KFTXaQDuJI4nCAeuirCdz+WkOOHWgpl4HDMGPeWbJqKuyGYm
         Utbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765384112; x=1765988912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJZYQknDSHLvDKguXhtEKNArlWtBipldxLRZyU8kGAA=;
        b=TGcvsq4ztun3KBcHq8ailyKsGzDL/sm8d2h7F5wnXXuZcqvicrHcT2FV/ETy1yERDJ
         pO6VB5AQHkXz8+LUbMF6gHvLkEvZDoqKFnabciZylXGcYTIXBUBbepP+jt2vXdUKia3p
         2q9FZj39ENRsldJxWjY6allpGUxa/srTzOhK/7KsNVN+2QWV7bjYGZjI8Ic20zy+1MpD
         XYfHH/Y+Iee1yXUx7Tj3wrh1w2mkcjxxgOl5rUPASLwb8R6/WP2giIlcMhXmiVXzyQXp
         KsmgJSg6twSZhQzdTlx5RBhyLicJ39LR7SdgkaXMAQlMcK4LTxB9OxDhEA/rIYswVmkS
         VBOQ==
X-Gm-Message-State: AOJu0YxLa/iN1kLpq5MyZP8j5DGuyaEnntTWp8v5Z343UfEkQ9iq4FvW
	ev8jkTpOhrY9mEO3joWb6u0eDEIo/DVVHi/s5hsnD6/IRqcQv/ebF/gr5g90YQ==
X-Gm-Gg: ASbGnctkA5gyFyCbPYRME7Lv+1TF8X+xEHt/cyzJXTvW7268UwXQEI6BDZ2OKlo/RI6
	Zn1PIBEqQ40dORHX776DKvoWfFB3AHjtr2jKapLnhS4m3+tmadJ52MM7dR16dCxHUbeqt7XmkGs
	USzqX4TSSb3cM6qnCGDz92R2Gb8WTKw5wgolblyGmgFJ3sljIMnL6DZ0k1hVDuyWtxJmMztqhdh
	fIel/zSQRLLel9exOHZ4UoWmPz/kEd3RSuy08JAsrA9zzWg5wNZa2F/aAMJDOyFstSDW+lrEVJS
	DdbY54dJUh6xKx2ju7hH2UcjHmH6PwjRDUbuPrgoYAH3yUOcQMiKJTc/7zbwaw7Vx9Nz9AaOsDt
	LSwz318/s0zxW9+uIs1qiAW0e835cv3XyOs6SBZMSdKrCFXZo65a5muqnPqi2DZF0EtBFUO+3fI
	ql/gFQTo3MFQI+xn08jA7buYT6/Zocp0CuJL7ecnvgmhNXc6pLusAMy8+J/7qEfz/7yETT2peiW
	DYG5lbPSPVPnYhKXkvuQMkSwVZQIK7TgQ==
X-Google-Smtp-Source: AGHT+IEOTURGJY/7tDFDiPk6IetB2YEaM3bd1RUuyhbKckdTVmeWFHurgRgim5ZWERL+/J6iWhH4nQ==
X-Received: by 2002:a05:6820:f021:b0:659:9a49:9059 with SMTP id 006d021491bc7-65b2ac652bcmr2158121eaf.36.1765384112012;
        Wed, 10 Dec 2025 08:28:32 -0800 (PST)
Received: from [192.168.7.203] (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ec61d03sm9487131eaf.8.2025.12.10.08.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 08:28:31 -0800 (PST)
Message-ID: <16e02bce-18c3-42e4-a51d-60c4bdf8a763@gmail.com>
Date: Wed, 10 Dec 2025 10:28:30 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 ath11k@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
 <5a5b4961-904c-45e6-aca6-b58a122e2134@oss.qualcomm.com>
Content-Language: en-US
From: mr.nuke.me@gmail.com
In-Reply-To: <5a5b4961-904c-45e6-aca6-b58a122e2134@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/25 12:46 AM, Baochen Qiang wrote:
> 
> 
> On 12/10/2025 10:40 AM, Alexandru Gagniuc wrote:
>> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
>> is initialized in, core.c, a different file than the array init. This
>> spaghetti-like relation is fragile and not obvious. Accidentally
>> setting ".max_tx_ring" too high leads to a hard to track out-of-
>> bounds access and memory corruption.
>>
>> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
>> ".tcl2wbm_rbm_map". Use ARRAY_SIZE() instead of #defines to initialize
>> the length field. Remove DP_TCL_NUM_RING_MAX_QCA6390, as it is no
>> longer required.
>>
>> The intent is to make the code easier to understand rather than fix
>> an existing bug.
>>
> 
> Even the code chane works, I am not sure whether we should do this. Because, logically
> max_tx_ring represents hardware capability which is static. However the change actually
> implies max_tx_ring varies on tcl2wbm_rbm_map definition.

I see what you mean, although tcl2wbm_rbm_map is const. More details below.


> If we are going to add something to avoid the potential out-of-bound access or to improve
> code readability, how about something like
> 
> 	ASSERT(hw_params.max_tx_ring <= ARRAR_SIZE(tcl2wbm_rbm_map))
A static assert might be a good solution. I don't know how to do that.
By the time we have hw_params.max_tx_ring and tcl2wbm_rbm_map, the
latter is a pointer, so we can't use ARRAY_SIZE(). We could try to do
it dynamically, but I feel that's spaghetti code:

	if (tcl2wbm_rbm_map == &ath11k_hw_hal_params_ipq8074)
		ASSERT(hw_params.max_tx_ring <= ARRAY_SIZE(ath11k_hw_hal_params_ipq8074));
	else if (...)
		...

Alternatively, I can take the suggestion from your other email, and
keep the "max_tx_ring", or "num_tx_rings" name. Because it is part of
the hw_params struct (via .hal_params), it still describes the
hardware. While the value is derived from a constant array, instead
of being hardcoded, it remains an immutable quantity, consistent with
a static hardware descriptor, would you agree?

Alex


