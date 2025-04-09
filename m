Return-Path: <linux-wireless+bounces-21305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B027AA81DB3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CFC8A1A3A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3A1BD00C;
	Wed,  9 Apr 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A/jzPKE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DC212FA2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181873; cv=none; b=kWnCyttJUDXTRxJD5Sz7P9gDMqfIwlDx9PijEI252pUvafRIHjc2fbo/gGVbUvEQHett7I5rxplJSj/52JSBsNLjv0j7jgAYYIKY3+WuugOyfTMhXAyoH+vVxfK4KPB+DX6us4nzpg7IIUms6tj6OTu5lbaOnH7K0NFjz9wJBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181873; c=relaxed/simple;
	bh=5TgJkqPjPDW0YucPJTwe3BDsIP2hNlcnk1v8S9vOJ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjZF5UsF2X4zECIyXFe96nqcqZ6hNjSbeHLqY3msMrBR0icB/3x/PQFryoMgX176boGhfzPWbKhy4L8/WPe8xNjrJFQfcUSWG73MJI5Wp4Oto/bKdS/OACyTREjYrHPnNWmeRWoUNbKC4hx6TCDEdunvX9TWGvwAQHJZcDgReCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A/jzPKE2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYvt7015742;
	Wed, 9 Apr 2025 06:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XUyhaq3tVskskWx2VVAHu9VKorLepGI503CREl5Q1GU=; b=A/jzPKE2FCjhm+CB
	l5C+Z8iuqY7URyyDVmkvLiRB4WDMM+9pQMjG32Zh7Duggz95a0uQNLZmw0sXaUhR
	K26WdnES03q4VQ7PnPi6xObVRoOCqo1cx43s2c0U5lvfZRdmvImbp2i58N9U+E3R
	uJDPT6JXies+NyWdCL8hFYGQF/+JRo41oE+reXxBcP34fDgGJePKT7LudlRRuLgm
	FU0oCFB59QWDdA/WbtlJFDCKwvDaWPpNndT0/vD/MnPxlEvU3K//CpiDXO/mOm0S
	DU0wAogHjdr7at35a2/X2Kmhz5We9u/BzwanmaWsdbFk2QK5J01I5hV1562GShDJ
	/W9RGg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2tcjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 06:57:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5396vlKl025711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 06:57:47 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 23:57:46 -0700
Message-ID: <e8c67d1c-a440-7041-fe05-20b03d5854a0@quicinc.com>
Date: Wed, 9 Apr 2025 12:27:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: add rx_info to capture
 required field from rx descriptor
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
 <20250402182917.2715596-2-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250402182917.2715596-2-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sA5cB5OcH_RkZ6wMv39yDIv63XHqBOdW
X-Proofpoint-GUID: sA5cB5OcH_RkZ6wMv39yDIv63XHqBOdW
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f61a6c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=PQ96tUHJpw4_9QAaMmsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=242 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090028



On 4/2/2025 11:59 PM, P Praneesh wrote:
> In ath12k_dp_rx_h_mpdu(), as part of undecap to native wifi mode, the rx
> descriptor memory is getting overwritten. After this function call, all
> the rx descriptor related memory accesses give invalid values. To handle
> this scenario, introduce a new structure ath12k_dp_rx_info which
> pre-caches all the required fields from the rx descriptor before calling
> ath12k_dp_rx_h_ppdu(). This rx_info structure will be used in the next
> patch.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
> Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

