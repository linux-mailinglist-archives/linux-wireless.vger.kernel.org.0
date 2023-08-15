Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E386877D1A8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbjHOSVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjHOSU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 14:20:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C119AF
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 11:20:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FFIMxr023941;
        Tue, 15 Aug 2023 18:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qf+SFlzKgLF9CCdcywg6jtjPYARwSI6SrXbbqEpiVMg=;
 b=UFLnsw+MosmUQk/7cCUIPgXQRSNgWb58pxpPSrshPLbrLn8Q5qsJkXyVHas8TVQPVQl6
 YOQc///Jw+0PTxdQQV7mxJiplQlf6PsIWC6c26LA8eyWOiQs9bwh1+ZspuAJM1hFW4zB
 /MuX6/Hx7GmTgtpj/7FKVVSK4aoPnITYXbkXC63KXMg/KrmDRnCN4MRNz8pz5GJTlzRn
 Je1ZGfOEPkrXsYSn5PU5OpcJuecEihvH88b/fHA3yejvq0tnhYIF8eq77ZQpt8jyokbY
 PEniqS1XUpdo4g6jmfzuqYIw0L8AI+vqVnZjacy/E2Zbxx9yN8lPF+IZABEdyKmdG74i 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp2tegy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 18:20:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37FIKjuw010334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 18:20:45 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 15 Aug
 2023 11:20:44 -0700
Message-ID: <07997950-0f1b-cc05-6ba4-1378dc35eec8@quicinc.com>
Date:   Tue, 15 Aug 2023 11:20:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211_hwsim: drop short frames
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com>
References: <20230815181603.f576bd983875.I1efbeef082c3f7094037882f213202d760848eb7@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230815181603.f576bd983875.I1efbeef082c3f7094037882f213202d760848eb7@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: onQgE8N7xEXsnEv471gGgj3be80pogNv
X-Proofpoint-ORIG-GUID: onQgE8N7xEXsnEv471gGgj3be80pogNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=965 clxscore=1011 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/15/2023 9:16 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Frames that don't even have addr1 are clearly not valid,
> drop those early in the netlink/wmediumd path here.
> 
> Reported-by: syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/net/wireless/virtual/mac80211_hwsim.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index f446fd0e8cd0..8f1e4420ed1e 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -5626,14 +5626,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
>   	frame_data_len = nla_len(info->attrs[HWSIM_ATTR_FRAME]);
>   	frame_data = (void *)nla_data(info->attrs[HWSIM_ATTR_FRAME]);
>   
> +	if (frame_data_len < offsetofend(typeof(*hdr), addr1) ||

curious why addr1. if the frame ends after addr1 then don't you have a 
problem in mac80211_hwsim_rx() when it passes hdr->addr2 to 
ieee80211_find_sta_by_link_addrs()?


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

