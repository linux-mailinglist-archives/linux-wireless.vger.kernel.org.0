Return-Path: <linux-wireless+bounces-10538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF993CC05
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39812820BC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6B7F8;
	Fri, 26 Jul 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BmAa6wln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D463CB
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953086; cv=none; b=KIo9J3YfMQJ4zO2uiT9UAGGXraDA3BxVJuFImqYBpLTYGXAIFDvx4t6vqpEbIpJSp0YTwYIg6dFUyDmjFtSAgkD1iquujIcWDWgO2nNEqyDOup7QYwZfOVGxFcnv2AhLKj3+aebiirFaoQ1irMKYnxFd47eQZQFktE5r1zgpYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953086; c=relaxed/simple;
	bh=yZg9oysqT118TdkS+BnO52a9bMAlgL+mKC5IEXJrUMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UekDUH1ZK1v1+K/51r1GWVePiwpk3RG+btBZlJ34UXs0Adzsae0e6NEh/K9Wr+v4Wexp2MlOqB6K27n+1RhCOp36gAwxRgmCCARD++lWWUdHuxGp6wPpYaMQA5f8LwsZ1fSKQBR0AWhxG+TxVvIbt05mrHVAUVEnuSbKwhAxTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BmAa6wln; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PMulN3001207;
	Fri, 26 Jul 2024 00:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sgvwmUx7WWga9XwH6ssYGou8Wht/qrRh2V2hzXQcXbg=; b=BmAa6wlnSKOyzKmC
	JPMLD4d/K3Q6qtrn25q5HN24AyMKVR2QLN60EZQbbEpNO9DDiETbyQytI9if/rju
	zjKleBxiuAEPG3EYdonMA3d4mnIRGhTorn2BVRhVBHA7qz9i4gM01TPIgLv8tdov
	b2XiMoNxOSx98JxvNhK4AvOqRevQc7paShLqlNjo16KlMeYB9xSNYak1Qbo37u85
	H3qxALBQCniZ0p+TwICjcLudO0+/r7CiI/6YUQoC+H+rrIYNjYPq58YA/p5MIxhf
	+Idx//75WIEaCOv+q6yipXx9OUuhi5Y3XesdellnEVicxO11cAdiUeMQT0934MRD
	A/+eRA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k40ym7c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:18:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0I1i5031166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:18:01 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:18:00 -0700
Message-ID: <00729c2c-532e-426a-a503-4d000f20a838@quicinc.com>
Date: Thu, 25 Jul 2024 17:18:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] wifi: ath12k: fix A-MSDU indication in monitor mode
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-11-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-11-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 45ZbXXs5hf2kLN_rbuBZ7Xb3YMtDBvpj
X-Proofpoint-ORIG-GUID: 45ZbXXs5hf2kLN_rbuBZ7Xb3YMtDBvpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=825
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> In monitor mode, host will reap MSDUs and then the MSDUs with same PPDU
> ID will be aggregated into an A-MSDU in ath12k_dp_mon_rx_merg_msdus().
> 
> However, ath12k_dp_mon_rx_merg_msdus() doesn't calculate the total
> length of the A-MSDU. This causes Wireshark to display the A-MSDU
> incorrectly.
> 
> Therefore, need to add calculation of the A-MSDU length.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>



