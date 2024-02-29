Return-Path: <linux-wireless+bounces-4254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0786CBDD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C671F2482D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9280137779;
	Thu, 29 Feb 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="JqXvBkOz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE35137767
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217950; cv=none; b=bP7UL0ZQiiGXumMfR7PGdbTt18SqVp33vJ4RsxGZYxI3/Uj6RA8Ooz+tY+8Qd3SrvCtKko2cEoWaoQmb1rZx1A33FpLn/bfeySeUjmlCeHfzI8T65JF39N8/BXI8qCDjT39+Yx3Rq0rnnZ8RplV9nvJZ2cLDgbtkeTVj1V9lrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217950; c=relaxed/simple;
	bh=H+cRqbqPGJ75w6hI9ljZWV3rNqj+mXrDQtyHGY/bncw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I5T5vj94Jns1U+o86QNb+JTWiyaQX6L1VyNFDSxLUD9pgGG7qP5tVBCaJT5QNhYIP6uaxb3WEZ1XCKDYXV1zrPEIjTrqHUiHIZW93tLNFgRwt/3kV0pnAnOJXjwYFLqkNCFozh9kyJwnwXlJwQIuh2XZ2gffw/gadUGKX08uAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=JqXvBkOz; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=H+cRqbqPGJ75
	w6hI9ljZWV3rNqj+mXrDQtyHGY/bncw=; h=in-reply-to:from:references:to:
	subject:date; d=aixigo.com; b=JqXvBkOzaaVBux0vez5QCa+wuqoWEBpw47V8jDIA
	W8A0iTt52pZIbpXmrVlEerXSf4AkXbQG1ZyrSEHBs2eSN98ekFtClXSu6NDKwxGscncYxa
	pFO4GlXLPwuXEyZVqRmAGCo/JaVWDP6Eg8wNug1dOZ8LD4XC3/1o5BRLWoNg8=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 2dc9baaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Feb 2024 15:45:42 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 41TEjgUo132510
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 15:45:42 +0100
Message-ID: <5cd86456-ff2b-4e4a-aa12-1e11e5de92a5@aixigo.com>
Date: Thu, 29 Feb 2024 15:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
 <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
 <b9b2224a-f021-483a-8606-6aed94c5f6f9@aixigo.com>
 <795b376aa2c9112527cf135a5176f01c6af69ade.camel@sipsolutions.net>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <795b376aa2c9112527cf135a5176f01c6af69ade.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi Johannes,

On 2024-02-28 11:30:44, Johannes Berg wrote:
> On Wed, 2024-02-28 at 11:23 +0100, Harald Dunkel wrote:
> 
>> It used to work with the same kernel.
> 
> OK.
> 
>> This is what we get for the new (6.5.10, Debian backports) kernel now:
> 
> But that'd mean it's working - or are you saying that's a different
> machine?
> 

The laptop recovered on a power off reset over night. It worked again
on the next morning (I was told). I logged in via VPN to upgrade kernel
and ucode file. My colleague rebooted it once again, and it is still
working.


>> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
>> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id 0x80400 wfpm id 0x80000030
>> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=0x370, rfid=0x10a100
> 
> This seems to work, has a proper PCI ID, and shows a different RF ID?
> 

Yes, I would say so.

> You previously showed
> 
> iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x1010c000
> 
> So I think it'd still be interesting to know this line from the system
> that doesn't work any more, to see if it really was _exactly_ the same,
> as this before and changed, or whatever happened.
> 

root@ppcl013:~# grep rfid /var/log/kern.log
2024-02-26T09:55:24.858020+01:00 ppcl013 kernel: [   82.527151] iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x1010c000
2024-02-26T13:21:24.361666+01:00 ppcl013 kernel: [   20.136735] iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x1010c000
2024-02-26T15:30:25.639827+01:00 ppcl013 kernel: [   38.203931] iwlwifi 0000:00:14.3: PCI dev 51f1/0000, rev=0x370, rfid=0x3010a100
2024-02-26T15:30:25.639828+01:00 ppcl013 kernel: [   38.204862] iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x3010a100
2024-02-26T20:45:28.752692+01:00 ppcl013 kernel: [   21.294757] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=0x370, rfid=0x10a100
2024-02-26T20:45:28.752723+01:00 ppcl013 kernel: [   21.813877] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
2024-02-27T09:11:49.132498+01:00 ppcl013 kernel: [   48.939136] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=0x370, rfid=0x10a100
2024-02-27T09:11:49.132582+01:00 ppcl013 kernel: [   49.420458] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
2024-02-27T09:44:52.740746+01:00 ppcl013 kernel: [   57.435249] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=0x370, rfid=0x10a100
2024-02-27T09:44:52.740759+01:00 ppcl013 kernel: [   57.764033] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100

> 
>>> If you really have subdevice ID 0000 then something went wrong and you
>>> have a blank OTP (now), which seems very strange.
>>>
>>> This is an integrated NIC where part of the NIC is integrated into the
>>> platform, and other parts are on the companion RF (CRF), so could also
>>> be that the CRF module isn't seated well any more in the slot and it
>>> just cannot access the data properly?
>>>
>>
>> You mean there could be a problem with the wifi card not being plugged in
>> properly? We will check when my colleague is in the office.
> 
> Yes, that's what I mean.
> 

We will check when my colleague is back from home office, but this
might take some time.


Regards

Harri

