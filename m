Return-Path: <linux-wireless+bounces-29087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14260C68A83
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FE294EF709
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BC30FC05;
	Tue, 18 Nov 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V7vu4MPP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TayY2rk8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056F3019DA
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459642; cv=none; b=l2XqnCZx3N8z91sig34c2nSYQ0uFAFEr1kWgiwohiNIzASh70YVQM/3yskooD8H28FXewtMBfPT2l8e1Nywm0PyLUbt/KLzvfqC/hNj1ug7FyAqMBLF96Jeyy1ZR2z6o68owTDG80qg17gvMWAA7HK+rLaluC/azkHVUDLGDMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459642; c=relaxed/simple;
	bh=5fM0Awd1Cl1zoqXUtiblDpUfWEvg7OkBguj0W2S4tn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FySI9vlbHMZflQ2aOGYQpiHEQwdvw006+/NXcB/gYfwylTmtupmJ+qwxmuAiI67h89UWSaLOdU48TYM6OxjcQ5da76zqd8rB3Z/LX6LbK7IDaTg2LNjo5fbSUCXuMw2Qb9o8bvYnoZF95v77flcxnpTvC5vwHz+bllyuvRJmsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V7vu4MPP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TayY2rk8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI9rKxc2664716
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gPufLjmIrqMLSLMrepnxIXEELbKqNgUquhm6Il1/jc0=; b=V7vu4MPPTc3MaEmF
	3FV9hDq70X+vOOx54C/DxqWzFkfrTHOZpShBpGHFdVx967BSFAUkN9MsDyYfrWmB
	bcjfMTeg/DJoIP4XFg/yX26MVub9Tmnw0mISKwxy2gq8HI4Z6erNHKS2LZgtVKkV
	ma6upZyo4l9L22HIFlR9L+2tY+CEpPOEqmPi3/Z5AqSR81r4ldxxxQhdna3ox8p8
	EdYkikX3NIXD8I6acAYxMauu1FD9L3E2sp86LG9ONJqruQJAujAEd6AbRwAthm8i
	YqKDg1Ff49JSzq6brg3Mem8AJNJIM1YxJI9uMowroX2RowdaYdH8vggj6pSHyZAE
	KNnQ2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agpjk801w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:53:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343d73e159aso11869803a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763459639; x=1764064439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPufLjmIrqMLSLMrepnxIXEELbKqNgUquhm6Il1/jc0=;
        b=TayY2rk8t858U6kGfD+xWWXOeKsSSrbxHvjxYDVuGaPwaEKlUwpN6GYZz1TlSzVEq5
         s1w2V/ZNYEDklFNuB/Sxky/SrkxI1veFKWpSSogIwH/pguIuPEY0A2t3T7pZ+8F1jp7e
         Xjy6a2/NhLGkOFrQ6coPNw5jDg+BsMByfBti1ebhvnk89yveQiZKX32bAEKIQZaxyCWy
         0tnKHUzuvZtKCPtD0ApvSqrO5pbpcb082jYsavTi0+Th7G6nSpoNZ8JWyrrsP5G+u3+o
         CXNugqgvqZFqw54/xg4K4PNTbTALlzD1X2xqS/piqz+elrRtT12GmU6ec0zQI48IXxL8
         koRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459639; x=1764064439;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPufLjmIrqMLSLMrepnxIXEELbKqNgUquhm6Il1/jc0=;
        b=ceaIWqxYLufzvMJD7dPJX+e5CLb5Sq3YxN0DrrLQdu7wJTciUdTQhNci9l3G9twKl3
         ZZb3jPud92AhwFq8POexSrvvgwnmP04mayVrDpey32wCGCxPJF+Fn4NsvxaTTeQLV2NW
         ijJ2gg3JXtg8vMwBA+Cs1xwzoSVanH5MEMkNTdYmGoTQvFN6J5EcGa9ISc1xxq6PKi11
         pa4U6RnSVEN+p2ITUDQLhh0dNWwHsI+DQuWj2PvWOg5BUeEA5Z+h9ZB8BUpErH70V3Kq
         hFB+F4ifqQ4vqsG8HN4O2pgZBpThJw1vAM3Sr5rTa2Yupz5TcBeE3f1/AYXd4d3rxDhP
         VPyA==
X-Forwarded-Encrypted: i=1; AJvYcCWdXqzJkFtzaCXIiiwngjbtf0pbeKz4NFbzQNRdlzhlYEmPfNAseRE9aTGVVIh+QD0/qKJdVcqmwiUHRfR4Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1GCpAVQPkrRmQI+TtKfoC9qW1Vxnhww6rrTJi/E3k6iHNFTh
	/IxkPohlzbKe3Bs86HLuFjGLJzWWs8P+Z5ObdzUBPSwrinpUsFUGwTfem2+cz52oC4oBtEvZpfs
	FmeDAO77ElKXmb8rszx60REoOmfdtLtjE/U2mhx1YeiCxHKymF5LqonLxEHS4SQ/X/Y6lUA==
X-Gm-Gg: ASbGncuz0E6sYMJb6lsX7n0S6SF1UelyMtQgFAMsL5Mq9sn0hryvyWG1tJ145xuB4ql
	nH1hKaxYFFJu6p4C7vv64HeHeNCQNymwTd39nDh71Z5v0l1JXYZtKAj9Jyond3e+PI0YWR12zMl
	zGoiJmJ9MqVEpt/Ftb15sxev74UjT67L6jacg//57D+yPgIe6stGNnEpVt/aS6ukvRZ8siDSfSI
	GUIBXPNTkwB44uyfftarS9TAxBqWldtl/eQCrHoUeiWW3ijsc9IwpnJ1MhmQ1zwRlGqRVHXc21l
	ElPqF6gAiudgrhzZimX8qF2bRdYnd0FDKsCtA/F4NIvh4bkaQG6CNi6maDnO6vPgSdYGgL/tmBa
	nXpauOPW0mVO/kMhb2U8/3rF9lQU7CtvRt1C2o/SHotz2/s/2ra/N7j6JACPikE4Yeu4SLdJW
X-Received: by 2002:a17:90b:4b89:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-343f9d9116fmr17829697a91.3.1763459638597;
        Tue, 18 Nov 2025 01:53:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoeE4yTWrswRWzDc+hCOps1oXPq1aDH32AhkqgBFvLZGGTCpqSrYv/TJJihXrjfjuRDAJWJQ==
X-Received: by 2002:a17:90b:4b89:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-343f9d9116fmr17829684a91.3.1763459638174;
        Tue, 18 Nov 2025 01:53:58 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c22b1bsm15751738b3a.66.2025.11.18.01.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 01:53:57 -0800 (PST)
Message-ID: <ddd31f03-8312-4e42-be97-2d2e1b390c76@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 17:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
 <5a308d21-d463-4d6f-b5d3-95a0c2ede2c1@oss.qualcomm.com>
 <aRxAa8OYCZqEx7Da@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aRxAa8OYCZqEx7Da@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IgPcVM3-mlSoavAo2dApVZcyMNsb1XvT
X-Proofpoint-GUID: IgPcVM3-mlSoavAo2dApVZcyMNsb1XvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA3OCBTYWx0ZWRfX73co1jff4qCD
 jmb5G81EO7ayBS4GF8VpGIcnzrgkap6556Ih+Zj35oA7d58JobMDufTyIpl3V3ff+5zNVV+tLjs
 7jE16F8XHj9nc19eLms5+ZDcs9rT90Sd+ltEYrwjECDZJL5NbRk14/JAEkXBdX6sy+qENTqp0lI
 A+avVsaZb0LmlplfrJQD/+/yppea9hJ66++y8K8n+VUxoj439+dsaBhbRm9Eoo8JJLhfNyZYDpY
 +gNChW2n1MA9wGAZhHuYa5dYFmuXXZ/jzdYAjb2hYwhdc2X8vxQQIkjb+C54wT8+2Jd4JAbabbk
 +rJjZ27nBf0G8vsoJYNb1azqXgkkv038kBlDOB8a0Xi5Cwfy28CueMczsO3+XzWE/HIdsTOaQNC
 7wjZbJ9k61wkAoon3jKoeOyzwhoBhw==
X-Authority-Analysis: v=2.4 cv=N/Yk1m9B c=1 sm=1 tr=0 ts=691c4237 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=HCAvJRNLDqgM5c4XLS4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180078



On 11/18/2025 5:46 PM, Alexander Wilhelm wrote:
> On Tue, Nov 18, 2025 at 05:35:09PM +0800, Baochen Qiang wrote:
>>
>>
>> On 11/18/2025 3:21 PM, Alexander Wilhelm wrote:
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
>>>  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
>>>  1 file changed, 20 insertions(+), 15 deletions(-)
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
>>
>> should we also need to change its type to '__le32 *'?
> 
> I saw that in the 'wifi: ath12k: fix endianness handling while accessing wmi
> service bit' patch where '__le32' was used? Which one should I preferably use?

I mean, should hp_addr in hal_srng structure be declared as '__le32 *' ?

> I'll change that in the next version.
> 
> 
> Best regards
> Alexander Wilhelm


