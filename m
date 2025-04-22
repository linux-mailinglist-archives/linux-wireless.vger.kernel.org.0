Return-Path: <linux-wireless+bounces-21802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FCA95A4D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F64C1893687
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A3814A4F0;
	Tue, 22 Apr 2025 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="d0DdIXeW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B93335C7;
	Tue, 22 Apr 2025 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284127; cv=none; b=H0Ge71X/RFLCgrC04P8tkp4rYpGMYQlHeX/Gq8yRec31wYw+4TeM9dYQmyVHGAYIlA2pHcED8xv2XNFOauXShfX6GbZxN3KIRYJR4WzRqyRF4whQSOeSJUhZtFxpIeSD8LCuUkkh80WSa+YVHzEWDVU4COMUv1OFirrg+UYl1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284127; c=relaxed/simple;
	bh=czEkA/zVOBS82zkx4p5INjnF9fJ8GCh884Sqbxam5dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDbHYQH5i9ZFBBSY7LPLw+leeOH7hHetE9lfYF98J37Bw6QiAAwtxDh5qYoz/AJzsHK32i3U1B92Y+XfQcAD8F8aj/cgtpJi5gcSsLAu2t+3ygxnBNnnTq1ZsOOFXOcHbDGbASUlAZnlvlikyOt6SQYpON+0VwQO+xsx/qZVD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=d0DdIXeW; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 104F42618F;
	Tue, 22 Apr 2025 01:08:43 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id D847F3E886;
	Tue, 22 Apr 2025 01:08:34 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 6FC5B40009;
	Tue, 22 Apr 2025 01:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1745284114; bh=czEkA/zVOBS82zkx4p5INjnF9fJ8GCh884Sqbxam5dQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d0DdIXeWM0oSk1Xq83ZlCb/7yRuqf67gi4IXHEpFXOZ8NMPMm/fEMSIr1FCfbW9kH
	 /IMD+EdOqVzLorEXuJwL1o+1klNueqYwSBASbAWGvmnJ6BI+3WBVbY0sgoNzvmAcIU
	 G8nFp9/EIYAxfDCgZ2SKKq5SzXVn03m47TDkYgz0=
Received: from [198.18.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id A7FFF407DA;
	Tue, 22 Apr 2025 01:08:30 +0000 (UTC)
Message-ID: <985175be-de04-4d1d-a859-fa740d87c9c3@aosc.io>
Date: Tue, 22 Apr 2025 09:08:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
 Liangliang Zou <rawdiamondmc@outlook.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250419081251.285987-1-jeffbai@aosc.io>
 <4a7284bd703743959e709b9465dabf1d@realtek.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <4a7284bd703743959e709b9465dabf1d@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FC5B40009
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,outlook.com,tuxdriver.com,lwfinger.net,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Ping-Ke,

在 2025/4/22 08:27, Ping-Ke Shih 写道:
> Mingcong Bai <jeffbai@aosc.io> wrote:
> 

<snip>

>>
>> Please note, however, before the rtl8723be finishes probing, the AER
>> errors remained. After the module finishes probing, all AER errors would
>> indeed be eliminated, along with heavy lags, poor network throughput,
>> and/or occasional lock-ups.
> 
> Let me clarify here means. Do you mean all work well after applying this
> patch? Or still lag, poor throughput or lock-ups?
> 
> If all symptoms disappear, it would be worth to take this (quirk) patch.

Indeed, everything works well after this patch, save for the remaining 
AER errors during driver probing.

Best Regards,
Mingcong Bai

