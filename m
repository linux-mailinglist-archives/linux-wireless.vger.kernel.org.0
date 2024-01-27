Return-Path: <linux-wireless+bounces-2586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9667C83E86A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D80E289A23
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A11873;
	Sat, 27 Jan 2024 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VReFo0qn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB8186E
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315044; cv=none; b=gFoyvPigzxjgGW4oXJ6GlcFLmihk6yQ54dvrlEY78LBrbTIlNEFCgqV7CcznaSeL9ZUpUuHo1uVkghi28nWZhfBM4ulOjy9VSgVRZ7ElYTb3ckvEYJyoRL1pwCQoOj3ahd/Y6z7+0YBBKfHAeXkcjzSRK47INT+zUG3KfDwe8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315044; c=relaxed/simple;
	bh=F/shBDasmCKN+GEl+OibJu+7a1nxwI+uj91+DSFSswg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iB813bUUeDqeIs/JoXrDzsyNxAmMXKfe+QTofFsQiyG3eFQQcXuxMzmJKLNSTu3PK9x44R0GP0zjAp3XGO2LWTqk1dJ+8ScJhhg/gT+afiHXshanZdwg3mNex2CiJVn5oPYK+uDt4qosgPYubMviAneEYPjr6r+fTs008ElCM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VReFo0qn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R0LX3P023033;
	Sat, 27 Jan 2024 00:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=z5Dmcn0tLMetworJ7ghrTDfwdElvkBrKOKq8NFKf98U=; b=VR
	eFo0qnmoIgOcCZWk/uBYYbj9Vu9+iya4StpuwCaF/+iA6AbVno63TlFUcXKjeeHP
	jnkDDweukyB3G3yMTaS1BAHHilRd7WvdUuKTh1rOEtma31JYLX+TDlBNXqpO/GVE
	MD9k8ZqwuM6qIABfuCg1iZmpuUnaLVun9yktZVfi4oFnXv74sYUs8ci5dN6U3IHz
	T1JLYwSDOYhvHOWogvo6un3iyaLH4aQzRyCZ+XSPKJTWbRShIFAqeJzKC3cahmS3
	cIDP/eEEoM81mzqUniJxwl1+m7V/D5Z73jrSVwoV1cyRZsAfarDPgKozLjk0NkXm
	jgvySIGuSUyJh5w6Easg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvq6sg06v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:23:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0NwN4031376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:23:58 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:23:57 -0800
Message-ID: <8cc71105-9901-4732-aafd-f8e116e485f3@quicinc.com>
Date: Fri, 26 Jan 2024 16:23:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-8-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-8-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W8CU0_xQDw2XLbMnrt3YR4EYZMLjDA1_
X-Proofpoint-ORIG-GUID: W8CU0_xQDw2XLbMnrt3YR4EYZMLjDA1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=841
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270001

On 1/26/2024 3:52 AM, Kang Yang wrote:
> Current structure wmi_vdev_create_cmd is not matched to the firmware
> definition. So update it.
> 
> And update vdev_stats_id_valid for vdev_stats_id.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
> 
> v4: no change.
> v3: no change.
> v2: add Tested-on tag of QCN9274.
> 
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 5 +++++
>  drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index c7e732c6c145..34e676799616 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -828,7 +828,12 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
>  	cmd->vdev_subtype = cpu_to_le32(args->subtype);
>  	cmd->num_cfg_txrx_streams = cpu_to_le32(WMI_NUM_SUPPORTED_BAND_MAX);
>  	cmd->pdev_id = cpu_to_le32(args->pdev_id);
> +	if (args->if_stats_id != ATH12K_INVAL_VDEV_STATS_ID)
> +		cmd->vdev_stats_id_valid = cpu_to_le32(true);
> +	else
> +		cmd->vdev_stats_id_valid = cpu_to_le32(false);

else clause is unnecessary since the struct is zeroed when allocated

>  	cmd->vdev_stats_id = cpu_to_le32(args->if_stats_id);

suggest this only be done inside:
 if (args->if_stats_id != ATH12K_INVAL_VDEV_STATS_ID)

> +
>  	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
>  
>  	ptr = skb->data + sizeof(*cmd);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 0efed12dd7ab..74b0ee9f86bf 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2712,6 +2712,9 @@ struct wmi_vdev_create_cmd {
>  	struct ath12k_wmi_mac_addr_params vdev_macaddr;
>  	__le32 num_cfg_txrx_streams;
>  	__le32 pdev_id;
> +	__le32 mbssid_flags;
> +	__le32 mbssid_tx_vdev_id;
> +	__le32 vdev_stats_id_valid;
>  	__le32 vdev_stats_id;
>  } __packed;
>  


