Return-Path: <linux-wireless+bounces-14418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DE9ACE1E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28079280F55
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FA73176;
	Wed, 23 Oct 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LM+uW4tq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5562171
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695674; cv=none; b=YlmHp6dDkv0IuMxgUBGs7P347Aeup2VEmAyzwxSvRQLur2Z3R4OY4Eq+sGBcSNT49XHt/1VPyMCyLi+J0XrsPhmCaOfsye1Bzcv6Kr4rwvt0Iqi6JJostNv6jUT53JuInYTRiaoBpum8LC12BbLdpj43YvPo6ZqA/QehlY0dtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695674; c=relaxed/simple;
	bh=PluurB4kH2NbwB5sk+c4BbO56nM8xFzlQUX3cnqS/hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syRMY5GiZ9LX7iOpzAohZA6okos1UpKFMxHpGHFLposIAymn2yQmfagK895kVk8hqJj4dBGmo9WEQgNgFgeSnNvw0h6ZS69/PXFZbeVwkTfjFIc979Dh1jIK2/gFzjqqq4sMuhQgAE1VJSEAZ65pCp/8VntxFBGXNuCUDDVEpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LM+uW4tq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9qFLT020080;
	Wed, 23 Oct 2024 15:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	62S6iCnytL5p/vW3jA+z1gQwxHIHLxFaI69oZ3vFQd4=; b=LM+uW4tqSpO7oUJF
	6K6u361UT97bJenTSLtvOFA/L/xKUzi6MIvPn+AFvpQKuAXeSRJvA/1vzmd3oYnk
	ob0Oc4ykWLoIm75ZaPEJjKcCm2ybhvCj/wBaQPQ6PzilmI23W0ebngI7+mplNVnk
	x4nUEY2E7mbmEYoZId139fcF47uhSxmo/7Cq0wz51DEudCb/2FwJrkm+lRAWU8WN
	a7YBJKPvkh/k2dFt9YCqlVku7zOQDYQ5piQDYDBWGFBnU3bgESQHXuEtGvbIZjek
	xIzOCCXBtlxRH6zujvuO2vjC/AYGhby8wsq+kU0G5Atb/b10bn0oss8/bp1HOZwG
	ZrwjTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em66akby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:01:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NF16Td011985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:01:06 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 08:01:06 -0700
Message-ID: <ab8f3e88-f55b-4945-b4bb-a784d1466a27@quicinc.com>
Date: Wed, 23 Oct 2024 08:01:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto for
 error handling
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-2-kvalo@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241023133004.2253830-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1LpIDylBV3dx0a5UIByjgau_gycP_Pcy
X-Proofpoint-GUID: 1LpIDylBV3dx0a5UIByjgau_gycP_Pcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230092

On 10/23/2024 6:29 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In commit 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal
> for MLO") I had accidentally left one personal TODO comment about using goto
> instead of ret. Switch to use goto to be consistent with the error handling in
> the function.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index f5f96a8b1d61..f45f32f3b5f6 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7047,8 +7047,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
>  						       arvif->bssid);
>  		if (ret)
> -			/* KVALO: why not goto err? */
> -			return ret;
> +			goto err;

why does this goto err instead of err_vdev_del?

>  
>  		ar->num_peers--;
>  	}

looking at the context for this patch I have a question about a different part
of this function:

	param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
	param_value = hw->wiphy->rts_threshold;
	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
					    param_id, param_value);
	if (ret) {
		ath12k_warn(ar->ab, "failed to set rts threshold for vdev %d: %d\n",
			    arvif->vdev_id, ret);

NOTE: no return or goto

	}

	ath12k_dp_vdev_tx_attach(ar, arvif);
	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
		ath12k_mac_monitor_vdev_create(ar);

	return ret;

NOTE: this can return an error if the RTS threshold set fails, but fails
without cleaning up (dp vdev still attached and monitor vdev created)

Seems either we need error handling if the set param fails, or we should ret 0
at this point



