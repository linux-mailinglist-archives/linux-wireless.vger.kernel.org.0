Return-Path: <linux-wireless+bounces-7741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2968C7746
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2601F21F85
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28901474A3;
	Thu, 16 May 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MxGu/sg4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55714B959
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864842; cv=none; b=L7Kl1cd7s/LKxR4c+ofIuKeaFEbRxAhPeWR+Fje6hRNFVrIumUT/QTQgb2CSR9n4m75ZnSCWiMglXDrSn47lLVlgX1aeiBzuVKfL6b5oggKHru/er6nFShLRETu8jpekz2IjYRk5rrJbn5hOPEwT+lya/9UU1LxX390gqtIKNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864842; c=relaxed/simple;
	bh=9Jsb2s5yqyD612mFUgEUandq/cGifnWR08JVOmOgNmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NoX1NvWpL1krUSCgKP+dVgCsbv/rOVtkvU69QysSMTw1PEJttU1pecUF2ZitSwtdhUCUukzGxZtjDMNZwTef6zgSBmgyiNXnu7HEcsZRv33tx/R0TZvlXKQfb7etxwZUA9B0W4I8N0MSEV7reBNsTzVg1V8RAqblpF567XCbmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MxGu/sg4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8X8FA021397;
	Thu, 16 May 2024 13:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vKNw4NoSgQn4imrfCjwhfio5dGu/2psYleBjAgLsiUE=; b=Mx
	Gu/sg4mvEaVEB9/M69ol2+Nl/AfYE0wKhlYt5iHtJQ/GJkv791lDycV0CNlgq3bB
	yPUW68m7r0lqsj8b51ssqnOn1jCr7YoquS3kt/5WLfLbCC4Bqeo7doTKcemQ0seL
	OTrEb4TrISO5iI9OErGuzg/OamwvQM3nsWtiLMxZTRljWEoDl27ihZckZ2wnYOnw
	NlCebtTmE6r9FDfiaUKfLdmx+k+LdrY28ze3S4h35GgmfbbttVkZTknXQRI1M5FE
	wkHnFVzUvbYo9/m+CrXNZ0igoQun0PcpUyoim1RKIK/WY6hEdSiA2AIFgr7gzGhD
	G7IBdwL1iw/K2OvWJu0w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbdth9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:07:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GD73OF028490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:07:03 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 06:07:03 -0700
Message-ID: <99aa5279-79d8-4e18-960e-0515c2a1b70a@quicinc.com>
Date: Thu, 16 May 2024 06:07:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: improve the rx descriptor error
 information
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
 <20240516000807.1704913-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240516000807.1704913-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2i1EYPI8YmKj_QJ5ZpEz3NC97SZpIHbc
X-Proofpoint-ORIG-GUID: 2i1EYPI8YmKj_QJ5ZpEz3NC97SZpIHbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=17 lowpriorityscore=0
 clxscore=1015 mlxscore=17 suspectscore=0 spamscore=17 malwarescore=0
 adultscore=0 mlxlogscore=67 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160092

On 5/15/2024 5:08 PM, Karthikeyan Periyasamy wrote:
> The ath12k_dp_get_rx_desc() failure log currently contains the same
> information across multiple Rx data paths and lacks sufficient detail for
> debugging purposes. To address this, change the ath12k_dp_get_rx_desc()
> failure log to include cookie information along with Rx path details.
> This will provide more specific data for debugging purposes.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


