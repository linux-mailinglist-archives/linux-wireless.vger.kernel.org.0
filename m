Return-Path: <linux-wireless+bounces-12068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BE960D22
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E81F24400
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD21C4621;
	Tue, 27 Aug 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="rmQu0rt7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EF73466;
	Tue, 27 Aug 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767636; cv=none; b=nfECdMzfHrI37mapv8ahcc7SNpAATFqhvrE0jIW36MTuYcRWY2KDFJ0mnrb6Ouxq07bXZ1ScSzJmc6OYt/cQNTmoXNmLCZd5Wk/lLUF3x86D1MzNWbsjFJ6yWG4uYv0c2ngIVpvukqvJpGLvredwKMKA2e6u7mvyRIhxywHUHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767636; c=relaxed/simple;
	bh=BvTWNfqaZi3sKno+OEdrssKIAJOJKR8uvoVVAM/Y/EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqUXTScx20gwUpSfJCF2KY+OV0Aktj3GnJwPursgYK+HVM6cFxIIwrCJAJ/kvxuKl1InbTdkwycjmvohl/mBYXJIhaGzw4NfEethM+QMjXflFdaOLnO4+dbBAJ8KCb24gOEtk66HGvJXfjJ8x8MomjXAd9n6rrbpKYCnzfmmTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=rmQu0rt7; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1761B80067;
	Tue, 27 Aug 2024 14:07:05 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 684C213C2B0;
	Tue, 27 Aug 2024 07:07:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 684C213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724767622;
	bh=BvTWNfqaZi3sKno+OEdrssKIAJOJKR8uvoVVAM/Y/EM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rmQu0rt7ur9cDJlmIx0aS4/5muESJeFtgMmOadc/n5BAxnlW/OhB8KnJhMisu7dDs
	 sNyzRJ45eMTTc1dWUK4k8IPQhiHr2w7BYdc3H0e7xII4MDfMwsLT3Eg+HLfDsMedGD
	 JwxEFJPSRF+PPQPI8HDXs1JX72OMxGtFxrWTXKGo=
Message-ID: <c6b03c0c-7730-46fc-80d3-0c5d8dea4534@candelatech.com>
Date: Tue, 27 Aug 2024 07:07:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: acpi/dsm: cache error retcode for
 iwl_acpi_get_dsm
To: Kalle Valo <kvalo@kernel.org>, David Wang <00107082@163.com>
Cc: miriam.rachel.korenblit@intel.com, johannes.berg@intel.com,
 gregory.greenman@intel.com, pagadala.yesu.anjaneyulu@intel.com,
 dan.carpenter@linaro.org, daniel.gabay@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240827005114.4950-1-00107082@163.com>
 <871q2afplp.fsf@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <871q2afplp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724767627-EBOlna--rhvL
X-MDID-O:
 us5;at1;1724767627;EBOlna--rhvL;<greearb@candelatech.com>;6bc33b0a102533f075ec50fd94efbfef

On 8/26/24 23:26, Kalle Valo wrote:
> David Wang <00107082@163.com> writes:
> 
>> On some HW, acpi _DSM query would failed for iwlwifi device
>> and everytime when network is reactiaved (boot,
>> suspend/resume, manually restart network, etc.),
>> bunch of kernel warning shows up together:
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>>    ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>> since iwlwifi would make 8 acpi/dsm queries for lari config.
>> But for iwlwifi, it is safe to cache the _DSM errors,
>> since it is not possible to correct it without upgrading BIOS.
>> With this patch, those kernel warnings would only show up once when
>> booting the system and unnecessary acpi/dsm queries are avoid.
>>
>> Signed-off-by: David Wang <00107082@163.com>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>> index 79774c8c7ff4..3f98f522daac 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>> @@ -30,6 +30,8 @@ static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
>>   	[DSM_FUNC_ENABLE_11BE] =		sizeof(u32),
>>   };
>>   
>> +static int acpi_dsm_func_retcode[DSM_FUNC_NUM_FUNCS] = {0};
>> +
>>   static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
>>   			       acpi_handle *ret_handle)
>>   {
>> @@ -169,6 +171,10 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
>>   	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
>>   		return -EINVAL;
>>   
>> +	/* If HW return an error once, do not bother try again. */
>> +	if (acpi_dsm_func_retcode[func])
>> +		return acpi_dsm_func_retcode[func];
> 
> Static variables are usually avoided because they are problematic if
> there are multiple iwlwifi devices on the same host. Should the error
> message be just removed entirely?

In this particular case, probably static would be best since it would not
be helpful to see the duplicated errors for each individual interface anyway?

But also, I'm fine with just making the warning go away entirely.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


