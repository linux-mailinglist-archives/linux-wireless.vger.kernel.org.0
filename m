Return-Path: <linux-wireless+bounces-21259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E025A7FA60
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6077A9798
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1C2673BC;
	Tue,  8 Apr 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GWrQlabB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9D266F1D;
	Tue,  8 Apr 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105940; cv=none; b=qDqpE1CiQ9gMzdCE3RdR4nBLe/URhE0m9bvoipvHWI6ZYGP7QgzM9w1+a+poib/pOjMFRGmM+tgTTVZFvwcrC9neC9SAp49YRjRk6hR4gXqIeDTSETVhWGojdF/uaPlL3qbIpHJq09gWSEBYGE8h1Nh3+A+dbGHNBww1PllVheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105940; c=relaxed/simple;
	bh=sIUvOd8p97+lcTTDarHIe6iGuOljbNgcNFgMSSA+1gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FrrNKPYvdWmrfy8gydCIAIY5Kzebf22K0dHNfeQP62/fdq9ZUu0VWpsArsekyka2dWuIRkmu+o6aN4xslQSlLP6GWKMqtWvPAw8BxEfT6HkEEQmsDd5/H1XFtfPVa9dhU76em0QTyWPBhnWL0fYmXvrsztkhpRjH/gAWpcdyfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GWrQlabB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382JK1K014105;
	Tue, 8 Apr 2025 09:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2bLzXGPNdf14yhwDNjr5G7XTe8KRDfZT9vpWF09aeWM=; b=GWrQlabBujxHZsPA
	44I2Sr/I2jdrVz0d15xAOeuFZdkCwd9NHC1sr7Z29oKehwCJMuKC6KCC92vFSUqy
	FyCq2MNeiGj6Gaw/Zg0ZMyvwcqWGUKVN9ces4O2XWcyz5vr1wNRRbR3/EHdUHB+P
	fF+WJUKTcG5g1yypnatsmlHpyvkhDWwBm8vjMgVBldsKHC7Wh3qRG0cc9Ge2g/2G
	cqu0ag4gkDVNBR25v3SKeNgcy2SmvB4lWTgpqNJxsYApH2BIPoCAXzCRW+VY/yz/
	0wfZM+oS7O8IY/0lXQ07HHG2ONUHhn4HHkYW2idRW3qzzYGRZ3oWGPV89auSsKqi
	w05Lqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm79x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 09:52:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5389qA5d001149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 09:52:10 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 02:52:06 -0700
Message-ID: <618e7026-b32b-681b-787e-839ecbaf490b@quicinc.com>
Date: Tue, 8 Apr 2025 15:22:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 3/9] wifi: ath12k: fix failed to set mhi state
 error during reboot with hardware grouping
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
 <20250408-fix_reboot_issues_with_hw_grouping-v4-3-95e7bf048595@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-3-95e7bf048595@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TZLIXGopljX7Tjt34G-8eiryIPwJ64hq
X-Proofpoint-ORIG-GUID: TZLIXGopljX7Tjt34G-8eiryIPwJ64hq
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f4f1ca cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=xIekBQewz7G2E8zR-ygA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=691 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080070



On 4/8/2025 11:36 AM, Aditya Kumar Singh wrote:
> With hardware grouping, during reboot, whenever a device is removed, it
> powers down itself and all its partner devices in the same group. Now this
> is done by all devices and hence there is multiple power down for devices
> and hence the following error messages can be seen:
> 
> ath12k_pci 0002:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0002:01:00.0: failed to set mhi state: POWER_OFF(3)
> ath12k_pci 0002:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
> ath12k_pci 0002:01:00.0: failed to set mhi state: DEINIT(1)
> ath12k_pci 0003:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0003:01:00.0: failed to set mhi state: POWER_OFF(3)
> ath12k_pci 0003:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
> ath12k_pci 0003:01:00.0: failed to set mhi state: DEINIT(1)
> ath12k_pci 0004:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0004:01:00.0: failed to set mhi state: POWER_OFF(3)
> 
> To prevent this, check if the ATH12K_PCI_FLAG_INIT_DONE flag is already
> set before powering down. If it is set, it indicates that another partner
> device has already performed the power down, and this device can skip this
> step.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

