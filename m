Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5D763D00
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGZQzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGZQza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 12:55:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8E106
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 09:55:29 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q56txr011163;
        Wed, 26 Jul 2023 16:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sxH4P/VNokBhM4oPtyHzEtjm3EFIf0Jgyt4HiDCo988=;
 b=GSweYayRzOcNORVKaqRfArjWt0WsYFpdr1vmtwtxvP6JEPssF3satcO9XKC+v3b03XpE
 ikzkIu/PVwUdp0/0A0VMlsnBZkWcO3fLKBPMSehEra0sGNjhWvTIzSAd0AB/wC7SKH7F
 dL+2AcUzZWGg4Yt2maG+V0uzTeicX5WOfHAUYccw4b/ad7+c280P5Vt2KuWGBkY3fQ2Z
 Ashqe34Yl51+JX9vV2LOyig6qJgzgTpXnpwjnpIJaB/Bbl2+A1JWWQ52VhSY8hfdF9QI
 vRyLVIP+BaGFUB9hjo5Phj9N5wFoGdBQnYQbvRdimTBMlgYsSqar8fJfpVvnEUv88TnT Lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2ufm9he2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 16:55:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QGtLqK014635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 16:55:21 GMT
Received: from [10.48.245.247] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 09:54:47 -0700
Message-ID: <8fe1a927-14da-445c-4c48-e3f4b4c324d4@quicinc.com>
Date:   Wed, 26 Jul 2023 09:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix band selection for ppdu received in
 channel 177 of 5 GHz
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230726044624.20507-1-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230726044624.20507-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Z0T54WVTj6A6_EwugDl-7BDvkhyJ3R3
X-Proofpoint-ORIG-GUID: 7Z0T54WVTj6A6_EwugDl-7BDvkhyJ3R3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/25/2023 9:46 PM, Aditya Kumar Singh wrote:
> 5 GHz band channel 177 support was added with the commit
> "wifi: ath11k: add channel 177 into 5 GHz channel list". However,

I'd use the same syntax here as in the Fixes tag:
e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")

> during processing for the received ppdu in ath11k_dp_rx_h_ppdu(), channel
> number is checked only till 173. This leads to driver code checking for
> channel and then fetching the band from it which is extra effort since
> firmware has already given the channel number in the meta deta.

nit: s/meta deta/metadata/

> 
> Fix this issue by checking the channel number till 177 since we support
> it now.
> 
> Found via code review. Compile tested only.
> 
> Fixes: e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 5c76664ba0dd..1e488eed282b 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2408,7 +2408,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
>   		rx_status->freq = center_freq;
>   	} else if (channel_num >= 1 && channel_num <= 14) {
>   		rx_status->band = NL80211_BAND_2GHZ;
> -	} else if (channel_num >= 36 && channel_num <= 173) {
> +	} else if (channel_num >= 36 && channel_num <= 177) {
>   		rx_status->band = NL80211_BAND_5GHZ;
>   	} else {
>   		spin_lock_bh(&ar->data_lock);

