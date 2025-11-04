Return-Path: <linux-wireless+bounces-28531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2451C306C0
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 11:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C00B421C99
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89B27E04C;
	Tue,  4 Nov 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LeGqwCZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ROoH8TYc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E82D3728
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250617; cv=none; b=HAGdNlOP+M3VEEhOvcMgD6ai8M+AhyXFfuFm0sAnk6AghsJRTFF95diYJT4u6hTcHVPrA4vkOCNtPDNmMUodI4ML6Wu0qQ6XOHZUmVix2dZ+aDfh0cNB3B9xiJPeTTnyX/ghB8t7U6DYiAkiLdNdb0FSilW47OEsoMuEu9/kyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250617; c=relaxed/simple;
	bh=MuoilC0VTOsrZEqJTfVH8oKLDsTK7+h4JzvfMEsDJ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzyj9pkP691vLaQ1sl0FX+zeJFke8cdAoP4o6dKBHtcm0gWNePwEX6nDpZeg0K8WvTT9p59l0pk/jGOlJDGaqbmV+b6RvjSGUyVusELIZmrcn9cSdUjMxgpmmHD0EtWs7wUAkzao5C7yidb/haa1+ycuXWrAv0Rla5VujlHweeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LeGqwCZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ROoH8TYc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A49dXHi1659026
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 10:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dnsHg7l7z3axrmeIt2jE59/8P+zW2SMfuQqPkc0ikz0=; b=LeGqwCZZ5ShC0529
	UiQg1OSdrOZHRMQUPWGQO+xi77gI31pWMJXAHeLI+TXLDM7mlOl/U01JgSTm9b9v
	6i7sWuv1/8ZGk7N6g4weCKuQQcEdJg9aa7FWZPsN3q5QYCXvv+K4/HrYKhiwNX1A
	O10EMUERs9JWIqV3DNlWAzXneEFzlin0Lx9w0uBeSE/LD49fYYTybq4jXok149iU
	NyZynKXBVH0z0l2mnMoA7GstrDzywy/P8Ti9f+7bpKD3Q3yD75piOYt88Dnwok6X
	ThWVFUnzULWRRY+Xb2AfT+ehWQYsLXMUJAdTP/YjtZDBMYOmDJhMTHI4ZiiVKP+q
	2qlv/w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7f2502jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 10:03:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3418ad76023so470836a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762250614; x=1762855414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnsHg7l7z3axrmeIt2jE59/8P+zW2SMfuQqPkc0ikz0=;
        b=ROoH8TYcPNJJKo6EpIxh2CkCgXcgE/EmFSjHBcpVKKifeXCScQRfZFG0antkkn8v8/
         my4hWk7A/Q6VGUw/2rFtb188byeKKH2GcMiHVMpneMg0kLYdf9tnTYmEPlEydqxQU+h/
         3+KbpZYi6cCafxLeVV0ULuhyHZeh4wuSuwtsgswlmRBznYpsJBTQK2Lj+JYCQp7eCN3B
         dfdvRwFr9PTuQuRK1ezs1tO6Rxtu9seN8CVaXEBYWoVAlrJyu8BCTC6kKsu7CwdR83iA
         ugT7YjbEi/PkcZEePWX/rY4Zg1eIe+XAI0dKFHG2s4lI+/o5kS+MgxSKhg/kg0HZNqfl
         NLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250614; x=1762855414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnsHg7l7z3axrmeIt2jE59/8P+zW2SMfuQqPkc0ikz0=;
        b=tn5cud4ooJi0qC+zlKmW3zkS6QZ/3TDgDhOb/28DRL7i2ygOrG2MWxzb1gn+q4l579
         MZ4vmPS6x9aGZEBTHgpQFCkBO2pBAkRTxhLZRn3ti04gSLqNr4ElaVadApJz6hvP4hFI
         7t5tEdTA0TeSfk6PNBmKmS828ZTA0PajwAankUKFUbcnCbnYa2eY0AeyaT+bf42Zqx23
         57z3cXKpmtiQujoPmUbrNFWUgzhjIe4xFHveC4iLOGHr2qvuy6QUWHl8twqBBJvE7bB8
         HItODynoHvi8sN2GwXWy3iDqH0jCuO17ONXVaNUtVAf2JMmnx3FGv643eEHn4SixY/Bj
         smcw==
X-Forwarded-Encrypted: i=1; AJvYcCWSMxUe15fNnMUFo8C2ZCOcf6jD+h8DCDiCRwEvFBh/PjZEJpBPUSNAxqEbb13y/nF7mtWjwt2VKucfQzC51Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/F9iPTMJarjAG3mcNZRKQxTZtRb4/Ag6w1F75w5kln7pIGva
	KzMpLZWUV06q99dbRFpa/Ag3a5zUCsWobBY1kxG0qXLM+sOSLzz2yyZ6CcT6FgpogOU8dRucHGf
	8atsXbf6neJHlRhNeMxPsccmcbDx4HHcHDsKhyVixxl4uy9czDSZdPI4Lh0/EmeNJ1yEEUg==
X-Gm-Gg: ASbGncuPxmw223Zl3nocMEZUTJnAOaV8pbfez1ExEy3NinqL7iyj6/wvbb8makPR9oT
	qD1q3lR/uNeNN+guBHmvLl4/NOHkQ2Ppmm7M26vTC8OrIiRyvx6wXGlbuZ+T/rb4D/T0agrMXb/
	kGSIQVeEEhTOdiF34t1KjhCgjsTgMjUdntlCBYjqdA0fpYl1kGJor54Fd4iZt22yP4D0mov4BTk
	lA7ouqxZ7mS2UKYlwlI/tDAZU+F2jNBPc6tFPube4msl1aFqYR2TecCA95jdmBbDFVEDSaqu8Oy
	39Ym9EF9i3AOILNdbRdXFyLx4obb0FwEoz1DiXN6CL8UMhaVyu7fIwLkFoZ44GbPPzJR2C+BPpU
	38TdX/jpxgmbZ0URZM/uh8fjMJq60YyhFRUJRyKRt
X-Received: by 2002:a17:90b:3504:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-3408308a99dmr21489991a91.26.1762250614099;
        Tue, 04 Nov 2025 02:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLU1b7XFdcUkAzLleqDxUjw0hBMJVxE2i1zl9Cml7kjB9Lu0pjsUx79FubwDh0FGlml25IvQ==
X-Received: by 2002:a17:90b:3504:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-3408308a99dmr21489943a91.26.1762250613364;
        Tue, 04 Nov 2025 02:03:33 -0800 (PST)
Received: from [10.152.203.89] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415994181esm4052328a91.5.2025.11.04.02.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 02:03:32 -0800 (PST)
Message-ID: <14787410-a5ed-4370-9b04-7d57d322e27e@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 15:33:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
 <fce447412112421887a1a81f5ada850e@realtek.com>
 <e79d3239-d536-45c9-b081-09ea7ba5bb00@oss.qualcomm.com>
 <DD5A1KBRHCWZ.RXDUFTTTZU4J@gmail.com>
 <5f5e23e38544400895ed888ea824cdea@realtek.com>
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <5f5e23e38544400895ed888ea824cdea@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dNyrWeZb c=1 sm=1 tr=0 ts=6909cf77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=stkexhm8AAAA:8
 a=PUqyzkP4zcmw8mfgwKMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: rhi-aZwqEUZ3DdT67qYiGnvX_AcXk2S1
X-Proofpoint-ORIG-GUID: rhi-aZwqEUZ3DdT67qYiGnvX_AcXk2S1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA4MiBTYWx0ZWRfX9+S3i7/05BeU
 thIhp1ei8mHCPHp4N61Xt7e1030I1ZPcjZz2EmJ+PVZJwx+KIia4vqeFS5qhPphY8NrKlZUBenG
 HjdW6wQOH+1hcT4l6+OKE6m78H9w2sVizdNAexLHHVdNwoAiaIXJQrUWNYWgbQ0a1UAzhIA7Inx
 hJmkLX/BBnlEZYJe5957Tz4a8DyJK2P58RyAD1W/8WfQXJx17VhzN/9InwaAvaEnOztOi4UvboF
 3fygdQlu+KtK5cHASTdkJ07+zFN78flK/RrO8p7eNhkU77QLvoscSEPbJs/Y9SKvcIHk5RBsAmK
 13h4Er5pKcaCHzVf/KG88rU68OlgDkYQOIs7kCDBCYeXmHJSc3buglRpZ73i4CnFURv08WEAHbQ
 6V6Pe37uI2ZqoPpmqayq97BwPzrF3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040082



On 10/3/2025 8:58 AM, Ping-Ke Shih wrote:
> Nicolas Escande <nico.escande@gmail.com> wrote:
>> On Thu Sep 4, 2025 at 4:24 PM CEST, Jeff Johnson wrote:
>>> On 7/24/2025 1:48 AM, Ping-Ke Shih wrote:
>>>> Johannes Berg <johannes@sipsolutions.net> wrote:
>>>>>> Before we move forward with implementation, we'd like to confirm whether
>>>>>> the proposed design looks sound. Are there any concerns or potential issues
>>>>>> we should be aware of?
>>>>>>
>>>>>> Out of curiosity, we're also interested in understanding how other vendors
>>>>>> are currently handling this feature in their downstream drivers. Is it
>>>>>> typically offloaded to firmware, or is the logic implemented in the kernel?
>>>>>> Just want to confirm whether all this will be used only by mac80211_hwsim
>>>>>> or will there be any actual users?
>>>>>
>>>>> I think Ping-Ke previously indicated that they were planning to do
>>>>> things host side? I'm not super familiar with the timing constraints
>>>>> though, so I'm not sure what that might imply.
>>>>
>>>> Yes, Realtek vendor driver handles the feature in host driver. Having not
>>>> tested CSA and ML procedure mentioned in this discussion thread, we
>>>> are also not sure how timing constraint to evaluate if we have to implement
>>>> the feature in firmware.
>>>
>>> Ping-Ke (and Johannes),
>>> Have you had a chance to review Aditya's August 21 follow-up?
>>>
>>> We'd like to move forward with our firmware-based approach (since that logic
>>> is already shipping in our OpenWrt-based systems). Perhaps Realtek can propose
>>> alternative host-based logic, and there can be a flag to select either
>>> host-based or firmware-based Critical Update handling?
>>>
>>> Thanks,
>>> /jeff
>>
>> Hey guys, any news on this one ? Seeing the ieee802.11 bn preliminary work done
>> by Johannes, reminded me that there are still some usefull parts of 802.11 be
>> that are not completely finished yet ...
>>
>> Thanks,
> 
> Sorry for the late. I checked with Realtek vendor driver, a cfg80211-based
> driver, which prepares CSA IE across links by driver, and send firmware
> beacon content with offset of countdown of CSA IE. Then firmware will countdown
> and inform driver when countdown becomes zero.
> 
> This info is still not very useful to decide where it should be implemented though.
> 
> 

Thanks all for your inputs and suggestions. After internal discussions, 
we have decided to proceed with the hostapd-based approach for updating 
beacons in the non-offloaded model. Once we have a basic working 
implementation of this design, we will share it for review.

Regards
Manish Dharanenthiran

