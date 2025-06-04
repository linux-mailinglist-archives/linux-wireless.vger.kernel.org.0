Return-Path: <linux-wireless+bounces-23693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20535ACDB90
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 12:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07F03A4380
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E928D82F;
	Wed,  4 Jun 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UQVL7H7Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1201F873E
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031311; cv=none; b=fOmqKBcFIY+z+PTsVkkccgXJtJ1eedGnVVSQdC7LhujbFUBso9FCQRYEqvup20tVfDj5ye1S+GAlqKsnAcj0i9/Au1Z6yrHIzXLuRGfCAg8qAml61V8wbp1Q1M8ZxsqWkVKNBW81BZL6F2iLYjZO6FUw1u2AYvvjDDKnCVHcBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031311; c=relaxed/simple;
	bh=uVXiz7YiwmFP/PvX3IkvoIwJVKuytUdwCoIClqS+YIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5/ilL5PPPe6Ul5UIMHJ9zgCxO55kLKnAFB/YuQMM/FD2Fjv+Oa6eHzpqzCXO7Dx+UWo7edx8q06jPaIO/eYyK6Pezy0k2lEba2lF5fPVYvvfUeDRfPty93YMsiIv5irbqhrw+a0gvE1xekywvVhbooB9Zlw9M4cpswztVPfano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UQVL7H7Y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4144793a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749031309; x=1749636109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PynvX3kh+SNKtlYdWAEfYx9OfkkI7M8piskychTT13Q=;
        b=UQVL7H7Y/eEU1EMimzazLbmA1w0VsaAMMjTKbNXmI52R8Yu8aKVPIJrWoZ/O3bEeKh
         HxXsvv2lViblWMmutDSkaTuMr5r1ckAt/ClDXORCIaiwAia+50mT/aVOV0IgsEqn2cJa
         XwOblO3qXs4Gys8MGUxYTmCzz/ECq88cIyhXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749031309; x=1749636109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PynvX3kh+SNKtlYdWAEfYx9OfkkI7M8piskychTT13Q=;
        b=MIxLwSe0DjiDXLaHgVfSoUv9XE61TS/f2OzgVISUDx14SqItrTydEkS8NqfgYQjINy
         jLdjZIo5yiYBU/kfiFOwrCMwiFi8VqgtlEymX02KaSgEf/Yy4ltc85V3C/ubjTrumrx3
         qj9VSWdC9fIHedyH3OzfdEpE1vs/7/LKG8YokDlo9EqCBMrftbEf49bqaHSimRKU8JxJ
         Kqqi1WWdx3i1BPpTuOql6mFLteZWxOCktAE9IybQfYqUGMpTn1lBIfDWTTYSAAkPyFLj
         HZgH3aWRbWTFe36FveHMTKYMdMZ9pzG7MYsJkkZtYuWjRHp0Dr8C66J1TPsONe4Mp0Ro
         uuqg==
X-Gm-Message-State: AOJu0YxBCQFAWGqkVCFcA1+CVnfAol4cKhAfwq2PN79xrI1NvEx7Eadv
	7VnM/VM0NCtZhjcQst1VAjKVw3wQ8W5kWACqnstLGOfHl8V79Sr+xoqGk7igr274eg==
X-Gm-Gg: ASbGncuXqZRGgqJJ4VHmgesz8nc+W0+tidBiIsFPhy8O588o8DCsjXyCbc697BsXIHt
	yJsmYxA7Fv+0SZMZrpIkzbwvS+w98cygtVEYu5nHHkjpYwqKG7vAhd/rkSc22qW3Rg/8QobuIdA
	KmQCxbiiLlgL0yHL1fNq7nkGOcyT/2GrhiEGwf0VxJKx7Oovf9NALQgSr2AiziHIT6SHyaNUeRd
	NI14h72c9KerRnyAA/c60u+Wbhl1O2jly/7Dge+whEQlWHAIYOwAsreHODY05L3q7HjEGypERmp
	82Azz5sBGxzDJqRTXUhtAZNCUX19M4TskLLH9aypAoSbDclASfHuGhikzJ+YI2BfAWf1j/7taaN
	zvIQUjUs7RdP/TA==
X-Google-Smtp-Source: AGHT+IHjobl7NX5KRfd9whJPm/Ms1HQ2618Ad2efTZIaAFMeTzffYmpmkEigcuii9SkTd9YkpNnN3A==
X-Received: by 2002:a17:90b:394f:b0:312:639:a062 with SMTP id 98e67ed59e1d1-3130cd320f7mr3824355a91.16.1749031308880;
        Wed, 04 Jun 2025 03:01:48 -0700 (PDT)
Received: from [10.176.3.8] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf44cbsm100547545ad.167.2025.06.04.03.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 03:01:48 -0700 (PDT)
Message-ID: <1122ef86-c43b-4d39-aebb-e69a1150f61b@broadcom.com>
Date: Wed, 4 Jun 2025 12:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd
 offload to be enabled if ap mode exists
To: Ian Lin <ian.lin@infineon.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 carter.chen@infineon.com, double.lo@infineon.com,
 vinoth.sampath@infineon.com, gokulkumar.sivakumar@infineon.com
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-2-ian.lin@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250604091629.3943-2-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2025 11:16 AM, Ian Lin wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> Add a check to determine whether arp/nd offload enabling
> request is allowed. If there is any interface acts as ap
> mode and is operating, reject the request of arp offload
> enabling from cfg80211.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
>   .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
>   3 files changed, 22 insertions(+), 1 deletion(-)

