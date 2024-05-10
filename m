Return-Path: <linux-wireless+bounces-7491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D718C2AD0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 21:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AF21F23FC1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173A3E48C;
	Fri, 10 May 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cd/owGug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D10965
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370820; cv=none; b=eCTughI06l0wLFhibmA1xPGoJSOS9QB3iVN8wG5DUMI6UU/mKCveLIPjanwD7GzhRgtz3cAdN4cuDZXS5qwusPWkGgIG3l9LPjYgj0kg2dBwefuYbk6Webb1LaAvIjiNwkqhWiIR9gjy74HxN1eBlU0B+lOqV6R8AaWcXwuXvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370820; c=relaxed/simple;
	bh=DeiTLEzjD94cF9MAhE1KUohMtzqAZJa7ox+QDvZ7kA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hdy2niBAUvVlWqo0PDAW5f4fhK4XsQTM+zaq5FQD2G1WqP9GHaPvtgLiJREFBvo4CeYI2ch54VJVo9fBCS7gS5DFq2KJw16rRPphsPXmrdT1LvPN/uy7K1yPi8sjzTKBrPRapL1cQEUmf5af1f8gxvCrB7HsDH2chWg9e+ZpeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cd/owGug; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AD5lgw028344;
	Fri, 10 May 2024 19:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NqvdwL1lGyFTJhFTb8pX9ppM6bMMO3rSKYSfSL6ORzI=; b=Cd
	/owGugibYUKPfIs0n95Gb1Gscy0SKFxBbh/C7bNEjz8L9vcb2vMQf2CY+AJL0FBl
	bvZtmOe4wmS5jXNLKY37Xeoff6HoOYSWAMT3ohiXJTkmbsgPI4ryK2xGdyIN73Gi
	VB5J8GV3RUGfRo/uegSjpvMZoAdWczGZRm8HEZPl0O6wJ+uQbImmSM65wJu1ogOZ
	LAgKRw0WdfliqE8TdnkEqhq6BIvPPDjb4MHsKDAN2Ii8twhd9/NCZQ+n0wvIe0hO
	CD26RwEq6dab8Rlkl4/Pw5pDzrzTMEBAJ07jnJVq7iA+HPhF2HwGY1LgjMOQzLFs
	4anSiBQaqRH6uC6csHAg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0tetc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJrZ2K020301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:35 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:53:34 -0700
Message-ID: <4735f493-e300-48b0-9113-93f5bff21b49@quicinc.com>
Date: Fri, 10 May 2024 12:53:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] wifi: ath12k: Add htt_stats_dump file ops support
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-3-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510050806.514126-3-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2VynYSMS_XHjBP6MVyAz4NXurPb-ZnIx
X-Proofpoint-ORIG-GUID: 2VynYSMS_XHjBP6MVyAz4NXurPb-ZnIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100142

On 5/9/2024 10:08 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add dump_htt_stats file operation to dump the stats value requested
> for the requested stats_type.
> Stats sent from firmware will be cumulative. Hence add debugfs to reset
> the requested stats type.
> 
> Example with one ath12k device:
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
>         `-- htt_stats
>         |-- htt_stats_type
>         |-- htt_stats_reset
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


