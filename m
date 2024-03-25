Return-Path: <linux-wireless+bounces-5209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701888AA99
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8722E1C381F9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E151034;
	Mon, 25 Mar 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gm7FdNy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8B548E5
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380839; cv=none; b=lMH06pRXpcdr6D/fHePUlxRyd2nRxqYZDqmmUGhm8xC3DfnsX5H/dIl/Sqgt6x1+wRmcpb5g8y2ZUQRyIxOmTtWXT/y0irKHTqBKWg0sLmDJHReXjZEwJQicp6ePeOzYWxUkreUU+Dnhkh0dAoP85K+yug9EO9lwXGp79QxawpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380839; c=relaxed/simple;
	bh=W+4cn50WwFUAPhVb0WLOmog9999U8CorfnmPu8qWDOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GSFZs1Pl//PQbdQYpaUuVC3ML6tF47TVWsDuchZYH8ueaCw6UQazgAYcF/g8a6LKIitFyIpWj/v4PwLA9VAenzGmIJzJbOw/59MCTLJRM7CZT0JyVSuHPNp7dSZn/t2InU+ynyIzwyCfmafGly7RprNR8k0LZ1HucIHXWaBABlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gm7FdNy5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PEP8Cx009965;
	Mon, 25 Mar 2024 15:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ybsJ2fOEoCQVOgnBS7Jkh+5OA8rzXC3UyWZGtt5z/UQ=; b=gm
	7FdNy5lJfpmLSLrdVBRjWvqeFj2Wrsk2cHBCpNWzE0EwYRQKOOaY+ranv3OvwPsk
	xqJc4+EkSzzrANSW4AY1EroUpabxbtSwJtvFkHB2BYVDyZ8s16/w2WuyW1H8ukHU
	CKNHqSZ3fEkZQ4WCXox5lZv1bXY5/nQEnJPK+e9CuZLKz7Xb3Y6kK+cRu2WbArZZ
	S+RyfDxPHmbkByIvVC/qHJZnSrVtCrHTkfoy9ej8YeDpKbmi/EeRPPTnWCwt264G
	bs0Bhc6dn/6M8qelu2ziie+0km5gNs0XHat4kqYUJh2ZDM+9GbboDhCvGYZ5CubJ
	t3ybuZLQ0P4YhBb7PHyA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3b0yr5y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:33:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFXobW007076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:33:50 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 08:33:50 -0700
Message-ID: <b03ab374-4d46-48ca-826c-3d2aa39034b4@quicinc.com>
Date: Mon, 25 Mar 2024 08:33:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] wifi: ath12k: scan statemachine changes for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-6-quic_ramess@quicinc.com>
 <85e7f591-ed52-4554-bd92-09086eaebcdb@quicinc.com>
 <e5fe8dc4-c44b-4734-906f-a9dcbb724bb1@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e5fe8dc4-c44b-4734-906f-a9dcbb724bb1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RiTWS5Jg65oCSn7B2D4AoJ8QcVD_uG_2
X-Proofpoint-GUID: RiTWS5Jg65oCSn7B2D4AoJ8QcVD_uG_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=846 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250086

On 3/25/2024 8:24 AM, Rameshkumar Sundaram wrote:
> On 3/22/2024 1:24 AM, Jeff Johnson wrote:
>> On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
>>> From: Sriram R <quic_srirrama@quicinc.com>
...
>>>   	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
>>>   	if (ret) {
>>> -		ath12k_warn(ab, "failed to delete WMI vdev %d: %d\n",
>>> +		ath12k_warn(ab, "failed to delete WMI scan vdev %d: %d\n",
>>
>> this change seems strange. isn't ath12k_mac_vdev_delete() called from both the
>> scan logic and from the normal ath12k_mac_op_remove_interface(), so it might
>> not be a scan vdev that is being deleted?
>>
> No, in Single wiphy, the vdev logic creation for an arvif is such that 
> at any given point of time only one vdev is created for an arvif (either 
> by ath12k_mac_op_add_intf/assign_chanctx/hw_scan).
> Vdev created by mac_op_scan can either be re-used or deleted & 
> re-created (on a different ar) by mac_op_assign_chanctx() if required.
> Also once mac_op_assign_chanctx has started the vdev of an arvif, 
> mac_op_hw_scan can only use that vdev. So mac_op_remove just simply 
> deletes the one that is currently created.

then if this function is only ever used to delete a scan vdev, then shouldn't
the name be changed to reflect that? the current generic name doesn't reflect
that specificity.

/jeff

