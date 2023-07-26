Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EE763E88
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGZSb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGZSb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 14:31:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C0173F
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 11:31:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QHvBwl017064;
        Wed, 26 Jul 2023 18:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pFAVev8gmR89CZl3pBdc5/JgsTu1h/9lyPc1TXgYYbc=;
 b=YTknnVtMvh5PTJMC7q3MSTrZOUZ1ReDQh5ltS1PIJvwSOCezhf64b/farxq0UggaQBOK
 1FVshN9O3rzU9DFM67dHTdSrB6JwX32V0G3qZopy0GbXvRfOjNWrUJEP6MGhjJTc2vW6
 w/nxTnnqbVYma2NMsrkzeIhkfyPWKzxRiKQNwOhLqgJQ0J1V1dRiGoz1rADhD5bB8ggY
 LuqrxrBbEb8tnxMX2pVRus5hyIN+Qq7jLWQHVY2PkRfqg1a8Y5OS3qx93w4SMz56ULzP
 UfmhNbfISIh3UloVOJu5IrUe5uBQfUy2hc9Rk0UDOVPLyEmpjDqX/fSigfKIWZbsNnDB cg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2daukp18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 18:31:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QIVDlX004155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 18:31:13 GMT
Received: from [10.48.245.247] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 11:31:12 -0700
Message-ID: <b23c9ebe-b49b-0c8c-5e20-d02fd4134844@quicinc.com>
Date:   Wed, 26 Jul 2023 11:31:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: simplify
 ath11k_mac_validate_vht_he_fixed_rate_settings()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
CC:     Ziyang Huang <hzyitc@outlook.com>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20230726092113.78794-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230726092113.78794-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: waGtP6umHOQ3Gnodt8h6BOcnpXfWcAcW
X-Proofpoint-ORIG-GUID: waGtP6umHOQ3Gnodt8h6BOcnpXfWcAcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=871 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/26/2023 2:21 AM, Dmitry Antipov wrote:
> In 'ath11k_mac_validate_vht_he_fixed_rate_settings()', 'ar->ab->peers'
> list is not altered so 'list_for_each_entry()' should be safe.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 8c77ade49437..2aadf2c387b6 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8255,7 +8255,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
>   					       const struct cfg80211_bitrate_mask *mask)
>   {
>   	bool he_fixed_rate = false, vht_fixed_rate = false;
> -	struct ath11k_peer *peer, *tmp;
> +	struct ath11k_peer *peer;
>   	const u16 *vht_mcs_mask, *he_mcs_mask;
>   	struct ieee80211_link_sta *deflink;
>   	u8 vht_nss, he_nss;
> @@ -8278,7 +8278,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
>   
>   	rcu_read_lock();
>   	spin_lock_bh(&ar->ab->base_lock);
> -	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
> +	list_for_each_entry(peer, &ar->ab->peers, list) {
>   		if (peer->sta) {
>   			deflink = &peer->sta->deflink;
>   

In the future please make sure driver-specific mailing lists are 
included in your patches when they exist in the MAINTAINERS file. Adding 
ath11k@lists.infradead.org
