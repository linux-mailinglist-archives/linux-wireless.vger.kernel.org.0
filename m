Return-Path: <linux-wireless+bounces-13220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09598739C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02841C24F0B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382F20EB;
	Thu, 26 Sep 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUjp4VLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A47196
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353878; cv=none; b=dtjN3vyr22Z2Y32DCCljcU0gk814gpKHyvJzMMLu3W08mcQCDu1RnmnnvjpI6/VJrIpKCwD6uVrPLd0ANHRd69vKgsCUN4mBto+wF+WYDF4GGFhVMbdaXNAOKukjtoecbTy4pY4qxVwJM7a2Xy8t29D4ywpQuVr/cGGjs8yv+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353878; c=relaxed/simple;
	bh=j66/24Sy6KVKIVusYN7H5yL1N7uKP7ELQV+3p6rSwkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvYdZyyuzHi/sD6W1rpDB/lXmRzeU65r8r9HFYa/1U3N/GpkPtpxov2F68elFrrexJjooJHi4fyLYRkqnBPaNAS/p2477UrdyXyrCTTurzP7cl1WEGZJZ8JfEPUns3vzA8AvtTnHWLPsSTqdqUJpXpXs+3V6JvcJ9YXf1SCacqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUjp4VLW; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aef2c1e5fso39508839f.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727353876; x=1727958676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVVKUnJeefhn3FGdHzSXUGbhKax+mPAJgyRkXPtqOFo=;
        b=BUjp4VLWxovthDgGVg1AVvwKBpv2ynHdSkER5Kc7vD8Tvk8Oe0R7RSCnu4UxC5GjoQ
         +D0B4xp0j7jYc3zEff+FWclteG0Nx6jXqjVZjsrqR1Z9P7WaByH1DnIMupnkK2IoM6Na
         g7CdKUvpCHs3obPGQdxjLF/+vQGvGdyyZeEh5kF3IrfZBBv2yJwXCTzS8FoHdj4aWjyw
         gS3JCxuq8dLrUTHxi/XRb3kWlCTxUm27A6jBR12qsWQcgB4+1LeQva3uuD1lStRFYgom
         Rbb4S/o7B5+bhXlyQnSfbEUYB0gskfyTktisvgmzCJ6mwfOL4HjhlxIDm+8Nb96ULJek
         UvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353876; x=1727958676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVVKUnJeefhn3FGdHzSXUGbhKax+mPAJgyRkXPtqOFo=;
        b=PwoAVzThjdAKFQH+qsCqUlPeQDmnPCqJbRp2UqqEhaWIOZhKny/dhrugUteearcM1V
         CPC51ulgwPMuH8La4AsBEjU/URW0a3rdCF1zyMN6ulxFwr253kHS9x41s5AKj4pyLGvF
         p/u6kim9twuvmmgfOEdbrzXjNXCU3UwKHBf6SplenZC/8xtlOK7q7JwqxLLeIM5I69nw
         gRiu3SR788e2m9gbs8Cnfi3Xx9ahMRjS4k+h/SCheEHlyVssqK8xamIcsm5D+Lb/gZy4
         s+bw300DMzoAzeuaIHj41k0mKuGM+twWWLwVkMd1WwrYzIP634Px3d5XV0/g58v3KpKR
         GohA==
X-Forwarded-Encrypted: i=1; AJvYcCVSpSCuIL1J5OgW03u0o4Kj0823uWWb8OJAoZRbCP7dxNOXeTHHMoyzaobwEz/B0pISU7VwhfDFrfR1zhhxbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNvXGAMi7u4aVjB5RE2GF5MHe5SWW/wHHaK8hTwGi9AlZ0g5b
	PlPojb9kTOb1efvdwSlCALxIoHko2leC8EOa5xH22nwKxSp3ttDc5wtP9w==
X-Google-Smtp-Source: AGHT+IFaQy/8F/cd19b+3+0CPcydcAWuxUdDYOjWOcMnSQ5frKBvR1ug8Z76vUGPZ4D2P/Ij9Kd5jw==
X-Received: by 2002:a05:6602:160d:b0:82a:4490:692a with SMTP id ca18e2360f4ac-83247d2bd4cmr588881839f.7.1727353875710;
        Thu, 26 Sep 2024 05:31:15 -0700 (PDT)
Received: from [10.117.37.22] ([64.125.133.168])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f0e93b4sm1676309173.28.2024.09.26.05.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 05:31:14 -0700 (PDT)
Message-ID: <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
Date: Thu, 26 Sep 2024 05:31:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
 <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/25/24 8:16 PM, Baochen Qiang wrote:
>
> On 9/25/2024 7:33 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>> On 9/25/24 3:07 AM, Baochen Qiang wrote:
>>> On 9/19/2024 8:21 PM, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> I noticed an issue when we started putting ath11k clients on a WPA3 network which seems to be related to the fact that management frame protection is enabled (works fine on WPA2 no MFP). Immediately after an initial association a neighbor report request goes out and we get no response from the AP. After getting a PCAP in one case we noticed the neighbor report request went out unencrypted, though still had the CCMP IV parameter. The content of the request was the unencrypted request, and something like 15 bytes of 0x00 padding. I will say, this initial PCAP was made through the AP vendor so perhaps it automatically added the right keys to decrypt the frame, this could be a red herring. I tried on my home network and it was hit or miss, sometimes I would get a response but sometimes I wouldn't, but I did see the frame was always encrypted in my home network case though when adding the PMK directly in wireshark I couldn't decrypt it, where on other hardware like iwlwifi I
>>>> could.
>>> is your home network also WPA3?
> any comment on this query?
Yes, my home network is WPA3.
>
>>> and how did you get the PMK? is it generated by IWD and printed as debug message?
>> I actually had to modify IWD to print out the PMK after it derived it. WPA3 makes this a huge pain since the PMK differs between SAE exchanges.
>>
>> I've attached an IWD diff that prints out the PMK, which can be added to wireshark if that helps.
> Thanks, I found another way to do the decryption.
Out of curiosity how did you do this? I couldn't find any other way to 
decrypt WPA3 connections in wireshark except adding the PMK directly, 
even when capturing the 4-way handshake.
>
>>>> Some time after the connection neighbor reports work fine. I'm not sure of a time frame or delay required that gets them working, but it makes me suspect that ath11k doesn't have the keys fully added in the firmware before userspace gets signaled as "connected". Running the same scenario on ath10k or iwlwifi has no issues. This neighbor report request immediately after connecting is IWD's default behavior, so its relatively easy to test by just restarting IWD.
>>> I captured a WPA3 SAE PCAP too, but only can find some unencrypted ADDBA req/resp frames. for those encrypted action frames I am still struggling to decrypt them
> I checked all the action frames after decrypt the PCAP, but still not able to find a 'neighbor report' frame. next will study IWD code to understand how such a frame is triggered.
>
> and again, if not possible to share the complete PCAP, can you share the individual 'neighbor report request' frame ? you can simply copy it in wireshark.

Immediately after connecting you should see one of two possibilities.

1. If IWD did not receive a response you would see:

iwd[694]: src/station.c:station_early_neighbor_report_cb() ifindex: 6, 
error: -110(Connection timed out)

2. If a neighbor report was sent back by the AP you would see:

src/station.c:station_early_neighbor_report_cb() ifindex: 13, error: 0()
src/station.c:parse_neighbor_report() Neighbor report received for 
xx:xx:xx:xx:xx:xx ch 44 (oper class 22), MD not set

I just re-ran the test and now, for some reason, I am entirely unable to 
see the actual request go out. In the case of both ath11k and ath10k I 
see no request and but I do sometimes see a response. For iwlwifi I was 
able to capture a request/response but for the most part I don't see any 
request either, but always a response. Maybe the request is going out at 
some other data rate that my monitor card is unable to capture reliably? 
Not sure on that one.

So as far as seeing a request from ath11k, I'm unable to get one at 
least on my home network. Getting a capture on the corporate network may 
take me some more time.

Thanks,

James

>
>>>> Since the neighbor reports work fine after some time its not really a critical issue but I wanted to bring it up just in case.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>

