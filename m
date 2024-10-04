Return-Path: <linux-wireless+bounces-13518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF09909FB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 19:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DF5283093
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605B1CACEB;
	Fri,  4 Oct 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QB9EXLu+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FE1E376B
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061742; cv=none; b=cpCBul6tWh1tXo4kTb92f0LIEw88Df1z4L8cvJ/pCmjh2ZqBJkJ2ZO7W/v6WqVwGG3nbsPTEfCGFlVffFYbpYsmwJnZECz4oEitbdsaYfTUSaC6GMU8dy4wUX4kvOXCbqEt7H7HsI6GYCkz401UQIoEsFn8o7zApAcVYX9bWjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061742; c=relaxed/simple;
	bh=x5Rv9zHgihAsf9lODMBt3EQaq6yR5gEfjWr0FA75o1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hcnt0aU+AI4gWJNxQGqY1OPqXFtYJPYayx6ygtavUPB3suEAG8JPqXu9+6prBQLd/nFjNulooZ13CRUHjiu8WhGeUw5/TK4//juA+8V01uFkt3Kp8ttZ5FmNxnLhlEsap/VXxBMlzWTFTcCDq4SLJGBA7soUjDa8QL+pR9jRlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QB9EXLu+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494B3xHM026679;
	Fri, 4 Oct 2024 17:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OQGaxH01c90zyB7W2GgISPxiGHLC5E8st1li8CuHK0c=; b=QB9EXLu+x02BWyk+
	AiZ1JyWO4StIJJBmIwK1saPc6qk6heaGq13cuMD3ft1J2ij8jTCKj9yTpSgp2Sef
	WxHZfLSri2/FcSvoWkRjbVRc/eIRTxxoc69Mrf8y8Awjs0WYP14NKpzGaY6qbk3Q
	w5wis99M4cOIYgKJidAcqLUAQZPdiZIEdBSPAdDQVjm7O8VCwSKDO5wy36Of8w5w
	hrKE/u0miKKArDYc9CStWZsdS99Yz40L+QPPi+HpgdTWK823IvE4gaQi/W6UKZ+b
	KbpMoLNpUXMz8KAKHCZJcHfmyY2Xl3nz3YWfpUjwGm7qPa2qCsAGtG8wwqMtviHd
	ax1kaw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42207v2shj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 17:08:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494H8mkP028834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 17:08:48 GMT
Received: from [10.111.183.136] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 10:08:47 -0700
Message-ID: <fc56f428-7dd5-4005-8873-9feb27706d4a@quicinc.com>
Date: Fri, 4 Oct 2024 10:08:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix RCU stall while reaping monitor
 destination ring
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240924102345.811-1-quic_kangyang@quicinc.com>
 <20240924102345.811-2-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240924102345.811-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NmND4ohA8E6y-dNxe5p4e0taqx6VUNDV
X-Proofpoint-ORIG-GUID: NmND4ohA8E6y-dNxe5p4e0taqx6VUNDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040118

On 9/24/2024 3:23 AM, Kang Yang wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> While processing the monitor destination ring, MSDUs are reaped from the
> link descriptor based on the corresponding buf_id.
> 
> However, sometimes the driver cannot obtain a valid buffer corresponding
> to the buf_id received from the hardware. This causes an infinite loop
> in the destination processing, resulting in a kernel crash.

Seems this should have a Fixes: tag

> 
> kernel log:
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ……

let's avoid unnecessary Unicode characters

> 
> Fix this by skipping the problematic buf_id and reaping the next entry,
> replacing the break with the next MSDU processing.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index c087d8a0f5b2..072963d3396c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4781,7 +4781,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>  			if (!msdu) {
>  				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
>  					   "msdu_pop: invalid buf_id %d\n", buf_id);
> -				break;
> +				goto next_msdu;
>  			}
>  			rxcb = ATH11K_SKB_RXCB(msdu);
>  			if (!rxcb->unmapped) {
> @@ -5405,7 +5405,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>  					   "full mon msdu_pop: invalid buf_id %d\n",
>  					    buf_id);
>  				spin_unlock_bh(&rx_ring->idr_lock);
> -				break;
> +				goto next_msdu;
>  			}
>  			idr_remove(&rx_ring->bufs_idr, buf_id);
>  			spin_unlock_bh(&rx_ring->idr_lock);


