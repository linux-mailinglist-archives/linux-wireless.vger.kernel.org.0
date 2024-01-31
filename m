Return-Path: <linux-wireless+bounces-2910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CC784496E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB372824FF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7674F3986E;
	Wed, 31 Jan 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h+85FoZJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FA3984B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735278; cv=none; b=hLMx2BxU5LGvu7Pj7YE2rtYacuPzN0LHbyNlUbnpJ25CuN/6vw5V7vpU2G8IcAZtd6KVvVY8WTtLlA+DmSd0jeq2LaZA/9PABfND0Do2yWzGsVHcL5D46FOLCCNXPC4aO9+jprVhpKxx6jtqlAFjNMyuG83oX8EbFImzIVbOw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735278; c=relaxed/simple;
	bh=J4e9o9H1cbGF+Spy9ObmuHmdFaURXeEOrMrKHuJVMWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sZeN5nr2+3nIHSVvd4ufZcgi24KwwaDpi57d1wEunIwZGL96IhMSjmcjfDuX2kgIAGu6Srd4kTmZAj5397hBynUWK+Ihd6Ul5tmfgG2hJBTeGfR7jTRaAxBahoyLY8jAk8CU/IQh71f6pFLHOTHRKiSXDtsBAE03nO8Pr4tZ6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h+85FoZJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VGacfK009056;
	Wed, 31 Jan 2024 21:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DBPfAjsnEmFBuXnZUfeETWc+amlVTK7WsFXjxeIztuo=; b=h+
	85FoZJHopWsUoqszsRhmaukHyX9zud1yvgdRnbDV0OqQ4fgExq7f/IVV5bKfNLm4
	ZhXwjltOO3DLFDafMVSZIjVBFLLvdVtSgmLLEVivVjtAOMNDZRpWeNAL0WI5mxdO
	l5qaYKsrj3xmkXmGd2H54xu6Z/qmzPHCrhbdnftLtNWxugYILFgf9y4NzR2PbIrT
	wSx05BTGVoIBKjkdumxYr3BUsx1KJR7IBWIT680X5SQvWZaqbasniq+Fqw5HK68q
	4X+m+ZZfxs/cC0O1ojE3rxK734LWDa2mPNUx2vkOpr9Axa3vDbyhsGYyW+pXog13
	/2YTIOpRdF7T1165oAuA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vym2m9jr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL7s8N009686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:54 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:07:53 -0800
Message-ID: <6b845336-6eaf-407c-86d2-b7676ed58aaf@quicinc.com>
Date: Wed, 31 Jan 2024 13:07:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] wifi: ath12k: subscribe required word mask from
 rx tlv
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-10-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V-tVOsM68O0Pe5JEcV2gJRVCDMJYDgAr
X-Proofpoint-ORIG-GUID: V-tVOsM68O0Pe5JEcV2gJRVCDMJYDgAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=842
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401310164

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> 
> Most of the RX descriptors fields are currently not used in the
> ath12k driver. Hence add support to selectively subscribe to the
> required quad words (64 bits) within msdu_end and mpdu_start of
> rx_desc.
> 
> Add compact rx_desc structures and configure the bit mask for Rx TLVs
> (msdu_end, mpdu_start, mpdu_end) via registers. With these registers
> SW can configure to DMA the partial TLV struct to Rx buffer.
> 
> Each TLV type has its own register to configure the mask value.
> The mask value configured in register will indicate if a particular
> QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
> in the mask Nth QWORD will be written and it will not be written if the
> bit is disabled in mask. While 0th bit indicates whether TLV tag will be
> written or not.
> 
> Advantages of Qword subscription of TLVs
> - Avoid multiple cache-line misses as the all the required fields
> of the TLV are within 128 bytes.
> - Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
> even for 64 bit kernel.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


