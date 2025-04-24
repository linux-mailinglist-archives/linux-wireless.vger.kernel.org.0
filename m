Return-Path: <linux-wireless+bounces-21970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C12A9AB97
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7197B1B60477
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F46224239;
	Thu, 24 Apr 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M04B4UAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C1223DF2
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493670; cv=none; b=UczHaFab4PttrxeIsiMRV4V3Epxp46h3AwoRRRkVcLojnv+fc1KkviOn8YkPrNMCbTCEob4Y8LMip0I4G38fiEelFEdgboQufSOchyWNp8QTstPjSX2nEVh+MqxWUkYAvP1eGpSlkH+SvGPv9jcvp/G3nsPGFHr+gMjYqMilD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493670; c=relaxed/simple;
	bh=hkROyuUaa+ccN+b8Ik9WD0A/DcR8F5ghln1TdBzKLgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GWgR5eC9Agf9/oYFLqBnaKvw+yIOmm+bbdJnmZslURSLrp3fBNU4EGlenYnlXqWXirnjUGrXIQHIdFfValUGGLOgajHz3v1QjWR9eLIKxjO6ibXgAjWczSvDBzhjDhtwJgsv9FQphHWmbWnL9JXxpvMfymG1c/V5ZZWVEZtVcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M04B4UAT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAKOUj016942;
	Thu, 24 Apr 2025 11:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkyKtYdVuU1HgwploWiBWAnIBj3fnQDOwwxN4Vk2ikE=; b=M04B4UATzilKG+mX
	AXxbq4IJHvp9B7YE+gXAdi+e0XEuh5fICynkKilKc9te6vxJnApZ2M84bJZXhhIE
	5ATASj2PAr6+vWYVVniLgN/IuC3rKkTBgIC6vDJSogJYIWbQYkRBGQ7vIo9FbbWU
	yZfT+fGNgB4JQindlE1J4wgLmy//Bqtj436cglSC0yl7IPM2uA4Qdwipl1L92JEO
	V66+5WuCxEQP2UYwScC0cM7Au7m/H9Bnjav7eJ2YrseNWwdkok/YGyK+69UykzRq
	WwtvLvOPLYa/hrwSpgXswrQ9+VePAUWKBX6ebSAVwlAUARIAxOVolPEU3gGJRDbh
	1pYx7w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh15acg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:21:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OBL0TH001357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:21:00 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 04:20:59 -0700
Message-ID: <805f8628-6316-4951-a9ba-dd4df2ba2a99@quicinc.com>
Date: Thu, 24 Apr 2025 16:50:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 2/5] wifi: cfg80211: Report per-radio RTS
 threshold to userspace
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
 <20250328122519.1946729-3-quic_rdevanat@quicinc.com>
 <c9f5231349d941505f6d479463f31b5a76f3d65d.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <c9f5231349d941505f6d479463f31b5a76f3d65d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wm2EAZejVJZGvVNBj2onOmHjCoevw3Ws
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680a1e9d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gbb1z4RvrpL43Ve-MDoA:9 a=QEXdDO2ut3YA:10 a=wGWsV5WchKQA:10
X-Proofpoint-ORIG-GUID: Wm2EAZejVJZGvVNBj2onOmHjCoevw3Ws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NiBTYWx0ZWRfX4rmYHxFZucWw PyY0DMskk+Zkpg4snH4kaB5tnq6Rfjg0Zk35Wvuw2V6j92CQFcMM3RijUyuPK327UO1CU+EBxQq AYPzFlKsM2wCJiGq3+M96ROBvfLcGOfdlwDT+YzKSzFH8C1QDXYKb09+kSDilGOsHv2Z0ruykUN
 BqE5Y6mMdeSwPIo0cqF9Rd/6Qvr7o2W+o2s3NGPrh18GL09idCxKulqLikKxaxAKcjSqCwfS9Mh ZLkedONdwxwiWMxzQ9lEPY3eWtza+OP0XFC3byVLTyP3biGZWzAPrDpnCmFhKbctvT8U9Zr47lQ lynPiJt0pa3+QSBMX4+NtvKIKtyIjRXco9rYCVSUO/YHGUqa6BGOrSAIKbWe4O6ldSWy69uGNOV
 UjaOEnxb4kWC1maF/edCcnL7wyIow2tw6WLqEgf0Xs2f/VxP2MmpG6lxYN7uhdReWTaMwpub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=931 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240076



On 4/23/2025 9:07 PM, Johannes Berg wrote:
> On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>>
>> @@ -3237,7 +3243,8 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
>>  						 skb,
>>  						 NETLINK_CB(cb->skb).portid,
>>  						 cb->nlh->nlmsg_seq,
>> -						 NLM_F_MULTI, state);
>> +						 NLM_F_MULTI,
>> +						 state);
>>
> 
> Please don't make unrelated (and unnecessary) changes.
> 
Will remove this change in next version.

> johannes

