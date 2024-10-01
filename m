Return-Path: <linux-wireless+bounces-13375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014498BD0D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1431F229EF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A9EEC5;
	Tue,  1 Oct 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlFQcKvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47894A06
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788004; cv=none; b=MQrrxj/XReq2cHgjrz8oE/T8A9Tt8SGwkpLVXgZ6GjDmArbHEd1WExUZLIs6z2sVORS9NwJ8Zf/vgRHE+M0yi5BqJgXUrZI96fjdkD0Es1X12nUlS/rNi1rhvF7YQh8vhsegZr8mHXZk1bzPpBsLrPzegNwNBTSZiKuHouK9Am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788004; c=relaxed/simple;
	bh=mUiwpp+YFTN5f/MqmVvzd+8Z7paLmmGrZW7v90xSyFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W51f0NRJo07AVQE20CCIYJ2o32mnFWF2p/FrVxWaXmj2t9ECsXKz0APp1fFDpstnGhGqKeWOmIH6rLNGOctFf8438kFjKHIfyAZss0aCW/DbqpUkzEHg6UfxiLy3CneIbq7fBDL9RUSAfYgva4ergjovyywhr3sSizxRPbCNE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlFQcKvL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e6299191so2944223b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2024 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788002; x=1728392802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUiwpp+YFTN5f/MqmVvzd+8Z7paLmmGrZW7v90xSyFQ=;
        b=HlFQcKvL2Y0ZfVAIwrStY2cA1+5/OZTgK+g+aReBZELQbMGfmZLHkZJH4P3vqN0Ges
         k5PnMGxa86MOnTyA/C5m8zn7Anhjq4+DEaxuqagnKhnvpq9zVE0MK4/bzitDlZ2G520N
         ISPFcM8q1fSJsUQvOKFoxBYMlK2ptllgR6wVACao3OPM5DYf+zPHUER9EF/2Zya4QuB+
         gONSwbaYyEsNliBnzJlD5BxblVLk+JdbZ6u+O2lvZk7GHmfhpHSblLgm1BqIfSrFQ58L
         HbBHbetfuFc3zesTtJRhGXNeiaKe9Yx+fp6i8IJ57B1MBH2VQxLd0LOdmfT5NxHCA2YD
         OytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788002; x=1728392802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUiwpp+YFTN5f/MqmVvzd+8Z7paLmmGrZW7v90xSyFQ=;
        b=gpDYd2wcpj/Wpm7SWqZdg4VOp9HBdx9880doc9aAfyocykT2nq1DgNG+gpahSszJvB
         kfn9DFXR18FuEMalJAq5IEbikJNTpPNz5AhzwGfbQ8+aZ+A0/WkbCyS3UGcFnGuE/cMm
         +cVhE6MH7HYPrO9M7QjOzkHqb8HGM+R3XptuOO76P6AvKkREM6SWZEI+iDBNrmz5MYds
         9THfbhBcyHPHdNM6es6+LhzMVUKI7JJ4AbZ3ivKS888i6SEsUrQsBxnYPZfp7xvziUq+
         qFRc0E53phrLlL5HyBiWWb17dzdSiuewi4JDg736O+s4pW9n2/gvEVCxjxYSEUknxib5
         HFWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+v/YbeeIVMo0h5xqypYlQ+2ctiTSOnvewEZisY5I5WQN4qyAygqDnUxDPUbEqSl+kCfofjDbmiuRL40/3Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYRl19q05XqSmQhmdmEIpHW8X2DL426zIoLfQ0c/H8GaRUb1b
	drzzU1cffH5ivEraxZXZXQMsuGS4vV5XkZf/B65iV6ocFaG+vne/
X-Google-Smtp-Source: AGHT+IHbXGODWUPOAFbdKrdNOhwteN0tT2k15ZEgihTJakWG+vneSmKLvmdXWEMRBXAnP/ZAq7okSw==
X-Received: by 2002:a05:6a00:4fcb:b0:717:85e2:28fa with SMTP id d2e1a72fcca58-71b25f853bemr15842439b3a.16.1727788001657;
        Tue, 01 Oct 2024 06:06:41 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db294ebdsm8137931a12.19.2024.10.01.06.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:06:41 -0700 (PDT)
Message-ID: <dfe29bc6-a8e0-4690-9aa2-b38a15ae1297@gmail.com>
Date: Tue, 1 Oct 2024 06:06:38 -0700
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
 <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
 <241fe825-991f-4dca-ad1c-e45f6a524edf@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <241fe825-991f-4dca-ad1c-e45f6a524edf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/28/24 7:14 PM, Baochen Qiang wrote:
>
> On 9/27/2024 7:53 PM, James Prestwood wrote:
>> I think what I saw here was because the capture was done through the AP vendor was automatically decrypted or something. The frame was still marked as protected, but I never had to add the PMK to get wireshark to parse it correctly.
> this is exactly what I see. there is no automatic decryption here, it is only because the frame is NOT encrypted, though 'protected' bit set.
>
>> On my home network when I was referring to "always encrypted" it was because the frames always had the CCMP IV and the content of the frame itself was not visibly a neighbor report/request, just a string of hex values. Once I added the PMK and decrypted it wireshark could parse it.
> is this tested still with IWD?
Yes, only with IWD.

