Return-Path: <linux-wireless+bounces-8630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874AE8FF2C6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC5287CB6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413681F171;
	Thu,  6 Jun 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gNt6XkIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867B1CAA9
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692254; cv=none; b=t9r84oKbozJ+8xdl8Vtu7jS6tdtgJYLgYFSQ/bWpY36lSgjzU8U57KwbOAO3fxdEtHterDu5yML1mcCoFbAHIxg02/v0G2cM8CYaMJa9/7y/UsGKhxEAM5PW/7Tegw9rOmWstMIP95bQ3TQAtUrB3ZyNBE/usIWAK54fvSB35QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692254; c=relaxed/simple;
	bh=9Obw2X5qISUvJC/MrgJALmW/a94TzVizNNNufWa3hBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PaFtfHlvLxiea/dTT/ze87AzrTKUFU97iNAm2SpwOnBD1ktnqaGRFVTxxOYInL5WdXKfEcjlOcxnNgfxCUUe9I6WKnsEm3HmJihZIbuk8YiB4nwfB1hTJHJnUNSKBTIm7L/PuJ5leiV3fRm7j6KAINYx0BBKd2eMcqqZawB847g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gNt6XkIw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456AMfZL031654;
	Thu, 6 Jun 2024 16:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	td1JCc+xR83J1CfZP9yAbQ9iUkPKoTjfs56I+wfuRkY=; b=gNt6XkIwZ0Mkr2HC
	CebQzn1y7B/MM+CcWL+xPTt0LOp4Up6cohJJluxeJLcHhByyGMIRJo7e1pW/Ki1w
	KZeuQW43ixn21usK7dnboTCZUj7uRFiwWHHtcyc2udgo8h90kvTxmPOx3QoTjiV7
	nsg7LyQ7kB1GUDrNqBBs5Bc+mDW3MmyXNGjUD6JZuVYRD3EKPStiIIVs/EPMjAl4
	bFvVd9MJFkBZdMRi+3/3yuCVCJ3sbAUhn4HM01UeE8pLpbTR0rElPAuIoH5iZ9hI
	RnMEFry6LAprBEUKrTH4wTWqSkWTep2f1FbknW8HGVcSMf9sC/25NFbiUEFpW6vX
	turW4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjk89c8sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 16:44:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456Gi6VC018319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 16:44:06 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 09:44:05 -0700
Message-ID: <6bdebf58-1bae-4a8d-b804-fdb0e0557364@quicinc.com>
Date: Thu, 6 Jun 2024 09:44:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] wifi: ath12k: Dump additional Tx PDEV HTT stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
 <20240603044214.960261-6-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240603044214.960261-6-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wO3hOHu4CRrClsCoZRudqOfjQZEzOh4G
X-Proofpoint-ORIG-GUID: wO3hOHu4CRrClsCoZRudqOfjQZEzOh4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_13,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxlogscore=890 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406060119

On 6/2/2024 9:42 PM, Ramya Gnanasekar wrote:
> Support to dump additional Tx PDEV stats through HTT stats debugfs.
> Following stats dump are supported:
>         1. PDEV control path stat to dump Tx management frame count
>         2. Tx PDEV SIFS histogram stats
>         3. Tx MU MIMO PPDU stats for 802.11ac, 802.11ax and 802.11be

again have a new comment in this patch

> +static inline void
> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf, u16 tag_len,
> +						struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv *htt_stats_buf = tag_buf;
> +	char *mode;
> +	u8 j, hw_mode, i, str_buf_len;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 stats_value;
> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
> +
> +	if (tag_len < sizeof(struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv))

sizeof(*htt_stats_buf) is preferred

> +		return;


