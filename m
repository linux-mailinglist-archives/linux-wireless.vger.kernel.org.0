Return-Path: <linux-wireless+bounces-19701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8642A4BD5A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D54F189904D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88651F2C34;
	Mon,  3 Mar 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jv2dzxdG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499831F0E42
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999750; cv=none; b=UuRrVNgi53AGk4pJZANW8jVIHb7BimJO7IVYLvfMLK2owK1YXPxfkw6SHSxIT8fJ4I/1RN9Tetv3wqruDw3Kn65IYLcUby9Cd7i7Ee/tCPg+fqHlvVt1JHlaP/xxbdMyZMACa2Mgen3Ml266v6JeBF15eAAFpErVWDAKnhbx6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999750; c=relaxed/simple;
	bh=QfgaoOTaVCeFVw9QIKCZ178bWm139su9+6MlepL2q/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUAOOE9eY09OEgsZ1kmyPyElYnUgEMh1r3JuyZ9fxOaSIc20ZBVD/8dOOwY6YyvixSbTLjL576/rBORtwQx6+kqEsRBl+TwdVH8cXVSmgct/zK4FKsKDA+SKedVkL/ctdtmeh9gk1TovrCvsNfAQQv7PQV09aNcfrXBp5uvdI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jv2dzxdG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522Np5KT024773;
	Mon, 3 Mar 2025 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pinMVHt9qL6QfCohmeN6dUgtGWHduSrkCVGfxwhUt+A=; b=Jv2dzxdGK+FZxiIZ
	GEf3NcpcbDpda5qPtERrFUU2B36XG71KrmcTCys0PWSNX1JmcPAvhHalSDlEhTiF
	Is1pdSSKN44mUd9kvj5XJlJCLvqDv4j2mWbYZA9uXPu2QrNAC+Cl+jdAbV6x33Bh
	5TiDo08TpkxYuRiRTk8xRQbBfYiiOneHaE6kFVaQfsA25ryua3+Kg+0cEgw0cxmX
	xU0K5SqQYNiLcDnamMngebjmQeIS5AJ5InEvkbJhtjNe/r+zarzAgUx32wFlD0Am
	nqtr3H1utpErCJeMPSVWdOW6jyY0lOgDlT8olzph0e4ErtZ+WmbbDLt0RMEcLwzo
	gr+Glw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d4c8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:02:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523B2JWH011669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 11:02:19 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 03:02:18 -0800
Message-ID: <ff04fb2a-33ca-45ae-b383-13e36ea28d6d@quicinc.com>
Date: Mon, 3 Mar 2025 16:32:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
 <a2bcb0b6507c843b13e0ef98d76727a76b53f129.camel@sipsolutions.net>
 <28d36a7f-3408-4072-9857-8bd652260926@quicinc.com>
 <2ed1cf759e1b8eed21cae42f856c1012dcdb59e9.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <2ed1cf759e1b8eed21cae42f856c1012dcdb59e9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qCKMBpwF_6roVKSvfVDMMS03i2vDXuOr
X-Proofpoint-GUID: qCKMBpwF_6roVKSvfVDMMS03i2vDXuOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=719
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030084



On 3/3/2025 3:50 PM, Johannes Berg wrote:
> On Mon, 2025-03-03 at 15:48 +0530, Roopni Devanathan wrote:
>>>
>>> The order here also seems really odd? That basically means the driver
>>> now needs to propagate it to all the radios, but you still have
>>> different per-radio values at that point, that seems bad. You also
>>> didn't even document any such assumptions.
>>
>> The idea is to maintain different variables for global RTS threshold and
>> per-radio RTS threshold. Each time RTS threshold of a radio is getting
>> changed, we are trying to update the RTS threshold for that radio alone. If
>> global RTS threshold(rdev->wiphy.rts_threshold) is updated, we are trying to
>> change the RTS threshold of all radios. This is the reason we are assigning
>> same value - rts_threshold, to all radios.
>>
> 
> Sure, I get that, I just thought maybe it should be *before* calling the
> driver, that way the driver can always access the per-radio thresholds
> anyway, and just has to figure out whether to set all or not?
> 
> Then you have to roll back if it fails, but the driver doesn't have to
> track it individually itself?
> Understood, thanks for explaining. In that case I can move the code snippet of
setting per-radio RTS threshold before calling the driver.

In this case, if setting RTS threshold fails, we might need to roll back to
previous values. We might need to create local copies of RTS threshold values
for each radio like other global attributes. While extending this design to
other per-radio attributes, we might need to create local copies to store all
per-radio attributes. Is this design okay?

> johannes

