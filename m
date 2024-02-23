Return-Path: <linux-wireless+bounces-3966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDBB861756
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2A228D4D2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A57E796;
	Fri, 23 Feb 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7Ut2rW+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1E82C60
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704813; cv=none; b=e2vhPBQV0AB/iFoPhY8h4qqfQ65AjjETKN49dhszJvG5h5oNZ9IMmjoV7g0yyAr8Ptn4hjknB71mv+ueD+i/jQQnqwHlDY3sd4E4U29/AWgPPYAu/J9gfw1xk0teGAs2OdMa7OOKj1GSTVxa8GcaeFq3kd/E4N7SWgKepcwL7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704813; c=relaxed/simple;
	bh=uU2AiqAW6UC27Osn2auK9x2iqhtWTDxUZDqc/eVT9A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N27jB3rEe0fs0dp6SGV0OvQfx11ETUSVsMLaLKWWSc2uQMjKo63b37IyBM2kwIgexiwR3Qcv2WrVwe6wiv4wVqnb8zheNzkl4tUbirdk31V5UkWKequbUxRzhmv3aXVmzc1SbAK4oJ6qeTmvEsi9L+wEX1AmOAc96yRIQbmBnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7Ut2rW+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7810827e54eso70007385a.2
        for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708704810; x=1709309610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aINjorUzOodywEXZfg0nVueIK+OyFNiNfskoaDd89g=;
        b=C7Ut2rW+I7CRAqrnF8/3u67mdV7eK94/zFDuE7kUlNYKFxs/M2TyzU5MhwgmHXGwQy
         bJ8tWpWWYTMobELAxDBOF2pm+x4BQLu3WcHADJ9stOv0ABU0vPe95JTm5twdUAMXHktv
         J9n5yc/OPZhIjK/oGbcU+xaaZXRuSmdDphjzwo6Bkh5V4mxcSuIZ2DYCqOtMfYy2dUpB
         Gjf7UXrYz/aPjrAGuRFzypeI34HU2oPl3eWKbK2E577PdTduCTloyp8i7UViMywYDZ3w
         wqLtHWHQpzGKCxk+gq6FAekcSdrL14GuIfNDOePnYRgg3gMDIuRceX8KyR0Asst0I6EN
         xXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704810; x=1709309610;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aINjorUzOodywEXZfg0nVueIK+OyFNiNfskoaDd89g=;
        b=V4MgMM5oQvw3m/n03Kmgr8ym6FftQvuh3pxsaq+ANiHfAjBe0fmmvNsoAIR99TP9CM
         5K7n9dFBUfwaWgrGESI2aGOtUCuIgTosvcjJ+Laz1L9Y0z3lfbjHukX24dLPWiWtrXnt
         5vk1oW/cDfN4ZkS1LSpT5ILa1GkD7L8gQ9YArPU9csipOd5ImD0jBlK2b0l77w7KB5Hw
         6m46S9lz5ZPrGx+fGP5hg9EW3nJjvtN0ES6FTHxi3cMWBi0XY5eqdurFhgJUIVNmJChD
         7hPEDHnp7A1/byn3eE3KfzlTDLAh3WP7h9Qyo9QjjVDF/4L5OYcGrKgnLcUovytFhz4a
         wGNA==
X-Forwarded-Encrypted: i=1; AJvYcCVEX2pemv4jjzm7Lt3p+B4f4yx/Kbfz/uoiRbtHBVA6piRAOuWd76hkpWQMHhSOvxlBwswUvNh6WgPXYtaJdRY51e3kMeiZsJDJdITDp+k=
X-Gm-Message-State: AOJu0Yy9nMoUPK6XVphcNegn8J7DbtnEqLbo5Gl+YDCpq7uEZU1Biyo5
	d/agWXvVMWi1iyQmlBP8ysHFAUBJJqZbLXMbW5FIBOxsyssC0CHfeluzcMYY
X-Google-Smtp-Source: AGHT+IGqlviBHlDCdHrq5HRWGzCKI8tDSdcP+63u8he/GGEyPqbjgXiLHlzOXmBpkYAiBhKcv/zg+w==
X-Received: by 2002:a05:620a:2098:b0:787:2b1f:1c50 with SMTP id e24-20020a05620a209800b007872b1f1c50mr308988qka.52.1708704809794;
        Fri, 23 Feb 2024 08:13:29 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b00787bc6ebfa7sm74024qkb.60.2024.02.23.08.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:13:29 -0800 (PST)
Message-ID: <3cd77b50-f681-4b74-bdaa-6e2bd73ad744@gmail.com>
Date: Fri, 23 Feb 2024 08:13:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
 <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
 <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
 <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
 <026d9ba3-525d-4a12-8d03-5fece818330c@quicinc.com>
 <0e8ad2c2-cc39-4903-97f7-c3ffb525e61a@gmail.com>
 <df35ce71-84dd-4c2c-af9a-820cb9a71291@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <df35ce71-84dd-4c2c-af9a-820cb9a71291@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baochen

On 2/22/24 5:56 PM, Baochen Qiang wrote:
>
>
> On 2/22/2024 11:38 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>> On 2/21/24 6:26 PM, Baochen Qiang wrote:
>>> But you are using monitor mode, not station mode, on ath10k, right? 
>>
>> No I'm using station mode. It looks like ath10k creates a monitor 
>> device to receive these frames (that was already done before my 
>> patch), but the interface I'm using from userspace is a regular 
>> station interface
>>
> OK let's forget what ath10k does to receiver those frames for now and 
> focus on ath11k. From what I got from firmware team, it's expected 
> that ath11k station interface can't get those frame without a scan 
> because device A is connected to an AP already and is supposed to get 
> frames only from within the BSS, apparently device B here is not 
> within that BSS.
>
I still don't know why a scan would change anything. Maybe the act of 
scanning triggers something in the firmware to allow the RX of multicast 
frames (like to receive probe responses)? If so that's not really a 
mechanism to enable multicast RX, its just a side effect of scanning.

But yes currently when an ath11k device is connected to a BSS it will 
only receive frames from within that BSS. This is what I was attempting 
to change, allow it to receive multicast action frames while connected 
(or disconnected for that matter).

The whole point of DPP is to provision a new device. So one device is 
offline and asking the connected device for credentials. This is done 
via multicast action frames.

Thanks,

James

>> Thanks,
>>
>> James
>>

