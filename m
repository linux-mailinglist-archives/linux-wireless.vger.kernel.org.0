Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9150D77D605
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjHOWay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbjHOWav (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 18:30:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026481FF3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 15:30:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FMT3DD031407;
        Tue, 15 Aug 2023 22:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E3KW2IksLgN2GlXDP6Hi7rHMQYVuWWdWHMgJueJwXSI=;
 b=SSGiZ9vEP4VAnRN2ll3GuI0+on5+sc56szrg3w8NoCCLgfUSsVMJkKLT1AxlRlDSfxqo
 bOseoXcDMeJbTk4t16nXDeEmYkubHldbKFiG+92629m6x/RGAd6a8S3oGLfHOcUUWRR4
 b8BxAcDtVrTZb86pzMBJplBmaOgO7blLSpZoPWmyjcJvkKt4zK0dYBIHGydQ7rGdrG8f
 IANdmZf1HvrM43AhpoJTdZ35yWNhoUZW2netqSl5cLHHoEDMUZhpf9dIp/y8MhBP8ELk
 y2m+nBqNQTJQHw7ZEqQ6UfO2gV8J59SBiPiqMDmCS5p9rFY4qgv79VjQAjSMd66bRleZ 1g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfuj8jcgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 22:30:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37FMUcAT002534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 22:30:38 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 15 Aug
 2023 15:30:37 -0700
Message-ID: <993dc9f6-d956-35ba-d691-7200fb6503d9@quicinc.com>
Date:   Tue, 15 Aug 2023 15:30:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211_hwsim: drop short frames
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com>
References: <20230815212800.d849938fdc9f.I1efbeef082c3f7094037882f213202d760848eb7@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230815212800.d849938fdc9f.I1efbeef082c3f7094037882f213202d760848eb7@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XW-qjJKaDThx2rNtICCwHyBu0_0OxTTM
X-Proofpoint-GUID: XW-qjJKaDThx2rNtICCwHyBu0_0OxTTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/15/2023 12:28 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> While technically some control frames like ACK are shorter and
> end after Address 1, such frames shouldn't be forwarded through
> wmediumd or similar userspace, so require the full 3-address
> header to avoid accessing invalid memory if shorter frames are
> passed in.
> 
> Reported-by: syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/virtual/mac80211_hwsim.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index f446fd0e8cd0..dd516cec4197 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -5626,14 +5626,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
>   	frame_data_len = nla_len(info->attrs[HWSIM_ATTR_FRAME]);
>   	frame_data = (void *)nla_data(info->attrs[HWSIM_ATTR_FRAME]);
>   
> +	if (frame_data_len < sizeof(struct ieee80211_hdr_3addr) ||
> +	    frame_data_len > IEEE80211_MAX_DATA_LEN)
> +		goto err;
> +
>   	/* Allocate new skb here */
>   	skb = alloc_skb(frame_data_len, GFP_KERNEL);
>   	if (skb == NULL)
>   		goto err;
>   
> -	if (frame_data_len > IEEE80211_MAX_DATA_LEN)
> -		goto err;
> -
>   	/* Copy the data */
>   	skb_put_data(skb, frame_data, frame_data_len);
>   

