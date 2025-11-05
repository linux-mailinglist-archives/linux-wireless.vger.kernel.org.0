Return-Path: <linux-wireless+bounces-28639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBFC38048
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 22:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB474E3C0B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD923F424;
	Wed,  5 Nov 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hvicQM64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790E142E83
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377995; cv=none; b=bhdA1Uo+xvXSksCR4/xlL6V258TvXoxwcx0yNkZPB58o7IQdFZ56HodKCOeH9qV6iGdf1lHqd3JgkjRDc7CuVTJTuJ0NwpPrd+vo03+EePCR1VjeA47drcmOUL8k6VRAjMU2nLZwo01IZhHZht/HOBUsxA4O83GkV8e0FYId718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377995; c=relaxed/simple;
	bh=dt4EI8dEThPviwygHXBfe05dDrTJeqOsXnXTxQGt0d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G0x7zofa6P2DEZiAHqZZR2selblcI1aV0M6JiLN57uWIN1bpuqlqNQJ2aI4zph9t+yMTbBjRgoDtnYT2YcVmF7srehlgBtK4cUMYp28ozn2FXdj3MkGOV4wklRU3PyP+dZJVQDCxgHJLHvZJsEVGVZ63ZbjItwbtC39Kel4SGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hvicQM64; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFJA51850415;
	Wed, 5 Nov 2025 21:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXoBk2WA3kgqcQll08NfBMRYZdvwV5ZymPrenJIJQiU=; b=hvicQM64WUnYg4J9
	I9SP/YTZ9i5eo3IF/UqgJDYm14PH9wj1MP8kZmwUSUCx9lPIYg/9ikA/xuxrEuuj
	Z998R3aNPslDtQptcKg4RDmn6AcGcsLYMj5UuSPIQerQBAWwLka/1KTljL7TF5bI
	CEO6AED56pe5JNF5ehW6MA5IrNyJ1oE+WFrPj5AIMKc8J366BFEAbENE51yqSS3S
	QdSlJ0L7RkZ6r3OApNscyLULZ/du/vPKcP7iMR8A/RBhY/fxKSTPAAQu1rkqTVEn
	inh3eBenAzLuYYJsiyTelS5c7wTYMBDnapc1wmPXZNnWkyFGyisIbNEhTr51+OLF
	y+WolA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7yp62qfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 21:26:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A5LQQmf016436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 21:26:26 GMT
Received: from [10.110.41.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 5 Nov
 2025 13:26:25 -0800
Message-ID: <ca61c6dd-b1a6-4f5f-aff1-341a8c5f88c6@quicinc.com>
Date: Wed, 5 Nov 2025 13:26:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <hostap@lists.infradead.org>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Sathish <quic_asathish@quicinc.com>
Organization: Qualcomm
In-Reply-To: <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H-KqYA_SKsafBJzKx0OMbKo5fuO6tvhi
X-Proofpoint-ORIG-GUID: H-KqYA_SKsafBJzKx0OMbKo5fuO6tvhi
X-Authority-Analysis: v=2.4 cv=TsrrRTXh c=1 sm=1 tr=0 ts=690bc103 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tBHhnF7gIzYDTaLQyKEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE2OCBTYWx0ZWRfX8cK6tnAindNf
 3lpEV3nDrhwtgdCdWu5t84oQM4XhqSetxNyd2rfw2Qi4D/8bczrg3FNIxYm8pQVuXhtmktXFYWS
 HximIpzMgCuxHLg0ac66NIEc+AjyLOddzfP8ty34NbVZ14/znDw0FJpqSZsqRnQu2J3OdN6A9/o
 7MsL15PtetezBwnKQXDG4TEZm4qgOAsGjfEabK6FkNwfGDMC64SVvHRSE0+GTxiqKei/eRVgbFD
 xvevzO9xtqYozn4j+8jYGViOEJErTV4f3HW35rQUVX6yDjflUVTGrulbQEwSZTpYiupoVGNtUcW
 wWzmrrJvZsc9RVp7faLbcnbsglhv8BZ6pit9dlcg+DyrXyhHiXSeZEFAQb2HeS4X0GOH8i8k1dg
 lRWeI8fdyNhbzZbeA6kj12b3OlRK5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050168

Continuing on a message excerpt I missed from Johannes' earlier response,
since it is in a similar vein to Benjamin's response:

On 10/12/2025 06:51, Johannes Berg wrote:
> That's not _really_ a good argument though - mac80211 will likely have
> to process this in process context, likely acquire wiphy mutex, etc.
The ST Execution sequence — which includes receiving the ST Execution
Request, sending context, receiving a status code from the target AP MLD,
and ultimately sending the ST Execution Response — is largely client-
driven. It primarily involves parsing management frame content and
handling context data embedded in the skb as extensions by the vendor
driver.

From the target AP MLD side, we do need to access the generated group keys
to include in the ST Execution Response to the client. However, beyond that,
interaction with core wiphy data structures is minimal.

While it's likely that mac80211 will operate in process context, if our goal
is to minimize latency as much as possible, we believe it should be feasible
to implement the ST Execution logic without acquiring the wiphy mutex. This
could be achieved by isolating the ST Execution path and leveraging a
high-priority workqueue, thereby avoiding unnecessary contention and
improving latency. However, this is, admittedly, dependent on the tolerance
for complexity in the mac80211 versus the demonstrated benefit - which is
something we are gathering experimental data for.

> 
> johannes

Regards,
Aditya


