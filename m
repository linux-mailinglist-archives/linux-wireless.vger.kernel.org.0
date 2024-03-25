Return-Path: <linux-wireless+bounces-5221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A953688ABB8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3617E1F621F9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473E4C63A;
	Mon, 25 Mar 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQ1rNauS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D250248
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384047; cv=none; b=aUFz63TujDawDq7xoDW6d6ZWt/Q2+02aGD/5Vjff+9/FfcaAlQwnWQO3SYnMrD70TcuF52da/tEMwGiJ5h65INLQX4ChWCeskogvAV+T55JAW8XMRyNdDAd8jjsM9bziSkoZ2JLy8wZ7SXLLZSsJti+wRj8d+RX7FKL6CkFMYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384047; c=relaxed/simple;
	bh=8Ql+Kac9ddzN7IQvwdBQCMZkuzsdtgJi+M0dgfdEkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CbPdhPcee1XXNOvyjtt24rLM9gNf0fXJB+R6tZV5m+DnAtc+tF6rzJ6uX9HtDYxoft35KDhgPqJ5kb7T0dhDslhgHfheFFEzgoOieGWisayNFqFfYbD6hK10fyx9AlGr8JUk2HNzWtiVTooNQNpy5YOwMrf8TCUfAwmOc04l/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQ1rNauS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P84P2e029311;
	Mon, 25 Mar 2024 16:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=waVWADioXffzsZLB3KJMo9L81pjqqznMze7L/6+cFgM=; b=LQ
	1rNauSWt1CHjG5nbJi8cdtCSmQhAgSgbxRx9hJ6HfbJRr19JjSGoNi5sX0epzePz
	+2y77yyj8bzFdjUPSx6K93TbJQAaCPQ7c1opl+Q3VRx4Dc9G3YS1t3toQucqdWEz
	8XoQ+e1dWKzZcqP4KgDgVB8QNE7lTNt930py0R8N6iY619ZYgYqziQGLkeI7klta
	loorJpY3TL/NzrTyMzCLrX4fjEF3rsIJ35gI9YFIQ1bx5K8jDbYQWILdXQMVi9bK
	MAohzapYWEgszxrzgOGqPzb7kHgcnE/Je8VzV9v6OGrs3Hxjap5JJ3M5cjsRcVLs
	rcR0nRGnDzKA77Q256Uw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x35eah7q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PGRJp1010840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:27:19 GMT
Received: from [10.216.55.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 09:27:16 -0700
Message-ID: <85455dcb-9242-4f50-b3e2-17499633189a@quicinc.com>
Date: Mon, 25 Mar 2024 21:57:12 +0530
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-6-quic_ramess@quicinc.com>
 <85e7f591-ed52-4554-bd92-09086eaebcdb@quicinc.com>
 <e5fe8dc4-c44b-4734-906f-a9dcbb724bb1@quicinc.com>
 <b03ab374-4d46-48ca-826c-3d2aa39034b4@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <b03ab374-4d46-48ca-826c-3d2aa39034b4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FLvpiOE4uw5s42ZOWBjofQ1cJgLoDUV6
X-Proofpoint-ORIG-GUID: FLvpiOE4uw5s42ZOWBjofQ1cJgLoDUV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_13,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250091



On 3/25/2024 9:03 PM, Jeff Johnson wrote:
> On 3/25/2024 8:24 AM, Rameshkumar Sundaram wrote:
>> On 3/22/2024 1:24 AM, Jeff Johnson wrote:
>>> On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
>>>> From: Sriram R <quic_srirrama@quicinc.com>
> ...
>>>>    	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
>>>>    	if (ret) {
>>>> -		ath12k_warn(ab, "failed to delete WMI vdev %d: %d\n",
>>>> +		ath12k_warn(ab, "failed to delete WMI scan vdev %d: %d\n",
>>>
>>> this change seems strange. isn't ath12k_mac_vdev_delete() called from both the
>>> scan logic and from the normal ath12k_mac_op_remove_interface(), so it might
>>> not be a scan vdev that is being deleted?
>>>
>> No, in Single wiphy, the vdev logic creation for an arvif is such that
>> at any given point of time only one vdev is created for an arvif (either
>> by ath12k_mac_op_add_intf/assign_chanctx/hw_scan).
>> Vdev created by mac_op_scan can either be re-used or deleted &
>> re-created (on a different ar) by mac_op_assign_chanctx() if required.
>> Also once mac_op_assign_chanctx has started the vdev of an arvif,
>> mac_op_hw_scan can only use that vdev. So mac_op_remove just simply
>> deletes the one that is currently created.
> 
> then if this function is only ever used to delete a scan vdev, then shouldn't
> the name be changed to reflect that? the current generic name doesn't reflect
> that specificity.
> 
Ah Sorry, i misunderstood your point earlier, as i mentioned vdev is 
created for an arvif either by 
ath12k_mac_op_add_intf/assign_chanctx/hw_scan).
So this vdev_delete can never say if its a scan vdev. For some reason it 
was put as scan vdev delete in print message :( .
We should remove this change.

Earlier I thought you were asking why vdev delete is being called from 
both places and was trying explaining the logic behind. Totally missed 
the print message, Really sorry about that.





