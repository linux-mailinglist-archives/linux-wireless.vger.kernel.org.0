Return-Path: <linux-wireless+bounces-14426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330059ACF83
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9801F21BBF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C201AB6D8;
	Wed, 23 Oct 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h/b93Qun"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68F79C4
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698901; cv=none; b=OfIOiKtf/aXwLJ8uEU219aY9xRrvKI7ccRW+3UGyCO7totD2eCwOdJVBAzl2mExvGP1neRrK1jgu4oEHZIqpyZ2RUiEaSNvWxKJSLViXPEK7cavTS83YhAK33FnghKXX1BY85N8OFe9xVakcxx4IMm8PLTe951iaF/eni2x3UbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698901; c=relaxed/simple;
	bh=EZGj73KnpkkYS/8rmd7DO7/4m4MU5naKnfRxrfqlqEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KTnGzsOAPK4L2vMOgI0t10SFXXoFV90hJ+S4yGnWs65TiAc6g5v+RgAcgiFMN6nGsc5dpUdQohIQkKjBqnhnkVJPaAsVE9rJzcspWcBnggvzfUiTEImiooY43RaM4b3t9XQagaSZPl8umQpfM0xaIU+OW5ffHQSgXIRFT0jgF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h/b93Qun; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9cj3t018075;
	Wed, 23 Oct 2024 15:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JfJQocG0Byys8cb+0L39TCoP1dAqS2s+pZumt6sigz8=; b=h/b93Qun27CyMiSJ
	HDrPAunufArZ5sfFy5BsvxLXp5VLrGkF2sv3n9GNmrD9WeSf0SPUNw7EkrbjDwqz
	nepCpB6u4Zh+KZJ0EtHawwF6a2kc+DnnJvkHtQ6xFkybCCT7v2tCxZZt5O74i49X
	6KsmXB0M1mh0hxK5SpozeZ2caLEXlglchgf9+1BYp+o+sq/UgcTAKsgdcNd9RiSE
	CUt8KrOmrE6x81teva6CPB5HISdYb5Q30yXbk+MQkLPT7hWNLFsnvvSXrWv5us9Y
	9QwvaQskpPGhAzHB84lr8U5nYwAfY4ZqpOrURcfETJCSIPMlsHZy6bc2b+5v3GYa
	cNmKGw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3waqr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:54:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NFsqnF023332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:54:52 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 08:54:52 -0700
Message-ID: <f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com>
Date: Wed, 23 Oct 2024 08:54:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-7-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023133004.2253830-7-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Phe56Oq1D5uJTsAemkN1iWiVRudo5Gq
X-Proofpoint-ORIG-GUID: _Phe56Oq1D5uJTsAemkN1iWiVRudo5Gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230098

On 10/23/2024 6:30 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Driver should indicate to firmware whether a peer is multi-link or not in peer
> create command using multi-link flag. Add changes to support
> WMI_TAG_MLO_PEER_CREATE_PARAMS in WMI_PEER_CREATE_CMDID.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c |  5 +++--
>  drivers/net/wireless/ath/ath12k/wmi.c | 27 +++++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/wmi.h |  6 ++++++
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 019a1a6c6777..b628bc2fd0f5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4981,8 +4981,9 @@ static int ath12k_mac_station_add(struct ath12k *ar,
>  	}
>  
>  	peer_param.vdev_id = arvif->vdev_id;
> -	peer_param.peer_addr = sta->addr;
> +	peer_param.peer_addr = arsta->addr;
>  	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
> +	peer_param.ml_enabled = sta->mlo;
>  
>  	ret = ath12k_peer_create(ar, arvif, sta, &peer_param);
>  	if (ret) {
> @@ -7016,7 +7017,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	struct ath12k_vif *ahvif = arvif->ahvif;
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
>  	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
> -	struct ath12k_wmi_peer_create_arg peer_param;
> +	struct ath12k_wmi_peer_create_arg peer_param = {0};
>  	struct ieee80211_bss_conf *link_conf;
>  	u32 param_id, param_value;
>  	u16 nss;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index e089b58bbea1..0583d832fac7 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1230,9 +1230,14 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>  	struct ath12k_wmi_pdev *wmi = ar->wmi;
>  	struct wmi_peer_create_cmd *cmd;
>  	struct sk_buff *skb;
> -	int ret;
> +	int ret, len;
> +	struct wmi_peer_create_mlo_params *ml_param;
> +	void *ptr;
> +	struct wmi_tlv *tlv;
>  
> -	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
> +	len = sizeof(*cmd) + TLV_HDR_SIZE + sizeof(*ml_param);
> +
> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>  	if (!skb)
>  		return -ENOMEM;
>  
> @@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>  	cmd->peer_type = cpu_to_le32(arg->peer_type);
>  	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>  
> +	ptr = skb->data + sizeof(*cmd);
> +	tlv = ptr;
> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
> +					 sizeof(*ml_param));

using the same TLV size both here and for the TLV that follows doesn't seem
logical. is this missing + TLV_HDR_SIZE to account for its own TLV header?


> +	ptr += TLV_HDR_SIZE;
> +	ml_param = ptr;
> +	ml_param->tlv_header =
> +			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
> +					       sizeof(*ml_param));
> +	if (arg->ml_enabled)
> +		ml_param->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
> +
> +	ptr += sizeof(*ml_param);
> +
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> -		   "WMI peer create vdev_id %d peer_addr %pM\n",
> -		   arg->vdev_id, arg->peer_addr);
> +		   "WMI peer create vdev_id %d peer_addr %pM ml_flags 0x%x\n",
> +		   arg->vdev_id, arg->peer_addr, ml_param->flags);
>  
>  	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_PEER_CREATE_CMDID);
>  	if (ret) {
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 33b9643644c6..07bd275608bf 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3026,6 +3026,12 @@ struct ath12k_wmi_peer_create_arg {
>  	const u8 *peer_addr;
>  	u32 peer_type;
>  	u32 vdev_id;
> +	bool ml_enabled;
> +};
> +
> +struct wmi_peer_create_mlo_params {
> +	__le32 tlv_header;
> +	__le32 flags;
>  };
>  
>  struct ath12k_wmi_pdev_set_regdomain_arg {


