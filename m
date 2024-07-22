Return-Path: <linux-wireless+bounces-10435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EDF939435
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FA72820D0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8D16F909;
	Mon, 22 Jul 2024 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7tJp2Lp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA917C74
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676490; cv=none; b=HEqSy9ZdJzDMB3Gk2F/J9GYdws29XE/2eLFF/3jN4ygKbP2drX8HX+wbVIuhZ2hZqwakyGhd51von0S69Fw+dMvTrwIQo+L8gzZQpQtx9tfslnd5TkgAvLny9G4+xsxaWab6NsKETjAf1GufkJ6WxTs2yaSt0HQvzJgMGOsB/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676490; c=relaxed/simple;
	bh=AoNRmn1q+k2A+IQJxMbdDvvliNvhCmgAv5nlYwOOIug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XNm5lSiM/upvEtLPdTjK4D09oJx5FYHaVx6uYjJZPHN8Lg3M8YGs+OrW0hHCWM/atrWy7L0gjSPpXuh19ICpUpP8HlrDYqaFcL4SGi8Uc5nRgzz39EYW6nSwwEHSJKDOfgcR7YYUROjTeeuZE3YcQhhMOHJxEE2CYNt9QgGtkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7tJp2Lp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79ef7ecc7d4so265649885a.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721676488; x=1722281288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C6s3wWqOZtpEVgXLSBWbU5EfnxGRL76gFc48fTCghN8=;
        b=T7tJp2LpYwxwKv2oQ4sUmmCDX89U5N4LusMuwQBfdMAoue09llKhwrhINLdZVbcgIy
         gzXOD1s66KBkR/M1+YqKjCs08DjZIQlTxFQM+66VcszVKSbatHhcqiTVggedoMswmppA
         JgNNyRbAiXNW8X0TVfUm437tR5pVClemkD7I/yXMkK9/JvDmsDFPhW8n2GZnfqqRU+tL
         ECgAwTn2CfjPHZ3BKNSMAY2+uAZ2xScrPqVjUqAg10C2iU8FeSwDqAUeuBhqm1JxyPpM
         40HAUTEo2Tu03DNNjwnTUv/LqRXtJ23kzNanKuDUwsV4o4r2ylZOynshig+jFsvQ6AlS
         K/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676488; x=1722281288;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6s3wWqOZtpEVgXLSBWbU5EfnxGRL76gFc48fTCghN8=;
        b=n6bddREY5CbWDNdSeMN/1BPtffQuly45tIKAOcwNChW39kxEicI63Zf6pEnO238JQz
         zjGM30MUlnXcYxQRqRlLlonPr3NCfaDpmSLnylWEeKIKUl4mnWLnC/aej4PFGyCRuXzK
         3OAhRJirR/M4fVqL3WbdfnJQGKbS0LJ6ZBBZTKmsbn+aqrmPqtFszMGmIRBjvR3t0sC8
         0kLHsiKZc+XfRIH1XIhV5Q25ekQcYRpDEmbRoS57+q42WRnQQP6vvtjiF/ueO8ISjzXW
         lS+TpIIdDOCaczFSuKt6agSMtY5oqjtz4/DDixyzI7cpmewbNBfWA1uc1likHgPGEjrG
         CmGw==
X-Forwarded-Encrypted: i=1; AJvYcCWvERqxJp4V+L1X/oSaNqPfcS4sF8bIlYT69pQ5iaAGfSBMGgJ7f71eZaa5RSnu/WTkPeHZS5+V1bSosKZ459rWutijzwXilqk+S2uqS5o=
X-Gm-Message-State: AOJu0Yzk767wl7pTge1gAQidDv7/6bfJsOdJ+GlktlnE+gRTUIkfNs35
	LSAvr3Dlt3gtuWfkzzbcL/eSxv5Nvx7IVRIre7amnqG0quDGsMYO
X-Google-Smtp-Source: AGHT+IE+REJU4tj3eLbpjGs3VEZ0vY6/I1jdPxro3tXhs+eIRy20XIs8wb1+p/Ae2UTgcj9WwHIQEw==
X-Received: by 2002:a05:620a:40c2:b0:79f:181e:3c58 with SMTP id af79cd13be357-7a1a1343fe9mr1095159585a.42.1721676487838;
        Mon, 22 Jul 2024 12:28:07 -0700 (PDT)
Received: from [10.100.121.195] ([50.170.153.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fba365sm391277085a.28.2024.07.22.12.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 12:28:07 -0700 (PDT)
Message-ID: <70365e83-72c6-476b-bd9a-33f7ea3c8a31@gmail.com>
Date: Mon, 22 Jul 2024 12:28:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
From: James Prestwood <prestwoj@gmail.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
 <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
 <6e8fe8cf-315c-47bb-b8db-5b17f7323109@quicinc.com>
 <347dce6b-94c6-4aa3-89ef-25525b4e72db@quicinc.com>
 <d9788e11-b804-42a1-8074-3646e01d8d4d@gmail.com>
Content-Language: en-US
In-Reply-To: <d9788e11-b804-42a1-8074-3646e01d8d4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 4/16/24 5:50 AM, James Prestwood wrote:
>
> On 4/11/24 1:00 AM, Baochen Qiang wrote:
>>
>>
>> On 4/1/2024 11:30 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 3/30/2024 2:39 AM, Jeff Johnson wrote:
>>>> On 3/27/2024 9:25 AM, James Prestwood wrote:
>>>>> Hi,
>>>>>
>>>>> This error was brought to my attention in the kernel logs and I'm
>>>>> wondering if it is of any concern:
>>>>>
>>>>> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
>>>>>
>>>>> It seems to happen every few minutes or so. I don't notice any bad
>>>>> behavior associated with it per-se, but maybe its an issue of some
>>>>> buffer needing to be increased in size? Does this mean a frame is 
>>>>> being
>>>>> dropped due to no room to receive it?
>>>>>
>>>>> Hardware we are running is:
>>>>>
>>>>> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
>>>>> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb
>>>>> board_id 0xff soc_id 0x400c1211
>>>>> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e
>>>>> fw_build_timestamp 2023-12-19 11:11 fw_build_id
>>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>> Hi James, I was not able to reproduce this issue so wondering if you 
>> could help reproduce and collect logs for debug. If OK please first 
>> merge the debug patch which is available in patchwork:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240411074812.86700-1-quic_bqiang@quicinc.com/ 
>>
>>
>> Please also enable full ath11k log:
>>     modprobe ath11k debug_mask=0xffffffff
>>     modprobe ath11k_pci
>>
>> Once enabled you should see lots of ath11k logs.
> Thank you for looking at this. I'll get these changes in to test but 
> it may take me some time.

I did get these debugging changes onto a client to test but had to 
modify them twice now due to a massive amount of logs associated with a 
few of the prints. The first iteration was using an info print in quite 
a hot path resulting in the logs filling up with:

kernel: ath11k_pci 0000:02:00.0: ath11k_ce_completed_recv_next: pipe 2 
rx_buf_needed 1
kernel: ath11k_pci 0000:02:00.0: ath11k_ce_rx_buf_enqueue_pipe: pipe 2 
rx_buf_needed 0

I then downgraded that to a dbg print, rebuilt, and now I'm seeing tons 
of these:

kernel: ath11k_pci 0000:03:00.0: dst get next entry failed
kernel: ath11k_pci 0000:03:00.0: dst get next entry failed
kernel: ath11k_pci 0000:03:00.0: dst get next entry failed
kernel: ath11k_warn: 367 callbacks suppressed

I have downgraded the "dst get next entry failed" to a debug print as 
well. Just to get a baseline and see if the "failed to enqueue rx buf" 
message is even happening anymore. I may need some more guidance here 
because I don't think I'll be able to enable any kind of debugging 
without the kernel logs filling up immediately. It may be difficult to 
even see the "failed to enqueue rx buf" failure with a debug mask of 
0xffffffff and the changes you suggested.

Is "dst get next entry failed" anything to worry about?

Thanks,

James

>>
>>>>>
>>>>>
>>>>
>>>> + ath11k list to get more specific eyes on this issue
>>>> + bcc to internal list as well
>>>>
>>> I will look into this.
>>>>

