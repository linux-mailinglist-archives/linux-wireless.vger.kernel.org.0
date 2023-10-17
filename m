Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D506A7CCE17
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJQUcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQUcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 16:32:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400469F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 13:32:21 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HK96YV013876;
        Tue, 17 Oct 2023 20:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=khsiudFerz/J9RJBGlM4PpNUGlUt3v7S4kNP2T9wrnM=;
 b=HzEPJfETvxGtr+l44lrmfH1y4yVBGDju2y30yNETijN2FHj+udhB/nwwkfkECmfmf/QU
 ujw3ne9jc8w+aP4TQt9qOvAsAHiuPNq9uFwcZwJrc/TWIMp+fh7XZYvBmn+3lVY06z8+
 WMw57BfjDjZAhhbBLPNNWuSgzyjWenNntEumjQQTiJIgURip+kX5CkT+UuTooPrFgtVn
 mK+Jp9Re3/pkAs0UtXmNQkdhBmITGG2Zpg8f/O4GSuiEhI0ts7rT/05fBr1ityPDgFKY
 XqgiFBrnUuZgPLC3r8zjfF+lFOF9f7mKZqbW2/Yo/a7QKoKOL/KW4teR9PJNY1Ta66mv Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaky359c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:32:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HKWF5Q006511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:32:15 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 13:32:14 -0700
Message-ID: <a833b7a7-12ed-4080-b7ed-fce7c672ee0e@quicinc.com>
Date:   Tue, 17 Oct 2023 13:32:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action from
 RX
Content-Language: en-US
To:     James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <20231017165306.118779-1-prestwoj@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231017165306.118779-1-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fUuIjxVP67-FtzwTXeqe-bRBRKV6aVe0
X-Proofpoint-ORIG-GUID: fUuIjxVP67-FtzwTXeqe-bRBRKV6aVe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=758 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/17/2023 9:53 AM, James Prestwood wrote:
> Advertise support for multicast frame registration and update the RX
> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
> received. Broadcast action frames are needed for the Device
> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 03e7bc5b6c0b..932ace5b900b 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -1249,7 +1249,7 @@ static bool ath10k_mac_monitor_vdev_is_needed(struct ath10k *ar)
>   	return ar->monitor ||
>   	       (!test_bit(ATH10K_FW_FEATURE_ALLOWS_MESH_BCAST,
>   			  ar->running_fw->fw_file.fw_features) &&
> -		(ar->filter_flags & FIF_OTHER_BSS)) ||
> +		(ar->filter_flags & (FIF_OTHER_BSS | FIF_MCAST_ACTION))) ||
>   	       test_bit(ATH10K_CAC_RUNNING, &ar->dev_flags);
>   }
>   
> @@ -6020,6 +6020,7 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
>   	FIF_OTHER_BSS |				\
>   	FIF_BCN_PRBRESP_PROMISC |		\
>   	FIF_PROBE_REQ |				\
> +	FIF_MCAST_ACTION |			\
>   	FIF_FCSFAIL)
>   
>   static void ath10k_configure_filter(struct ieee80211_hw *hw,
> @@ -10121,6 +10122,8 @@ int ath10k_mac_register(struct ath10k *ar)
>   	wiphy_ext_feature_set(ar->hw->wiphy,
>   			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
>   	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
> +	wiphy_ext_feature_set(ar->hw->wiphy,
> +			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
>   
>   	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
>   	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))

+ ath10k@lists.infradead.org

