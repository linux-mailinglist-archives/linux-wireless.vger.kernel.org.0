Return-Path: <linux-wireless+bounces-6397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065238A6B71
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F1B28475D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0C12BE8C;
	Tue, 16 Apr 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnDLFkOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44806BFDD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271827; cv=none; b=IxNw0Wd8T1yZkC13NGWDC5XkfJNX5D8nXpTATMDA7ko3YZq++Qqo0mgRZR0iDumCE0iQnmNI2X6yKy4n+4gORRqGDX6OhSqJ1O8QZMHzF4MeMNQYrWO7nniCmPW4jUm88JRFakRIpc74hdCb+EtZ7fiTVGBqcAtIy4dnxVlHyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271827; c=relaxed/simple;
	bh=QsPs60QrR/NJi+PpximKUyGXiGUK3mOV26RSuEUF7So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDU4zcrt1PJJ1srx0SuVMjCT7At6vaH4Cvb2Yxo/ZdE4RJZ4MAYVq2SdD7qcl1OnOfhQgv3cWIJDP9+f3JyLFyFlWxbJT0dhqTnXZxnGrU5ODV+X7j7b7m1Mo0R8hWq3/4ShTiYhM0wnw98UOf9hCbz6neXb+7ZbWW3IEZshxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnDLFkOt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78edc3e80e6so216478585a.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713271825; x=1713876625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbLGwITuEtblOKj7PN81xTUn9EbuXq4z1YxI7bfyEy0=;
        b=WnDLFkOtXtR3phxJHAwqEhZP+nb4P7bdDGRzUEuyiLJKTJ9iAvXiNMDaTWk8aYjgHf
         6Z6xK8kWoRZ1l+ZUCuVqu1SuzhdgODf8ciTHHDqDD2VC0zKRlplwiW3EqqU4ZQQzuGYk
         zc2UJt0QWJLVEtrf3uDCISqa3dPwanuSHKXFyR1KhNxZwMqbv52E2pGB43Ml8Q/08hGZ
         kY9lZEKjy+ZHZPUPZyGApIMuApJKPA/DxQ2Jz9jY7kOF5rswA4JdHct7ExZtX4sPTeip
         NgyQ8bCkuXhe2SmtCZvg5rpsN1bDMsttBf2FO8GN5EgWiPlCHGlXi+J7vp/ufIlyX2ux
         +I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271825; x=1713876625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbLGwITuEtblOKj7PN81xTUn9EbuXq4z1YxI7bfyEy0=;
        b=JSs3BPBEHy5cT90O9KORLclBEk+wULy2Ypfj/HFdx6LeUZqm43CnA3hJ3LMqMFdfaz
         BUQZ6Nc5tWDW8oQo6kebrn37fErGxOTPiiRRhuRJp3/JVJ8z9uTqsGnN+1M9+/u82PyM
         WN7Qkugp3f60jbV1weUmpoaOoWOb+FEX3lp0q+884BIZThkyFiEamJBYLc8OpL5GRfNl
         6w9Rx7+lm8/5tXLIqcjB9SP2y64ccLRloqphNnZB9UJFn20nDlGahuJcAdyZkSLi7dGg
         hU4E4ulP9kj5BDfZgd2vd0E27XjBXokvrwv8GiUBk0yzl9kYawdi/wyxF4TstRr9aLba
         Z6SA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWPvZmp4HjCSnJjkUshwJmvghpTQRvixjpnT9fdHqlrEvyKdqSO1K4OquqsFVroOh7wuIJ85QYUyCVawVZcCThVELtjMOrP0NM7ISuic=
X-Gm-Message-State: AOJu0Yx9s+cpk4aPu8xLPZ6+i0OENoGAot/6d6oPKp7g94BoD2RnVziU
	iLRd1ssGf9whV6oxSjTQoBavn7DvsnHYOhmKT7IdfZ4dYZJbX+2dctoG7g==
X-Google-Smtp-Source: AGHT+IFJKKC9Ww9D6e212WG1c66Tea5jJjCW/EvP9ATviThjFFhz9pX7/bogm/nLARbPSo9CVHaCRw==
X-Received: by 2002:a05:620a:1a04:b0:78d:777e:bc11 with SMTP id bk4-20020a05620a1a0400b0078d777ebc11mr16867267qkb.38.1713271824600;
        Tue, 16 Apr 2024 05:50:24 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05620a1a2500b0078d6b2b6fdbsm7458352qkb.133.2024.04.16.05.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 05:50:24 -0700 (PDT)
Message-ID: <d9788e11-b804-42a1-8074-3646e01d8d4d@gmail.com>
Date: Tue, 16 Apr 2024 05:50:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
 <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
 <6e8fe8cf-315c-47bb-b8db-5b17f7323109@quicinc.com>
 <347dce6b-94c6-4aa3-89ef-25525b4e72db@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <347dce6b-94c6-4aa3-89ef-25525b4e72db@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/11/24 1:00 AM, Baochen Qiang wrote:
>
>
> On 4/1/2024 11:30 AM, Baochen Qiang wrote:
>>
>>
>> On 3/30/2024 2:39 AM, Jeff Johnson wrote:
>>> On 3/27/2024 9:25 AM, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> This error was brought to my attention in the kernel logs and I'm
>>>> wondering if it is of any concern:
>>>>
>>>> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
>>>>
>>>> It seems to happen every few minutes or so. I don't notice any bad
>>>> behavior associated with it per-se, but maybe its an issue of some
>>>> buffer needing to be increased in size? Does this mean a frame is 
>>>> being
>>>> dropped due to no room to receive it?
>>>>
>>>> Hardware we are running is:
>>>>
>>>> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
>>>> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb
>>>> board_id 0xff soc_id 0x400c1211
>>>> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e
>>>> fw_build_timestamp 2023-12-19 11:11 fw_build_id
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
>>>>
>>>> Thanks,
>>>>
>>>> James
> Hi James, I was not able to reproduce this issue so wondering if you 
> could help reproduce and collect logs for debug. If OK please first 
> merge the debug patch which is available in patchwork:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20240411074812.86700-1-quic_bqiang@quicinc.com/ 
>
>
> Please also enable full ath11k log:
>     modprobe ath11k debug_mask=0xffffffff
>     modprobe ath11k_pci
>
> Once enabled you should see lots of ath11k logs.
Thank you for looking at this. I'll get these changes in to test but it 
may take me some time.
>
>>>>
>>>>
>>>
>>> + ath11k list to get more specific eyes on this issue
>>> + bcc to internal list as well
>>>
>> I will look into this.
>>>

