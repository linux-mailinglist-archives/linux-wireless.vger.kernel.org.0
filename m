Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442607A9D0E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjIUT2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjIUT1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E75B88
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:09:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LF7K1m001558;
        Thu, 21 Sep 2023 17:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LNygmIKmXn3TloZGMOTcy11agEPItZJYdzbjy1HGvWk=;
 b=SliNADxf7u5WBn+rq01ZtCA+qs2wlN0DEJJ28EcgQx8VXnh4Kb2Huo5xbh7NJ/ctQFSX
 BsKVmeDIllju3Dzh8olDIbrCpZLZGrVyUZtVeHkN/9XLxA5NlO7x/FnQ4Wo9keoOIrx3
 pF6cgEBmu/f5bOthkhqLQnj5e7LW2BNesu1WEOjKFY5ANydhXkBq3GlqVHyLCOzlbFqo
 rKESAlss6RNw8kxpU06XF9w87hsLN57arPDV+WLDXqsYZPa1yLRk1jUS3keJT3RsVwmx
 8XkIvE6CkfQZ2qYCroq1YMfQt+UpbBeN1+UghIXzuVRJy/rhyhH+sYzYBM127gTPLHuv Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8892252b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:09:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LH9KKK010028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:09:20 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 10:09:20 -0700
Message-ID: <edd759d5-855e-4438-b649-db7915bab3e0@quicinc.com>
Date:   Thu, 21 Sep 2023 10:09:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data
 handling
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230921075440.1539515-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230921075440.1539515-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jcGFp4CQEDmuo_hanOfCvgozzez4Wq8H
X-Proofpoint-ORIG-GUID: jcGFp4CQEDmuo_hanOfCvgozzez4Wq8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=947 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/21/2023 12:54 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with
> sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
> which immediately found an issue in ath11k:
> 
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    expected struct ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
> 
> The problem here is that we are accessing sband->iftype_data directly even
> though we should use for_each_sband_iftype_data(). Now we iterate over each
> item in the array and use the correct vif type which this vif is using.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

