Return-Path: <linux-wireless+bounces-22899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63508AB4C35
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0903019E6450
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 06:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE471E9B18;
	Tue, 13 May 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="J9G4mPqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C21862A;
	Tue, 13 May 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118728; cv=pass; b=P3xmT+PqDhsv/TLscMUQo1cfbGC9FckYx5TLdV17TWynYMNfeinhWuUNo1BHNkGIwjdARFl4kHeVapboT7rNKBiN5UTBiDJjmRKx1dgIl2z5SP+Ob37hNOdniw8G7F9Gw6fNkdi5YjhpCFtOYA6c6lp7jxcR2/xcv0escOIdePY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118728; c=relaxed/simple;
	bh=y+L7cdhRBfjhgSwo47lMKyM7oldihg6/nlUiTfTvlrg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vEkoEI7CWBQpkORBrz7c+A4pAvCpq1ER88SCdQhI1QTc5dI+nyot440e8DHk8b/LlsM2zJmEiHJ3IgOftnE3BiVCuY3CE/BdZ2bpfiKDeZk8IdFuBtx6gyh8EwxoYj8LE4ae5eFsODtBx8vlzu+KhXmjULFqz+74i8YUZJzxg74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=J9G4mPqR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747118686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N9e2mauoUIL5tJpbMwyeC7WI9kWkYAzWj8tgMyULpEooybe8OR3n+P21AtLCiagJD2e2cHXIbNsjhIPZ9hyFCdN8Z2gN8UxqRhvazPOssZPXst3ZvMwGNMDkkIrpJColhcle1Rj+wouqrDBCzhAxALKGW00w+x1Kd0Ziat5DmvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747118686; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+kxhlRDU0zW0Hh6yejx3JiPQYtX8vLhNb6JgzAtvBpo=; 
	b=R7aS+3z1/BQG2veWY83SisctQcHE+owrzNLcqlDQTKwdaApKla7QKNTcWr7LFhiMkIiPaC9Pf7S5+PtiTCjY5e14IW5tyg9GWaj9/aP23DTuXgSzcwhYXUK7V4GW+q0BBUuh33IIuf4KvB2e/OsvL++olkjx1sgWRlQjOaPUbIk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747118686;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+kxhlRDU0zW0Hh6yejx3JiPQYtX8vLhNb6JgzAtvBpo=;
	b=J9G4mPqRzB+b/wscEypiXBOXYIvxhOqwjRlUrsAHPOG+XjqBSwiiMIMxMP5P3QcC
	jGGRjs2w1FPAD6ng3vqAPTGJlZjHUhgyfA8n6FbdE4DD4nYPDMYX4wadLVD4BM0hk2T
	N3qp2JJZbxDJ3jahF14dPXYV0+EI4QzmPIUkTDu0=
Received: by mx.zohomail.com with SMTPS id 1747118684253297.23905688846673;
	Mon, 12 May 2025 23:44:44 -0700 (PDT)
Message-ID: <5521efad-1ca8-41e3-b820-5527d634c539@collabora.com>
Date: Tue, 13 May 2025 11:44:34 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 sebastian.reichel@collabora.com, Carl Vanderlip <quic_carlv@quicinc.com>,
 Alex Elder <elder@kernel.org>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org
Subject: Re: [PATCH v4] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <jjohnson@kernel.org>, Youssef Samir
 <quic_yabdulra@quicinc.com>, Matthew Leung <quic_mattleun@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Kunwu Chan <chentao@kylinos.cn>, Troy Hanson <quic_thanson@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20250506144941.2715345-1-usama.anjum@collabora.com>
 <4a6b83f4-885a-46e1-ae31-21a4f3959bae@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <4a6b83f4-885a-46e1-ae31-21a4f3959bae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/12/25 11:46 PM, Jeff Hugo wrote:
> On 5/6/2025 8:49 AM, Muhammad Usama Anjum wrote:
>> Fix dma_direct_alloc() failure at resume time during bhie_table
>> allocation because of memory pressure. There is a report where at
>> resume time, the memory from the dma doesn't get allocated and MHI
>> fails to re-initialize.
>>
>> To fix it, don't free the memory at power down during suspend /
>> hibernation. Instead, use the same allocated memory again after every
>> resume / hibernation. This patch has been tested with resume and
>> hibernation both.
>>
>> The rddm is of constant size for a given hardware. While the fbc_image
>> size depends on the firmware. If the firmware changes, we'll free and
>> allocate new memory for it.
> 
> Why is it valid to load new firmware as a result of suspend?  I don't
> users would expect that.
I'm not sure its valid or not. Like other users, I also don't expect
that firmware would get changed. It doesn't seem to be tested and hence
supported case.

But other drivers have code which have implementation like this. I'd
mentioned previously that this patch was motivated from the ath12k [1]
and ath11k [2] patches. They don't free the memory and reuse the same
memory if new size is same.


> 
>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>> index efa3b6dddf4d2..bc8459798bbee 100644
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller
>> *mhi_cntrl)
>>        * device transitioning into MHI READY state
>>        */
>>       if (fw_load_type == MHI_FW_LOAD_FBC) {
> 
> Why is this FBC specific?
It seems we allocate fbc_image only when firmware load type is
FW_LOAD_FBC. I'm just optimizing the buffer allocation here.

> 
>> -        ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>> fw_sz);
>> -        if (ret) {
>> -            release_firmware(firmware);
>> -            goto error_fw_load;
>> +        if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
>> +            mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>> +            mhi_cntrl->fbc_image = NULL;
>> +        }
>> +        if (!mhi_cntrl->fbc_image) {
>> +            ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl-
>> >fbc_image, fw_sz);
>> +            if (ret) {
>> +                release_firmware(firmware);
>> +                goto error_fw_load;
>> +            }
>> +            mhi_cntrl->prev_fw_sz = fw_sz;
>>           }
>>             /* Load the firmware into BHIE vec table */
>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>> index e6c3ff62bab1d..107d71b4cc51a 100644
>> --- a/drivers/bus/mhi/host/pm.c
>> +++ b/drivers/bus/mhi/host/pm.c
>> @@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller
>> *mhi_cntrl, bool graceful)
>>   }
>>   EXPORT_SYMBOL_GPL(mhi_power_down);
>>   +static void __mhi_power_down_unprepare_keep_dev(struct
>> mhi_controller *mhi_cntrl)
>> +{
>> +    mhi_cntrl->bhi = NULL;
>> +    mhi_cntrl->bhie = NULL;
> 
> Why?
This function is shorter version of mhi_unprepare_after_power_down(). As
we need different code path in case of suspend/hibernation case, I was
adding a new API which Mani asked me remove and consolidate into
mhi_power_down_keep_dev() instead. So this static function has been
added. [3]



> 
>> +
>> +    mhi_deinit_dev_ctxt(mhi_cntrl);
>> +}

[1]
https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
[2]
https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
[3]
https://lore.kernel.org/all/y5odcxzms6mwpz5bdxhbjxo7p6whsdgwm772usmmzqobhf6nam@p4ul7vn7d3an


-- 
Regards,
Usama

