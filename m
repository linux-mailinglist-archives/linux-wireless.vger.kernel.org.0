Return-Path: <linux-wireless+bounces-22316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C77AA67A6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 02:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A12A16E7AE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FF645;
	Fri,  2 May 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LtMl6stj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA6195
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144346; cv=none; b=EtJy6DPFc8SqiBirqDh+PuPuCxar5cbsxgYepKN96u4lL9qYlWcdhMe4vMu7QQbYP0WE/2foNS2LX3Ud9Fz0hfd3CT1U1VNRK/wUDFLH/GV/vrCFq0PwC/A9oO9vYw/OWb83ZJgNaS4t90LVSC+5SUAtnarWjz+ZH4BBxIbC1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144346; c=relaxed/simple;
	bh=XrsWRdKwfxeEiA/Dn0iBKwqRP+DgsDMe/vBYRqOpk78=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ca1piNNN0nRZZru/QigyBIpbZVDENmDUMn48jpsjpcTH+kcYht4kQAKIp/YYsUeog3Rr29WGL69mV/XoBRo1+o9MuFCIZeueYn6bjqXrRUkEq6KiC9AyCNl6PHy3LcNsYZRiaharzv/DwTKOkhP5TZExqRw5mI07JPE1f2fKzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LtMl6stj; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.217])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B3831600CD;
	Fri,  2 May 2025 00:05:35 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AFC49A8008E;
	Fri,  2 May 2025 00:05:34 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 451FB13C2B0;
	Thu,  1 May 2025 17:05:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 451FB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746144334;
	bh=XrsWRdKwfxeEiA/Dn0iBKwqRP+DgsDMe/vBYRqOpk78=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=LtMl6stjN2SjM+AYPDbL+8k/w7DHbNm6UY6TR3M4fiNJsH4y3as2hjeU1xj1qugwE
	 SYPk5e5gor3ccT0FJhLzBSAitOHY/XnstelHo/mX8jceht9EqwNO6BNcrB+9ofWoBy
	 M6YrMQI3+oOVWaIpJzS1sJkXn0Nhsjqzz2eGQJzU=
Message-ID: <ae0d64a2-8a69-37ce-7ca0-a6a73d371a63@candelatech.com>
Date: Thu, 1 May 2025 17:05:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Intel mld stuck at 40Mhz on 6.15-rc4
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
References: <aee3f644-16f6-6edb-5e45-f9da3c021f89@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <aee3f644-16f6-6edb-5e45-f9da3c021f89@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1746144335-ij20lhlqyDlY
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1746144335;ij20lhlqyDlY;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 5/1/25 17:02, Ben Greear wrote:
> Hello Miri,
> 
> I am seeing an intel be200 radio using 6.15-rc4 + hacks kernel show only 40Mhz
> bandwidth on a channel 36 wifi-7 AP that should be supporting at least 80Mhz.
> 
> I looked through the recent mld related driver patches on linux-wireless
> but did not see anything that looked like it was addressing this.
> 
> Do you know if this is a known issue and/or is there a known
> fix for bandwidth problems in STA mode for the new mld driver?
> 
> Thanks,
> Ben
> 

Gah, I should not send email at the end of the day.

The system in question is actually using an older kernel with no mld in sight.
I'll debug it more tomorrow.

Thanks,
Ben

