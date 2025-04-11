Return-Path: <linux-wireless+bounces-21427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B6A854D4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B4318906FA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F627D76F;
	Fri, 11 Apr 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MEX+gC6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01020468C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354600; cv=none; b=WIgWJ529w+UMM1iB8ZOGEGsC/aCc84eEPr51tLWFAaXpYzf2yxlSkhysVkq5Ilmi5QPfEN8I3WjbA8hLKssGfpH+rjX+0MfZsFwjdZMvmSDrgwwgbFRxtsmPtBf6K73KGCHgO7x1fz3BEOO03geeQ9tv7DviMkaJ1Y4wiL8w8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354600; c=relaxed/simple;
	bh=LWCbrfaR1+rfagFyhA2Dlt7e9GHcy8k23/8sr6SCCMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GSxof5hLNbYQPPzLfAOJTILo22ljx99T3Nxl0OxuxvlLLlMkTeMZcvcBYrWRYVjuO2RURcbplHeiB/GvoSdui60+ClrcLi95EqufLvoaTGzmMnzCfOdH8Y4SHgCrGVz0SPfVtntEFRzFBcBNrY4REUfM/1YItD2JuPPHSpOce2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MEX+gC6g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B52Tva019642;
	Fri, 11 Apr 2025 06:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HH4YTn+qSJYjR+ECHiPT4ImZ25lHhgTq5AMQRCJRneo=; b=MEX+gC6gj9MLhaxv
	+t/J85P0jtTKBPgEs94AQtchtLKw+QmJcCnzOJadutNYeS4lyB9Pv8qypYZ7P/V5
	ObOsb2RR0I+/+UgUE5U+5XXKxIhpPZpRJiBlxlYJP7KFNzAPFx00BwaKy2ZPBmIC
	t9oPV9ebsOVIhkNQqo3J0Aq+b0y5aqH4/jRoHSFMOC2fRodOA5hFbbuOo4va5aSt
	vft/Y3cruRm3DeMIyTHzuKWJ+LiklDoR0OM82yPDTWsyCYDshFkwKi5tHsYv6s6C
	AO+ZwurXQl5J2b04Ce+0e9thPAulEPVQQxwJRM96tMzB+JDJFzP5Dl7oukWskDcl
	5nKFiQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrsn00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:56:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B6uYgn002576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:56:34 GMT
Received: from [10.216.57.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Apr
 2025 23:56:31 -0700
Message-ID: <9a08982d-8233-0206-8931-0f9b3c6b5980@quicinc.com>
Date: Fri, 11 Apr 2025 12:26:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3 3/4] wifi: ath12k: Fix memory leak during
 extended skb allocation
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
 <20250411060154.1388159-4-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250411060154.1388159-4-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EKKerLcxZvUBMiEmvJpYIvdlFbT8SbVQ
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f8bd23 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=1Rmxdi0974yHcJ9oK0YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EKKerLcxZvUBMiEmvJpYIvdlFbT8SbVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=712 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110048



On 4/11/2025 11:31 AM, P Praneesh wrote:
> In ath12k_dp_tx(), memory allocated for extended skb is not freed
> properly, causing a memory leak even when the host receives tx
> completion for those skbs. Fix this issue by storing skb_ext_desc
> in the host tx descriptor and using this skb_ext_desc field during
> completion or during ath12k_dp_cc_cleanup().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

