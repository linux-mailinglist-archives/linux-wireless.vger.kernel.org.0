Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94B7A6BEB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjIST74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjIST74 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 15:59:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F719C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 12:59:50 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JJn2A4013407;
        Tue, 19 Sep 2023 19:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=63W2IAvA0IG1FQKgGuqoGTIoaVW4nn9+mb9tTJpChJw=;
 b=WMS5b/qYPSpNhx682gJMgaP/p06pfZPMwhG79Mfw9R6Rlgq3r8aZENTuG+leFbQ7uJSi
 HbogBrxlCLToxznwhRzcpnA2RUKaksfTJZRmyQ+89zbve82+sa4XNipW8HFoHC3cuNZf
 7QOa9kzw63YT/DY7iOW5ja4czZR1bYJbzIg2wois2P0nH51MI7vGcQYKeyzk3L+dnmXY
 pjxxMJ7ND3M6YOIk8/DuQabyTpGCDL1cKXXxflEVXQEAhTks7ImI2wux5a8PzRoTy/Rc
 emOe8gX6JKXFEDUluQpTyrhuPkCvXDOqh1tHMrfDg4jE2kz5liWsCZF9RPPCAKZRkZe0 Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6vcmaju7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 19:59:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JJxlaG017673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 19:59:47 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 12:59:46 -0700
Message-ID: <0457896f-2d58-4a4f-9be3-77c30b2d0585@quicinc.com>
Date:   Tue, 19 Sep 2023 12:59:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] wifi: ath12k: get 6 GHz power type from HE operation
 element
Content-Language: en-US
To:     Aishwarya R <quic_aisr@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-4-quic_aisr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919071724.15505-4-quic_aisr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pq0gaCDMKfbpDvidnIzcMLS3c0sq2H9m
X-Proofpoint-GUID: pq0gaCDMKfbpDvidnIzcMLS3c0sq2H9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2023 12:17 AM, Aishwarya R wrote:
> When 6 GHz AP or STA is assigned a channel ctx, it needs to

here again, what is "it"?
and why does "it" need the power type?

> extract the power type from HE operation element.
> If unset power type is present, by default IEEE80211_REG_LPI_AP
> power mode will be used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 5b9af264d305..01f81b087fa2 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5823,6 +5823,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>   	struct ath12k_vif *arvif = (void *)vif->drv_priv;
>   	int ret;
>   	struct ath12k_wmi_peer_create_arg param;
> +	enum ieee80211_ap_reg_power power_type;
>   
>   	mutex_lock(&ar->conf_mutex);
>   
> @@ -5830,6 +5831,16 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>   		   "mac chanctx assign ptr %pK vdev_id %i\n",
>   		   ctx, arvif->vdev_id);
>   
> +	if (ar->supports_6ghz && ctx->def.chan->band == NL80211_BAND_6GHZ &&
> +	    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
> +	     arvif->vdev_type == WMI_VDEV_TYPE_AP)) {
> +		power_type = vif->bss_conf.power_type;
> +		ath12k_dbg(ab, ATH12K_DBG_MAC, "mac chanctx power type %d\n",
> +			   power_type);
> +		if (power_type == IEEE80211_REG_UNSET_AP)
> +			power_type = IEEE80211_REG_LPI_AP;
> +	}
> +
>   	/* for some targets bss peer must be created before vdev_start */
>   	if (ab->hw_params->vdev_start_delay &&
>   	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&

