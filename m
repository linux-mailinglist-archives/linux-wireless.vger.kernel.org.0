Return-Path: <linux-wireless+bounces-29099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044FC68F83
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 12:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AA454F0DBD
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61528853E;
	Tue, 18 Nov 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsUapDaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBarVvlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D133BBBB
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463754; cv=none; b=QYcXTw8HoxxO499U4aUKiIm8QDeyyUW55394yMiqP01SP8kgWN9aMKe9HTIj77PaDQSmAHvZZ3Vis4yJ6JcqwDr6IADA6ekoRHackY8DKKT/yUmYRUsp4gz1oqc+L7Zu5FpxvRYozXx4n0vxXlMDfwNaYoCPOa3/UfAdEwy54xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463754; c=relaxed/simple;
	bh=h1DTni8g/XbrKrsiM/RGkw34bbLBthGBbLEnfFzjZd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+vW+PwfOuzxu2Hby/0DuzO3YN7lhZFsyiy5YUaKiKNmXd6RlDLCwLTWLnt9QNCAIp+l5dAJDiR4YaGlaL1zR06VaEGiC2NjCQ+UTANW3g1VI9ATmDGjZ8JZHNz+Bm18cvSDqkOvP6QEbDh9mF+t+V/okfjj+4UJlH+TqXKAZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GsUapDaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NBarVvlv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VUCF2250242
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 11:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WSKfSg7sX/L2rplVdh/J8TmLKq8S4qDVyuOFKl89jto=; b=GsUapDaUFKzoSBtJ
	O7Vmm2UYWja+UhQr5YnjW587tPIX/LSa4Lg8j6aVljOR1xw2tmcDFIS/4MumNDZh
	UDwV51XaOCzsPLGECh+VwRh+greoCuKIfOzaMBPEioyi/Sf0hfXVfM8g+DsvNO3T
	ZIp53L3taEyN1/cNX5sFDWav6+Z5fcNhTjQC5i1Lkw2Cfkd1VdgXiHE/rKYCL5ST
	OY3nhQ/9d2l4gmrpkqNzn5cgOya6FS/r0uox8sDrdBuDvQq+mzKeNeDs0W5Gi7VX
	6DDnWMc3WCW6okERevw1ceJl03dwiVAsOgEVFgHG4/+HE3K2SVJXKEEJeLRnkVjL
	Zb7ZHg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5gf0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 11:02:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-342701608e2so6446914a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763463751; x=1764068551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSKfSg7sX/L2rplVdh/J8TmLKq8S4qDVyuOFKl89jto=;
        b=NBarVvlvf30+vqJy0vpwHIWUeXr0yoaxyv8cSx8Megf/KFcvjZ/FGASykhILlHV9sM
         6TGdmxwG7M96OFGtGmnZt78imrQDsZC3yYhBWX41GSA2zrhnWTciKn5JRuIGP13/4YpH
         TWvX5fOWV++/9ZNXQ7F75k1X1I+dHLXk5GxkgaEaSQA4ISftbhzq8a4NXYQrmKks9x0W
         pTw0ohf2uDZS3Pq7BMmSdg1pwMLgEqs0g100+hHFegAnzZGRW/WPVBcan8cJSXQTYTK3
         hrZluTljNrsUpe+B4MGIPulX+AhzTw8tMP6HSRgeWS8jEc2Q934/hwbLPg4tbMZ/cakI
         UoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463751; x=1764068551;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSKfSg7sX/L2rplVdh/J8TmLKq8S4qDVyuOFKl89jto=;
        b=vuksmGpSzZdKbImLsvkhFsquNGWPdHDA66dBlak7/D+lzYrtbEC3KmQtK5+lqaw5aj
         nBElbx3T30JjKtwnotSR85pL4tC+U1cQTo+KlWfJ44+big9VfY11sd/iSyhxZzGfnRSO
         /blnmeOKcg2Z2LBLM2QjRLHcheZNwhkXBTuWq4MTrAm/kVnAJlkTwapNjiJL2Fy+Y4u1
         6dgqrKJlg3gdFCVD4Mbpcc8UCxRqLwIpHKjisi8L6s1bHk4/UBZXMtsXmnbinouIJb56
         UZ4aGQh7XxUERHGhPlxdk5kZSNwjG1dq8p73gYJlFkk46lcyVx0zd3SYikTTo3ckIPGt
         uVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX47gXoGVVZFTjWZWEn5t1vEvwnBySxj6U5nvYnwkHfJEWO8UEskYpHxpmfnpinXsNZgDEy9vMqMuJem1ovbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfC1adsBfPhOHuEdolVdIIWmH1EQfzlyP3ql+1cGqaV0UV3pQ
	adPgJ2nc3bc6LedoYSknRftokFGaOseLwo6NUreT11Ap4FPzV6zwayagIFZd+Mmj8YJnAMS8rvV
	LaJr4d8Svlg1wfUcpnL365vL63gvgQyG0h8DBm49LDMizWUjfHasjv5NEZMwyUbK4hoKLuQ==
X-Gm-Gg: ASbGnctrgLuYdSYinSsbJLs+2Ya9jUPJpY0vTL4VJO0gkgTCF+NzvrNXa7QynWjH8vF
	wee+3Ta4c+nGX3vuqspSb5UiG1FaejSlNz/0rlYgclm/PAngEGCzMGDuRjKOK7xJLpPeNX8/IDj
	1qcycZ+LhJrgUhvnENgW0g3nHzCswymS/D2JEKduVSdJUJmm9oWnZY2xkuR2uCvONckY3qrVVe1
	/A6N5FyYkh5UsvxvOtXlzpE+azBGPHn586VH2yHep9u5kM2Ls6rSbPMb83P2bi/MKhLPEpdhUaq
	rRITVDomy3tS2jH/gyR3S3eF/otPxHAzjv8oa6cNWCZQRcdsKsLIfrN+wNF94zultCAfiQ/jNiP
	2dmQnvyLWWctm6DHsDETmtOugPbkED6HC9K1kPXSwEcsjdljx4JA2V+gepxd/owF5YvUvtyNG
X-Received: by 2002:a17:90b:4985:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-343fa7607cdmr17750842a91.33.1763463751194;
        Tue, 18 Nov 2025 03:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwv0x5GGt5fd/ZbS3sjPoD8CgkzGMYteoLU0SLlRueuAqIO7zFP1VFikcjvr62aik5gzjmcw==
X-Received: by 2002:a17:90b:4985:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-343fa7607cdmr17750795a91.33.1763463750608;
        Tue, 18 Nov 2025 03:02:30 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07bbbd2sm21838078a91.16.2025.11.18.03.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:02:30 -0800 (PST)
Message-ID: <bed8564e-0801-4c55-a9ce-32956db68b98@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 19:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251118101723.69279-1-alexander.wilhelm@westermo.com>
 <25dc40e9-6fe6-4e8d-b767-02f8a304e1ca@oss.qualcomm.com>
 <aRxPOLxQkOUCDK1B@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aRxPOLxQkOUCDK1B@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eM3JxLhvS8Xk5lrfYpU5F_iZ55ftVQep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4OCBTYWx0ZWRfX0M1rD4+zuub/
 GBXW7oz9Cnl1C6vTB3tpnjuxa6N3Wqw8a3Fh+ukmTe2Pz5P1mBNd11nFi1oXmy3nw5d1gzta737
 QomMvNJHEbmIuf07Pi3HZP2DMzYCtJk0YlnfYje+OuLiiMGuVpqJTm/MLYrYuHoYrQcCKYKkNj/
 dV+fN5nBoiWJ7xT7cIiIA0BodonrT4oiNEXZduTxm1tGF6tAP6Ll8p87qvEh6n1f0qMAKbQJaMb
 LHXcUWy5WdaGlZZcWNUaOmDmq5i7r/3QJoiXuVAGlUuK9Gpe5c1HJ9jiOVPfngWKUc7kvNrjRCy
 ox/cjrHp0aot+tZKRrUWPjwC+cjnYcygRqCeRvsU84Om5Lz5FDJOXCDUWva0qnRFMUbGIvddje9
 9ISlAKmPddzbv4G4qB3xpRKuYTrlPQ==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c5248 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=PS0NEqStB8q5LQhKI8EA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: eM3JxLhvS8Xk5lrfYpU5F_iZ55ftVQep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180088



On 11/18/2025 6:49 PM, Alexander Wilhelm wrote:
> On Tue, Nov 18, 2025 at 06:43:44PM +0800, Baochen Qiang wrote:
>>
>>
>> On 11/18/2025 6:17 PM, Alexander Wilhelm wrote:
>>> The SRNG head and tail ring pointers are stored in device memory as
>>> little-endian values. On big-endian systems, direct dereferencing of these
>>> pointers leads to incorrect values being read or written, causing ring
>>> management issues and potentially breaking data flow.
>>>
>>> This patch ensures all accesses to SRNG ring pointers use the appropriate
>>> endianness conversions. This affects both read and write paths for source
>>> and destination rings, as well as debug output. The changes guarantee
>>> correct operation on both little- and big-endian architectures.
>>>
>>> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
>>> ---
>>> Changes in v2:
>>> - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
>>> ---
>>>  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
>>>  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
>>>  2 files changed, 24 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
>>> index 6406fcf5d69f..bd4d1de9eb1a 100644
>>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>>> @@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>>>  	tp = srng->u.dst_ring.tp;
>>>  
>>>  	if (sync_hw_ptr) {
>>> -		hp = *srng->u.dst_ring.hp_addr;
>>> +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
>>>  		srng->u.dst_ring.cached_hp = hp;
>>>  	} else {
>>>  		hp = srng->u.dst_ring.cached_hp;
>>> @@ -2030,7 +2030,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>>>  	hp = srng->u.src_ring.hp;
>>>  
>>>  	if (sync_hw_ptr) {
>>> -		tp = *srng->u.src_ring.tp_addr;
>>> +		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
>>>  		srng->u.src_ring.cached_tp = tp;
>>>  	} else {
>>>  		tp = srng->u.src_ring.cached_tp;
>>> @@ -2149,9 +2149,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>>>  
>>>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>>  		srng->u.src_ring.cached_tp =
>>> -			*(volatile u32 *)srng->u.src_ring.tp_addr;
>>> +			le32_to_cpu(*(volatile u32 *)srng->u.src_ring.tp_addr);
>>
>> s/volatile u32 */volatile __le32 */ ?
> 
> I got it. I'll fix it in v3.
> 
>>>  	} else {
>>> -		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>> +		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
>>>  
>>>  		if (hp != srng->u.dst_ring.cached_hp) {
>>>  			srng->u.dst_ring.cached_hp = hp;
>>> @@ -2175,25 +2175,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>>>  		 * hence written to a shared memory location that is read by FW
>>>  		 */
>>>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>> -			srng->u.src_ring.last_tp =
>>> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
>>> +			srng->u.src_ring.last_tp = le32_to_cpu(
>>> +				*(volatile u32 *)srng->u.src_ring.tp_addr);
>>
>> s/volatile u32 */volatile __le32 */ ?
> 
> Same as above, sure!
> 
>>>  			/* Make sure descriptor is written before updating the
>>>  			 * head pointer.
>>>  			 */
>>>  			dma_wmb();
>>> -			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>>> +			WRITE_ONCE(*srng->u.src_ring.hp_addr,
>>> +				   cpu_to_le32(srng->u.src_ring.hp));
>>>  		} else {
>>> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
>>> +			srng->u.dst_ring.last_hp =
>>> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>>>  			/* Make sure descriptor is read before updating the
>>>  			 * tail pointer.
>>>  			 */
>>>  			dma_mb();
>>> -			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
>>> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
>>> +				   cpu_to_le32(srng->u.dst_ring.tp));
>>>  		}
>>>  	} else {
>>>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>> -			srng->u.src_ring.last_tp =
>>> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
>>> +			srng->u.src_ring.last_tp = le32_to_cpu(
>>> +				*(volatile u32 *)srng->u.src_ring.tp_addr);
> 
> Same as above, sure!
> 
>>>  			/* Assume implementation use an MMIO write accessor
>>>  			 * which has the required wmb() so that the descriptor
>>>  			 * is written before the updating the head pointer.
>>> @@ -2203,7 +2206,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>>>  					   (unsigned long)ab->mem,
>>>  					   srng->u.src_ring.hp);
>>>  		} else {
>>> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
>>> +			srng->u.dst_ring.last_hp =
>>> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>>>  			/* Make sure descriptor is read before updating the
>>>  			 * tail pointer.
>>>  			 */
>>> @@ -2547,7 +2551,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
>>>  	 * HP only when then ring isn't' empty.
>>>  	 */
>>>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
>>> -	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
>>> +	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
>>>  		ath12k_hal_srng_access_end(ab, srng);
>>>  }
>>>  
>>> @@ -2648,14 +2652,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
>>>  				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
>>>  				   srng->ring_id, srng->u.src_ring.hp,
>>>  				   srng->u.src_ring.reap_hp,
>>> -				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
>>> +				   __le32_to_cpu(*srng->u.src_ring.tp_addr),
>>> +				   srng->u.src_ring.cached_tp,
>>>  				   srng->u.src_ring.last_tp,
>>>  				   jiffies_to_msecs(jiffies - srng->timestamp));
>>>  		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
>>>  			ath12k_err(ab,
>>>  				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
>>>  				   srng->ring_id, srng->u.dst_ring.tp,
>>> -				   *srng->u.dst_ring.hp_addr,
>>> +				   __le32_to_cpu(*srng->u.dst_ring.hp_addr),
>>
>> still my v1 comment does not get addressed:
>>
>>
>> why __le32_to_cpu() only in logging, while le32_to_cpu() elsewhere?
> 
> Sorry, I was confused with the previous issue. Yes, I saw this form on an
> upstream patch where '__le32_to_cpu()' was used instead of 'le32_to_cpu()'.
> Which one should I prefer? I'll unify that in v3.

I am not sure here -- Copilot tells me that le32_to_cpu() does argument type check while
__le32_to_cpu() does not, in that case we should use the latter one because we are sure
the type is safe.

However actual code shows they are actually the same:

include/linux/byteorder/generic.h:

	#define le32_to_cpu __le32_to_cpu

Let's see if others can give some insights.

> 
> 
> Best regards
> Alexander Wilhelm


