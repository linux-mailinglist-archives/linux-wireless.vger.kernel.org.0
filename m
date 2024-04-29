Return-Path: <linux-wireless+bounces-7009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2258B64F0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 23:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075BB1C21996
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D01836E9;
	Mon, 29 Apr 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fvCxg93Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF6839FD
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427863; cv=none; b=r0+jxJU18bgz6mVGAS1pztAntDrFyn0Pzb8IZaI4V5SRJQM7s568FgUNX062Ip1zEoI41azNNJ53zUc80mN4ubX00y4fJQm2yuwlT0VAfeHr0h8MHqIlXptVrsONYKUu6/PcERozi0XGHb6OX+yEy0cmhcEI4qj0aAImGw8ay14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427863; c=relaxed/simple;
	bh=dEu0a2yVGKTMFXEWhw1f2UGjTe3DP0/+Q4Tk6B9C/II=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AJDulo5+OJuVjb22VJhFKJ2g03Ubtm7EFgzcv9w1tG/gmnwtBqY2zG7Uoi6dUxl5pQUgQ8uePB0LhAOWtsxrITA5cXX7TtOKm8rqqp9BmJ4Tt0BgzT9SZcv2yjDQddW26sRjeZ5ygYDYljAlXlkeItwvfMvMHa2NROGlbHEKSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fvCxg93Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TL0Z86023356;
	Mon, 29 Apr 2024 21:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PSFpxn/BPcX4u9HeZTUoCyoNSd95G7IKLIlKXusGBHQ=; b=fv
	Cxg93Zz25HzZQB/BBgmHLP4LlH14CUK6OzsoupHt0+AngXfQWjGygawefwP8nlvJ
	XcCxw4GW3AmYU5vvHH1g02Rtgt1cscCCKA9P6cx6E3DniIXS+nNozGhqfbeCQGss
	A9rwi6/lN/bBM73etbw979+OMomo4gLOxDzt5+cKhbkJg3sQxTdeKWTugke8BfS+
	V9bDWs34pG6EqvFlWmyJ+B6+7NkqczaFJ2VWYMtcBsqSJ8stPpTBi5tz/QjWOOMy
	5V/EOiV/+Privglpx+TnkAsCicKvgOfrb3tOLiQrAMQT3KqAcocg0HZrEBj9KNLq
	qIqT/UuJoAFps/rbN2Wg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kj3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:57:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TLvZOa031493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:57:35 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 14:57:34 -0700
Message-ID: <ac9dc67a-8bfe-48d4-a169-99f2caca3643@quicinc.com>
Date: Mon, 29 Apr 2024 14:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/3] wifi: ath12k: Remove unsupported tx monitor
 handling
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
 <20240429072039.711706-3-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429072039.711706-3-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AJU_EWjznHyeCaFc9AkTk0N7DXH5Wcnj
X-Proofpoint-ORIG-GUID: AJU_EWjznHyeCaFc9AkTk0N7DXH5Wcnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_19,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290142

On 4/29/2024 12:20 AM, Tamizh Chelvam Raja wrote:
> Currently tx monitor is not supported in driver.So remove
> the tx monitor ring configuration, allocation and handling.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
>  drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
>  drivers/net/wireless/ath/ath12k/dp_tx.c  | 42 ------------------
>  drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
>  4 files changed, 1 insertion(+), 138 deletions(-)
[...]
> @@ -498,7 +487,6 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
>  
>  	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
>  		ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_dst_ring[i]);
> -		ath12k_dp_srng_cleanup(ab, &dp->tx_mon_dst_ring[i]);
>  	}

ath12k-check warns:

drivers/net/wireless/ath/ath12k/dp_rx.c:488: braces {} are not necessary for
single statement blocks



