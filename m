Return-Path: <linux-wireless+bounces-21918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EBAA98D16
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44767167775
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940027CCFA;
	Wed, 23 Apr 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VC/dQ1KM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF601139566
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418536; cv=none; b=PDhy2xJkYpbTXfYxllGW+aE49ECRdSgM4B45QO/Ek72udn71lcbXJ0+BxEVh68J3gHmhYO0DlmXIWyHMZIBzhz0155YX+ZwWagHIHeLclLO8Q6q06SDiY2xEwRqdrmrD4dYCm3gjj1oyeH3QrmtTlyHltP7I8daJQgTUBWRMBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418536; c=relaxed/simple;
	bh=3d4L/OpgIskPzmhWJd9Lo1MKK6TrrdQd5WCm5NOL5mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhrltbfoYn1S4jJaYyU7q/e2V0VSSL1FCSfGJ7yviYGOoTnkdKtyCH6eakuAGASjASJpmaj0ImXwDky5tRgSi0GX/xVCkiir8bnfU9gq1mrT6VnE7jza6zzc4Xuz/+zhyW4rKDVm2y6VeLYl/gJVdqJV4KyMMGsPY4vkBlvZnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VC/dQ1KM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAqBPQ011871
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 14:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RI8p1FKSjrsTzbJbzVg5SpTQ5yttOOHdObui3LUhhiw=; b=VC/dQ1KM9IG/hSFW
	JVTUndSPIoH/n85bst0pAkMR8wNSC1yQXRbdWtCpnImka1t/osZeHORUb2pzThuD
	ln3w0E/ZZh12vZ0NBXqrI1F6IqbcbL21mVv5bvcClPdfUcYHR76VJxJ26G65PBvG
	5brtROsprjWp/YwXB5gZD6rhiWHjN/LH0OB1+YH5nFqovdZVHIbqfhlFbY7wgsBr
	+CSajBrns1f8kD25Ev2r+BXi8U6jGOlrrc6jdncP4mjHDcBkaQVqR6g0vpI2+vgh
	/U12dos69D78rhJdGEtWDEUSAXBM63eAh6+HTC+8foBW0l7FTxCpZGvrAQJqWZxf
	dZYKxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1jdxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 14:28:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a96112fso94399355ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 07:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418533; x=1746023333;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RI8p1FKSjrsTzbJbzVg5SpTQ5yttOOHdObui3LUhhiw=;
        b=AioxRdqnyn43hW90L1uSa9B9gn7YATyXbxA9MGHLT6Ef8f0PubmYgLnLDijh9W4jga
         1karX47mZuqYSjgdJV1tKbNEXI/h8DxorMkHNEBMi6TRIHWE+lH8kPlk6VkXRIvNfoNF
         s+goiU45oM8Q/cTLSnvVBiuSHCi6N+wUG/Qkjp0Uv3Qk2T5tRfG0L1EPHWmI7uFgCD81
         dJgv97nvU2qIYSe75vgaS26tMTlxrctSFx+41SDmgFdyZ75++Xhi3WhAbPdpQT02KnOc
         HGT3RvyQViGF69vMRdcuipm3kHKhKwjXeNeqtfLxfNgfmxTBxReMgRh9KqWZRKcDy0Ca
         i5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSDnVMm+PsinL2ZY00ZD4EDoCDY8udJgBNV9QMD+QO6wagu8a4jVvhdClw3qbiu63hwB7A+0FtystIaib1TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1G+7JRMzX3WDRsqwvafdpLOb3dsY1maflfGkIXT9dxgXrnC2K
	aJbmj9u0OqV86PZRfnm91wFVocIqDfaEijmhR2SX3k7D7PUTgzSjgctX3S5V2HsYAqXBDhXaQ8Q
	VcmnHBRjfx3r+col5AbbofUxUk1kf6hI3j4IUfewI3iGJKHRb0eBRl830dqr1i+VaUA==
X-Gm-Gg: ASbGncuQRngr6kjTLRazqO2LKm49zJuf21BO5aWfx/d4g/puNaAsSZgEkvhCHVxdjRU
	8IRuoSEiJqzhYlk1GwDWNUwED5LDm/o/xCIVYRp3ulwAMeQeqWVImC1p809ULP640Gu26u3W6Hd
	/x+KiDWVxzSHo4gXXRKgeTgbfoOz5lLVFwDwsdlbmWlDuA+IFFTpgaTTb8X0Go7eXafymtsR3Mz
	svAf5JopMw0SrQGsrTEWtXq9ePRywt66S8du4cPZ5uU/QNkk+ptUaPXp6chkRlghITImF8fnNC9
	Jd8QlFPOY1uB9p1dbgSFtC4mv0wgv2NrCIlZm4t4AgYiEF5Qb2H6CRKHb7rFdiy7U1E=
X-Received: by 2002:a17:902:f14c:b0:220:e1e6:4472 with SMTP id d9443c01a7336-22c5357f2f4mr219639165ad.13.1745418532715;
        Wed, 23 Apr 2025 07:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCNu809EkQVsTIbQad9yh76IO7LGCSGm7PzVmwCgFbrK+zwOALKe/846lCKlRIrlk7DV74kA==
X-Received: by 2002:a17:902:f14c:b0:220:e1e6:4472 with SMTP id d9443c01a7336-22c5357f2f4mr219638815ad.13.1745418532265;
        Wed, 23 Apr 2025 07:28:52 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdb0e3sm105389555ad.21.2025.04.23.07.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:28:51 -0700 (PDT)
Message-ID: <228546c4-a4b5-4f21-950d-2623a48f60a6@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 07:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250423065931.4017574-1-usama.anjum@collabora.com>
 <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0OTq4Vrl5sd1HmyYCrgIZ2PX8L_fdXBp
X-Proofpoint-ORIG-GUID: 0OTq4Vrl5sd1HmyYCrgIZ2PX8L_fdXBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwMiBTYWx0ZWRfX7/V4qQzfhsZl InzYTPGGpujW9i32+zN0X5GoYcrsIx6fBYf8NA6SniwmMduqiXw595DY4H2r09GD+0AfMPLlj2Y XGYfRIX9eEC5Yd7+w6Ftao5xcqoF6g8AbauuHLvWqMc6sJDEFlBDHwbf37oD9n3S4X5Ou8IicO/
 7hymBeflgG9HtI/bY0j4EJHehYtoOnwpUymLXSGwTwFIlJ/I8o8iMY4tNytJ+HtRQqlLKQiIuEz ZPAWUr9Nj37B3iiAIw1KTWHFJFZuuXwwUXXsB7CYEjyugsS46Ah6k5rQm/MvrscB5tCtwH4Va7u OWzSYCWXsdKKbeOLW1rhVYyHBTwt4PRl8fuH8Hs7cLxVg2YlYD1wuy8fP1VG2Im6diDMUr7l8HA
 /5fCNJkFO2f08bAu5vtGjm1HsBbXj6DqmqvFZ5RbIbw4nGZdhdiyQZyYzfM0EiIoLkJbpKC7
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=6808f925 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=I_dGSvPyyRiqSV0Bi5YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10 a=324X-CrmTo6CU4MGRt3R:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230102

On 4/23/2025 1:15 AM, Baochen Qiang wrote:
> On 4/23/2025 2:59 PM, Muhammad Usama Anjum wrote:

For starters, can we make the subject a bit more specific, i.e.
Fix MHI target memory reuse logic

>> Firmware requests 2 segments at first. The first segment is of 6799360
>> whose allocation fails due to dma remapping not available. The success

the memory allocation succeeds but the remapping fails? that seems like some
specific information that actually isn't very useful. From the perspective of
the driver all we really care about is that dma_alloc_coherent() fails, not
why it fails.

>> is returned to firmware. Then firmware asks for 22 smaller segments
>> instead of 2 big ones. Those get allocated successfully. At suspend/
>> hibernation time, these segments aren't freed as they will be reused
>> by firmware after resuming.
>>
>> After resume the firmware asks for 2 segments again with first segment
>> of 6799360 and vaddr is not NULL. We compare the type and size with
> 
> suggest to rephrase as:
> 
> After resume the firmware asks for 2 segments again with first segment
> of 6799360. Since chunk->vaddr is not NULL, we compare the type and size with
> 
>> previous type and size to know if it can be reused or not.
>> Unfortunately, we detect that it cannot be reuses and this first smaller
> 
> s/reuses/reused/
> 
>> segment is freed. Then we continue to allocate 6799360 size memory from
>> dma which fails and we call ath11k_qmi_free_target_mem_chunk() which
> 
> it is odd with 'from dma' ...
> 
> I think just say 'allocate 6799360 size memory' is good enough.
> 
>> frees the second smaller segment as well. Later success is returned to
>> firmware which asks for 22 smaller segments again. But as we had freed 2
>> segments already, we'll allocate the first 2 new smaller segments again
>> and reuse the remaining 20. Hence we aren't reusing the all 22 small
>> segments, but only 20.
>>
>> This patch is correcting the skip logic when vaddr is set, but size/type

see
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>

Specifically:
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.

>> don't match. In this case, we should use the same skip and success logic

who is "we"? the driver is performing the action. As part of changing the text
to be in imperative mood this should go away.

>> as used when dma_alloc_coherent fails without freeing the memory area.

add () to function references

>>
>> We had got reports that memory allocation in this function failed at
>> resume [1] which made us debug why the reuse logic is wrong. Those
> 
> The link is just v1 of this patch, it is not the report. If there is no public report,
> just don't mention it.
> 
>> failures weren't because of the bigger chunk allocation failure as they
>> are skipped. Rather these failures were because of smaller chunk
>> allocation failures. This issue is in the kernel side as because of
>> memory pressure or fragmentation, the dma memory allocation fails. This
>> patch fixes freeing and allocation of 2 smaller chunks.
> 
> I know you are describing why you start to debug this issue. But I don't think it is
> needed in the commit message. No matter kernel allocation fails or succeeds, the issue is
> there, and the description above is sufficient to make the issue clear.

Concur with this.

> 
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> blank line needed.
> 
>> [1] https://lore.kernel.org/all/b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update description
>>
>> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
>> I think we should keep fixes tag as ^ claimed that its adding reuse
>> support. But it left a bug in reuse which we are fixing.
>>
>> Feel free to add it or leave it as it is.
> 
> Jeff, what do you think?

I would drop the tag. As I understand it, the issue described is due to memory
fragmentation/starvation, and not due to the fact that ath11k does not
actually reuse the first two segments.

> 
>> ---
>>  drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index 47b9d4126d3a9..3c26f4dcf5d29 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>  		 */
>>  		if (chunk->vaddr) {
>>  			if (chunk->prev_type == chunk->type &&
>> -			    chunk->prev_size == chunk->size)
>> +			    chunk->prev_size == chunk->size) {

please don't change this...

>>  				continue;
>> +			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {

...instead just use if here. we normally don't use else after a statement that
changes the code flow (return, goto, continue, etc.)


>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>> +					    chunk->size, chunk->type,
>> +					    chunk->prev_size, chunk->prev_type);
>> +				ab->qmi.target_mem_delayed = true;
>> +				return 0;
>> +			}
>>  
>>  			/* cannot reuse the existing chunk */
>>  			dma_free_coherent(ab->dev, chunk->prev_size,
> 
> 


