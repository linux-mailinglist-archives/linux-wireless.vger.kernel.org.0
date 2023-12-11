Return-Path: <linux-wireless+bounces-673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09780DD71
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 22:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA55B213D7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5859451010;
	Mon, 11 Dec 2023 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gx4foxXr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97ABD
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 13:46:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBLY7iV004858;
	Mon, 11 Dec 2023 21:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fkcBVKA/a6ncrLS9B200BQa7oO+QJWSQs7ila1NiWcQ=; b=gx
	4foxXr8heIwMB9rW1Aq7Co0PNOfxPB8F5MPt28odvZF0e/NiWliyXXrgYsJmTxfF
	tuDtn/Eblf1py+6SPn0szcPIjM4EPNVzxAyR+7JxvIR20m7KwOMKj4xPWwp5DzBW
	BTe2rjJ8eOpACdL3nMwUcZcN+rkSP3Wn8uM31vYlv5pQ/w5s0n2do0B/v0vWT8BM
	F5B9f3fy0qYS6qs/f5P638krPkfqttHSksvYTyYw7vWjMdtnHiXjC8GVLNR14qIB
	5/a0Sbz9O37FEWtt7wcQO+c9oohKAswxfLQ+YSpNpvjM7D+MMoWLnIi+vU8cwpIZ
	4GLF4Qsd0b9eb3pXKuGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux28s99qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 21:46:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBLkQOk009280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 21:46:26 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 13:46:25 -0800
Message-ID: <889fdf9c-0c86-4553-984b-d4e64682d12a@quicinc.com>
Date: Mon, 11 Dec 2023 13:46:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/12] wifi: ath11k: store cur_regulatory_info for each
 radio
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231211062216.382164-1-quic_bqiang@quicinc.com>
 <20231211062216.382164-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231211062216.382164-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OL8wMNP-30e2Vl0Hu0T0Ef1wJHSk773p
X-Proofpoint-GUID: OL8wMNP-30e2Vl0Hu0T0Ef1wJHSk773p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312110179

On 12/10/2023 10:22 PM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
> in ath11k now, the info should be saved in ath11k. Save the info for
> each radio and support switch regulatory rules dynamically.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> v9:
>  1. add check to soc->reg_info_store in case memory allocation fails.
>  2. remove irrelevant change w.r.t commit message.
> v8:
>  no change.
> v7:
>  1. fix ath11k-check warning
>  2. fix memory leak.
> 
>  drivers/net/wireless/ath/ath11k/core.h |   1 +
>  drivers/net/wireless/ath/ath11k/reg.c  |   6 +
>  drivers/net/wireless/ath/ath11k/wmi.c  | 153 ++++++++++++++++++-------
>  drivers/net/wireless/ath/ath11k/wmi.h  |   5 +
>  4 files changed, 122 insertions(+), 43 deletions(-)

I came across a nit during re-review. Kalle, can you fix in the pending
branch?

> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 75c79c99faa9..78bc2715e476 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c

> +static
> +enum wmi_vdev_type ath11k_reg_get_ar_vdev_type(struct ath11k *ar)
> +{
> +	struct ath11k_vif *arvif;
>  
> -	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
> +	/* Currently each struct ath11k maps to one struct ieee80211_hw/wiphy
> +	 * and one struct ieee80211_regdomain, so it could only store one group
> +	 * reg rules. It means muti-interface concurrency in the same ath11k is

nit: s/muti/multi/

> +	 * not support for the regdomain. So get the vdev type of the first entry
> +	 * now. After concurrency support for the regdomain, this should change.
> +	 */


