Return-Path: <linux-wireless+bounces-21829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB861A95F36
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E3016982C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8623A9B0;
	Tue, 22 Apr 2025 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="dttW3+Md"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0923A9AC;
	Tue, 22 Apr 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306631; cv=pass; b=t9QQUTEuuqZ/mZpezbUTfQwtjlYm1wmCBmOpwOLJADunG1UkhmIMZqhL/YBoCHy4Q6iEzY+jGAa3kE7rA0NfP8x3hjGkH/qMd70TXW0/mbp3U07GPsm3i9tSX3hFE/DmhLrdj8WqWQS1IJPCGZebjh9m4CWOtKWcjP61xn+snb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306631; c=relaxed/simple;
	bh=qxGmdTUUVtRQJVs06CMIGU4NOobJU9B0mpBRWYFWtfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkW2gTOaJ/vIotDaFI/DNTxc0ggSbVPQOTaJDj/gmx6U7BcavCbwWqxLqgwPLTeTS3m9A4F+EoSOG/tvN2um2/E0LVjTm9aNnCn9R68YWWoVL/t1tR9XCj9FU823CDXThk7R2m8MpHkBd5bR4tNqzfFK8qAmlkE7PeIjShLQDeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=dttW3+Md; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745306594; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GDnCa7CSKWBHKjYhDVczW/mMrfcPwDU1sUCc0MevFwLUCvd4NcoPizYCU/6G5i/7F1JmaRyjNs0q62xdEWD0Fbxilbl92lJtTCh29hFbbnsNI+THuEFHEDjin4n4yhPm/MeMT2o3BTcgeRShq/P089tKsnEu/aBTWUJSM4MfeBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745306594; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=koqDyNKGQKcTOFROOVdPEIjL8A0vo5aApu1lGJhvNxs=; 
	b=lIUcwZorjEP0FfJneApPY7wNvpWFiSPlu1YzjMaC31fTenpjF8fjVq/upqZFfq5IYTl0DDefqhIGaG8oTAgX/t8/h38W1PQgUKkgC06/wKJujVMAH5XsXQXcQ3Mm7+ouhVZU/T1Gi2JZChF/OPDJfGGL04TjOUNU75ZOd3af7ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745306594;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=koqDyNKGQKcTOFROOVdPEIjL8A0vo5aApu1lGJhvNxs=;
	b=dttW3+MdHV0ZvUPfId1ImDLKbcLxB71yIt2cwy5XeOjHQ06D7N0gKM2wOpdpNtrJ
	UxuQYE2Ufy8xn+giIF7ZlZOXjvH76522qxaUeV1kyy+KAA5FpZ8C+L5uCvSfg9ov5uF
	rgsqCwePNdsMb3KLFsPc0NoYUj3Y7G4FnWsfaDv0=
Received: by mx.zohomail.com with SMTPS id 174530659195343.6404687687517;
	Tue, 22 Apr 2025 00:23:11 -0700 (PDT)
Message-ID: <1bf328cd-d301-4d1f-a8f5-7020d9e25ea5@collabora.com>
Date: Tue, 22 Apr 2025 12:23:01 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
 <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
 <e0159cb8-fe21-7f71-1ebe-744ed26bd698@quicinc.com>
 <85580a01-289a-461b-b0f1-38fa1b96717c@collabora.com>
 <1c0b2217-49d9-360c-ed60-db517eaf2ccc@quicinc.com>
 <7d6b074c-8499-4984-b235-d1285b006ab3@collabora.com>
 <ad5e99e8-3ff1-4727-aed6-528ac747f409@oss.qualcomm.com>
 <5dcf3ddf-6b0a-4b4c-b4a3-6e015a7e2f53@collabora.com>
 <822543a0-d7e1-4aec-ae1b-018b32985d1f@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <822543a0-d7e1-4aec-ae1b-018b32985d1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/18/25 7:08 PM, Jeff Hugo wrote:
> On 4/18/2025 2:10 AM, Muhammad Usama Anjum wrote:
>> On 4/14/25 7:14 PM, Jeff Hugo wrote:
>>> On 4/14/2025 1:32 AM, Muhammad Usama Anjum wrote:
>>>> On 4/12/25 6:22 AM, Krishna Chaitanya Chundru wrote:
>>>>>
>>>>> On 4/12/2025 12:02 AM, Muhammad Usama Anjum wrote:
>>>>>> On 4/11/25 1:39 PM, Krishna Chaitanya Chundru wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
>>>>>>>> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>>>>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>>>>>> allocation. There is a crash report where at resume time, the
>>>>>>>>>> memory
>>>>>>>>>> from the dma doesn't get allocated and MHI fails to re-
>>>>>>>>>> initialize.
>>>>>>>>>> There may be fragmentation of some kind which fails the
>>>>>>>>>> allocation
>>>>>>>>>> call.
>>>>>>>>>>
>>>>>>>>>> To fix it, don't free the memory at power down during suspend /
>>>>>>>>>> hibernation. Instead, use the same allocated memory again after
>>>>>>>>>> every
>>>>>>>>>> resume / hibernation. This patch has been tested with resume and
>>>>>>>>>> hibernation both.
>>>>>>>>>>
>>>>>>>>>> The rddm is of constant size for a given hardware. While the
>>>>>>>>>> fbc_image
>>>>>>>>>> size depends on the firmware. If the firmware changes, we'll
>>>>>>>>>> free and
>>>>>>>>> If firmware image will change between suspend and resume ?
>>>>>>>> Yes, correct.
>>>>>>>>
>>>>>>> why the firmware image size will change between suspend & resume?
>>>>>>> who will update the firmware image after bootup?
>>>>>>> It is not expected behaviour.
>>>>>> I was trying to research if the firmware can change or not. I've not
>>>>>> found any documentation on it.
>>>>>>
>>>>>> If the firmare is updated in filesystem before suspend/hibernate,
>>>>>> would
>>>>>> the new firwmare be loaded the next time kernel resumes as the older
>>>>>> firmware is no where to be found?
>>>>>>
>>>>>> What do you think about this?
>>>>>>
>>>>> I don't think firmware can be updated before suspend/hibernate. I
>>>>> don't
>>>>> see any reason why it can be updated. If you think it can be updated
>>>>> please quote relevant doc.
>>>> I've not found any documentation on it. Let's wait for others to review
>>>> and it it cannot be updated, I'll remove this part.
>>>>
>>>
>>> Wouldn't this be trivial to test?  Boot the device, go modify the
>>> firmware on the filesystem, then go through a suspend cycle.
>> I just tested this. I've used an old firmware from last year vs the
>> latest one.
>>
>> Firmware A: old firmware size: 5349376
>> Firmware B: new firmware size: 5165056
>>
>> A here has bigger size.
>>
>> 1. I loaded A at boot and then replaced the firmwares in filesystem with
>> B before syspend. At resume time, B was loaded fine by freeing the
>> bigger memory area and allocating the smaller one.
>>
>> 2. I loaded B and then replaced A in its place before suspend. At resume
>> time, memory was freed and larger memory was allocated. But driver
>> wasn't able to initialize correctly:
>>
>> [  184.051902] ath11k_pci 0000:03:00.0: timeout while waiting for
>> restart complete
>> [  184.051916] ath11k_pci 0000:03:00.0: failed to resume core: -110
>> [  184.051923] ath11k_pci 0000:03:00.0: PM: dpm_run_callback():
>> pci_pm_resume returns -110
>> [  184.051945] ath11k_pci 0000:03:00.0: PM: failed to resume async:
>> error -110
>> [  187.251911] ath11k_pci 0000:03:00.0: wmi command 16387 timeout
>> [  187.251924] ath11k_pci 0000:03:00.0: failed to send
>> WMI_PDEV_SET_PARAM cmd
>> [  187.251933] ath11k_pci 0000:03:00.0: failed to enable dynamic bw: -11
>>
>> So should we generalize above that changing firmware at
>> suspend/hibernation time isn't supported. If firmware package is
>> updated, does user restarts every time?
> 
> You may want to review how other devices handle this.  I can think of
> these threads as potential reference
> 
> https://lore.kernel.org/all/
> CAPM=9twyvq3EWkwUeoTdMMj76u_sRPmUDHWrzbzEZFQ8eL++BQ@mail.gmail.com/
> https://lore.kernel.org/all/20250207012531.621369-1-airlied@gmail.com/
They are talking about firmware cache which is not being used in the
wireless drivers. In my kernel config, firwmare cache is enabeld. But
everytime kernel needs to read the firwamre, it reads from the filesystem.

What can be the way forward for this patch? Assuming my previous
experiment with changed firmwares across suspend/resume failed, I should
remove reuse logic and send again?

-- 
Regards,
Usama

