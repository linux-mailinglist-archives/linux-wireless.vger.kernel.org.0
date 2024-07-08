Return-Path: <linux-wireless+bounces-10086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F792AC8F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 01:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EE91F22508
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA912E75;
	Mon,  8 Jul 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyELS522"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC58C06
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481573; cv=none; b=Q87DN+dymbLEYiTBgY43qGfO+KDGtA77j/z5Hkp7Y6FgoK4KoLfAa1v3ziNZCpQJ10j9bMYcQQWXDdSPnq9ne8s3Vh16TfHmRKxXYPvBTYAZsmdLPmcnDqvl5V1glhE1D+jYOB789rpieb/N31TzptODcBX2TndgWkSG7ZYVk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481573; c=relaxed/simple;
	bh=19Ym1JGLrnGVBEXbAbBdNgdhaTmwjUgspLgzXwCV28o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LrgbcqWxL+S8LbYK3zwCivjg+1/t1Lo7FuuJFdhKH72XdXPxOqaJdGv+iSctj4PgMbuK3uvetnhfRGTvlvWpy3giI3KdAFHr+B2jUCYcRP1G6/zo2a55D18827ElFl1k6cVBrK8wTGmlkGx8i9AyIS5Bw6GHEtBseUk0XItNwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IyELS522; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Meowd012208;
	Mon, 8 Jul 2024 23:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6OLQNNv3wHhoZl68PLjnz9+Sa2EoPBOEpp8cRmc3e4=; b=IyELS522y2ARgBFC
	BOJFDE0yN61pMk+2/JcSS1Uj8GAsq8WDs1REkvMjMr5MxNwL3CFC3uvTDY0meB3D
	scZlThy5MjuxfSp1cjldFcz7qoSJBwg8Ein/gGfvA2Avpr++Im0NmoW81HDsT69l
	v+4zbCpsZeOHJVN9AGSwvlaf61k35S94VOF7C3/o/6LKAAvaTh6HN9dnobZhn+xQ
	TU9XeRXnOTM+Lr+M6iNx+zUbXtlFNN7TikV+8BhXQYXrq4rYotKGW1u6qko+r4Wr
	XpJc0JxS7HIDjrQCs+ZJuezlic5BqnpZll698U1p3eUu5rB0RkL4Nlj6Iy9VY3M9
	AGXwtA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg3vywc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:32:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468NWmxl031113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:32:48 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:32:47 -0700
Message-ID: <c5219b32-bc58-4581-abb7-7bae22090bcd@quicinc.com>
Date: Mon, 8 Jul 2024 16:32:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix array out-of-bound access in SoC
 stats
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240704070811.4186543-1-quic_periyasa@quicinc.com>
 <20240704070811.4186543-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240704070811.4186543-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TL5DFtv7WgFfmjlgDIoumhcX_kk4Ditg
X-Proofpoint-GUID: TL5DFtv7WgFfmjlgDIoumhcX_kk4Ditg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=776 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080175

On 7/4/2024 12:08 AM, Karthikeyan Periyasamy wrote:
> Currently, the ath12k_soc_dp_stats::hal_reo_error array is defined with a
> maximum size of DP_REO_DST_RING_MAX. However, the ath12k_dp_rx_process()
> function access ath12k_soc_dp_stats::hal_reo_error using the REO
> destination SRNG ring ID, which is incorrect. SRNG ring ID differ from
> normal ring ID, and this usage leads to out-of-bounds array access. To
> fix this issue, modify ath12k_dp_rx_process() to use the normal ring ID
> directly instead of the SRNG ring ID to avoid out-of-bounds array access.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


