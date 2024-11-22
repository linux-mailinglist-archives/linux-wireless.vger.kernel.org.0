Return-Path: <linux-wireless+bounces-15615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F004C9D6516
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FECB2312D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42A4A0C;
	Fri, 22 Nov 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L+tzG9l2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6B1531C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309643; cv=none; b=KWZtnwkfZYQ5ulVRfrxlsiCC4Lk2uMkSYzovCI7lQ4xxX4eriAA6q+hvR7lDwPy1iT8AYBHT1yZId3HCwMvbLCoOMo+5t6VOYDEyPap1fAEoyVzAGXikZhmQjhDZ/VlXCiY8AcxwGSupQF6emWfX0FMvwOGXtufcU98ElxMd/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309643; c=relaxed/simple;
	bh=2swiKz5R60kV3lCGT4ko3famJAs96YsvVH1H317H6yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jgpYTxuTkeNmieFLBBw/dxTjdy2+/8PLhefJl7iSdakIRzdbVDlnf6QsVrQ9/EbjIVtPILIIrnmNP8W87hKgrBIq5hlCGYbVSNGWLwT5bYTS8WuaI7ZaWKMIpSYEc4+KO9wQouOPK0DIlij3cBp0Bmg17D9+BfkAK88qb16AsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L+tzG9l2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMIXuCm003632;
	Fri, 22 Nov 2024 21:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhY8e9WMw3LtuvmwOUonOFh5kzu++uTPDYZjxS7rYfU=; b=L+tzG9l2u1gL7dDB
	sDBi2B3YZyHpJj8KW3VgX+yiA7lU34r9il3ZFilFCCT/QwefCFZNi8hI+QEo8bkK
	hBBWZbGKEGgeTv9EnT1yBI2cr+u7K8G/Jy1r66wbZpfRHWbjwFzZrHTiCIFkjWuI
	oUYP2rFlfo0WrZm7IGz7KhAnmBEJHHD7z+KEWVeHspxpB1yYaRdyZEt9u3+dw7Fp
	hU1vbk19MouxfT16nwAqxGaMvp/vkGab55+jFkbgXoiwfPpRpYIbtIAOvFRiX+hv
	5PtdqJVz3pAAu94pZ9+zaGTgNCZO9XMoSC9tosNZTOTj7J2ZCa1DJUwKkZUxK/qQ
	fmTsag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432p0d9wc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 21:07:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AML7D94024568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 21:07:13 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 22 Nov
 2024 13:07:12 -0800
Message-ID: <75c641d9-26f5-4d42-bd48-14b1606ba4d9@quicinc.com>
Date: Fri, 22 Nov 2024 13:07:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix invalid data access in
 ath12k_dp_rx_h_undecap_nwifi
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
References: <20241122174252.2067375-1-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241122174252.2067375-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4F_fRWRxrwMsqKFecAngmYgvDENK1rQJ
X-Proofpoint-GUID: 4F_fRWRxrwMsqKFecAngmYgvDENK1rQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220178

On 11/22/2024 9:42 AM, Tamizh Chelvam Raja wrote:
> From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
> 
> In certain cases, hardware might provide packets with a
> length greater than the maximum native Wi-Fi header length.
> This can lead to accessing and modifying fields in the header
> within the ath12k_dp_rx_h_undecap_nwifi function for
> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
> potentially resulting in invalid data access and memory corruption.
> 
> Add a sanity check before processing the SKB to prevent invalid
> data access in the undecap native Wi-Fi function for the
> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

One nit...

> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 42 +++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 0fb39c174475..26ff9a346dca 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2474,6 +2474,29 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
>  	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
>  }
>  
> +static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
> +						   struct hal_rx_desc *rx_desc,
> +						   struct sk_buff *msdu)
> +{
> +	u8 decap_type;
> +	struct ieee80211_hdr *hdr;
> +	u32 hdr_len;

try to keep reverse xmas tree format



