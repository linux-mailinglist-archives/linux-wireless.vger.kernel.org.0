Return-Path: <linux-wireless+bounces-11767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0195A68C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182881C20DB7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D67405A;
	Wed, 21 Aug 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="e2srs40r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02047175D34
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275566; cv=none; b=ecMEHR01P13qNwk+3QAq0JvHTN7bACqMSJdy6l1EITtLakm/OUWwEHOnP7w9dhePT6pJL9JkI6Ra8tWuOPZoO+6dBho1a9CcCsiJFyOp5iTvIT9ihJH79BoLTfA7OZvTqfAHEZFH6+O08Nm1Byab0Gr+4O1QokJIvFjeXC7cxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275566; c=relaxed/simple;
	bh=jqI5uPtkQOCuHuZx0IKYUp40Xka6BvRF4D+HCb/dws0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxhdjMin3NkB/igh4KvjX+zMby6ThnPWLxmBEqCso00Uz/OiHHMfnDFdSPX6yeNausXGIbkodmspMPO5R7g4/4uxfiIzDvVWb5oRLinkEquSmSLQ8YWomTo+J7nOft9iAtdW476SGnsDuzwKWnz2VwNd86/5GxaLebOkvyGQNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=e2srs40r; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id geO4sDQbKnNFGgsq6s6iwc; Wed, 21 Aug 2024 21:25:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gsq5sLq5kZlJQgsq5sF3hO; Wed, 21 Aug 2024 21:25:57 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66c65b65
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=fvnvuae_TkRx4EM278wA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=59nlnOmbwxXF7SPkM/tf0B08dO77gGtbNswEQSGJ8uE=; b=e2srs40r0TGWPoBDcKoSZFLbzu
	evrOHUuEkKa2s8+qH53UQq9wrZkFLc7ytsrDiPIppt3+jfIpmLNrxjJPi9/vZrwiPOnxrKGav1zkQ
	Pg+06QLya3Ed5iyxC3wRrdaCLaZemjBjmF+DeUP5BNh9P+6cP9YphuLRuOCACOyeUsIg2AGvTuC7q
	V+v0ALHkZZd4TP8g2GMkMgJPSOwz8BbiYG7T5xRVoAr8Q0Jo4GdEUr8SBkqTCUkKo7VG7J2bhw8iM
	3FouKCoMsyzjPvI61hgWsHWhiCwHbLrWmhB7D75IsC9OfsKyLmreOe5dAdf8I9VWaaBDA2H+ilyoE
	iNSkwO/w==;
Received: from [201.172.173.139] (port=56500 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sgsq2-0021C5-2U;
	Wed, 21 Aug 2024 16:25:54 -0500
Message-ID: <0627c008-a3f9-4b2e-a3b9-72c6a1a287b0@embeddedor.com>
Date: Wed, 21 Aug 2024 15:25:52 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mwifiex: Replace one-element arrays with
 flexible-array members
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>,
 Ganapathi Bhat <ganapathi017@gmail.com>,
 Sharvari Harisangam <sharvari.harisangam@nxp.com>,
 Xinming Hu <huxinming820@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Y9xkECG3uTZ6T1dN@work> <ZsZNgfnEwOcPdCly@black.fi.intel.com>
 <93b3f91a-baa4-48e1-b3eb-01f738fa8fc1@embeddedor.com>
 <ZsZWxnfy21CpOLoR@smile.fi.intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZsZWxnfy21CpOLoR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sgsq2-0021C5-2U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:56500
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAYFdt2avJpsjjgvvJnoETz7tPzrGKoJC/rLpiedrp1n409Y2J27dOkQWtOZD/xHvHFRla//ee9uwk4TJMJzjYm53TUG8Yi1SZhHjr+Gyo/PEdvwCo0f
 GH2189kFWKZ16/3n0zf8gMU1oZSvznvBhJoKesd9QKwfkmi9uKbkV1Bm40kmQjdsoiMMxMdfLluYiRnp1781pSeX10XRN0hmdybM9+L6iuc3lethcSxU7PX9



On 21/08/24 15:06, Andy Shevchenko wrote:
> On Wed, Aug 21, 2024 at 02:59:34PM -0600, Gustavo A. R. Silva wrote:
>> On 21/08/24 14:26, Andy Shevchenko wrote:
>>> On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
>>>> One-element arrays are deprecated, and we are replacing them with flexible
>>>> array members instead. So, replace one-element arrays with flexible-array
>>>> members in multiple structures.
>>>>
>>>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>>>> routines on memcpy() and help us make progress towards globally
>>>> enabling -fstrict-flex-arrays=3 [1].
>>>>
>>>> This results in no differences in binary output.
>>>
>>> Sorry for blast from the past, but I have a question here.
>>>
>>> This change seems converts many of the flexible arrays in this driver.
>>> But what's behind this one?
>>>
>>> struct host_cmd_ds_802_11_scan_ext {
>>>           u32   reserved;
>>>           u8    tlv_buffer[1];
>>> } __packed;
>>>
>>>
>>> AFAIU this needs also some care. On the real machine I have got this
>>>
>>> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
>>> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
>>> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
>>>
>>> which leads to
>>>
>>>           memcpy(ext_scan->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);
>>>
>>> but the code allocates 2k or more for the command buffer, so this seems
>>> quite enough for 243 bytes.
>>>
>>
>> I think this would do it:
> 
> Thank you for the prompt respond! Can you send it as a formal patch?
> Or do you want me to test it first? (If the second one, it might take
> weeks as this is my home laptop that I don't reboot too often. I think
> it's can be sent anyway.)
> 

Done:
https://lore.kernel.org/linux-hardening/ZsZa5xRcsLq9D+RX@elsanto/

Thanks for reporting this. :)
--
Gustavo

