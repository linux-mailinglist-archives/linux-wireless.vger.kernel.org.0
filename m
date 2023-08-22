Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C567844E7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjHVPDB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHVPDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 11:03:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB71126
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 08:02:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDZLID030861;
        Tue, 22 Aug 2023 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ec2xXjTpHwM/dYVtr/TOR18uTBjnieZDrWAncDG9vzw=;
 b=pkmt9RFaG7fwyMnB9n8ZLmFOFmCspGq0sPNrdmdty5389gG8ynP+xBHlLh7kY7v8sMrA
 bONhyGh1VCgeN/9Bsaz6o0+tYKYyzt13ehrmR21zdgumv/jyJ3205PPmj//NVU1c2NDj
 mQ+61OBI3e73ZATwYz3eWbR3BFn2A5kZIcrbPxcWMAqtqx005rITtq8aMcOBf57oRpsK
 dpgUA0Iuf/qTrw/9oP694YnMTgvj874V9svxe3C0epDQpsv6tAaH2qae9W6P9N38FNgQ
 j+ENWj56jOMvNKSP4Y27PIpB1WdAp+ZDc/3XmNpY4VDmdAD7E2YEXcGA/fC4Emw6Yezl 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smfjs9rjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:02:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MF2ocU014424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:02:50 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 08:02:49 -0700
Message-ID: <e082171e-9a0d-4a49-a6a0-171dab78e11b@quicinc.com>
Date:   Tue, 22 Aug 2023 08:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath11k: fix CAC running state during virtual
 interface start
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
References: <20230607124647.27682-1-quic_adisi@quicinc.com>
 <20230607124647.27682-3-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230607124647.27682-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZeJJMowFiAYVY0paOVaZgVGv7Wy172R-
X-Proofpoint-GUID: ZeJJMowFiAYVY0paOVaZgVGv7Wy172R-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/2023 5:46 AM, Aditya Kumar Singh wrote:
> Currently channel definition's primary channel's DFS CAC time
> as well as primary channel's state i.e usable are used to set
> the CAC_RUNNING flag for the ath11k radio structure. However,
> this is wrong since certain channel definition are possbile
> where primary channel may not be a DFS channel but, secondary
> channel is a DFS channel. For example - channel 36 with 160 MHz
> bandwidth.
> In such cases, the flag will not be set which is wrong.
> 
> Fix this issue by using cfg80211_chandef_dfs_usable() function
> from cfg80211 which return trues if at least one channel is in
> usable state.
> 
> While at it, modify the CAC running debug log message to print
> the CAC time as well in milli-seconds.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index a31b8e89684b..31982545266b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <net/mac80211.h>
> +#include <net/cfg80211.h>
>   #include <linux/etherdevice.h>
>   #include <linux/bitfield.h>
>   #include <linux/inetdevice.h>
> @@ -7193,6 +7194,7 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
>   	struct wmi_vdev_start_req_arg arg = {};
>   	const struct cfg80211_chan_def *chandef = &ctx->def;
>   	int ret = 0;
> +	unsigned int dfs_cac_time;
>   
>   	lockdep_assert_held(&ar->conf_mutex);
>   
> @@ -7272,20 +7274,21 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
>   	ath11k_dbg(ab, ATH11K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
>   		   arvif->vif->addr, arvif->vdev_id);
>   
> -	/* Enable CAC Flag in the driver by checking the channel DFS cac time,
> -	 * i.e dfs_cac_ms value which will be valid only for radar channels
> -	 * and state as NL80211_DFS_USABLE which indicates CAC needs to be
> +	/* Enable CAC Flag in the driver by checking the all sub-channel's DFS
> +	 * state as NL80211_DFS_USABLE which indicates CAC needs to be
>   	 * done before channel usage. This flags is used to drop rx packets.
>   	 * during CAC.
>   	 */
>   	/* TODO Set the flag for other interface types as required */
> -	if (arvif->vdev_type == WMI_VDEV_TYPE_AP &&
> -	    chandef->chan->dfs_cac_ms &&
> -	    chandef->chan->dfs_state == NL80211_DFS_USABLE) {
> +	if (arvif->vdev_type == WMI_VDEV_TYPE_AP && ctx->radar_enabled &&
> +	    cfg80211_chandef_dfs_usable(ar->hw->wiphy, chandef)) {
>   		set_bit(ATH11K_CAC_RUNNING, &ar->dev_flags);
> +		dfs_cac_time = cfg80211_chandef_dfs_cac_time(ar->hw->wiphy,
> +							     chandef);
>   		ath11k_dbg(ab, ATH11K_DBG_MAC,
> -			   "CAC Started in chan_freq %d for vdev %d\n",
> -			   arg.channel.freq, arg.vdev_id);
> +			   "CAC (for %u ms) Started in center_freq %d center_freq1 %d for vdev %d\n",
> +			   dfs_cac_time, arg.channel.freq, chandef->center_freq1,
> +			   arg.vdev_id);
>   	}
>   
>   	ret = ath11k_mac_set_txbf_conf(arvif);

