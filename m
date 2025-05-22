Return-Path: <linux-wireless+bounces-23272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA92AC0448
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD733A8026
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58681EB5E6;
	Thu, 22 May 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OB1v3jBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154741F130E
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893254; cv=none; b=cE6m5wWwFNCnsMSYrM+PjT8axCs3R6U1bYtLxAR2spSOddAxpay8+2tpirjt4Ou86xHU7dgyO2Ljs+HPDXEJR/EZReDJI03Ghy9gD0eJsMhIhMTZQu3i0R76CE4RPXstEVQHrNSCO+QIG6a8hVM0no3/hER8h+yNoQcKbtnUxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893254; c=relaxed/simple;
	bh=Kem4hsxRSdnu0Xw4O6zQ+/LXEZ7da+pNevSRD2icm24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DpJLcn8RpMWu7QO/3fWvRvnKbEAx76kOz01TRlu0e00vRU0WrMLsTfD4VKRcslQPYnQBD/1++3YXaMmy6WnrhVlc0euOBuQrwE3mANEjegGLjfJwQlR4WLx+Ilp72CYrNlaYXXv1sQAIPaqO5a59n/cCX6mpOZVGm9EqTffuV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OB1v3jBz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHhAit031705;
	Thu, 22 May 2025 05:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GBNsclG0h+c18QHCqubYeLlvEbPGDwLFjIE1GxmBjig=; b=OB1v3jBzUlLlz88z
	V2UkfWZ0KecStSBW/wYtBLnQ+v7h7c2egtDvvd8J8hC8kN4v/cvZNPOYu/I34Ef3
	VCPv93sC9O6NjPfiyH8H+WM2jfAQwOkMkj7d08uo2Dyz57XKK+tYnQ4j2QDUO77U
	ZHRfyzXs9ZbMrg0qdFNMLFdSr+0cpfytZcxPEIE/pYL764EjS4oDhzh3wKp1XQO/
	/qQ1UT5snUZGUJtgMET7kgcATRmg3EJiEOzljJ6sgLsjrY6OT9EC2ZBstdSc5x64
	97f5l0KQKIBXEaTBCh9VKBnDzJqeYmV9qICcll7hp4iJ2NDvNk1gQD3gNl/Liv39
	o+zMLg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c23qcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:54:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M5s8e3018946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:54:08 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 22:54:07 -0700
Message-ID: <3cb77c8e-06c2-4a99-8390-c416fb8aed6d@quicinc.com>
Date: Thu, 22 May 2025 11:24:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
 <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
 <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
 <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
 <df3d08425fc7d5db127ccf2e84c258b7c728b751.camel@sipsolutions.net>
 <3e19960a-4809-4215-b6ef-d66d6dcd87df@quicinc.com>
 <41ac222861e4667a66afb97b9b0346722ec616b7.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <41ac222861e4667a66afb97b9b0346722ec616b7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA1NyBTYWx0ZWRfX4zliizf3nyQX
 gwXxABYkvO+4lD0tgVStUdivT+dGBDKHoTBV1HAC6O0Kb944GpnDu/gB6GXCZhRYMagW0BOvajy
 jKbdterWRMmcfq/4T+Lj0Ph3F1auZvPP/Jz0vunmT98cRhsHFWOY7A348eTsj4nVfDCzhEHYB/L
 V0U1kaIg12JY+wSPDSITmOpvgNUbTaNz0QHr0Npc6PMEmBZeY5basj7Jsm3e+MMcama8Bn4SYeE
 +Zw5wwTT2+aHvHuaEp19jhklbajkTfKQgTqiGpE8d1Pfp3Noo3+6Cc/urGIMja+MQTaCc9c1Iba
 TqbIi7ExSrLDSjdzSzaYT+ObZeb2AaT0R4vlZJMRsmzKVqKlc7spMWZQbmjS3PEDxqUuEbgKP77
 +hcEA1tQCYdIoH4jkRNG+GBdgyTesbP20h34tbywbcjEbqIt5243E5aLfH5IjpRKOLAEwgV/
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682ebc00 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=7aYAAM93CBTB0vGBoOkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: anwl6PzcQR5-ybCLuNntiT1eXhcQmsaD
X-Proofpoint-GUID: anwl6PzcQR5-ybCLuNntiT1eXhcQmsaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=688 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220057

On 5/22/2025 11:21 AM, Johannes Berg wrote:
> On Thu, 2025-05-22 at 11:20 +0530, Sarika Sharma wrote:
>>
>>
>> Yes, there might be chances it was used before.
>>
>> Shall I do this cleanup before this series something like cleanup to
>> maintain consolidate data for tx_packets and tx_bytes as nowhere it is
>> used per AC?
> 
> Let's just leave it for now, this is already enough in a series.

Sure, will take up at later point.
Thankyou!

> 
> johannes


