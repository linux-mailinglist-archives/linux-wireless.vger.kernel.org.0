Return-Path: <linux-wireless+bounces-21258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E381DA7FA44
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDDB3A42F6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2227265627;
	Tue,  8 Apr 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VnFPbrh4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF04226D17;
	Tue,  8 Apr 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105890; cv=none; b=M2BGT3xvhLytT+k3ojqlQAtH5JZykadhUKrd65l0Hu5TOMwttteee5XrYitjg4KYW+f+I5Id+V6KKIWGFIY2HBJ0qEmMBn+ipCxmSJ1UIDvHMSy5RXPcmRuwSes/UalVdRHi0gl6121+lygjc2zuhTOuMORoPrQv2f9WQ0+GOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105890; c=relaxed/simple;
	bh=FpsaObry1FIu0nkhtdGSmNrq+OfI8A4Xs9kB/CmtKkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=szYdkzVm6m7SFfBy+ni1TKyK5ALGIZPBKZ58IoK0jHm3nBRc8LaJg7XSHofGs09pk1IXS+YQeK72wd5ZLDl/mky/6DtJKxuPbZzwt5NAlo+kuWHMaUzm12NZvxk8tNAILl6dvZG9ZkVjzoDpHRNnvfB4whu2X2C0xuxr3aRbh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VnFPbrh4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GfQB015965;
	Tue, 8 Apr 2025 09:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ed63OzewtrZIzsKehMuw++mw1XYT/gtKAztZU1CTx3Q=; b=VnFPbrh4VqCJXpFo
	CHaGHV3zsl3H/gFF8MyvE3vapZzuOZwlvEqU7qDHTvUSc80m218UXi/8SD9N3PH5
	dHe5xeQJ1NiuMhklUy+4s+p9Npqhu19A79oQC3mJ7fKu52RA552hSfILKFw/gB/r
	F3C5G5B9MirlvmlexCojWuBLVNAe4q4UZ8mqcWl2zO/GFtiwcjDkTiAxDHvtDI3q
	h/jmwkn+4lNZyweLgK64L53bcQezWUCChAJSs4MxiW8UexuQ6dgJaqiWL3MMVhSb
	iBVuFCytCHoah75lmeQAwC/P8FNdPVGw0ELpDbnWUK2BhY3srei4/YKRfgwYPHKk
	+rlBSw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftf7d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 09:51:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5389pIAs007302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 09:51:18 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 02:51:15 -0700
Message-ID: <22e79435-0b29-b0a0-9446-cb5311b87ec7@quicinc.com>
Date: Tue, 8 Apr 2025 15:21:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 2/9] wifi: ath12k: add reference counting for
 core attachment to hardware group
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
 <20250408-fix_reboot_issues_with_hw_grouping-v4-2-95e7bf048595@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-2-95e7bf048595@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f4f197 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=GNQ4sJM4HwgcdJPfVrgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bWQL2uAlmVuy6JMbahaDRVCZrnTkouUn
X-Proofpoint-ORIG-GUID: bWQL2uAlmVuy6JMbahaDRVCZrnTkouUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=938
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080070



On 4/8/2025 11:36 AM, Aditya Kumar Singh wrote:
> Currently, driver does not manage reference counting for attaching and
> detaching cores to/from hardware groups. This can lead to issues when
> multiple cores are involved. Or with same core, attach/detach is called
> multiple times back to back.
> 
> Fix this issue by using reference counting.
> 
> With that, it is now ensured that the core is properly attached or detached
> from the hardware group and even back to back calls will not alter the
> count.
> 
> Additionally, add some debug logs during the attachment and detachment
> events for better debugging and tracking.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

