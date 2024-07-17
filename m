Return-Path: <linux-wireless+bounces-10313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9F934288
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 21:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23C9B21E16
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968617C9E;
	Wed, 17 Jul 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kMbTnj5N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383918643
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721243796; cv=none; b=TJlWUBKpLJO5xCBzsmBzZ/PgFZTcj9QvoV3i8LQ0yX8rr9lhngbXpNcJvnle7AyiYmXNOI3szbPl0ijWzYFQXH3qcBe8o/uOsHLC55wNiur9PSXtmooIpm/eK16qALHQlhUIWrDuoeDnoYGYz96ls0hdtIowEY0iHMnKQwKHZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721243796; c=relaxed/simple;
	bh=RiBCrhHvXh55XJqwfogmMO7Z7lahi15/WtBdVUDFdrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r3CNhn+3BVQMtHG7Z9W3Ubr7o85a16s3aixwO3WYOrf0rhym3AS0tc1ATqPgX/5jf026ojwwBfFphVA+58KiwS8aOSvjAcWqzkIOzRDdOWcwO8iIZW3b1fd84qCQ7WJIHhTfjruOZIax4FbGspDM8wPeGbOTuSMJQpNAWjSVDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kMbTnj5N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HErx7l008253;
	Wed, 17 Jul 2024 19:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DzOu3z9NqFALwhTkqFZuanahE9f/4lVJF+uA3qhNUC4=; b=kMbTnj5NU56di4YT
	FBXH7KkEyDsARgQ4u6wUo9F6wBXB0Q7xhX95P4yekhI92X61J2/O+hAFwqKUkTS/
	u2PI7K3jmRFktxzGnaOX4HCSvymb8zPcgIVCdUZdvsATKTBUbongrRscXiAcAJh5
	KMXGt/iahOsOwg1VMn1r+/GU3BJQtHw47zu6HfDlGYiAcqL5d0LNpDE/LXjEtWnY
	GA0IPJ+AzdRuWRK3lAJ7djRZOz8HwM52kKCae1GfWqkOkC9UnmCUM4g2aaNb/e0F
	Pv+/9uOBdA+N+ZCdTbluKzeL2TiII42gH8GgRHbYfFgE59F9Lb6EdmZjz0dQrGEU
	tWs4yw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfu3f87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 19:16:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HJGNuP023712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 19:16:23 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 12:16:17 -0700
Message-ID: <4514f5e3-32e0-4adc-ad89-36c6650f0079@quicinc.com>
Date: Wed, 17 Jul 2024 12:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: Dump PDEV transmit rate HTT stats
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240716024542.30339-1-quic_lingbok@quicinc.com>
 <20240716024542.30339-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240716024542.30339-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2M3khtnW7CyAQdZF7Pztc8_YmVR1ty-H
X-Proofpoint-GUID: 2M3khtnW7CyAQdZF7Pztc8_YmVR1ty-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_14,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170146

On 7/15/2024 7:45 PM, Lingbo Kong wrote:
> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
> 
...
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index d52b26b23e65..a773be6384c9 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -129,6 +129,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
>  	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO	= 8,
> +	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE   = 9,

nit: use TAB before = to be consistent with existing code

these same issues are in 2/3 and 3/3

also in 3/3 just one space after =

>  
>  	/* keep this last */
>  	ATH12K_DBG_HTT_NUM_EXT_STATS,
> @@ -151,6 +152,7 @@ enum ath12k_dbg_htt_tlv_tag {
>  	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG		= 21,
>  	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG		= 22,
>  	HTT_STATS_TX_DE_CMN_TAG				= 23,
> +	HTT_STATS_TX_PDEV_RATE_STATS_TAG                = 34,

nit: use TAB(s) before = to be consistent with existing code

>  	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
>  	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
>  	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,



