Return-Path: <linux-wireless+bounces-13020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B0297C90B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275FDB2163C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270B19D8A9;
	Thu, 19 Sep 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaHGlinT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA719D897
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748511; cv=none; b=QRqi8eb/rgNlRh/16t7V/Ihe5i7u54Txx8l2F3bSfgGV+eL7SQnRyn5RaBEkfvk+NssEE3sQA9w4Q+Cr5SRcl/13eiGy2AGTNf7ekdtNrRkjieOmnKwTVMv4IYNLeu4856D31B/5qAf+gbbaXqty/1a/jaUP/7A9cwlyqD1m5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748511; c=relaxed/simple;
	bh=VPfkElCik4d45OOT9g7FIG1zTAtmYb1RupKiNY62OZQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QOUMLJMB1ZuwB0jv50zonrDCsCUQ/CLIJcfl0hK4STR7zZ25GxKeTgHiuzGbkrM2iJU1GF+nBo7+s9zlxhhamN9i9pmJLkOr/LWw3e7ZkAu8QG0UljMMaAjiTG5umi5+HNmlKu6kgfvaWVR3rOP9wHrxz1jWRtCJWAXXjuPcmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaHGlinT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ae0e116cso77801185a.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726748508; x=1727353308; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aPinBNpEQJmGkGlD8UKbnq3igt9GLhQ1nJTLZCt2t8=;
        b=kaHGlinTpniRlUQdVqEw3MatTIJcf+X4t5Pn6+AUoO6oU3+843e87ned504yKLv8yT
         qjwNTHXdYdSX4LzTkqh54cpJwFdfGoRA0k3yycRCk7L6dBLdDGKvK4iHpFR2j+tuRnK/
         HjqNj6FXyvXcgyi4lW/rEPmWHzmSczfAJVKf48jSKw2NkcLDDa7IKku+p8EMw5XkgMCG
         7Va31pHzBw3OKI5500QBQzv4RMzN4iaZrG7QEgzdQibd8P6yRMjlL1hKtO7z2jIEJkxs
         KmMbAWR5QlpEDvgwI17TqAfiQbdUbw0SQfugxPigp0TV/Opi6k5qBjp9RmFhEoB3gFBG
         U7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726748508; x=1727353308;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/aPinBNpEQJmGkGlD8UKbnq3igt9GLhQ1nJTLZCt2t8=;
        b=rt/y8Yy28bpfBGIH1YPcjsix9RQni06qTsUj5gbSoZEOqQeQgAJHM1B4ws69FFqAwq
         Uvk191feEevlqWauE95qqSOSKJMZHo7Og6j8N6CVCyS6psoL0p0uXjSlLE+Eb0qG03ip
         pwGSPQh+gdbhpnaBsd/hi+406wq3PVYhtgjQj42FWhd0xvGyYHKE9byjFUAX5SSnM2tc
         cq3mSf1XCWG0BMYoaZvpX8F4PVz3NsG/L/qvBsrqqeDUZOlJiQ25Ndl2wl20J6bfoX8Z
         uEIviP+4E2VzpnurIdzqcDiDd7yqTGowAedcuiqfX5uXSYbyqJWpF2NUPWVroaf585iU
         u6Eg==
X-Gm-Message-State: AOJu0YybShvFIsRVKjGMZe5Hq17lTijgm3OHziMkjFmFzsMzmQCnJla/
	5no5vlJL3c2ljCX1Jf0tgrfL3Z47KfI1rD2w5KRaBbNj3RV9KzDErWzxZQ==
X-Google-Smtp-Source: AGHT+IHmlJqFsWyU2FsvDsYsWVtepRrCPdLBdyxSiSA3TMcqUitL7XYEPTVYs6LXteGXk1D3u0Vg2w==
X-Received: by 2002:a05:6214:4a89:b0:6c7:5e3c:ed4 with SMTP id 6a1803df08f44-6c75e3c0f9dmr38936096d6.32.1726748508322;
        Thu, 19 Sep 2024 05:21:48 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b1786961asm7059851cf.6.2024.09.19.05.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:21:47 -0700 (PDT)
Message-ID: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
Date: Thu, 19 Sep 2024 05:21:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed an issue when we started putting ath11k clients on a WPA3 
network which seems to be related to the fact that management frame 
protection is enabled (works fine on WPA2 no MFP). Immediately after an 
initial association a neighbor report request goes out and we get no 
response from the AP. After getting a PCAP in one case we noticed the 
neighbor report request went out unencrypted, though still had the CCMP 
IV parameter. The content of the request was the unencrypted request, 
and something like 15 bytes of 0x00 padding. I will say, this initial 
PCAP was made through the AP vendor so perhaps it automatically added 
the right keys to decrypt the frame, this could be a red herring. I 
tried on my home network and it was hit or miss, sometimes I would get a 
response but sometimes I wouldn't, but I did see the frame was always 
encrypted in my home network case though when adding the PMK directly in 
wireshark I couldn't decrypt it, where on other hardware like iwlwifi I 
could.

Some time after the connection neighbor reports work fine. I'm not sure 
of a time frame or delay required that gets them working, but it makes 
me suspect that ath11k doesn't have the keys fully added in the firmware 
before userspace gets signaled as "connected". Running the same scenario 
on ath10k or iwlwifi has no issues. This neighbor report request 
immediately after connecting is IWD's default behavior, so its 
relatively easy to test by just restarting IWD.

Since the neighbor reports work fine after some time its not really a 
critical issue but I wanted to bring it up just in case.

Thanks,

James


