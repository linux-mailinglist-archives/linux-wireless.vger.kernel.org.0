Return-Path: <linux-wireless+bounces-13601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E396992C8A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 15:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57661F23919
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3E1D271F;
	Mon,  7 Oct 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2cRpbQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEE1E519
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306371; cv=none; b=GeYSc4z+GdpH8rn5mgWsIg7NYptL5AisCd33szoRiyUpA7b5896WSOr5rUU+U4MNjdsXKIdcN53GtA3pZsjWLT82bSyvsUMb9Kq4nnFNEXnaqWtoMl0ekx/edjrrmg8PWytFtJfyqbWTiQu8HTtyuuNCrGWyFngc07317sSigO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306371; c=relaxed/simple;
	bh=Yun7qgQTsJz2BzI3VjEUKoPV09aMuVzK6eBZFCNekvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD6r8JMUdsLoXppjpkAkUhoH3Pmm6vW0w0INXrnuVWoL0ViyE4tHyvTzCO9dXl4bH4QfvsyIgNnKElCQMPRVCBhhx3Mmu+T67OOJkjAswHFL2xXJceB0gPA1Pz44aPRrMy8CuSNjmstuQc0A1Hkox2X9NxJ3x1NhqIXcNQtn96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2cRpbQ4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71dfc250001so1048076b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728306369; x=1728911169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVbc7x7qGxvPs4q2XtOSLgTK7eiawW+8HJ7G1mC5t0I=;
        b=B2cRpbQ4FpgZ35n8lmeh2jyI6VsTFML+x+dCe6ixgQMuLsfjvHuMSFCfRhxGYTO68p
         3iqb7fmqY8V+8z+BDg4SIkG13+NGv3Mnlwe/Ha8amHAE9eE1BN/WDIQ3cNP0eZ0n61TI
         BVBzaY4miNULO5f7UaY8noHJGUde6EuHa4UoTWW6y66nNmRW8DE5V0GmPKykzeNLrNTb
         nvmB4llymtiBi7/cSpsRcjvDqcZXwptxdRfoI7DmdkZXlq1ztzURbH6KSwhSI9l11i6p
         6+XYrAeizOVLKTJMa8XI/VBSMpZuthAoCakC6QCJ0k17AKNGscWiVIxcxviaGCy4TP9G
         fAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306369; x=1728911169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVbc7x7qGxvPs4q2XtOSLgTK7eiawW+8HJ7G1mC5t0I=;
        b=Zl9f/rNk4q7pXB7ac66TIC6wXkJU3EYBJ4Fq3r+EwMzC2igeoTHpuT4exxrw5TJDl0
         +kNpX7QomWM6OKpi/TmJSRiuSHUFRW6IK4grqs4A+9pfzD7edArQElnJo8AFs8499+cr
         qZsDN7mQ0Ld8ELpYsNdgMbFDVQhUfGCxy47FkM0h/PecsokXwsG/VhDldWl5AKYupNSl
         3e0iKii9mKgIY5RKwMCKyR++dRSCJUsAOhBiWuppGORD/xIKaVwuwfElohPco54mMtsA
         KwxqTDvtkCigJTcm6V/nFfla/dN4CrYmwWIQq1B0erAEBHrGXzeUIWENaqfRnmvIDACB
         zH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+BoCEZUCgSNDt2WQ/94R9mVGsPiwvbG1jpr0MA2JWTEDtSdaSCnN4KTXDDTV83h7yZ9FGht0hrOfVw20JcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyeyiat0z8AKO3fHewt93t8jXaf9tNCdLGvS7QwsX3nQprNv8h
	1J2gDkP24aQSYvFw9FVeD4Lk4qxZGQb9z/zeYQzP0kJC7qOwbCEHnx0wWg==
X-Google-Smtp-Source: AGHT+IEBokp742xlJXBM+MooOnnuVX8tXk84A4LTmcw9Fd7Zmd5xB+kiCRAuVzfGh9bR6h1QzdaIRQ==
X-Received: by 2002:a05:6a00:1893:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-71df510bbdfmr1864578b3a.12.1728306369364;
        Mon, 07 Oct 2024 06:06:09 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f681f1e8sm4197232a12.28.2024.10.07.06.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:06:08 -0700 (PDT)
Message-ID: <4ce007ef-5a5e-4403-b53e-fe13513f21b5@gmail.com>
Date: Mon, 7 Oct 2024 06:06:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing scan results with SCAN_FLAG_COLOCATED_6GHZ set
 (Ath11k/WCN6855)
To: Ben Greear <greearb@candelatech.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <cfb00919-678f-408d-9fb9-83fc24fee197@gmail.com>
 <d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben,

On 10/4/24 12:18 PM, Ben Greear wrote:
> On 10/4/24 11:46, James Prestwood wrote:
>> Hi,
>>
>> I've noticed that when setting the colocated flag much of the scan 
>> results are not appearing when they should be. This was seen in a 
>> large warehouse where our network/SSID was using only the 6ghz band. 
>> There were other networks on 2.4/5ghz though, which maybe is having 
>> some effect, but those networks are not broadcasting on 6ghz.
>>
>> This first came to my attention when the majority of our clients were 
>> experiencing horrible signal quality. Upon looking at the logs and 
>> nl80211 messages to the kernel IWD was issuing both limited 6ghz 
>> scans as well as full spectrum scans and only showing a few 6ghz 
>> results, like 1-2 BSS's which should not have been the case. I was 
>> able to scan manually using "iw scan" and I saw all the expected 
>> BSS's. I isolated it to the fact that IWD was setting the 
>> SCAN_FLAG_COLOCATED_6GHZ and removing that flag resulted in all the 
>> BSS's showing up in scan results. Note, that with or without the flag 
>> all the 2.4/5ghz BSS's were showing up without a problem, it seems 
>> completely isolated to the 6ghz band.
>>
>> The NEW_SCAN_RESULTS event was indicating the kernel had scanned all 
>> the expected frequencies we were asking to scan, but the results were 
>> mostly empty for 6ghz. Only ever the connected BSS would show up and 
>> _sometimes_ another BSS, but generally not.
>>
>> I'm trying to read through the code associated with the COLOCATED 
>> flag, but its not exactly intuitive (to me at least). I'm not sure if 
>> this is something with mac80211 or at the driver level. I really 
>> don't have anything to compare it to as ath11k is the only hardware 
>> available at this warehouse with many APs around.
>>
>> I'm looking for some guidance on if this is expected behavior with 
>> the colocated flag, and if there is any concern with including it 
>> unconditionally on every scan. If it has unintended consequences like 
>> this, generally, across multiple drivers I'd like to re-think its use 
>> in IWD.
>
> I had some similar issues using hostap, and hacked it to do every 4th 
> or so scan with that
> flag set differently.  Hopefully that lets the 'fast' scan work when 
> it can, but still lets one
> scan the hard way...
>
> Possibly there are driver concerns too, I was using Intel be200 when 
> debugging this.

Thanks for the extra info. Seems like a mac80211 quirk if its also on an 
Intel card. Long term I may just parse RNR elements in userspace and 
issue extra scans if needed.

Thanks,

James


