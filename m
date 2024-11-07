Return-Path: <linux-wireless+bounces-15016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD429BFA8D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EC61C21075
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE612372;
	Thu,  7 Nov 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T80aN+3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABC366
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938134; cv=none; b=YWTXe+Fmgkaph+iX4FWTtZ7Ur9HDEDJfFJukHr9VUHeQvYrh1/pRCHvIYFFGjnYJdyKPo/qb8orxr8cora4wAe6SStF3Udt7T+fID9bjHbQ9ROSTQjFSiOJJKrKVIXSMMuEKc5ANcJ0HhphAU+FMSe+kQCd3LzwSbWoWAAGCLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938134; c=relaxed/simple;
	bh=CucV3XX1LcdhzWxBk+plvz6OOJtMh4X5f0J3aKq3ank=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hZhEk3PmBOkQmshEjS42JeMO6l45rAd6kiJoxqOoULIPvVOvmN3tBzeYpN0qXCchnDufbBO8xFecoYmA/a1K2uTwbewQm7l86fGBirNDCJBDtEJ7+xpcN3Dyre8IcWb5gbxVzwn+SkLZia4caRn8cR8cjGoe3nsGt9P4tZxUsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T80aN+3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6NqtnI017106;
	Thu, 7 Nov 2024 00:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KXLEA/sNCj34l76nW/dvezmuxsfZQbODDclCV8+JQxU=; b=T80aN+3zw/1adt24
	XiR4z+t9HmVNb/ru7qzQVJyxg2QYRSyAulQkRcz+icLA3xWmGHp+v2dX5qsH2KEQ
	2CL0bAYxNki3pJTcRee8LoAAEPLRAqiwPQqyzun+asgdm+PB68vkvUtG+JPLXQg0
	VTVUtNDnpQf0pC1E5v6CkYZTyEsaRa9OA72fgbteKJyp86P6vzzCzv37IjAhPOw1
	2s2nr7BGsayfW4ZJ3ukeO3fXOv7Uh3heH/z4T9VPkt0HIOQlK42YVN/GBkBdb/8U
	2n/n4vmnHeIdbwiMs0Xmwn1D1Hb1pH9PIeZDRrafsIHrrKddPnde43iMcg1gKWdF
	c3+5QA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42q5n8q77c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 00:08:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A708m8S003903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 00:08:48 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 16:08:48 -0800
Message-ID: <61fe7e64-7525-4d39-a6f2-0252e953e2e9@quicinc.com>
Date: Wed, 6 Nov 2024 16:08:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] wifi: ath12k: Support Downlink Pager Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
 <20241106044548.3530128-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106044548.3530128-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ppgvNqnq1L-FhurBuiEUDmzZHrCQBzH
X-Proofpoint-ORIG-GUID: _ppgvNqnq1L-FhurBuiEUDmzZHrCQBzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060185

On 11/5/2024 8:45 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request downlink pager stats from firmware through HTT
> stats type 36. These stats give paging information like number of pages,
> their timestamp, number of locked and free pages, synchronous and
> asynchronous locked pages.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 responds to
> the event requesting stats, but it does not give any data.
> 
> Sample output:
> -------------
> echo 36 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DLPAGER_STATS_TLV:
> ASYNC locked pages = 2
> SYNC locked pages = 0
> Total locked pages = 2
> Total free pages = 127
> 
> LOCKED PAGES HISTORY
> last_locked_page_idx = 0
> Index - 0 ; Page Number - 8495 ; Num of pages - 1 ; Timestamp - 4031009360us
> Index - 1 ; Page Number - 7219 ; Num of pages - 2 ; Timestamp - 885379515us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
> UNLOCKED PAGES HISTORY
> last_unlocked_page_idx = 0
> Index - 0 ; Page Number - 7144 ; Num of pages - 2 ; Timestamp - 4032070008us
> Index - 1 ; Page Number - 7214 ; Num of pages - 2 ; Timestamp - 885379512us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 86 +++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 31 +++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index c9980c0193d1..8a4fe3cbb8dd 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -2542,6 +2542,89 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
> +					   int idx, char *str_buf)
> +{
> +	u32 ts_lo;
> +	u32 ts_hi;
> +	u64 page_timestamp;
> +	u16 index = 0;
> +
> +	ts_lo = le32_to_cpu(pg_info->ts_lsb);
> +	ts_hi = le32_to_cpu(pg_info->ts_msb);

when I build with W=1

drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: In function 'ath12k_htt_print_dlpager_entry':
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2582:13: warning: variable 'ts_hi' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2581:13: warning: variable 'ts_lo' set but not used [-Wunused-but-set-variable]

> +	page_timestamp = ath12k_le32hilo_to_u64(pg_info->ts_msb, pg_info->ts_lsb);
> +
> +	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
> +			  "Index - %u ; Page Number - %u ; ",
> +			  idx, le32_to_cpu(pg_info->page_num));
> +	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
> +			  "Num of pages - %u ; Timestamp - %lluus\n",
> +			  le32_to_cpu(pg_info->num_pgs), page_timestamp);
> +}



