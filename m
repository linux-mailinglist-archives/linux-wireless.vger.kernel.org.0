Return-Path: <linux-wireless+bounces-16328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687429EFC33
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290BE28211C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5318C035;
	Thu, 12 Dec 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a+W4c9Pv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2C748D;
	Thu, 12 Dec 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031032; cv=none; b=isevlyHgy3fGU+6mGzh54k4AoL8Nwc492MuRvECB5eOnbQSBc8lDLie03aCFq47vhbmIFu5xExPIY+P0XrPHdIqCCgRdkzV4ngmr722I7EtjCt94ETEmq7Vk4zlV4fqjF2E/Fs7t3KtIH91kSb3zGnvdErcs1YWpAzof0+SzIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031032; c=relaxed/simple;
	bh=ZQrysuhtj7gpvR7Pg9m6pT1D/47GKCLmTFKi/n9zrzc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TtkhgJjb13/NQk35BRyunER21SeAb1Ah3S7WZ9Vn9uyl1Axh0y2O3WzOE4Vc1CtztoyV+tb2d+ffhrT/b2/kMDYp5nz/sXg9CNq6VLRw2s/lLWCE7J5rNszWa/uef308q9Zg/yI827ThmlmoFmRlc3uhyc97MaYnjz89b42odag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a+W4c9Pv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.128.151] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7A3E20ACD6C;
	Thu, 12 Dec 2024 11:17:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7A3E20ACD6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734031030;
	bh=tO2gvxoUGoZO1jpkcXEEyI2BAiP9UdBxuffy1wivgCM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=a+W4c9Pv7QXVBqUn/Dy5ZEtgWRtcp5iLyLtlaTxvajdzfdUHse8gYb8ykAe8H/IxC
	 6SQWYqz8ZlN3qvmR7jfWHpg3fRjdlIPpVZohDMslKXAXMNEPHPq5HyMO+PdQqgrdXY
	 kLXLLXolY9Ni3pJJFZUKmKVRUb3VzyOmPWeYekU4=
Message-ID: <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
Date: Thu, 12 Dec 2024 11:17:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 eahariha@linux.microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
 <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2024 9:51 AM, Jeff Johnson wrote:
> On 12/12/2024 9:33 AM, Easwar Hariharan wrote:
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>>
>> secs_to_jiffies(). As the value here is a multiple of 1000, use
>>
>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>>
>>
>>
> 
> something is wrong with your patch since it introduces a blank line after each
> line.
>

This is some sort of weird interaction between b4 and git send-email. I
used git send-email to send the patches after writing them out with b4
send so as to edit "net-next" into the subject line. It's good to know
to not mix the tools in the future.

I can resend from the branch with git send-email directly to avoid this
if preferred.

> Also if you want the ath11k patch to be taken separately, it goes through the
> ath tree, not the net tree.
> 
> /jeff
> 

I don't have a preference on being taken separately, whatever approach
works best is good with me.

Thanks,
Easwar

