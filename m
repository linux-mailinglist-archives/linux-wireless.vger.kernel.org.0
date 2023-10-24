Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102357D5451
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjJXOt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbjJXOtZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C110F5
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 07:49:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OEiOlX000581;
        Tue, 24 Oct 2023 14:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SjYQPEXwVgf32kmpE8OTFkNzg+vP85tQwJxwiIwm3xw=;
 b=le7IdongOEVhXeAQsE2zVS8D/iQo5Wa0311DAV4N/oPu/cX8g9g8xL5BsIEKBL2Q4BBa
 wDpMXOY08DoHBWWqGaKV8pKjDsPvp9UooGyxZL70DpnjrfZa8Z5D4qgBzSFbh8mvQngF
 5zVDUxletU03DeeHiwZVweT3bYc7Kznelur1sZnJGLN7zV9DSBxFQfv0fzLoGxEMk2My
 zmy/Vv2D4jY6PWsgmP2PtVkM3O4R38wCmbctTsKA2lu/P94eTdY0mtiDxlFuw9NFqcJz
 gyY78TmiZVpSE2xY8nwQhc9vEOok4MpHDYm5Ke6i09cofhpf8vqXQBiDLAIg/kCpLGup Mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxa0j3f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 14:49:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39OEmvMM015596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 14:48:57 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 07:48:56 -0700
Message-ID: <c269795d-1111-493b-ad86-3eee01e1fa88@quicinc.com>
Date:   Tue, 24 Oct 2023 07:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ieee80211: fix PV1 frame control field name
Content-Language: en-US
To:     Liam Kearney <liam.kearney@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20231024003228.1711193-1-liam.kearney@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231024003228.1711193-1-liam.kearney@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e5IvtO-I2zpFGVQLKrWB0zgplamTpDhT
X-Proofpoint-ORIG-GUID: e5IvtO-I2zpFGVQLKrWB0zgplamTpDhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_14,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=711 impostorscore=0 clxscore=1011
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/23/2023 5:32 PM, Liam Kearney wrote:
> Update PV1 frame control field TODS to FROMDS to match 802.11 standard
> 
> Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
> ---
>   include/linux/ieee80211.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index bd2f6e19c357..ca46147e6a2d 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -176,7 +176,7 @@
>   #define IEEE80211_PV1_FCTL_VERS		0x0003
>   #define IEEE80211_PV1_FCTL_FTYPE	0x001c
>   #define IEEE80211_PV1_FCTL_STYPE	0x00e0
> -#define IEEE80211_PV1_FCTL_TODS		0x0100
> +#define IEEE80211_PV1_FCTL_FROMDS		0x0100
>   #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
>   #define IEEE80211_PV1_FCTL_PM		0x0400
>   #define IEEE80211_PV1_FCTL_MOREDATA	0x0800

Suggest that along with this change you update the preceding comment to 
refer to IEEE 802.11-2020 since that supersedes 802.11ah (the paragraph 
number is unchanged between the two)

