Return-Path: <linux-wireless+bounces-21971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD4A9AB9B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B6116BAFD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8971A316A;
	Thu, 24 Apr 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="esXOuIbo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687A20D509
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493705; cv=none; b=ggdACrH5rI9qe+0YpZFvWlnZCUXaaER0eHsXucTv7E1VoxvlGKH83d27sMhU3fsc02pMgxRlccRoN6wxdaUQFlCcUCE8QuwwXsnoLU7TMQgISQYdgfNMOTjJdN3jZo4S+s6oRFuRA5My40ut+ZoRTXRnevbmPTrtYjw4kwYplqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493705; c=relaxed/simple;
	bh=u86lt/41uvNWxFNFJMbIAPsyOPgc7Z43lw26QiplGtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDUI93wmOoGF++iR3ZkJkd21IxVpQwQmBLaZXO+MkarLzeGNd8q8ohpTcCaBuCgTBb4Ns8gajRWZvggCws+BmIZdCyVhjpo3AqmzwNrULMHRLq/7geFmWJad4yxC77tbouNWLgqpQWHFtx3kfrKJP5XazGN8dqxPtfGDMwtwzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=esXOuIbo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9r21f003397;
	Thu, 24 Apr 2025 11:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SX+ncrSWnDUTM4Nkg5O7Af+7ogiQOuwlCJv7RTKKamw=; b=esXOuIbo862xhYss
	MLaPVdHrUQPKyODzTW0c0QOAA4n8rJUOIgE4+sZj8LaW3uajeKo1K2KnoGlAzdml
	rw2Wr4F26swiPLj9vAM6eWTqPfS7XJbGn61F7BSONdstc965/La6+NEW6lQ6nfrg
	86wef/Zuzw57KfobnAt7EX0NwTCAJbnCGDINecddqueQlBvC2VksIFZKG5TWRLAJ
	9Q4guvkzJi8Tr8bUBSdVwp7M2tBR5LPEesoBDk8uPt+Tw+NutCLHV1ZwuB8nnBil
	8mf8f827nEzTCYZdxkvek3QoIxZzbMDWgqTSypX32/HO7nSu02QdLnJ99OQPfm+L
	dxXJxw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0namb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:21:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OBLbWd024520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:21:37 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 04:21:36 -0700
Message-ID: <ec468183-9714-48d3-8581-a7f84e926969@quicinc.com>
Date: Thu, 24 Apr 2025 16:51:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 3/5] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
 <20250328122519.1946729-4-quic_rdevanat@quicinc.com>
 <f49009f55083da63239bab6fbc0886dba99c52fe.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <f49009f55083da63239bab6fbc0886dba99c52fe.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MEZEzILq6hODg34m3gC89XokTLyCzQB4
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=680a1ec2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=u5QtEqswIpedqItBNL4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MEZEzILq6hODg34m3gC89XokTLyCzQB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NiBTYWx0ZWRfX2h1CwKsjmtMo +XsMYlRIxRcG1RcmMs3H5uBNVeHIbLBOEkyPe7Ca30vNuigpsgNjuFx1Mnt07GGg9QVuxKk4Yct 9iyOj/CEk6aGhYxG/RpwbJYqaMUoqsFIvY7ALIi1mJsjeGDzwe77WhJ5w0+PnyrPjPn8mDRmvqG
 3CT7vOoNtwmknZBfkt6vAkJyeRgwmB9u3fd144EeByhBMhhq0UzgY/+0/7jI8FmkvGEnYbKnvA2 TvEUYdjZod4S0aL6GAWMM4bCBBUBbTNtlow157lBxHegzSVVY9Ul1Yv93fJ2DURxvT31cIC6QS1 vqzZAHSBsTzPnsbfAoH7wRRd9sO2C8CrWMJ43kdsLEJytihJqB1tdjplTT8RVANsvbNVqRsy8DJ
 CWagKfKqxfdZu4uFv23sjLrJPVaSTtrTppiHDtRIvi4t8wA7Ik3gcl/VDSjIOBEBTIov6BVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=909 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240076



On 4/23/2025 9:09 PM, Johannes Berg wrote:
> On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>>
>> +TRACE_EVENT(drv_set_rts_threshold,
>> +	TP_PROTO(struct ieee80211_local *local, s8 radio_id, u32 value),
>> +
>> +	TP_ARGS(local, radio_id, value),
>> +
>> +	TP_STRUCT__entry(
>> +		LOCAL_ENTRY
>> +		__field(s8, radio_id)
>> +		__field(u32, value)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->radio_id = radio_id;
>> +		__entry->value = value;
>> +	),
>> +
>> +	TP_printk(
>> +		LOCAL_PR_FMT " value:%d",
>> +		LOCAL_PR_ARG, __entry->value
>> +	)
>>
> 
> I think it'd make sense (and be trivial) to have the radio ID here.
> 
> Same in the first patch, but I missed it because the print was hidden
> outside the context :)
> 
Got it. Will add this in next version.

> johannes

