Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A47798996
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjIHPHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjIHPHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 11:07:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95C1FC1
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 08:07:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388DlVcJ027503;
        Fri, 8 Sep 2023 15:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Oq0yfLIbbPiAsqoAsMYbD7UXtukYo2xU4oNuwf9rzQk=;
 b=Jjw+dS5VgaMT0KcIsMQAs5xIXpW/Vsh2rhAyrCXT7cZyjkxED5NZzga5eF/RKhuSv5aE
 yCB2TpBmgUBqG4ZB2jOxL9DsgBVOsuFZXVn1R2s55nRMH4Yg17lqE2V5dwP2gOuqftRV
 lTqh3gHpQPWGAu9mOofYkjj7uiYQ2Jyyo49sHezJ4/WlC4N0AK0V7xQ2kHUDyimH7YSS
 2kiOlzASNxiFuOKOqjBaPArOIbzuaML4YmqJZOc6aa0Y3v0FD3IBuhetj4V1gu6QLbcE
 DWBCGKVrlIaN7mFkCINhP5uvlzXyN8buB21psKtMOUr7emp/zMJj2U1+jcg+soBsluFo wA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syf5c2xq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 15:07:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388F7SZi000479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 15:07:28 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 08:07:27 -0700
Message-ID: <3a4e40fe-1cf7-45b8-90a2-028d6a5c325b@quicinc.com>
Date:   Fri, 8 Sep 2023 08:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath12k: store and send country code to firmware
 after recovery
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906082948.18452-1-quic_wgong@quicinc.com>
 <20230906082948.18452-5-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230906082948.18452-5-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pzl3az4qdZJupP2-3Wk4AC5TxQMrKEkU
X-Proofpoint-ORIG-GUID: pzl3az4qdZJupP2-3Wk4AC5TxQMrKEkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2023 1:29 AM, Wen Gong wrote:
> Currently ath12k does not send the country code to firmware after device
> recovery. As a result the regdomain info is reported from firmware by
> default. Regdomain info is important, so ath12k also need to restore
> it to the value which was used before recovery.
> 
> This is only needed for platforms which support the current_cc_support
> hardware parameter.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 1 +
>   drivers/net/wireless/ath/ath12k/core.h | 1 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++++++
>   drivers/net/wireless/ath/ath12k/reg.c  | 1 +
>   4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 71450dc1f48d..4433d7701c67 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -696,6 +696,7 @@ static void ath12k_update_11d(struct work_struct *work)
>   		pdev = &ab->pdevs[i];
>   		ar = pdev->ar;
>   
> +		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
>   		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
>   		if (ret)
>   			ath12k_warn(ar->ab,
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index ba8a4f968a3f..10fa9de15024 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -582,6 +582,7 @@ struct ath12k {
>   	struct completion completed_11d_scan;
>   	enum ath12k_11d_state state_11d;
>   	bool regdom_set_by_user;
> +	u8 alpha2[REG_ALPHA2_LEN + 1];

curious why +1?
don't you always just treat this as a 2-octet array rather than as a 
NUL-terminated string?


>   };
>   
>   struct ath12k_band_cap {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 740e8045a6f1..0df154c34f8f 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -6908,6 +6908,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>   		ar->state = ATH12K_STATE_ON;
>   		ieee80211_wake_queues(ar->hw);
>   
> +		if (ar->ab->hw_params->current_cc_support &&
> +		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
> +			struct wmi_set_current_country_params set_current_param = {};
> +
> +			memcpy(&set_current_param.alpha2, ar->alpha2, 2);
> +			ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
> +		}
> +
>   		if (ab->is_reset) {
>   			recovery_count = atomic_inc_return(&ab->recovery_count);
>   			ath12k_dbg(ab, ATH12K_DBG_BOOT, "recovery count %d\n",
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index 97c93a4901e6..eb46bfc2b2b9 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -82,6 +82,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
>   	 */
>   	if (ar->ab->hw_params->current_cc_support) {
>   		memcpy(&set_current_param.alpha2, request->alpha2, 2);
> +		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
>   
>   		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
>   		if (ret)

