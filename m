Return-Path: <linux-wireless+bounces-23231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2712ABFB47
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D57C3BBF43
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3619ABC2;
	Wed, 21 May 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DUWK0Z2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8721465AE
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845067; cv=none; b=s14o+WeWG98OWEsfW1JwS9A537SC0kIrPE/fvU7OBVaqPZ/haB5Rq+Fafv47Vo2QeHmgSv3mstZ6qKP/o/kvBCE8uWdeP0h6nkDrkkStPOcvdU3p4nRA1gCvmyY/QO3d563OVpeWLmF+j2oepnsXfkKJvhqAsdgEAgZEK5rNAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845067; c=relaxed/simple;
	bh=6mKSnt/Jh834fEOrymmZNBJZD/BEXYXpnROUn2kGVhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n5GzcJblwuMfLQqert1AKXqVHhHX0/x6pRMrkj08oJOZUoTk0O2hn9ndr57LaziohmmXL0J+Wyrs13mMykUFMyeQszqy96a7EzXUFrrxIbhcQCpOcxHS+PXemNbSuYFvluLb//jsbxBPhcCaudGoArQe7lD9Hx7foWUc/J6IrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DUWK0Z2J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XLNL020981;
	Wed, 21 May 2025 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	No2o033PVBDDvc+FhXfrAqff2NRKd/VvjEUa02651H4=; b=DUWK0Z2JHE9qu64l
	tC66Ok4XzwpSMMp6yLaNjGo/Fo9rNQZ2LNjxQsrBIcWnIKtm5QB1zTbkifw0UQ9q
	vBbeX98c6CM0/cnf6u2ddY27DDxCKBudsLMuxy+grlTtzk0///Y+0uXGiELeg0tF
	vyEAlFUQH9v6DHIbJRPUpXHGdaC153TWGecPZCmM5ROfBLvxjQLT+w3MhZ/OQQZ5
	LTAiTxqsD84oUe3UDNmVm9IMdAo9lTZN57UY8N9CDjEW37i6Zeh4oUd/CTVePV2K
	tAXtqxJplqQoRzSiVdpXHE0cqHUiagInOYKbUlq7ay4J1DDPiSXwekyJBT6+9oTe
	bLe6sg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf03pda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 16:31:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LGV1oY024155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 16:31:01 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 09:30:59 -0700
Message-ID: <e49bd19a-b8ac-49d9-9cce-80772e8ac0b5@quicinc.com>
Date: Wed, 21 May 2025 22:00:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yahLjkP8J8UihopjXV3gOzGY23pPIK_U
X-Proofpoint-ORIG-GUID: yahLjkP8J8UihopjXV3gOzGY23pPIK_U
X-Authority-Analysis: v=2.4 cv=ZP3XmW7b c=1 sm=1 tr=0 ts=682dffc5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=5J8t3YBIyy4kgSINMecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2MCBTYWx0ZWRfXwJhRaHrG67Xb
 2vyxif//LOEE0sLsTYCEc4X/FYkYQars5XOlXouWLiX3EOoApq5lBMWZbCMLKt4NzeoJux4qwBS
 9aCYuHDWsCgkPEilM5kgG//ivUiDxIyjCeGGmyFt3yNenHwI3z7CSmCcG3mUJzJYZAn40JnarYy
 v42VLHYwOvPvGUqRQr0DwivaCjoeAmF5xW6XXF72b85HqgPXLzx0Miom+IaJ1yv11TkrGTyN8lD
 70cOPTiQrw92c61LyS0CvbdTybATAgOvycXRUtEJ25BhYAL+U9StwCKy53APfEBZN36Pf/BSf3D
 Bm9lFtJtwd+z6cix49gzhIoq83R16vR5OdtvGNC1gs73G+oFW20L/qRYZQMZHLIpw06yvsm65vZ
 h63Dd4L+iGGc/KpH1CYZwK9U7uhoA3Bs/oScJOfGAT51lkyq9aBeSWuAwcD3cYCtUJBUCXsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=816 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210160



On 5/21/2025 12:49 PM, Johannes Berg wrote:
> On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
> 
>> +++ b/include/net/mac80211.h
>> @@ -4569,7 +4569,8 @@ struct ieee80211_ops {
>>  			    struct ieee80211_key_conf *key,
>>  			    struct ieee80211_key_seq *seq);
>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id,
>> +				 u32 value);
> 
> That should probably have documentation updates. And passing a negative
> value to a u8 seems awkward? Maybe that should just be 'int'? For a
> value that's likely passed in a register, u8 will probably require more
> (machine) code anyway.
> 
Using 'int' leads to adding NLA_U32 policy. I think using 'int' is
costlier than using 's8'. Can we just revert back to using 's8' instead?
There will still be a default value of -1 and the radio indices will not
require u32 value anyway.

If this is okay, I'll send out the next version of patch series with
other comments addressed and s8 used instead of u8 (and int).

> johannes

