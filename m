Return-Path: <linux-wireless+bounces-18109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36292A21790
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9259E163F66
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AD2F29;
	Wed, 29 Jan 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YwAc9U/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD725A643
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130491; cv=none; b=GhXMYcII8GmjXLXIpRGy1Pm4BkhUoOl4ZahUINdg0nWEfzp8EZWORyqXxEuzPgVzSFiir5rnAbRTYFT1zuLyjIBehMO7XUjUiQS7Q1uPeJu/N5LX80lbLZYs/UXmvuth8oOiPdqZnwFaeY2rUatBUAj7r1+/6sRumwWSzzKJUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130491; c=relaxed/simple;
	bh=ffGnkUvKXDAN0Wtvr2v6DJpflvcP0SdoBJTV1x0tr/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYkuiDdiNjHo1nMMg9gmKazuyrW53gxSZ6FDIKahNwTj6ii8Yn+AstRSsToTOZyC+CAkLdhKceS8PyJpqNU2RLfMxc+9WCrbvvmK7qK1ujHZrqv9VkjdFInF0zOYtki84qW/o6vEUH3fQMZuoD5W6OZiGTvqP+ydgBTufUW1lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YwAc9U/r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2sNkl021406;
	Wed, 29 Jan 2025 06:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzfkWxJreF6ssp14Jtt9vtY84vRD3ibtf97KEMPqF8w=; b=YwAc9U/rk8xoNy2c
	pkY3vIOr+AMRc0orYDcaC/dNS05WNA11jUpW+bVlr8y72e1J29OFwAH40f8OIzkx
	k6gc8s1m3x2mP7FC+jYJBuSJyCYGn4FtBlyNFR7WQNo76qd/EQZ5felrRm8kB12e
	7/4p8egFa4guKp+jJLgH6bnxIDNAlBCfB7lpTuAcn4THtM4nonlbJZO3F8KNhXg5
	2ej3P7j8MlrWqSAsMMIkXdG5bAzLTKYuSxLGoDEIQjXpDUAMrs/8Qg2r3NACaHj6
	G2G9FmD5+N/vb/uUGFa91kXrTjo1WkRWiq39543Ql9yo7w8SQddKbsOglV3xu9rd
	LCuD3g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fbxvg8an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:01:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T61FFd009996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:01:15 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 22:01:13 -0800
Message-ID: <f4cc8b0a-31ab-14ad-2687-7f25ab0baa60@quicinc.com>
Date: Wed, 29 Jan 2025 11:31:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/7] wifi: ath12k: fix link valid field initialization
 in the monitor Rx
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>
References: <20250127114030.43479-1-quic_periyasa@quicinc.com>
 <20250127114030.43479-2-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127114030.43479-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3cwnBNPlPrDtxufQFB2O1Ad8aVqjMEV4
X-Proofpoint-ORIG-GUID: 3cwnBNPlPrDtxufQFB2O1Ad8aVqjMEV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxlogscore=928 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290048



On 1/27/2025 5:10 PM, Karthikeyan Periyasamy wrote:
> From: Hari Chandrakanthan <quic_haric@quicinc.com>
> 
> Currently, the link_valid field is not initialized in the monitor Rx path.
> This can result in random values for the link_valid and link_id leads to
> undefined behaviour in mac80211. Therefore, initialize the link_valid
> field in the monitor Rx path.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Tested-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 7e679ce177d3..023715df1126 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -2001,6 +2001,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
>   	bool is_mcbc = rxcb->is_mcbc;
>   	bool is_eapol_tkip = rxcb->is_eapol;
>   
> +	status->link_valid = 0;
> +
>   	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
>   	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
>   		he = skb_push(msdu, sizeof(known));

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

