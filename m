Return-Path: <linux-wireless+bounces-5063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE4881940
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51C01F21782
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFC85C59;
	Wed, 20 Mar 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oGtY3zwS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BA1400A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970916; cv=none; b=SkmgW0EOUcqaXGerSHe6LJmVH+Ws9TyDSzLEWJdrz3b3t8ioYgFpXfXxb2qf0+m1apGxMKufx8vYuXI6u9zcXqbCzVLz0fJn85EBGsOZPHiAVZs41IHvgxCNmz/npBnRw5PFP/PPvWhx695z32BRgnIp5Bn65EGDY0qKHGItxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970916; c=relaxed/simple;
	bh=Ews29+L/mMo57ftfDZYhGcfiZxorIWvUOV2wArJFZ8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eIs97ClfvSOjl1QoyeJCaLKaA7QiWlLAB972yKtQ9WhGTJc2Q2r5+GW2d83CtVFumYPi81bMTZ82Ag+MXmUdPowKrHSlq/nUG007J7Drc+m9D24ZntXM8HOppqrtlRDZXgaFP2J3yfBimdYsVz8McJ0KefJ8owTrxjkD3YKCM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oGtY3zwS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KKd8mi005158;
	Wed, 20 Mar 2024 21:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TrGpARu5ZuTG/eoBqjGXmMOWoOzpDcHGgUQWNAIIyHE=; b=oG
	tY3zwSbKK8VkLjkPQ0xOv8T1oRZ0FKBzApst5uDpZ06DG5ZUCE1Qgdnr1Ax6ugtF
	7aGHdhmWOgS5B1gLvH43fvM+/NGy0sZCmtiB5sPT+jqbwxZpZVEKLiM4jKBqsXdC
	ceRNyAsMf/jylFOUw9YSrzQGqfkkL8yQHvkvoq5FtF1Jhkx5NIr1J0J/KSS+aVBv
	e0FKjUnwTI3b74PLqdsZJDh5G/vq3DTgFuUbIgbKr6jtLh4lNdzUNRizmZdEuwF1
	FimitzJQM0IXIlE3njXU9XL/LRv1XTGOD+LOuk/K6nQEZx6ggF4SRW0TZpMyp5MR
	hCF1vuGkA/hXgmA51biA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyy76hb8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:41:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KLfn0G012187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:41:49 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 14:41:48 -0700
Message-ID: <4b2d875f-a073-41d8-bc72-e917d415829d@quicinc.com>
Date: Wed, 20 Mar 2024 14:41:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-4-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-4-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bd-mPsZQIcRB32OTGBtCvZOy-SdoMyOm
X-Proofpoint-ORIG-GUID: bd-mPsZQIcRB32OTGBtCvZOy-SdoMyOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=486 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200174

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When mac80211 does drv start/stop, apply the state change
> for all the radios within the wiphy in ath12k.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


