Return-Path: <linux-wireless+bounces-16840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848509FD9D5
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 11:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C9F7A03E6
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085508633F;
	Sat, 28 Dec 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b="gzWNowYv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dd54106.kasserver.com (dd54106.kasserver.com [85.13.166.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39E78F52
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.166.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735380837; cv=none; b=h2jCBz0nXC4RntJuPi34rnyoRy/OtM1k81+2HKv8iaSzSehcDfV2yxq/N+E6jBxg35BPPJxsuP7VFlFfYCQCkcOx6aDp/Av/rq6M46n19WQXj2V381GsN1or/7Is7zphmTkgqNgfpIFxmCxFMJynrI22Y0ksRUBEr62EFLxAt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735380837; c=relaxed/simple;
	bh=HsymhzJSDOtPa19UM4KGlsCuJJzU8jcyZev8yStGfNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l/pI8sCZDEHS1oYkdwUbnrhhmBJ6fuWEq7/vfrDYBK4/1D/GUwI7b+TZRNB/3ZQFdqGlHA4dq8HqCyu9SJqPsBuw+mT3rnLJQfzPN648J/Bsj/uqPnq5sSKt0CXsaFUAjgGQjAleTdP1DF1PT/rXr21ydCOJIFqbTbruPebJrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de; spf=pass smtp.mailfrom=steffen-moser.de; dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b=gzWNowYv; arc=none smtp.client-ip=85.13.166.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen-moser.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen-moser.de;
	s=kas202408292216; t=1735380831;
	bh=XS3W6Nm33y8lf/E3f46CoorgvUQmeVLhar9Ww+z/EqE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gzWNowYv4YlvX3VoF4Fql17e30OHgBgj2ZutUcoIIbq+3up32DNEKJA7xlLZEx/kw
	 oTEox7nMrN88SGmuRuj9J+aU4DUlbSSzgejmUmvsapM8K9OJLIAuTfCbIwKQBWi7pe
	 H4sjJ2ymS20JA5GCyLV3ZO1L39UOhRdAfAa9PC2A/qtM9C2ldqOq1ubj8QAx0kYE5y
	 qVKCYMP6hARUJu4i75HU/5BDN8DV5FoxqHnk0Chl9jGfkjCKzae4kQd0qGucpC5L8N
	 Fhvfxah4v+M/nofu1Jgp0Qj2hiwI6T4a/z5WYi4Ui1msGcR+yMjBSNqQeSNGAH3yoP
	 OWaqUKu0KfI2Q==
Received: from [192.168.1.101] (p54a3711d.dip0.t-ipconnect.de [84.163.113.29])
	by dd54106.kasserver.com (Postfix) with ESMTPSA id 39B85E4A034A;
	Sat, 28 Dec 2024 11:13:51 +0100 (CET)
Message-ID: <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
Date: Sat, 28 Dec 2024 11:13:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k with
 IPQ8072A (QCN5024/QCN5054)
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
Content-Language: de-DE, en-US
From: Steffen Moser <lists@steffen-moser.de>
In-Reply-To: <Z2Q9POuV-6MIdzRf@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Dear Remi,

thank you very much for the pointer to the patch. Sebastian integrated 
it into DD-WRT. Now the DynaLink DL-WRX36 runs absolutely smoothly, the 
WLAN links are stable, the packet loss is gone. No weird states anymore, 
independent from the group key exchange interval:

https://data.saps.uni-ulm.de/index.php/s/NLNpWqjc8iGsaEM

So your idea was a direct hit! Thank you very, very much. Several months 
of debugging have come to an end...

Thank you very much and all the best for 2025!

Kind regards,
Steffen

On 19.12.24 4:35 PM, Remi Pommarel wrote:
> Hi Steffen.
> 
> On Thu, Dec 19, 2024 at 04:02:30PM +0100, Steffen Moser wrote:
>> Hello everyone,
>> 
>> I've encountered a possible issue in a DD-WRT [1] setup where broadcast
>> packets stop being delivered after a GTK (Group Temporal Key) exchange. This
>> issue occurs on a system with the following hardware:
>> 
>>     Access Point Hardware: DynaLink DL-WRX36
>>     Router Software: DD-WRT v3.0-r58819 std (12/13/24)
>>     CPU: Qualcomm IPQ8072A
>>     WiFi Chips: Qualcomm QCN5024 and Qualcomm QCN5054
>>     WiFi Driver: ath11k
>>     Firmware: WLAN.HK.2.12-01460-QCAHKSWPL_SILICONZ-1
>>     NSS FW version: NSS.FW.12.5-210-HK.R
>>     Kernel: Linux WL-AP-EG 6.6.64-rt29 #1791 SMP Thu Dec 12 16:41:51 +07
>> 2024 aarch64 DD-WRT
>> 
>> The behavior is such that after a GTK exchange, the AP can get into a "weird
>> state". When being there, broadcast frames like ARP or mDNS are no longer
>> reliably delivered to connected clients while unicasts come still through.
>> In this "weird state", the channel quality (active time vs. busy time) goes
>> down and latencies to the still reachable WIFI clients rise.
> 
> This looks a lot like an issue we hit a while back. There is this patch
> [0] from Qualcomm's wlan-open repository. It is a revert of [1]. Using
> that the issue was never reproduced. Maybe this can help.
> 
> Also adding ath11k list.
> 
> Regards.
> 


