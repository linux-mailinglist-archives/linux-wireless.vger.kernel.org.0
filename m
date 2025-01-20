Return-Path: <linux-wireless+bounces-17766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCFA174B6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E88188630D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE51F1505;
	Mon, 20 Jan 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Mehp+jni"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82351F1306
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412530; cv=none; b=skAadTWnl9P3aYJZ9R9uzCfyO+z02y1Ae3bIJHzzNCBGPvboWDzIYx97qr8adY2ZvKK85xSqX2BiyBPOJ3IyBWu+FUNoZ+ZpIs4cOM7/iZ1ED1xD0S3A7vnKIcER0yhE5JiYcs/d2yPRlAd9XQ1ATba8O3PMo+rAl1lKhb20kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412530; c=relaxed/simple;
	bh=4Eiydyy06kX0Zgs83GD0q+F2XQAgL0BasVv3L/35s90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTIHbLdsPI/13NRoQ56ijXmtb3YGjvNaPmOF8miiHrYMm7kKii5y8yirOetgPuo+mtTaZOqP2b86T3Ha4YCfl8lVr9YhswjahrMiOARYxRlCNxwgO1rvLJHYk9ogsFk9seXHmXyrYSQVK09ezvcqKJPBl0Q4NfxFTJuTlq5CflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Mehp+jni; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DF0E1504C7B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 22:25:46 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 79831B80085;
	Mon, 20 Jan 2025 22:25:38 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.38.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8AD0613C2B0;
	Mon, 20 Jan 2025 14:25:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8AD0613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1737411937;
	bh=4Eiydyy06kX0Zgs83GD0q+F2XQAgL0BasVv3L/35s90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mehp+jni1wcDXP+Bl6OXCNDVJTVyg+wpDX8CuAJL2jn3SMoXxWNSI5cJSxXPsGBvt
	 lnZd17nfaHpZSovvuMqNK9ULbnsB07F0HotZbP1rKP5XJLTC0w3Bal627YALS5/Vyl
	 2TEjyOpXoKinO7Pk7LfEFyMuHZooIVdPfY1nvqXg=
Message-ID: <d18865a7-7120-455d-aec9-45f3747587f6@candelatech.com>
Date: Mon, 20 Jan 2025 14:25:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/12] wifi: cfg80211: add accumulated statistics
 for MLO links
To: Johannes Berg <johannes@sipsolutions.net>,
 Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
 <20250117124554.3719808-10-quic_sarishar@quicinc.com>
 <e484a38c-90ad-4ff4-8b86-2b714dabb6d8@candelatech.com>
 <8543cf2d657b0b975830434eddaf76c35dee8c23.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <8543cf2d657b0b975830434eddaf76c35dee8c23.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1737411939-Z5IqPz1kqn7m
X-MDID-O:
 us5;at1;1737411939;Z5IqPz1kqn7m;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 1/20/25 13:41, Johannes Berg wrote:
> On Fri, 2025-01-17 at 07:59 -0800, Ben Greear wrote:
>>
>> While at it, can we define these a bit better?
>>
> 
> No. We're not going to do "while at it do random other changes", ever.

I was just asking for clarity in the comments around those counters to
explain more precisely how they are expected to behave.

In case any drivers need tweaking to match that, it can be handled
later.

If my suggestion for how they should behave is not what you think it
is, then just change the comments to match your expectations, but
define it well enough that it can be understood precisely.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


