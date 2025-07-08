Return-Path: <linux-wireless+bounces-24916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C4AFC6D1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7938B3A991B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488F2C08BA;
	Tue,  8 Jul 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="ehqE1Nwe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3529B224;
	Tue,  8 Jul 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966032; cv=pass; b=RtmcwNVByrWuUgaDBRRcjJwDNLTgADpngT03YdpQaImMgDJOKyDrcouX1mpoiHvZKQNH0Zr9wAcTnb5EpwNbEMS1mtQyxvOfKUEpYsadviY/WIyeqsKvrW5/tSu7W1vmucfdbv7mWlM+t67QvrOaXAwDoCXaRoTbilGYK0k6PiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966032; c=relaxed/simple;
	bh=v6i8r2H7oRZrwf7IHlbE+fo33fnfHP+URyQNy3QrdU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4s9uQ7Z88c5uTdbXMd6VRS2itL3LEVwhxjvydyEWcQf52k4tzLL/XQz4h6h39HRyWTmh6bzF/FKyxVTstC4gzqXYHyKHLc9OM61zdLIPb2JQvz1U6fwX5O46+VT5uP6bdu04OtIbiiwk1xIWtpD8lJzgqEPwLfDs4w0h879xpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=ehqE1Nwe; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751965948; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N6CJeNVkwQAUAWxjg9vjZvB9IJc2/6qSwbnYWrWja6U6NsOMQ9tVn6ZBN2XKFUEcpLzP6OAPE2VkSMEzz0Dp4WSE2PIbC08B4q5ThFCjL/LDyjwmLJ1BMl/ioU8ckiwT80c0SIpAJFY3ZRAUkpo5HTeAmd3fIbM1quP626xH8WQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751965948; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xr7n94OD0AhqYVDjgBhoeAD9o6h9ME6lWOaPFrEy2w0=; 
	b=hgXQgu+VGEXmqAyeOU1kj1Oy9ff72yeYIWavXqV8R7+zlGq1EPGjHeiYlcs6bpMMVqP3A9BCoDEjfUEZsdKQDb3fthajG0MvGOpCxCPFPmOq+IeZ34fYvdO58TgjvhGmn/bNkZF7Uc2rrYk5MrW1YvdG0P4zwCBEFMUyvR09M/s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751965948;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Xr7n94OD0AhqYVDjgBhoeAD9o6h9ME6lWOaPFrEy2w0=;
	b=ehqE1NweoZcvK+aTFS0SGYdfmXyBU/p/QEfGhoUwEl5J6NZiECt2l1zITAw7klQD
	PZLGCKwF+3NBZrNTbC3wj7E5AHz1ysbRh4HGnIyOPvPhtq4r3oEGmdae2zIOUEYiYhW
	3YzNwQdqzS986bbCVTsdVJ0HwJmhxKsqXhKXYw/o=
Received: by mx.zohomail.com with SMTPS id 1751965945356214.43115978776154;
	Tue, 8 Jul 2025 02:12:25 -0700 (PDT)
Message-ID: <5c9843b5-d756-4a99-b93f-d32ed8f16e32@collabora.com>
Date: Tue, 8 Jul 2025 14:12:11 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
 <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
 <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
 <a92b3d96-0c19-49c2-ad8b-ad31dec973c3@collabora.com>
 <7b8ea9ba-02ef-4676-a4d3-d088920283c3@oss.qualcomm.com>
 <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
 <fdb9f1e7-bf8f-4018-b0ac-ac8a70d9b8ec@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <fdb9f1e7-bf8f-4018-b0ac-ac8a70d9b8ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/8/25 6:43 AM, Baochen Qiang wrote:
> 
> 
> On 7/7/2025 9:11 PM, Muhammad Usama Anjum wrote:
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>>>>>  	mutex_unlock(&ab->core_lock);
>>>>>>>>  
>>>>>>>>  	ath11k_dp_free(ab);
>>>>>>>> -	ath11k_hal_srng_deinit(ab);
>>>>>>>>  
>>>>>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>>>>>  
>>>>>>>> -	ret = ath11k_hal_srng_init(ab);
>>>>>>>> -	if (ret)
>>>>>>>> -		return ret;
>>>>>>>> -
>>>>>>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>>>>>>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
>>>>>> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
>>>>>> in resume handler? So when device wakes up, its state is already correct.
>>>>>>
>>>>> Hmm... not quite understand your question. Can you elaborate?
>>>> I'm trying to understand the possibility of cleanup of hal in suspend handler. For example:
>>>> * The driver has been loaded and has been working fine.
>>>> * The user called suspend. So all devices would be suspended.
>>>> * In suspend handler of the ath11k, we should do the necessary cleanups of the states
>>>>   like hal.
>>>> * When the device would resume after long time, the hal would have the correct state
>>>>   already. So we'll not need to deinit and init again.
>>> The hal cleanup is not only needed by suspend/resume, but also a step of reset/recover
>>> process. So If we are moving the cleanup to suspend handler, similar stuff needs to be
>>> done for reset/recover as well.
>> It makes sense.
>>
>> So clearing the hal structure completely other than ab->hal.srn_config doesn't seem
>> right. I've also tested it and it crashes the whole system.
>>
>> On contrary, with only the current patch applied, there is no abnormality.
>>
>> num_shadow_reg_configured and avail_blk_resource are non-zero. If I make them 0,
>> driver still keeps on working.
>>
>> 	ab->hal.num_shadow_reg_configured = 0;
>> 	ab->hal.avail_blk_resource = 0;
>> 	ab->hal.current_blk_index = 0;
>>
>> As you have suggested setting these 3 to zero, is there any other variable in hal
>> structure which should be set to zero?
> 
> IMO srng_config, rdp, wrp and srng_key may keep unchanged through suspend/reset, all other
> fields should be cleared/reinitialized.

memseting srng_list and shadow_reg_addr causes crashes. Please can you confirm why do you
think those should be memset. Here is WIP patch:


--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
+	ath11k_hal_srng_clear(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index b32de563d453a..d4be040acf2c8 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1359,6 +1359,19 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
+void ath11k_hal_srng_clear(struct ath11k_base *ab)
+{
+// --> both of these memset causes crashes
+//	memset(ab->hal.srng_list, 0,
+//	       sizeof(ab->hal.srng_list) * HAL_SRNG_RING_ID_MAX);
+//	memset(ab->hal.shadow_reg_addr, 0,
+//	       sizeof(ab->hal.shadow_reg_addr) * HAL_SHADOW_NUM_REGS);
+	ab->hal.avail_blk_resource = 0;
+	ab->hal.current_blk_index = 0;
+	ab->hal.num_shadow_reg_configured = 0;
+}
+EXPORT_SYMBOL(ath11k_hal_srng_clear);
+
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 {
 	struct hal_srng *srng;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 601542410c752..839095af9267e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params);
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
+void ath11k_hal_srng_clear(struct ath11k_base *ab);
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
 void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
 				       u32 **cfg, u32 *len);



