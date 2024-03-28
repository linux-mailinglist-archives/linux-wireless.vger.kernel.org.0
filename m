Return-Path: <linux-wireless+bounces-5465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66C890204
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34611C2B98C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383371879;
	Thu, 28 Mar 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4dnSIty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423B7E10B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636632; cv=none; b=sg0UckN+FYla4iMgAsEXpUYit/HUyQuFEAvF/wtbeyyITGY+XkZyXIel04EgI/GfP9/WtWDmGdzdAyRncHADcWxHT9IC1svC9y8DEO4L8SM8yEZOiP7Uk3MkKhmpWVKdv3cCDUmNAi0BEC7lwl4PbJSLdDfh09HBQf3dnJbtnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636632; c=relaxed/simple;
	bh=fRvSEwiU9Qtn1aRBX426CuX1lODY99pyBvoas4OS/eA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=hTQV2qIuy/tOuMh/9xddB0cPV4Nx6FbIouyb0ltwONcQsbjss6OxutHygA4a5rwtFdyj6xgncA0wPVpTPeSRaLY2mNI4cqrdqzxoCf4kFj1kge+TymbS9+ojj27pq/+rku+bDMY5FiDbRjP4deOvqwjexnFRAig93JhT3eoOezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4dnSIty; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1404047b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711636629; x=1712241429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=627mkCdVGao7oDK8Ssw4iDjUepk9Kg1HbgzRtecPuMc=;
        b=d4dnSItyrw5Z35tPb14kobTky2YHI3SgaWjADl2Qm1fQN9OTa/L98DXUuOrLwd80Vr
         ddYrtWzfuHzJNEVNSzlolIW2eZd1F4heBpNeAadiTF4MID1KShhyTgMFWQw4Wvj+WGcl
         lGCM7ZLEMeiM+wAmaXmlvKYsoic68JAuxYm25mNl9EVXvt2bWYyy3xxOsjoL2zS0Ffsn
         OBfkwZ8I7amJK1572MF4RLhW1IJN2z+0Wf23WghkAYqTyxhpWavIlUKBWLxHQw2m7x93
         kQfI0D7Ba5NLuxwc0f5oqMoynmapsZz7A81SzXC6AoM7zfu7VMlV66nQenGeaZI2kCmG
         GKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636629; x=1712241429;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=627mkCdVGao7oDK8Ssw4iDjUepk9Kg1HbgzRtecPuMc=;
        b=t5WJ7E5kUuq1m+UTWZdj8f4P7hVzbzSywXzTjZKBFD9Uea7F33WnK7ymSStL20srLb
         NMvNVAiTwX85bufNb5/ejISeAz05Ba64lXequgbLF6mn6eQrBUrD82Zmh76wEHZpkOhV
         t2aN1e41hg84DDcm8UJNAh4ZKpCr/X/qvbqmt26aW6B1lnpUllEWCj+lEhbT0XqM/g+n
         sIg/aGU8z2hXoQhvISP/ViQFJxqqyROX1T4KelpPR1ROz5fT92oYl4/wgsT8w3eFeCIr
         QkYmvhYLkdORmFi4yAZIWSNYv29Lr3vWHrUnhXXG8XhfNp/buEMIN0mjU+4jEKWEtlOD
         ALOA==
X-Gm-Message-State: AOJu0Ywpgmo6PQLDa2Xy/F6diFZMDtSRaO4ZMogKOgnitz9StGQowgmp
	ZIh2EKIIK11Ho8FIjJ3I4fKMPOaQ458/UGSGTxKsK7b+khg+oJ/5BkLJ6rGd
X-Google-Smtp-Source: AGHT+IG6QHQI1QO4neaXgDVm+rE1f9V/zg1wj8Y2RJDezlfk4u6wZ9fdMUFm2NR4OZgmVDeMoxbEMQ==
X-Received: by 2002:a17:902:dac3:b0:1dd:1c6f:af51 with SMTP id q3-20020a170902dac300b001dd1c6faf51mr3618780plx.16.1711636628657;
        Thu, 28 Mar 2024 07:37:08 -0700 (PDT)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001e0c956f0dcsm1643887plh.213.2024.03.28.07.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:37:08 -0700 (PDT)
Message-ID: <e458216d-b389-4abd-a9b2-90525ea10a8d@gmail.com>
Date: Thu, 28 Mar 2024 07:37:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
Cc: ath11k@lists.infradead.org
In-Reply-To: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ CC ath11k

On 3/27/24 9:25 AM, James Prestwood wrote:
> Hi,
>
> This error was brought to my attention in the kernel logs and I'm 
> wondering if it is of any concern:
>
> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
>
> It seems to happen every few minutes or so. I don't notice any bad 
> behavior associated with it per-se, but maybe its an issue of some 
> buffer needing to be increased in size? Does this mean a frame is 
> being dropped due to no room to receive it?
>
> Hardware we are running is:
>
> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb 
> board_id 0xff soc_id 0x400c1211
> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e 
> fw_build_timestamp 2023-12-19 11:11 fw_build_id 
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
>
> Thanks,
>
> James
>

