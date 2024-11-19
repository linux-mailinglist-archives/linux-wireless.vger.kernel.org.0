Return-Path: <linux-wireless+bounces-15491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BF9D1FDF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC512824D3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9838E571;
	Tue, 19 Nov 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lj1mq6Uc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30C153838
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996219; cv=none; b=qGeVnHa0Guu6zFifTj6fWgt9UfRV19JQ+fNsf0bh6SELqtxm5stFTsPwuhcE+m6sBmuqKA/O3m4hM0sbUsennq8B/sNyna2LWTykNfo/uQ+AioBkdkIProzSk4r0wd/asZhqRW3J4qK/yl1WFjVXT7vXKv6E0AFsmc/kKHvC0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996219; c=relaxed/simple;
	bh=Zij0s0EttkrsdXaacLYDeozKDXzWKzuDfuPQXIjV45Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fp40hA2hvQmlC9vfldQaCbPeOEDvld/D63u6sMrH8CfrLrQTP6G9kAPp2nonaq9C2ao7hq02310fCRDMD4ZlZ1dMXGVuuO5Xp4RbA3ryYeIvUa74TD6uXeno3JTTRwmt4QVP8dKYvW9vALlnWlR3vG8neMSFSinGdgT4c4EorEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lj1mq6Uc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGndu028909;
	Tue, 19 Nov 2024 06:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T43MysLd3PLlT/K7hKj+yocy4H1D1FGoyM3kVLo5Z8s=; b=lj1mq6UcE5ycrPVI
	C1nlLNouCcqhfZp2aqtbqEXrBThiAEh7fo8dSRAnefWZ5rUtprfbO6df1PaXzzeq
	V0VQNjXiJTmuPoEqsX34tpWTRZriUN82WbYU+FZqRasoYRjzs2ZDn1NVljFm7Akq
	HSvGLa1jBckuglOiml90dEDiyOO3tQ/l2R18np2Cgv0uYIpisv7nzycgrGKKaSB+
	VJMNxXoRiqW/AAeZc2K9hGVpj0SgNilJuMul29Slj6PQudjmps38wp4EpuiEHzY2
	UilUe5NI9OfegSAQl6iWtVzsV9UKKzeMi0TUALaJPRPi15udUYm9pJJqx7utSf0q
	VBdvIA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y81jb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63ZJ3004242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:35 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:35 -0800
Message-ID: <9c0d8e32-e1b7-4fa1-ba10-010e85c9b851@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] wifi: ath12k: Refactor monitor status TLV structure
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-3-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241119003248.1579567-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XAUye67Lc3139qOgU9dUFahWazkmnjQo
X-Proofpoint-GUID: XAUye67Lc3139qOgU9dUFahWazkmnjQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=803 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> The following TLV structures and bitmask definitions were inherited from
> the ath11k but were not updated for the ath12k 802.11be hardware. These
> data structure and bitmask will be used to parse the monitor status
> TLV data in the Rx path.
> 
> 1. hal_rx_ppdu_end_user_stats_ext structure
> 2. hal_rx_ppdu_end_duration structure
> 3. HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF bitmask
> 4. HAL_RX_MPDU_START_INFO1_PEERID bitmask
> 5. HAL_INVALID_PEERID
> 6. hal_rx_ppdu_end_user_stats bitmask
> 
> Currently, there is no issue since the monitor status Rx path is not
> enabled. However, in the future, the monitor status Rx path will be
> enabled. Therefore, update the above TLV structures and bitmask to align
> with the ath12k 802.11be hardware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


