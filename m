Return-Path: <linux-wireless+bounces-29268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B6C7EBC0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 02:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7721E3A4801
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6926290;
	Mon, 24 Nov 2025 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XzYddLlH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V8+OcMca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D91804A
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763946565; cv=none; b=qrSgXPRy3fTnR+mKuPUOSr2Alu6EDcri91NWoxxQD57fXPhbDYMB9XqPQNIQ+FTJ64LEUEttoUhP/d/pUs0MiHvnIVUoRwnoB0dIn67XUTRBi2P8JxOG24UbLNTy0ti40Dv/SG0xSDobrihxKH1xZhAmB9/wZpwbydUI0u0katg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763946565; c=relaxed/simple;
	bh=2lq6lDSZH3TSm3WmHAv+nta7bU8n48bnutFxFs5Yzys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNF7A6W+gvdkV2C0kVnc7t6mHfs0jpS8WC3GhnLQ/zcxJ1jcvSvzDoZVMdRWvKiw4MbQt8aywQn8AWfrHOMp/KnO11jj6KZADQsKTJBIzOXnKFqLaGgDkI4EzZt1v2ZoqwWcvHuANatAuqC3wEeKNBBiqkOx+IdGToeUPbBWQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XzYddLlH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V8+OcMca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ANLl6Qt2293119
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 01:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	McpwoqNXGS/RocSD4KfH9RgEXzDojkwJg9omrSOGFUY=; b=XzYddLlH8IGpm5k/
	Hc1JfnCCBo3yv6RVVS3ok2SG/V/7vjHL0nq+eIxSzwwsat0TEMeI0IYrK6A7RTWH
	LBAW5CQ4emXThOu5TE7GNlHeDhZSn/r0r3n+2S0RD9k1sXVilXfTtmjj53VSwCe1
	I4Tc6y8z0nARkwCXRsFUVpRc3irkeAXDE7vAAL8Cj2fJTN0ELjBvyUELmOjUFCZ2
	GxSdCzTH2JeArJOqiF5z36fpe9K5V8lzOYQwQ5n2jvmTsdFYiDz424q0u1AMviv7
	1PlZ3Fwg0z38dzA9LDkd5vu466DMLfdDLsilYdG9RDbIkDczjb1miXlacUE0u9Fx
	b+pRZg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak69eu5x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 01:09:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3436d81a532so7909859a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 17:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763946562; x=1764551362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McpwoqNXGS/RocSD4KfH9RgEXzDojkwJg9omrSOGFUY=;
        b=V8+OcMcatGMc39UAkq8G4W71JOQWuDKeay7IECGmij2P4l8ReAC/buPFIB7J9dUJBd
         FmkfCvKngkH4Y/7dBdZaBzqVNq9rqVYnQob+cTzCtzV5mWj2R4RhCxVKdMoNhd+jFqL0
         aTgvkGGA0G6y+4fRoaYZqA4C2n9YaRWiPpyqsJG4Hte4BJyhag3H9GimyKqp8HWCG8GZ
         QgcnoCqetMJEW7PUfBqp+YprSyRfsUNPhDk1CEd8R5JXH0BPrGYNsLdQ4HG7eYZvW16z
         Te6Km9W05/l169WNNGIHTjLLJn1+lWs7qFn0HG2gbiMuPykyprZVHzE37XgdU8e4BLjT
         yXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763946562; x=1764551362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McpwoqNXGS/RocSD4KfH9RgEXzDojkwJg9omrSOGFUY=;
        b=tUN83rg7UlKNBlVOvF4/N9RubH7fJTVAystQtbAA+3RzP6MqY8ByZ8RgobsxVK72rF
         vSVVUIQcnZ/pWtWsGyfNYc/EY1GrtLkuQUl4aVs0oLLAg5XEALWnu+cYBugHzIyYL12a
         g9x1ahImM0M3IALCgRP+qZTPadr5Nu7Rqn8pjnhK6EYeZizBz7bz/piOAzxg8vh4DbBP
         waPHUdvBhHlNrUSKgQ9usVit05ocLaPD/+4S4vPEki25jBPPoct/v7kl4sFcaNErCVer
         jzbKG46oXnkhTYVI0jUlz+HwMYFUuxkmAC7FfEv3xfu9h2YSM7tHt4o6QGO9lPPNs9jB
         +XxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvZ912WML062SiSOP+zrRJJiAzOnsCy9uXBxVGKgjQO6Yx219+/DECkMaaJdXouHw2fCrpAod9FrW6a3YLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyppgvIVOjd7Of8v/uLaVMc62v2zPRLe0aVbKyNRiFXtRFGc040
	/vWm0Ge1JclLbF4Dd5n2MDRs9FMrEDpsO+E58XjDFfATYFYzCOFstAfwnW42aZtt/PoYzvK/eg/
	U5btHPUMLa5jLePV530gT/D5bs6Vb53usQSRXJTAWXHG51FbYU46RUdCSaM26yE7Z4Hn4Tw==
X-Gm-Gg: ASbGncva5hut9nWzqd8LDAURdRy+4zAWemW53ZHIVDQWhH7Y5wCAVKcb73J9dEETcmO
	xanxmLKRMS8/UEtGYFQGI2xEQ2gV6pvzf+AuUTYzkscj3+dGTyN9zA95/xEihLxpXVKJbHkAJVj
	oH41LEtv6h6e3HKWnonMP/ybt20UzBNE5+PgosUKe4MMmLPaGhZX5L57ov0/UkvuJi2r9GZWrKe
	DZ73V8Q3/PTdyoBFfKusbn8H2cXatKQbTmzNDH/nFEKyPta7/kL9B4rITdvBZuPQvIoGGJtx3Ul
	j4klWjYQsK0lVCfAE1x68HQUjGQRjmF2XMwNw7yIRPpRZimwbaMFEfN/vLqvQE0bD54RpWsTu/0
	hpONnxoQaH8n70zXc6tOUbmlt1AxUu1JS
X-Received: by 2002:a17:90a:d40e:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34733f5b784mr10794115a91.35.1763946561911;
        Sun, 23 Nov 2025 17:09:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3hpThDRzrXX5W3YAZ58mr+1Y4niUPT9AW52f3JtZwyrZwbfFhhnTBId5teIW02fQcNgldnA==
X-Received: by 2002:a17:90a:d40e:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34733f5b784mr10794096a91.35.1763946561424;
        Sun, 23 Nov 2025 17:09:21 -0800 (PST)
Received: from [10.231.195.11] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed379558sm12410583b3a.25.2025.11.23.17.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 17:09:20 -0800 (PST)
Message-ID: <4a91f85b-12cd-42b6-854f-6e9574392791@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 09:09:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_yuzha@quicinc.com
References: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
 <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
 <35c554a3-efdd-425c-ac34-858a927bbe15@oss.qualcomm.com>
 <e7e4058e-6f95-444f-b843-d942496dcf07@dd-wrt.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <e7e4058e-6f95-444f-b843-d942496dcf07@dd-wrt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDAwNyBTYWx0ZWRfXzfr3MxKEvMqg
 WOA3q8GJB6mOqjhWVD529MlfOXKyu+COxhZ4WTVs94PaaRSf7OUsniczfBWS0PRDIKU3DxnpFeL
 e1Ro0jz2mTFgJAfGCQVoi62rdvmZx+drbOFC38cN1BADtkvRXyDzsGYGRHS0lryA+m1TqdzVF1Y
 kS4H0QiqXHG2XemdoTBpPD+gofg5VZ8knXngobtq/KTC++iRndmkW4fAyLFQVrNoACIyDKbr45q
 Xv2hHEoHCqZY4wt3U+cCvAs1PMjk83mkGGbxdvh5gMR9FLfMOINq3bxKDXC+An70CwSqC9nDoVh
 6SAOzGbVvjVPCbRadWrsDxYio3WDNlOj1ADt0o+jFVMPkYVyUbyw4jCIZy1NG5PLS6dLt62qoa8
 ZfOkCb9jtwyaxDmuO6A20NsTqXxVVg==
X-Authority-Analysis: v=2.4 cv=cMjtc1eN c=1 sm=1 tr=0 ts=6923b042 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=T51TZME3aqD6E_23_x0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: gMAuSBUqoZoX-iVNOK_hwHjx3BgvJKsx
X-Proofpoint-GUID: gMAuSBUqoZoX-iVNOK_hwHjx3BgvJKsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_09,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240007



On 11/22/2025 6:17 PM, Sebastian Gottschall wrote:
> Am 22.11.2025 um 08:55 schrieb Yu Zhang(Yuriy):
> 
>>
>>
>> On 11/21/2025 4:41 PM, Paweł Owoc wrote:
>>> On Fri, Nov 21, 2025 at 6:00 AM Yu Zhang(Yuriy)
>>> <yu.zhang@oss.qualcomm.com> wrote:
>>>>
>>>> hi,
>>>>
>>>>   From your log/calltrace, I didn’t see any errors related to MU EDCA;
>>>> what I saw were related to SMPS. Did you also add changes related to 
>>>> SMPS?
>>>>
>>>> Yuriy
>>>
>>> Hi Yuriy,
>>>
>>> Thanks for your reply. The ath11k driver is version 6.14.12.
>>> Everything works if I remove the mu_edca setting without any other 
>>> changes.
>>>
>>> The problem doesn't occur with the newer IPQ8074 firmware, version 
>>> 2.12-01460,
>>> which hasn't been publicly released.
>>
>> So the newer IPQ8074 firmware fixed this issue, great.
>>
>>>
>>> More details: https://github.com/openwrt/openwrt/issues/20702
>>>
>>> Regards,
> the point is what he mentions that these newer firmwares arent available 
> public. i provided openwrt these images for testing
> so he is asking if or when qualcomm does release newer firmwares to the 
> public repositories
> 
> Sebastian
> 
>>
>>
>>

hi, Jeff and Vasanthakumar

When will release the newer IPQ8074 firmware 2.12-01460?

Yuriy

