Return-Path: <linux-wireless+bounces-29723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53281CBA36F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16E653012449
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3D2EC55D;
	Sat, 13 Dec 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9iT+SGl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EB23E340;
	Sat, 13 Dec 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765594209; cv=none; b=WT6PCQPjOUSuYf++22D1cvn9lbuVYkLqI7Hu1VnhgqkeStX+gZ9t+ZV8FFDE1vVHRYeVSFye8k1EreXTXNfJmTDzWUOPnkW/GAbN/4Z5G5iDjYX6INHgFkdWGK9xDv0YEgcuL+vDeRGXQ3D3dE8VwPnew44zlF8+la2jbwaoipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765594209; c=relaxed/simple;
	bh=3jOIG/uBAXX9Tf3utTWvIsFwIK6BnzDTtVJEWQ5Bevk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHZldFdXty56G9dJ/p5okHK8w/HVk24UlsnVUyl2/ZYeju/qN7S1fDiHeKRyykvMpOJnebrgujAUFXJ5WlY6Bfard0XM9ppDHnBzALorHdDnV+d9fdKrc1Xti7Sem3WSVxYWfGZTA3mceMzHcutE9R+7Ae7uOW8BTKz/f65+jGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9iT+SGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B0AC4CEF1;
	Sat, 13 Dec 2025 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765594204;
	bh=3jOIG/uBAXX9Tf3utTWvIsFwIK6BnzDTtVJEWQ5Bevk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e9iT+SGlfCdBnQIerC3vz9B0Sl55FVpjjAxSdcy2rX9+AMzAmMSdsXXALHVqhJvC1
	 xQqWit5Cuc83HWVa7TWyiM+vctaBtUhhs+rxg/DVnR4e1iesIl/OEZo9L473jwaxzD
	 UqHvownywFDvBuqxP6zI7ArnCiVfVgpiucvDJn6Nr6d92AA7iIb0gCm6fHyqbTRfKy
	 GYaaKNnZAKMBrpI0d/IlFqLJqTFznqHxF7R5BvpJrYon4HimFw9oy2KporchywxMvf
	 p9S6b/xoTKI5oaYOazYl9IR8ieD1Yd18SNz2vMVk8aqLzQ14z30+ch0+fnfK5hDVYv
	 19qDYUIZnm1bA==
Message-ID: <191da5b6-209f-4615-b111-40b98687c705@kernel.org>
Date: Fri, 12 Dec 2025 20:50:02 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in
 mt76_connac2_load_patch
To: Eric Biggers <ebiggers@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
 <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
 <20251213023539.GC71695@sol>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251213023539.GC71695@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2025 8:35 PM, Eric Biggers wrote:
> On Fri, Dec 05, 2025 at 09:12:02PM +0500, Mikhail Gavrilov wrote:
>> Commit f804a5895eba ("wifi: mt76: Strip whitespace from build ddate") introduced
>> a kernel panic/WARN on systems using MediaTek MT7921e (and potentially others
>> using mt76_connac_lib) due to an incorrect buffer size calculation.
>>
>> The error logged is:
>> "strnlen: detected buffer overflow: 17 byte read of buffer size 16"
>>
>> This occurs because the field 'hdr->build_date' is a fixed-size array of 16 bytes.
>> The patch allocated a 17-byte local buffer 'build_date' but used 'sizeof(build_date)'
>> (17) as the read limit for strscpy, causing Fortify Source to correctly detect
>> an attempt to read 17 bytes from the 16-byte source field.
>>
>> To fix this, replace strscpy with memcpy, which is appropriate for raw data
>> copying, and explicitly use the size of the source field (sizeof(hdr->build_date) = 16)
>> to limit the read, followed by manual null termination.
>>
>> Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
>> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index ea99167765b0..d2c4c65ec464 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -3125,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
>>   	}
>>   
>>   	hdr = (const void *)fw->data;
>> -	strscpy(build_date, hdr->build_date, sizeof(build_date));
>> -	build_date[16] = '\0';
>> +	/* hdr->build_date is 16 bytes. Copy exactly 16 bytes to the 17-byte buffer,
>> +	 * and then add the null terminator at index 16.
>> +	 */
>> +	memcpy(build_date, hdr->build_date, sizeof(hdr->build_date));
>> +	build_date[sizeof(hdr->build_date)] = '\0';
>>   	strim(build_date);
>>   	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
>>   		 be32_to_cpu(hdr->hw_sw_ver), build_date);
> 
> Tested-by: Eric Biggers <ebiggers@kernel.org>
> 
> Can this be sent upstream soon?
> 
> - Eric

Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

