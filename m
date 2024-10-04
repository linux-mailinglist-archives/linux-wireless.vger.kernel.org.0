Return-Path: <linux-wireless+bounces-13513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAA990745
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B171F21823
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC61D9A7A;
	Fri,  4 Oct 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j7t5RFQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD21D9A65
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055045; cv=none; b=Wl9qe7tJpXxLW1iB0+79ChocWygGOoPadRhhnCZl+YcWa/A1xM+a+jjn3QXj/wzxqUm+zVuu1/OON1VFe5frckSPjWOhffaH6unxVZP3JUrlTJ/HYjai/eQ8I/4ixhdc6Pjbqe6tF97LcGTEAdgfGVAO8ANWygNW1sNBM3mHdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055045; c=relaxed/simple;
	bh=Fm5XpdwwOElFsANEWhwuFp5jES1dcq5qAaPMYQYcJa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jTF5R/uRfO/lr3DmUX0OmxLUReb8y4KIiqdxlTXwx5Dg/icHQh7adQf/8osbnyJM2N44oLPd/5wGFfEKbATd3GA1re9b48BR8gUcMd7cI0W0ZNcp0Or+heztOtyKMhnqJ+bg+A2y1vu/kMQ++7JmgcnhVBbON27b9E7pfS/nErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j7t5RFQr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Am131014162;
	Fri, 4 Oct 2024 15:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vp6Gt+/SMIfQbQpp+5lbiqXacAPxYGZdjp+gs5lPSXQ=; b=j7t5RFQrcCRBDV87
	OCk/dxG0WBh3xgAioxx4AWjCB9rYh6W1SJkaz8eRr0dc/OuJ+DdXgjf5/88+bd6j
	8gRqwucwrEglgI02ZBsITDO8elmIW8b3VAwKTjlzKo94AHOGNP0MP2rp2kmrP0FV
	JjnA3gVETOdXBtmH1km/XYUHMFllDPRIMjVK4pJ2PmldJ8lJnjohz/5kdK6GTu99
	Gi/ET9kaHQakMfBlPZnB1wLEmNSa52FIBcbGIMappqNRVeUXMVCfkyXaBZAWGW3Z
	fUvABtAD/Vx38jVSzsC+Me7iUxjpTVizyQXOBzmLmTHlA7F5eyBwBmeF4JlUcWfh
	TqQ/mg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205e2h8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 15:17:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494FHFMY026445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 15:17:15 GMT
Received: from [10.111.183.136] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 08:17:15 -0700
Message-ID: <a291a502-0fa8-4984-a9c3-9a720c76c60b@quicinc.com>
Date: Fri, 4 Oct 2024 08:17:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support
 arrays with 1-based semantics
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241004085915.1788951-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241004085915.1788951-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j4xjBgHx52gcSk53o4yxexV3F4oxxiki
X-Proofpoint-ORIG-GUID: j4xjBgHx52gcSk53o4yxexV3F4oxxiki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040105

On 10/4/2024 1:59 AM, Roopni Devanathan wrote:
> The API print_array_to_buf() currently supports printing
> arrays with 0 indexing. In some cases, a few arrays need
> to be printed with 1-based indexing, i.e., array should be
> printed, starting with 1.
> 
> Add a new version of print_array_to_buf(), named
> print_array_to_buf_index(), which implements the functionality
> of print_array_to_index(), but with an extra variable, pointing
> to the index starting with which the array should be printed.
> Modify print_array_to_buf() to call
> print_array_to_buf_index() with 0 as the starting index.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index f1b7e74aefe4..ec7add76ec85 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -12,8 +12,8 @@
>  #include "dp_rx.h"
>  
>  static u32
> -print_array_to_buf(u8 *buf, u32 offset, const char *header,
> -		   const __le32 *array, u32 array_len, const char *footer)
> +print_array_to_buf_index(u8 *buf, u32 offset, const char *header, u32 stats_index,
> +			 const __le32 *array, u32 array_len, const char *footer)
>  {
>  	int index = 0;
>  	u8 i;
> @@ -26,7 +26,7 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>  	for (i = 0; i < array_len; i++) {
>  		index += scnprintf(buf + offset + index,
>  				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> -				   " %u:%u,", i, le32_to_cpu(array[i]));
> +				   " %u:%u,", stats_index++, le32_to_cpu(array[i]));
>  	}
>  	/* To overwrite the last trailing comma */
>  	index--;
> @@ -40,6 +40,14 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>  	return index;
>  }
>  
> +static u32
> +print_array_to_buf(u8 *buf, u32 offset, const char *header,
> +		   const __le32 *array, u32 array_len, const char *footer)
> +{
> +	return print_array_to_buf_index(buf, offset, header, 0, array, array_len,
> +					footer);
> +}
> +
>  static void
>  htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
>  				struct debug_htt_stats_req *stats_req)
> 
> base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61

LGTM, please rebase your other debugfs_htt_stats changes on top of this

