Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A279F688
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjINBxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjINBxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 21:53:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA51BCB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 18:53:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E1Hldl031579;
        Thu, 14 Sep 2023 01:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LENaZ+N7qqVlnQ+MLQf6OQ27ElU6Qed1Gk4XOlWH3Z4=;
 b=MA1hNVVrjjc3IJWf/4YOWcIr68Y+caT5qMCCMs3SO5W0zWsEcTVC0YETgxeEH260gJx8
 hnS2uELbEwLPwUpdPa3Hx85qOwL8T48gZoI6OQAkrrbk5zPLTiH5DfrY2AMyeAiZtTAE
 9ziKuT5j7fRr55YGACIk0gC0L8RCwjCC4WK/37bJgfSc75MhdctSUA2b4JPhSt2wb1WY
 qHl2kaGHFomYaNaX5xqxwLe0S9GDDeGkD8Kl3gyj2FYq3w79cYuIhhk/7uYLS6aqWYhe
 RhcHMcQxCs9vWbwjAK0ROHB+RdfF2kbMvFCD+afO3JT7gvY2EXqJ+d84u62jPoOsD6qr kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7qbdh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:52:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E1qwc6020855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:52:58 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 18:52:58 -0700
Message-ID: <6a519ccd-823b-4dd1-a3dd-32752dfeccd3@quicinc.com>
Date:   Wed, 13 Sep 2023 18:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable
 IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230913105507.17675-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230913105507.17675-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CtwIWLXbTFJj4OhwRdEDZL7cRwNendWl
X-Proofpoint-ORIG-GUID: CtwIWLXbTFJj4OhwRdEDZL7cRwNendWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=896 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 3:55 AM, Wen Gong wrote:
> Currently mac80211 will send 3 scan request for each scan of WCN7850, they
> are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN7850 will cache the RNR
> IE(Reduced Neighbor Report element) which exist in the beacon of 2.4 GHz/5
> GHz of the AP which is co-located with 6 GHz, and then use the cache to
> scan in 6 GHz band scan if the 6 GHz scan is in the same scan with the 2.4
> GHz/5 GHz band, this will helpful to search more AP of 6 GHz. Also it will
> decrease the time cost of scan because firmware will use dual-band scan
> for the 2.4 GHz/5 GHz, it means the 2.4 GHz and 5 GHz scans are doing
> simultaneously.
> 
> Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850 since it
> supports 2.4 GHz/5 GHz/6 GHz in a single wiphy/ieee80211_hw.
> 
> This does not impact QCN9274, because it is not single_phy, so does not
> have 2.4 GHz/5 GHz/6 GHz in the same wiphy, then it does not match the
> condition and then IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS will not set for
> QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0f2af2f14ef7..d4dc03dc8d11 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7232,6 +7232,11 @@ static int __ath12k_mac_register(struct ath12k *ar)
>   
>   	ar->hw->wiphy->interface_modes = ab->hw_params->interface_modes;
>   
> +	if (ar->hw->wiphy->bands[NL80211_BAND_2GHZ] &&
> +	    ar->hw->wiphy->bands[NL80211_BAND_5GHZ] &&
> +	    ar->hw->wiphy->bands[NL80211_BAND_6GHZ])
> +		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
> +
>   	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
>   	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
>   	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

