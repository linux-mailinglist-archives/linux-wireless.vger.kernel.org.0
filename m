Return-Path: <linux-wireless+bounces-23492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8CAC7C5E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF72C7A92D7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F73227E98;
	Thu, 29 May 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Te0d5q37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E828DB72
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516671; cv=none; b=lkkYXu11LGEvzbuS32cHkwfvjtfMJHu9yiey8r6ZnNv8ktoOWdLd78gx+z7w30P/GijaG/cwkT4p1Oy1llYZ2iiLyeoVkkhgl1GmRljUbjeZt7tXgLBvL8Un8xEPEecvlSogUvUKNqODs4PGcIQom/RLGkHheuS24VktBrBCgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516671; c=relaxed/simple;
	bh=WUM0lFoWWP3mduMSUP+jsqNwrnizgzfLSmsTzH2avyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZGDB6V4J3VH/jAlEN7Xzb6EqVL4i3cdaiWNxcSpb6HzXr4DGWkUfKQfSgVKLBCew9LNLqSQGDNekuGrlxmWZ6ATohtPUBMA6xNprR181ugKRv+GzijlsGGLCOnVZackn/G3wjD6xbiSopB7MbJTPj994fmyuwii8MToFKiv3D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Te0d5q37; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7sGRk004178;
	Thu, 29 May 2025 11:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KAGPYb4lv1qBi+buKG1DZ+TJkmqnXxubCnwLiGXMi1Y=; b=Te0d5q37z9Br8Hs+
	+idQy8OK2dIse49cXlI5RiAfkk8huo8GBpgWqYpJm/2cKlH/myw9ihyufUPHQ5b3
	3afMTSvg+mApY5D8ePXpUgP7X6dS0/0qKEmAHgi0nEZJyEmdhLO/Q+RrAjnPwgEf
	CJXsMiRGF9NzQ+JRuTJeHwhfK/n+7yRkmtcUlobi5YUlDL1lZNJZWRq0yTVW6RCX
	mCIPsgMFIsjeMa85/bnryGB7mas+uyx7C79sgT7YxXUwERISXjt5MRFk1drQI7BV
	n/5wJK+h5BimE6E4D/zFmfh9fDreOzvHT2QZ1NH0vl+p+o0ESzxQiLbiOQVl2GBm
	wb00Rg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d7a4fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:04:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54TB4OPv002410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:04:24 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 May
 2025 04:04:22 -0700
Message-ID: <f26173b6-d6bc-41e5-996d-c0cd64056b5d@quicinc.com>
Date: Thu, 29 May 2025 16:34:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 0/3] wifi: cfg80211/mac80211: Set/get
 wiphy parameters on per-radio basis
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <a3fd78c8-b156-42a3-89e7-f81af1ce4276@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <a3fd78c8-b156-42a3-89e7-f81af1ce4276@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -HmY1SI4QI7Z24jCGGzSe9w7jG_14VSe
X-Proofpoint-ORIG-GUID: -HmY1SI4QI7Z24jCGGzSe9w7jG_14VSe
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=68383f39 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=EWGPpJ2BpWR8XW2cy04A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEwNyBTYWx0ZWRfXyw8Rob80eRhM
 yk06OgW3rM377mu/w0jfdnhcdxLcmWIoOuhQq7MPFCVbTGRfsdZ46CFNEsZQ9uxc16UeO96rL2c
 R3ePy4nT3TkFfP+TBdKjRBDyIElW7cInhklferQXYn+LJDW0Ena0dEakW5JAvxzxXbI5LarfucG
 zvu4msTo+hPFK8xB6YM4kyUSPmq68IpkFZE3v5rkb0fFZnd53Nknx6/dj/i1TKLKJ9GLTbT9T9O
 pMD7exRYQaAif52wvBFmm3ePIWD4ODUdM0k0aqC0pfVe8X8H3gADHixwzztSRa71bRaZiEMDLj1
 8N+CJy4zEu5nj1rXpyglzmn/Q501SmJvVmqzta1zOs+gkchqbPy+9hDydWqpjy3RTp6tc2jONGj
 UDeFvcNLpUdETN0rNl7tiLrKG7RsMZd2ACg/PhA8gByjgnkqaI13J92TNWatD25hUjcJhwEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_05,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290107



On 5/28/2025 10:39 PM, Jeff Johnson wrote:
> On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
>> Currently wiphy level configurations like RTS threshold, lacks radio
>> level get/set support and same value is applied to all radios of wiphy.
>> Add support to parse radio id attribute and use the same to apply the
> 
> i know this is bike shedding, but IMO we should use consistent terminology and
> call this a radio index instead of a radio id. we already have usage of
> radio_idx in cfg80211 & mac80211 (and no usage of radio_id), and the proposed
> nl attribute is NL80211_ATTR_WIPHY_RADIO_INDEX.
> 
> so i suggest a global s/radio id/radio index/ in all descriptions and a global
> s/radio_id/radio_idx/ in all code patches in this series.
> 
Okay, will change this in next version of the patch series.

> /jeff

