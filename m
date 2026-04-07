Return-Path: <linux-wireless+bounces-34421-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK21EZWD1GmVugcAu9opvQ
	(envelope-from <linux-wireless+bounces-34421-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:09:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C473A9A32
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB16A3017C2E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 04:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB243783B4;
	Tue,  7 Apr 2026 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXodyB5G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQVeje15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EE377575
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534984; cv=none; b=jFL7CesGc6kGKowShsIWePOxtRmdBpcV+2kU0lvyM7sDZc0V4AghvUC4x8SmUA6yHiO32syfCG3FmwNjDEkfTeBNJ411xWtsfoOQ9to+F99RqlR/uG/GR0TLuHhIwS3aMMkcRxRJct2hlfmhDwoIQmCPyTpDEtsM66K95yMvZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534984; c=relaxed/simple;
	bh=EvIHw2ewIj4mTh4EQu3rpuiCLWZfjujuPlNXzm4rxGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVUdytmLBBDY2YlYhiUPdeX0T0Bs1gCGqwTLvdhU4UI5YgXTIzpawyPU7zL16mQCVcfvVyGHg9anCWxcyp3RDEdo4qRn/+Nitr3r345QpAA1TDMpkjPtmz4HfC342oC3P/sWwuUZ2hgAvIXoKO4Ae0ttbkb12U07o+z3me12elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DXodyB5G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQVeje15; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LSDVD2009900
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 04:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1PBnRYiMHE9bP8gBrDCBrqQHKpcg5j89FyJ6YAHP68=; b=DXodyB5GNWbqa7rI
	zquYJZH8hdIIYk2xGVEWCHzdnp04LITO+wtlwTFGUU8SAKoxHiHUMts6/E2pYd5p
	jswPG4d+duFtsrws98P7lr9w8xCpjqkXcyDkzZEhiHNyRFN0qRm7q/cAesOi9oU6
	DktKQJBSGGGQzaoWeiBPVV77/jLH9J/tkhCYNvZD4W9BXZXu1YszOj99rsBKfacy
	7Q7dS7t170TZOwTn07iyjfclkBvlmmrQjftPefcZeymxMPJhf/matEZ1mxpglF8Z
	shY64o+HgpPKPG0q+mGLwbIg6Jp8vd3ZW0p7IAy0svEJoA0c5O7gTsfVVeJsnoGK
	jiS/tg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrrxnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 04:09:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76fede6ccdso90002a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 21:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775534981; x=1776139781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1PBnRYiMHE9bP8gBrDCBrqQHKpcg5j89FyJ6YAHP68=;
        b=PQVeje15QIjnOeHtwK7zVlgs0SqPJek1ui4WCvwY//3Q0nWuMh5JqZrFojG32Aoa4b
         M9MgOeM4T5OVMxglVD5sBkRJhcl+vpyQNbTbr9mORrWQy3e5n1lSZpewbvZNxq04G5s/
         3dL5/4zNVep69CFIHJIUZUs8NA/b/gglTBS28CY33968v66IcSHnSfJXCRC1hjFynUst
         MpqzMuRWa4aQiKjxzODcNO8W3Aae+lASh4GaumaP3961Puu4PUOcro2/yRlYtxvdbng9
         iWDR0nWxIHDrsKpLqga8TURp/3VE5TG7lsZ8dlAa6WaRafV5iHLYNcDsXaNcUv8fFrDV
         Dfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775534981; x=1776139781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1PBnRYiMHE9bP8gBrDCBrqQHKpcg5j89FyJ6YAHP68=;
        b=DJ4WAzkLVii1rPGU9rXZ00mdURjMfGwsWrxEp/QMoywsjsdVxl1C2oNHJatLknG2nu
         viDvB7CvkWnV1NUZOgVkE1l+Ip/quTLxdlb46FZIIOCn9ELoi/U4ZlGKD5EUhh5FciTS
         QmXr6h5Id8W8bu8dDIDkqMjf9n/jw7laK1GFLQRCiJP6xKJ7uvKIGy58/8RGv9GCgtwK
         QpJ7gpY69+ErSAtD9JHw/mImvXtDwlxhHKzA2KCJ/w9GTeC5GlolTyTbVKFuOu5Mr67c
         9sDo26BccVwFlivSbFz7fCprkz5VFwQhHHtIEVbuH+F7a0J+/ULEPaH5A4HTHSoDeqvf
         ILmg==
X-Gm-Message-State: AOJu0Yx3R5hPr/PbJwrDXxx1FC3m+i88fKcv10Lk2F27SrY9pfQqElkY
	oyI3K+IEw2oaALWDcAxz8biklM+rYUIW3Uoej3S5o7wcmFoO3zDkzOCF04GxVOgOm/qF/oooqEn
	NDsDkuDrcI7i+K1FKnpvDH0VUj1iFtXZ+PxDwdeAJX0ChhFVMXPDvouGBTmeKGM5zEOj8GQ==
X-Gm-Gg: AeBDiev3X/U9umE9yY+ZW3Rokwtx7NXDSa7liFVrryZ8yf3bfOSUuP0B3TKSL7iiNy9
	eW33V9b6gUp2gIUfIQJk+zl5r+bDtw6bcgj2MhP+FJdmtQ2m0H/1lwUzwQf3KEdsnAxwh30UM7B
	19kIx+GHJ1FfzGU30oUQQZWrn0r7nzRLUPs98t9qY8R+SSVN4OMemfHs6tnnFplTKJQlWrSXQMP
	iIOs8NCWmxIeb7cjZJzFYHY2vDs1es+gT0RX5ONCic7dZYEeJa88I5kiBaN+l/yyppgQ2zv0v+E
	2svr4rHr68eydNM4lUubY5rRYy6o5YvRFy5mtuzkSbD9KGJtgaTwjKHegl65B4RT4UYMr8DYwCh
	4owcYuSNKLBbSr39v7yY0nF+eEdrhMMMJyEWCvG8t2UmqrYo/3w==
X-Received: by 2002:a05:6a20:9144:b0:39c:4af6:4309 with SMTP id adf61e73a8af0-39f2ee00378mr16706179637.12.1775534980703;
        Mon, 06 Apr 2026 21:09:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:9144:b0:39c:4af6:4309 with SMTP id adf61e73a8af0-39f2ee00378mr16706057637.12.1775534978399;
        Mon, 06 Apr 2026 21:09:38 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659bedesm13411678a12.30.2026.04.06.21.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 21:09:38 -0700 (PDT)
Message-ID: <27cddc5f-888d-4f80-94dd-fb650f4985ea@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 09:39:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
 <5a606f7d-6665-4b0c-bbbe-32538b2315b6@oss.qualcomm.com>
 <95face24-deaf-47c4-935d-0b48b5141371@kernel.org>
 <09fb6efd-646b-4d0d-a0f3-9f6ce4b38442@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <09fb6efd-646b-4d0d-a0f3-9f6ce4b38442@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzNiBTYWx0ZWRfX0I8xKBMBODx2
 R25huxpyUWHUX7Y3gul6li9ky5rkM/c47ZXOm+24oXJmgUZZL/u4aVUooDiq+0t8dx9A7hTeuF5
 SqltmsL4L4pHSNh/qtWdi8pUbjQKUlpKoEKD46Ect2eY8KuIXbkgw8PleCJgcnzxwr6L1G6jsuY
 jmmkt8Ia1b7R9CD6xiSdvtHlJJA95GDYu4JdtMGq3zW1J2/WfxxvlL+HDVX1BnT8kleoq5koOUP
 xbd79xu2jW1W3hZXcIMqxv8FHeMGwKRO3k4V2UsIlgXWLgRE9jXzWybipKPgmID5JZgF/MsJ+jt
 QC7s1R71VY8Bc6ENbO/UYsVmOoDv5jwmiHbl9oHFhLoKMQQJMx2fEPhBBVEsNBhq8FTHNv7cEEn
 s3CoJTGWGldND/xstVZFXLhPT4hhCB9fsyiz29/hf5k/0MnvLUsAJ8HLRWlbNOIdtNC/PzeNWFa
 Wj/Zq/ge0Bvok6W02hQ==
X-Proofpoint-GUID: i7f8jv6q8Y36TJLo35zfv_nd9BKYjiwG
X-Proofpoint-ORIG-GUID: i7f8jv6q8Y36TJLo35zfv_nd9BKYjiwG
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d48386 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1nfJcm5jcH8UclV2M8MA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070036
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34421-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A3C473A9A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07-04-2026 07:53, Baochen Qiang wrote:
> 
> 
> On 4/4/2026 1:23 PM, Krzysztof Kozlowski wrote:
>> On 03/04/2026 11:13, Baochen Qiang wrote:
>>>>
>>>>   .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
>>>>   drivers/net/wireless/ath/ath12k/ahb.c              | 36 +++++----
>>>>   drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
>>>>   drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
>>>>   drivers/net/wireless/ath/ath12k/core.h             |  1 +
>>>>   drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
>>>>   drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
>>>>   drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
>>>>   .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
>>>>   .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
>>>>   drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 93 +++++++++++++++++++++-
>>>>   11 files changed, 231 insertions(+), 21 deletions(-)
>>>> ---
>>>> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
>>>> change-id: 20260331-ath12k-ipq5424-cddb63a46a97
>>>>
>>>
>>> only nit in patch 2/6, so for patches 2-6/6:
>>>
>>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>
>> It does not work like this. Replying to cover letter causes that all
>> patches will get it. Provide detailed review and response to each email
>> in such case.
> 
> Got it, thank you!

will address the nit in patch 2/6.
As intended in next version, will have your Reviewed-by tag for patches
2-6/6.

