Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12977E782
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbjHPRWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbjHPRWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 13:22:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB96526BB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 10:22:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GGLkDC011566;
        Wed, 16 Aug 2023 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LysnEy8yXcuBz+W28mFbywApt5dYc8GPk/kJ9Sveb0w=;
 b=O5ms3MeuZtpKcUqx8SXfzwqyM6HP/pVPi4yWk5A79jKknMgSEf8/AOSPnprmmmaGHpnR
 9mzDBQa9QOvTG1hFOU5heMQCNQh0onpfJoT35mkx6eZbyBal+fE2e2qeSEJ8NVX6NDn9
 H58IWIe80GOpgo77TgRyDX3OnXV3YHsAgSYZnCsq4UQvyy0Y+Ova+KspYLbwN14t7Tya
 139bC/rgCHykOFCamA26zHAPX93SIv2SshXdXghtI8VFMubf3t9dx7wLPRT1w6R/owYW
 l4gauzBK8zxtIaFPPUmTU5B7jDVwUDGjUNTheNV1LwD3S7QvldDNTyTtDZ/LvJkJADGq bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sh0tn8ac8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:22:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GHM2UN024238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:22:02 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 10:22:01 -0700
Message-ID: <29ee491a-a713-ae91-db00-a5306c340a97@quicinc.com>
Date:   Wed, 16 Aug 2023 10:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix puncturing bitmap handling in CSA
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
References: <20230816100412.e2677a05ffd3.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20230816100412.e2677a05ffd3.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jWgMBH-YT7VywYeeLHK-IrrJYUedfbHv
X-Proofpoint-ORIG-GUID: jWgMBH-YT7VywYeeLHK-IrrJYUedfbHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=977 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/16/2023 1:04 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index e7ac24603892..1657ff09a83a 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -3648,12 +3648,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
>   	lockdep_assert_held(&local->mtx);
>   	lockdep_assert_held(&local->chanctx_mtx);
>   
> -	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
> -		sdata->vif.bss_conf.eht_puncturing =
> -					sdata->vif.bss_conf.csa_punct_bitmap;
> -		changed |= BSS_CHANGED_EHT_PUNCTURING;
> -	}
> -
>   	/*
>   	 * using reservation isn't immediate as it may be deferred until later
>   	 * with multi-vif. once reservation is complete it will re-schedule the
> @@ -3683,6 +3677,12 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
>   	if (err)
>   		return err;
>   
> +	if (link_data->conf->eht_puncturing != link_data->conf->csa_punct_bitmap) {
> +		link_data->conf->eht_puncturing =
> +					link_data->conf->csa_punct_bitmap;
> +		changed |= BSS_CHANGED_EHT_PUNCTURING;
> +	}
> +
>   	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
>   
>   	if (sdata->deflink.csa_block_tx) {

Looks okay, though I remember there was a reason I had put it at the 
top. If this causes any issue I will send a follow-up later.
Thanks!

