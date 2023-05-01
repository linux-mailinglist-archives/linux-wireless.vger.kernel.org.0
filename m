Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28696F3523
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjEARlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjEARlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 13:41:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21935AF
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 10:41:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341GbeHb026549;
        Mon, 1 May 2023 17:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YujqNiIQkBsqwr/6Nmyu69bd6d5L4En006EWS4vVZxU=;
 b=ppOqXGRCcmB7au+ANlzrOJ+JsikRjlxVfAfEdgruzidd9DRnVUCqb3EZKJO7c8GPFNMD
 sGYpEwdUwEor4tcNKyqJCxDwtzcqlVk/pVzrr1rKt+vFwBuPlL+tgvHK7TltHHdcNtwv
 WBTmHzRxrRMuu6A0+Q96IizCWvBUCJ9RXcfQViHLUmyCGc5M8m5s7rKFfAwX9pUOgWnO
 7QRUB99VVV08sGBORx1ZmpuKwb0KG7yYWYMYgLWDQJdtSonZSZs+IHxnwMzR/z4PxGOe
 Nfe4kFGdLpwS+oYKcKY62eq3jhWwiUGqVLTmevMxTL4c4ujxnGl6uyelsVjk3cpYS0kX fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qa0a39ud5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 17:41:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341Hf2JX015785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 17:41:02 GMT
Received: from [10.110.95.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 10:41:02 -0700
Message-ID: <b9f98415-46f5-7b9e-ba61-9b11a4498a6c@quicinc.com>
Date:   Mon, 1 May 2023 10:41:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/7] wifi: ath11k: MBSSID parameter configuration in AP
 mode
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
 <20230405221648.17950-5-quic_alokad@quicinc.com> <87leibqme3.fsf@kernel.org>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <87leibqme3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nzyJScSxZScxn1d9rzUY5XvMOLErDVGG
X-Proofpoint-GUID: nzyJScSxZScxn1d9rzUY5XvMOLErDVGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=813 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010144
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/28/2023 10:37 PM, Kalle Valo wrote:
> Aloka Dixit <quic_alokad@quicinc.com> writes:
> 
>> Include MBSSID parameters in WMI vdev up operation.
>>
>> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>> Co-developed-by: John Crispin <john@phrozen.org>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> ---
> 
> [...]
> 
>> @@ -7153,8 +7161,13 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>>   			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>>   				    ret);
>>   
>> +		if (arvif->vif->mbssid_tx_vif)
>> +			tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
> 
> This had a warning:
> 
> drivers/net/wireless/ath/ath11k/mac.c:7200: line length of 92 exceeds 90 columns
> 
> In the pending branch I fixed it like this:
> 
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -7143,6 +7143,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>   {
>          struct ath11k_base *ab = ar->ab;
>          struct ath11k_vif *arvif, *tx_arvif = NULL;
> +       struct ieee80211_vif *mbssid_tx_vif;
>          int ret;
>          int i;
>          bool monitor_vif = false;
> @@ -7196,8 +7197,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>                          ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>                                      ret);
>   
> -               if (arvif->vif->mbssid_tx_vif)
> -                       tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
> +               mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
> +               if (mbssid_tx_vif)
> +                       tx_arvif = (struct ath11k_vif *)mbssid_tx_vif->drv_priv;
> +
>                  ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
>                                           arvif->bssid,
>                                           tx_arvif ? tx_arvif->bssid : NULL,
> 
> Link to the commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c884238009e778a0c8202a5eb0a7f68b13200bde
> 

Thank you.

I saw the warning but couldn't decide between adding a new pointer 
variable and letting 2 extra characters for just one assignment.

What are your thoughts on changing the scripts to allow up to 100?
Although nl80211 and mac80211 scripts also don't allow that long currently.
