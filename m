Return-Path: <linux-wireless+bounces-36283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC1kBMaWAmr/ugEAu9opvQ
	(envelope-from <linux-wireless+bounces-36283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:56:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF1519116
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90FC2301D591
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708F3750D6;
	Tue, 12 May 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovX6U9vD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPKfBN/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17C3750CC
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554563; cv=none; b=i2pRKSyKL/g8MNYmkGLHDPHFjO+6xEt4y679G4Adg2VwVlC1B6j/cOctiD+S2wl3hNPUVS1qsR3fF0LHXNsvdeqTkjBCU5WMD8VZjVQQCRFT6VW4og88KvJcmgIK+ya884gxVsv31O5Ph0MZ+x9usdd+zLhOdzg9nWqcXOKRQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554563; c=relaxed/simple;
	bh=at/Gy4TKikhwT/z/EgWbjOAjz24pdGRWezXhuPx3shA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF/ErgShRK+Cid6uv4XmLffcSG0ICUbie8xrf2TPB3vxWpxMLi6xlepCeSiat1A7n6kfFuQlLoVjI4eqk43MBhfEpEDcnnYYSr3kIHfcN80iBqzQl+/uKQ7i477Wc9JU1YeiSvRMslYWkN4Kw2K8Ng2X50o2P8O1pNbs7tzluY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovX6U9vD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IPKfBN/f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6Tkl3443739
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZTFqP2R/jd7sflLvliEfjGsykKjN4d7tspuW7eeGmwI=; b=ovX6U9vDI1pi75jy
	HaJS66QoBgbsvFFrbny2Sj7nib8okMotDcaztaurxbfZ2zGvcUMK8cL348EpAn+A
	1XeyBkUAy3KVGSjT5GsFd66GqvTCUoVDvuqfKzpWpVxkLR6zIuX5V50Iyv5/0fC+
	64tGeqsfo3RTiKbkDwR/6BwbtBNZYSYEtNm77+7YZE+qndl4L6Zzl+u6AGEkzXo7
	EnpZ9k1+JDb+oiNWT1R9Nh9p0+dBcGGSH1OdYKUFF5/dimJTN8TLcMQci/OuRyBc
	k1EmW/wyrLvAGqjM4g3jJy+4ZR/czpyqngzQVeQXQ//aiDhDMR0jXyzMKodQIPkj
	viYxnQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0h5hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:56:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so54054915ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778554560; x=1779159360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTFqP2R/jd7sflLvliEfjGsykKjN4d7tspuW7eeGmwI=;
        b=IPKfBN/fH2Xj1NukiAgyGeM90xH5+QI2Q8csDtPB6fu+oU2vZz+vMvVyD6NdaV61CL
         ekEdVtg2ZE8dgFo1132UDibQk/QQ/SMsT7JmkgqnaGd556UZqe6FcG+dZbU5YesWdY7a
         xuGXKeYYODHTPukBrHYp1B3zwBhduvIRaCrUYisLtqIr7HO1tyq1ibmvd6dyWgNR88ND
         MCnTj3laF7/YbnNif5zlliDR4U3XctlHuN1aMR7XxW0HVn/kWb7AJsEGSzYDuPa7OJ3i
         11GR2LbcEaMJsCS7jvrCILBJTWO2PYLxKtX7Emjc4BYY6PVf2/hdUw/m11G+QjuyjLpt
         m0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554560; x=1779159360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTFqP2R/jd7sflLvliEfjGsykKjN4d7tspuW7eeGmwI=;
        b=gZ8yd07yu6BLylMmAzKKOcOa7oovioH9V1eEhrVaeq8QNB5Jfasr7aGBcSU4m/F1hb
         WzpJiJ/bNPv7vFH1/EaA5BDD+q+Fi52qwvMILUJd07z9/euEl1gArepsHus9Wa8Lmesd
         rv60A+Ssh1zr14O1MjEVEoYRMg9pQnquTlJlwhrQF0GIbCc7xAuryXaTLdFJJeME2wu+
         zNTMrSTjAdMRFP7T6uqlhygDc7I+5tbZJeihDqXD3iA4G6moTYbxI07BjC3Q8tEdyTNM
         /6kbNUvqgFgbzE4paCm7InvGM0vn1Al+uGHKa+0Ag4aGbrUnsfxJ8b5ojpTbj+MRQDVR
         HSKg==
X-Gm-Message-State: AOJu0YxvC2zgyLftW2FLhN8VdEtf3zge1L8p0bXGSTRHNrQYHOTWqOfK
	Ed160ww8eRoZyehQ8LjUq5Li7PS5DQmNude/piplZnAknXIIgUBCWqmCeeHA70w+cEeOeiua7AZ
	zPpsWIBGwat0PjsD/zzI2+YkzhV6hHyXn9hxrdEMzYmu27pOWlqQPwAg36xqKeelTQ39wiA==
X-Gm-Gg: Acq92OHeL9TuV136jDXN5ylt3TM2GUWlZ09HhaYGrLo2xBnyFsfm1Sko62InSqT1YUS
	+vRKtVvX2P1yDy3Fug0D4EuU1R95zKU1EpJEenpJ/Rg2cdBGOfUT2xYXV95bEWEpRaj1pVzlZ1Z
	PflJtArqiuAfPaxwwGX+xzBRtt5VEHTEgqnvBOQ64LORs95newmGhGCn81kBXvbL6/ezgO/6BBk
	1xhwRq/MNGv1EOnoqYhAum8i3dqluz6PkYiUYs2mIhcUVM5hHYn/e48zHT7hmEdSOYiNxsE5I2C
	gbdgbHJ6Gi+EG1JlGZwWqDuaBaYEI5tRNy3YqkF28qDrco1njSkJssFndS6xDjoeaN1rQCAnx3g
	prQSjMGCOObejNyoJUfVUm6OQWB3xMZ4xdYKFYQ2Sy8gDWHWmYFbK3CTkXC1hUhgmL9Y/ujl0ZK
	FLmlW9pKsAbrHabOzZXbk=
X-Received: by 2002:a17:903:1ac3:b0:2bd:7ca:e67d with SMTP id d9443c01a7336-2bd07caea66mr2608135ad.29.1778554560485;
        Mon, 11 May 2026 19:56:00 -0700 (PDT)
X-Received: by 2002:a17:903:1ac3:b0:2bd:7ca:e67d with SMTP id d9443c01a7336-2bd07caea66mr2607865ad.29.1778554559996;
        Mon, 11 May 2026 19:55:59 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ba2sm124208155ad.50.2026.05.11.19.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 19:55:59 -0700 (PDT)
Message-ID: <36fff112-4cde-4b4a-aff4-b88ad85d67a2@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:55:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
 <7d3c5eae-233a-4c31-b64e-70f0afe74da6@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7d3c5eae-233a-4c31-b64e-70f0afe74da6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a0296c1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=9B1uR9gGAAAA:8 a=IpyFi0jJrv5YPyD8wV0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-GUID: 7QZhnQOPu9SvrvI6byGXw_5BxVxGA2w7
X-Proofpoint-ORIG-GUID: 7QZhnQOPu9SvrvI6byGXw_5BxVxGA2w7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyNSBTYWx0ZWRfX9213HFCJ85L8
 DPVB6S7bu6TJiCLHnhrFO56I1UuVm7Uk5whwzTKrY9PA4zs0cwZnsyY8WIQwhfBcSrJ6yBGSA+0
 EH7dOwgiqfsGk9//qSbTNs385Pl1CRB4ivmbpzUmXzzBTzQMYLRrf4THL2+Fwhvms5BAyh8K+Dg
 49/Hz1lAmEzmmeIqQSGJIkP40JDbhRg3DaqPqfRk7nJMpTmwtmKfpfbo5H/hRFzoLxiZmCujPyg
 Bwy1di4zmegBvm+odJhgwVgsBW5LjRmqZoVCPcxCgOpH4yTHXpIm9DfmWrOyGA+6+QwwM6C2hiN
 83zIsU2J5iCyiVTV3CznXtc63eo280u5mFlUmku0YnjL8bMfwyN94jHIbgWHyfBYmTmHfCjodix
 uFOR75Q/tN9InhdUwbH2lbi4+U00iZyQiJjsbqLAywNZgM98xCGo8DRo3i4CwZ5I6Sr2FBtUz6W
 E6cMTsmga9NEayMhPyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120025
X-Rspamd-Queue-Id: A0FF1519116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36283-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/5/2026 11:08 PM, Jeff Johnson wrote:
> On 5/5/2026 7:30 AM, Willmar Knikker wrote:
>> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
>> the dev_kfree_skb_any. This can cause a use after free kfence.
>>
>> Move the use after the dev_kfree_skb_any after use of ->is_continuation
>> inline with the while in the while loop above this one.
>>
>> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>
>> ---
>>  drivers/net/wireless/ath/ath11k/dp_rx.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> index fe79109adc70..02bd9787d6b4 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> @@ -1825,11 +1825,12 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>>  		skb_pull(skb, hal_rx_desc_sz);
>>  		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
>>  					  buf_len);
>> -		dev_kfree_skb_any(skb);
>> -
>>  		rem_len -= buf_len;
>> -		if (!rxcb->is_continuation)
>> +		if (!rxcb->is_continuation) {
>> +			dev_kfree_skb_any(skb);
>>  			break;
>> +		}
>> +		dev_kfree_skb_any(skb);
> 
> rather than repeating code imo it would be "better" to cache the flag before
> freeing and then test the cached flag.
> 
> however as you note this proposed logic matches the logic already present in
> the "Free up all buffers of the MSDU" portion of the function, so from that
> perspective the proposal is consistent with that logic.
> 
> let's see if anyone else has an opinion...

I also prefer a cached flag as it is much cleaner.

> 
> /jeff
> 


