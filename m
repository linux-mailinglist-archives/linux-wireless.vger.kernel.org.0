Return-Path: <linux-wireless+bounces-13262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D83988383
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3E286853
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC51891BB;
	Fri, 27 Sep 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMLVDj2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1E18A6D1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438031; cv=none; b=pBc2psphUKBFKOFpsEhdDDsVjOVFYwwflNVBCUSRBJ7ME78uaSjbelrp/0gHSrZdcmUYcOzOV4npk/bEo53a+o5DVoUJt4q62BQi6KvA/EvjuMOD/Z3lE6KO8qZFa3iY7C9ICN5DJ/h/4To/Z62rEl79z4iE9mW8RMQL9kc+hUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438031; c=relaxed/simple;
	bh=Bh+Of5Kdko+bgF/iGM/RUSH1xjHR2Y73Gva8MDqVPGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxKuPhUCphqRcHNoo79bdqfiLXRl4bjSLoZ+QXM/kIMiz4xlHJb/y7qLR0+nlnMxQYD73BIkqSPraWX//SHrt+CJNno9PdN/1BKQSFKu9OM8+zdUJ9rfXI4MfiOuHWcID1kNekTlR/hspKViF17KdaoJf2F3hTuWH4AwI33KcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMLVDj2n; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7acd7d9dbefso206889885a.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727438029; x=1728042829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWJVUU70D/KDWBudNPb5zBWCBs0ORCb7v+FRCsH7Kig=;
        b=lMLVDj2ngg+9GdtmI32qVwQd+MIRwaLKHG1yhCX3Bti/RcppB/pvqqJ1iR24F/Vg0K
         QxgBjfiwMZpvwXZEf4BrD33fhATJ/TRe3C6Xco353Shv+q4q2dkmsttuP80BGjFb/rlx
         W3dUvBHhEKXytnjmAJ71KgumR0XbEiiZLFTGIOwoIGVv589BuwSih3RNMhk3EPkS8Mpt
         1MlZBkZbgTQIaepSXIjQZztb76GtfRjBfDP+yA0L9e+A6KGMTDUQa4mxu/iNX4DZ6cv+
         /IRioLUP9dXXswwTgeAI4EzHvjSIF9yfOjDVe/ejPdsuMGVcX9MEQpRAAL9bhUh6uSax
         JMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438029; x=1728042829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWJVUU70D/KDWBudNPb5zBWCBs0ORCb7v+FRCsH7Kig=;
        b=Gjgz0xOh2X6o3HIDaq1mXQphOfZJRMHbcbIzOBr8lryNebSb5RgTXCURJAaJ0ER4Lw
         5MAF0lEqSMO5JLT0Y6IG4JmkJbs5cPC9sLanM5IRqJ9DMuzIy5YG5yMWQ2Fmr2Q9AU6U
         UGkS6gkpgPGG4nztrbm4xcqymiSZSSfREZOzCM3YL/vwvoqyoFxSwIkbypXne8DCyvBm
         6lyk+Zi22iMDMIWDVYXUDI3FqjSGetMAX9ewZX8Dc6n8m36ZYPXRKE9EOlTA6wYsVdWZ
         PBRFAP5b6IuoAQumxD1BiDCDrPLtxXK44CXdoowMPi1oLF+OJDND++UmJhzqCrDOuzEG
         qQWA==
X-Forwarded-Encrypted: i=1; AJvYcCUVpZRyW3mueo7j6donyt5+EjAMeab37I1WNSEeYgLDb+FPuNQ/FSl/ZKVkfscDBIqgf7dZgE/3f+G+IOCSIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYu/RVP3xJ4VfSAzuk4aCRm6N6sZk88SurMprEd/3wTw3LJciL
	TGxGM+8Zd26+Lq0EOLS12sYLwjER85IkkX8kF48M3bi4PND/9Bl+Bz99KQ==
X-Google-Smtp-Source: AGHT+IEE7JLeSI3B2+BaNE5hnyXLCVl6rzR29xUe6+pyEEx0p0sATrUexiG3bAAs5Ic/8j1Ajmdhfg==
X-Received: by 2002:a05:620a:4309:b0:7ac:e257:3b44 with SMTP id af79cd13be357-7ae37824064mr562846885a.13.1727438028658;
        Fri, 27 Sep 2024 04:53:48 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377bd791sm77535085a.24.2024.09.27.04.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 04:53:48 -0700 (PDT)
Message-ID: <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
Date: Fri, 27 Sep 2024 04:53:46 -0700
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
 <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
 <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/24 10:59 PM, Baochen Qiang wrote:
>
> On 9/26/2024 8:31 PM, James Prestwood wrote:
>> Hi,
>>
>> On 9/25/24 8:16 PM, Baochen Qiang wrote:
>>> On 9/25/2024 7:33 PM, James Prestwood wrote:
>>>> Hi Baochen,
>>>>
>>>> On 9/25/24 3:07 AM, Baochen Qiang wrote:
>>>>> On 9/19/2024 8:21 PM, James Prestwood wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I noticed an issue when we started putting ath11k clients on a WPA3 network which seems to be related to the fact that management frame protection is enabled (works fine on WPA2 no MFP). Immediately after an initial association a neighbor report request goes out and we get no response from the AP. After getting a PCAP in one case we noticed the neighbor report request went out unencrypted, though still had the CCMP IV parameter. The content of the request was the unencrypted request, and something like 15 bytes of 0x00 padding. I will say, this initial PCAP was made through the AP vendor so perhaps it
> how do you tell if the 'neighbor report request' was unencrypted? did you check the 'protected' flag in sniffer?
>
> automatically added the right keys to decrypt the frame, this could be a red herring. I tried on my home network and it was hit or miss, sometimes I would get a response but sometimes I wouldn't, but I did see the frame was always encrypted in my home network case though when adding the PMK directly in wireshark I couldn't decrypt it, where on other hardware like iwlwifi I
> and how do you tell if it is always encrypted?

I think what I saw here was because the capture was done through the AP 
vendor was automatically decrypted or something. The frame was still 
marked as protected, but I never had to add the PMK to get wireshark to 
parse it correctly.

On my home network when I was referring to "always encrypted" it was 
because the frames always had the CCMP IV and the content of the frame 
itself was not visibly a neighbor report/request, just a string of hex 
values. Once I added the PMK and decrypted it wireshark could parse it.

>
>
>>>>>> could.
>>>>> is your home network also WPA3?
>>> any comment on this query?
>> Yes, my home network is WPA3.
>>>>> and how did you get the PMK? is it generated by IWD and printed as debug message?
>>>> I actually had to modify IWD to print out the PMK after it derived it. WPA3 makes this a huge pain since the PMK differs between SAE exchanges.
>>>>
>>>> I've attached an IWD diff that prints out the PMK, which can be added to wireshark if that helps.
>>> Thanks, I found another way to do the decryption.
>> Out of curiosity how did you do this? I couldn't find any other way to decrypt WPA3 connections in wireshark except adding the PMK directly, even when capturing the 4-way handshake.
> I dumped the TK:
>
> 	@@ -2055,6 +2062,8 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
> 	        if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
> 	                goto invalid_key;
> 	
> 	+       l_util_hexdump(false, tk_buf, 16, do_debug, "tk: ");
> 	+
> 	        msg = nl80211_build_new_key_pairwise(netdev->index, cipher, addr,
> 	                                        tk_buf, crypto_cipher_key_len(cipher),
>                                          key_index);
>
>>>>>> Some time after the connection neighbor reports work fine. I'm not sure of a time frame or delay required that gets them working, but it makes me suspect that ath11k doesn't have the keys fully added in the firmware before userspace gets signaled as "connected". Running the same scenario on ath10k or iwlwifi has no issues. This neighbor report request immediately after connecting is IWD's default behavior, so its relatively easy to test by just restarting IWD.
>>>>> I captured a WPA3 SAE PCAP too, but only can find some unencrypted ADDBA req/resp frames. for those encrypted action frames I am still struggling to decrypt them
>>> I checked all the action frames after decrypt the PCAP, but still not able to find a 'neighbor report' frame. next will study IWD code to understand how such a frame is triggered.
>>>
>>> and again, if not possible to share the complete PCAP, can you share the individual 'neighbor report request' frame ? you can simply copy it in wireshark.
>> Immediately after connecting you should see one of two possibilities.
>>
>> 1. If IWD did not receive a response you would see:
>>
>> iwd[694]: src/station.c:station_early_neighbor_report_cb() ifindex: 6, error: -110(Connection timed out)
>>
>> 2. If a neighbor report was sent back by the AP you would see:
>>
>> src/station.c:station_early_neighbor_report_cb() ifindex: 13, error: 0()
>> src/station.c:parse_neighbor_report() Neighbor report received for xx:xx:xx:xx:xx:xx ch 44 (oper class 22), MD not set
>>
>> I just re-ran the test and now, for some reason, I am entirely unable to see the actual request go out. In the case of both ath11k and ath10k I see no request and but I do sometimes see a response. For iwlwifi I was able to capture a request/response but for the most part I don't see any request either, but always a response. Maybe the request is going out at some other data rate that my monitor card is unable to capture reliably? Not sure on that one.
>>
>> So as far as seeing a request from ath11k, I'm unable to get one at least on my home network. Getting a capture on the corporate network may take me some more time.
> here is the sequence I saw in sniffer:
> #1 AP send M3
> #2 station send 'neighbor report request' without encryption, though 'protected' flag is set
> #3 station send out M4
>
> is this the same with what you saw?
When I was able to capture the neighbor report request (rarely) it was 
after M4, not before. If you're seeing it prior to M4 that seems 
strange, unless the kernel/ath11k is doing some odd queuing?
>
>> Thanks,
>>
>> James
>>
>>>>>> Since the neighbor reports work fine after some time its not really a critical issue but I wanted to bring it up just in case.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> James
>>>>>>

