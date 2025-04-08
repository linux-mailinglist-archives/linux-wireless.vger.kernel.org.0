Return-Path: <linux-wireless+bounces-21262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F03A7FB12
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F2719E12FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A6267B82;
	Tue,  8 Apr 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nnHgqKFo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25991266B40;
	Tue,  8 Apr 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106121; cv=none; b=ZetoXOdALnXPc7CzWPCqJqPQ1oOs5Rin1ZfLrVyJVKjK8u0EHaN91KZN8djJX3c/G9Iiquhzp9iUYGidwQRf5W8Ld8Dd3tMKeu2QWaq/a1ZK8YOtaK9dMKQpb9h+EI0bFCRZHvnjx9xelgX70UYT0Q/NhUIYQUVn1t+oLUz5Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106121; c=relaxed/simple;
	bh=F9az9klwme7nafJiIvWR9AXzCIzSZICrxCJFSkeGI4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fw3AjiKE/CtOyp6jTRBHbeSeN5AkYQ9gKJFEdjZrlx9CsMSIH9P065UoghR0gjDVQyWl2OpT90QEd6q9ZIpvs8m8owsKCfyjHGrmLylBXsH7dZQr3aW25m8zDFk840RS6XzV0JSIsFUMmHSTW4m1nVwOojkFQDWs0g1aCEiA93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nnHgqKFo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GOpc010522;
	Tue, 8 Apr 2025 09:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9q/mQRpAXTG6b+vSXiWGlXFvCcYRkc3YzeAyGrH6mlM=; b=nnHgqKForz5O8nMd
	rd45LlBRHqJFEriGiTfZmXZt/vFZvJwPvKBvQWIIpTsz9/Bfdp+Ezr8qTpQTUz3E
	tHBAfbTHNTigFgVXuk18X3NfigNHwqJ1L92FjnxjSLJlc16CJ54yWzHsBi5o3PvJ
	MKld2zKp1QM47H5IZ01CnkEvkxFYyTyVMzc3lo9GsAyyBHHKjhhhmeiZu8PkykgK
	7uY5bSlNrTIde5miB+F5ElMXTRqOSIgrI1OD3RnWEgc035kXdSly8U3emBQTqnju
	O6VjoVESMNfOf3waK8pqC75Ixlj6uVGtsznUIewhxEKmhbTmvfjPoHj6gJzdaJXi
	watE/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1f7yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 09:55:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5389tBiq020775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 09:55:11 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 02:55:07 -0700
Message-ID: <7261d150-4b03-c42a-7abd-44bb3b0cb61e@quicinc.com>
Date: Tue, 8 Apr 2025 15:25:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 6/9] wifi: ath12k: fix
 ath12k_core_pre_reconfigure_recovery() with grouping
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Karthikeyan
 Periyasamy" <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
 <20250408-fix_reboot_issues_with_hw_grouping-v4-6-95e7bf048595@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-6-95e7bf048595@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2aGXptnFEwcnLTALlaxzCUI3Cq7V4TXq
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4f280 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=QF_tM0vuxDyYx1FaEDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2aGXptnFEwcnLTALlaxzCUI3Cq7V4TXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080070



On 4/8/2025 11:36 AM, Aditya Kumar Singh wrote:
> Currently, ath12k_core_pre_reconfigure_recovery() reconfigures all radios
> within the same group. During grouping and driver going for a recovery,
> this function is called as many times as there are devices in the group.
> Consequently, it performs the same reconfiguration multiple times, which
> is unnecessary.
> 
> To prevent this, add a check to continue if the action has already been
> taken.
> 
> To simplify the management of various flags, the reason for hardware queues
> being stopped is used as a check instead of introducing a new flag.
> 
> While at it, also add missing wiphy locks. Wiphy lock is required since
> ath12k_mac_drain_tx() which is called by
> ath12k_core_pre_reconfigure_recovery() needs this lock to be held by the
> caller.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

