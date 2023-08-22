Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415257844E8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbjHVPDO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjHVPDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 11:03:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA7126
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 08:03:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MBxKMc000706;
        Tue, 22 Aug 2023 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PaN4TojYzPZ3KFjDhk+97Ocy1UsIYtZWOEIgM+zXcIY=;
 b=hDC9JbmHM4O7wdX2BILg/jUTcbcbtoqstdw7UDqOyJRkH611vaWnLP0G1UOlVBdzVmnz
 zT81je8hdzRUIBUeXSFDAxFYsdiOrV8+ZvYXHU1kbrETQT25W7MEmKPz5tK/bYyAKPIA
 kVS//J8mInLeF6PLzBAJIhs9gbUOEOCv/Y7GJ1m86l6U3Pv4QH6FOKHeFp953BI78SuA
 1BjdfgV30MmWR5Z+RKuQZ8EXUxU426EnFM5PfsS19aYKHU01aWWcI6BjTUvrO/7p6hz1
 XwVxUSEo27qTGhrL3aPkqoAZaJWFtY0AKnLszHGQz088bMr60CAaZIaYr2IItcm4T5fu 9g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smreu10ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:03:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MF35Kt023729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:03:05 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 08:03:05 -0700
Message-ID: <10b4a983-de36-48f9-89f6-613519dc94a5@quicinc.com>
Date:   Tue, 22 Aug 2023 08:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath11k: fix Tx power value during active CAC
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
References: <20230607124647.27682-1-quic_adisi@quicinc.com>
 <20230607124647.27682-4-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230607124647.27682-4-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GxaWNuZnngpn9k19UHtqCQUmWDD3i4H_
X-Proofpoint-ORIG-GUID: GxaWNuZnngpn9k19UHtqCQUmWDD3i4H_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Tx power is fetched from firmware's pdev stats. However, during active
> CAC, firmware does not fill the current Tx power and sends the max
> initialised value filled during firmware init. If host sends this power
> to user space, this is wrong since in certain situations, the Tx power
> could be greater than the max allowed by the regulatory. Hence, host
> should not be fetching the Tx power during an active CAC.
> 
> Fix this issue by returning Tx power as 0 during active CAC since it
> is known that during CAC, there will be no transmission happening.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 9a2aa68afe3d ("wifi: ath11k: add get_txpower mac ops")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 31982545266b..9707910928b4 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9045,6 +9045,14 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
>   	if (ar->state != ATH11K_STATE_ON)
>   		goto err_fallback;
>   
> +	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
> +	 * the stats.
> +	 */
> +	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
> +		mutex_unlock(&ar->conf_mutex);
> +		return -EAGAIN;
> +	}
> +
>   	req_param.pdev_id = ar->pdev->pdev_id;
>   	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
>   

