Return-Path: <linux-wireless+bounces-8272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AEA8D3BEA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C19F1F21EE1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF751836DA;
	Wed, 29 May 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eHb+L+UI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF917DE14
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998963; cv=none; b=qQbOfGVTp0Ou5jLVE/AlKJpDvb1p5oIqEox6PURoo4OOLVFEJIX0i93UxgHtujb4hjM0ZGe5Nng6Fp1tusr1A0Bq2SZVq8Y5QFxH3tKEZWEvDSMBTi6vsA41Taidg084sSacER8SLxv8+7KryxAzN3Q8z5vovLs4Yx9Av6B4Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998963; c=relaxed/simple;
	bh=yJJhDV0kP7rRaja12AY04syL2CbtlL4KN7Y+TDinnHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lb6g6N/lkq11C4+OX9th7aNhs2V/VnepPJ+L2R2a0Jq2pk78A+ZqYdFMd+V64HKAYqaDoyyKEHtgKM7seCree5Fx1pOFq+scbTe7cMJkQKLpC4rQk4SJ5U3BQNssd0gc8LobLSg+cezQ1BKOcX5NLaAVPR/KyzNmGQcSso9JXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eHb+L+UI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TAuJXM026856;
	Wed, 29 May 2024 16:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qpSIB8zCMPhZJXXwMsLR0VEaQGYpFBGechwVjwXrKG0=; b=eHb+L+UIGUcrkTBB
	GRi5KYBCe9LW/6y9lPKo/KxNhIl58ln+s+I02yWTc4vWIjQD3mHnPhutwav7KLFg
	wggwvWtTpAKJBGRy0eNu639NubTyngRPAR7TLJmkFKN+HlwtMvVQldMKFBlwtbjy
	EyAz1mYYJnLRCcC68bmIPbnY5FPmTViaKyCkvF/Bl2VdvhH0G/NgMPPRdilXB9N7
	YX9x6hUlF6oP+u4fyviCP/WGNE8F3IiQEGTAVt6cslIRbpZgQ88YasHdqQf1mu/q
	NcS7fQitVX+mas23adU4DQG1+P1+KZUIlcPclIdYBGfdfGCs3LtVpuDbzgdT2VQ5
	WpQiow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k9f36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:09:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TG9IHZ002158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:09:18 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 09:09:17 -0700
Message-ID: <53fdf634-ab24-469f-b4d1-5e9a8c9c113d@quicinc.com>
Date: Wed, 29 May 2024 09:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add panic handler
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529021533.10861-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529021533.10861-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FGvNPL1tMdWnwX95nP9YZaYnsPs2asg3
X-Proofpoint-GUID: FGvNPL1tMdWnwX95nP9YZaYnsPs2asg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290112

On 5/28/2024 7:15 PM, Baochen Qiang wrote:
> Currently for ath12k PCI devices, firmware could be running in one of
> several execution environments, e.g., PBL, SBL and mission mode etc. Among
> which PBL is the only stage where PCIe link negotiation could happen. So
> normally firmware runs in PBL in order to be enumerated during system reboot.
> 
> However it might not work in kernel crash scenario: ath12k target is not
> found after warm reboot from kernel crash. This is because when kernel crashes,
> ath12k host does nothing to firmware. And during warm reboot, WLAN power
> is sustained. So firmware is likely to keep running in mission mode throughout
> the bootup process. As a result PCIe link is not established and thus target
> not enumerated.
> 
> So add a handler in panic notification list for ath12k. When kernel crashes,
> this handler gets called and tries to reset target to PBL state. Then PCIe
> link negotiation could happen and target gets enumerated.
> 
> This change applies to all PCI devices including WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


