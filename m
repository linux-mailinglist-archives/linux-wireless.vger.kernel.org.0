Return-Path: <linux-wireless+bounces-6056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7242B89E698
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 02:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E2F1F22528
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054A170;
	Wed, 10 Apr 2024 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FuYJVUh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769F7F
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707653; cv=none; b=NAPF3x3VZRRF8HGK2PstCs2LbApGI9stYdXAmDLPfXMqe5bVH7ax/mIDc9YLnZpGHz8zEADq3wKylBWY/BZq/TBf/GN1gUlD+hExIlzaqiLM+AqDHCAvvB7+r/0oSPnBJZkaWcHbCdKOrQsVSgbg/lgGdEKfYt1Suvs/KmOGfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707653; c=relaxed/simple;
	bh=Qf/C200YNIHf3H1owJsTHEZ0pju5m7YRE9+zSVQjDCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s2weDTdNxu58iQkPGwIdDLn3dw7LQBJRBhQY+gbZZ8Ts5GjS6b4SUscH6kEdca1L1aDLqM6BETRcuovbY5qDF3Ogp9hpw6i6PeLMCWuIeQDOFjUHEhBJiqA0NumXM3yI4WRnsNYAdYHSpWZqeJQeCR287IuuqLQ1VtQl76hAqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FuYJVUh7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A00OGT015941;
	Wed, 10 Apr 2024 00:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EY/V0UTpIc4eSRTb7M2ZDFuG/iwU+cKnFHTgb17wgXE=; b=Fu
	YJVUh7MGRuXBZQzjIRuwdj3anltoWEbAjY2oUdf6ivtROkOa7Pp+SHHQgsAZPKn1
	e6xyzbbikb48GowlY9LdubIRLRYfBTU9z7azNavdcJlt823/btQaYaJYE5B69Smm
	0S9Gi4mRletr08HDuDIOW3XOcRXBPHXDSKhfMjVS99bnO54bOggqwsygub0OpI+Y
	7IB1YSmSzJFtQP3eHtF+LP5fF/fH5NKv5DG7cRqwK/OikezmYvtA94nU9TESm1fW
	ExnYvWdTYhlk/olvFAQnw8gkAWDFAlxecVOvAKO0X/VvKMYCzHBdRa9fFq3aICbc
	G75hJA58t7oko4mfZzzA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdaw1ryej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 00:07:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A07MiQ008931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 00:07:22 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 17:07:21 -0700
Message-ID: <1e515bbc-0119-4114-b44e-d7a449b031f7@quicinc.com>
Date: Tue, 9 Apr 2024 17:07:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable service flag for survey dump stats
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>
References: <20240409175604.3299752-1-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240409175604.3299752-1-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rgHn3VHK1CzBjWvPj87zvwcd70yboJ7H
X-Proofpoint-GUID: rgHn3VHK1CzBjWvPj87zvwcd70yboJ7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090166

On 4/9/2024 10:56 AM, Karthikeyan Kathirvel wrote:
> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> 
> The survey dump statistics does not display channel RX and TX time
> properly because the survey flag is not enabled in the firmware service
> flag.
> 
> If firmware supports enable the service flag "bss_chan_info" in
> wmi_resource_config to fetch and print the stats for specific pdev.
> 
> Enabling WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 does not have any impact
> on WCN7850 since this bit is not utilized by the WCN7850 firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
>  drivers/net/wireless/ath/ath12k/wmi.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index a5575ce9eed4..16504786735a 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -3324,7 +3324,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
>  	wmi_cfg->bpf_instruction_size = cpu_to_le32(tg_cfg->bpf_instruction_size);
>  	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
>  	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
> -	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config);
> +	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config) |
> +				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;

shouldn't that | operation be inside the ) ?

>  	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
>  	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
>  	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 78afc94a815d..1283d25b5cc4 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2400,6 +2400,7 @@ struct wmi_init_cmd {
>  
>  #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
>  #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
> +#define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
>  
>  struct ath12k_wmi_resource_config_params {
>  	__le32 tlv_header;
> 
> base-commit: b36766befd306a606f287b0c0f0e53d994516acb


