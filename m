Return-Path: <linux-wireless+bounces-21265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86225A7FB2E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B66F1895514
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A82690DB;
	Tue,  8 Apr 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aOiUaxjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1025F7AB;
	Tue,  8 Apr 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106435; cv=none; b=hmhCyYMW8cfe47XWtRM+BQy62+aai0cNcL6RV/GaE1AIKlTFWl7IkhZqoqePuTzHLAOIr9vtslvZCjFcNSXuh4bPXzAwnjX0gcge3YbsOWV4bQJR7XboOt2XO8H3w30MBSxAEIcyJtBShCybrr7oQMETpUwj3t+HyXMtZp06aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106435; c=relaxed/simple;
	bh=pPwoorRSn9zoMiV5VNzcHlzY5a9nIyA7DLfs33iWgxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ApGgJ87OIVS/3q6Xa+1eCknKQ2A4tDSLB4hm38Slxnfgn/FF3dVqPAaFxTzZ6ApV24s+Be7BmKolWIBmBypb2an7KvrQpVjigU5GZpbDBr2FKoAS7ZqqD4NiudBwl/Pn14yPhxetoZ1QUkBRlz2RD8YzHtyy2clOnEaSkhjxN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aOiUaxjb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GNHS032605;
	Tue, 8 Apr 2025 10:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJqy7Sz9RXSkJYxpuGOsppiSlCw2DYQJ7M3SVJhTgcM=; b=aOiUaxjbn2CXTgpu
	1mt8+QcoU+4kGG+t6F5jc1Rf394LfP40RcU6u8P1YSY/CvQMxfnzNyQxIVTHUKSw
	15FSeAYdYjs03op7KdjyFoEqMYQvp7uUEgdkM7MHYx6I2lpEjunReZj8MI29fYuo
	7Wrzjf5yOux7L8891CWp9IEAk2T9aZD32OVlPZUuLdFPtz4I6Y7VHsobSSR06w3f
	+OQtSNo2N/q5O0eWSLy4nh4shnE2sMfaaQXIkpdDLKtho0wUNeRg4X4anRj7fE2T
	YfMqq0Ubvx6UGW3X1t73BMmGNuE+b9QxnJvDr4eB7GLGAtUKeBP0AEvEAfou7ffA
	mgQrIw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkf82a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:00:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 538A0Gpc028895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 10:00:16 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 03:00:12 -0700
Message-ID: <432f80c3-0f9a-133b-5447-a8e2cee5479e@quicinc.com>
Date: Tue, 8 Apr 2025 15:30:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 9/9] wifi: ath12k: reset MLO global memory
 during recovery
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
 <20250408-fix_reboot_issues_with_hw_grouping-v4-9-95e7bf048595@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-9-95e7bf048595@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UZIgXWwit1HudquUXkXWa6EBOnY_x58g
X-Proofpoint-ORIG-GUID: UZIgXWwit1HudquUXkXWa6EBOnY_x58g
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f4f3b1 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=qvveAbbDmAJIsQHAQioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=745 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080071



On 4/8/2025 11:36 AM, Aditya Kumar Singh wrote:
> When operating with multiple devices grouped together, the firmware stores
> data related to the state machine of each partner device in the MLO global
> memory region. If the firmware crashes, it updates the state to 'crashed'.
> During recovery, this memory is shared with the firmware again, and upon
> detecting the 'crashed' state, it reasserts. This leads to a loop of
> firmware asserts and it never recovers.
> 
> Hence to fix this issue,  once all devices in the group have been asserted
> and powered down, reset the MLO global memory region.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

