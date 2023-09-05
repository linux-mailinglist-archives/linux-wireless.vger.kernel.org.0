Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D1792B05
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjIEQqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353985AbjIEQ3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 12:29:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE72695
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 09:20:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385DNQwt015259;
        Tue, 5 Sep 2023 16:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dWtSZECRAQNDXD2BYo7D6dQk+9YJCH2S95YE/NRwCyE=;
 b=ERoLp7rKi5Pw9h0xXTS2jP7BAW5SmaMb+UhjzVkGcIoNM3o6TmqJg/penKanwk4Uj2s4
 STmG28Z6Ttjm1h8Lq9GKp+PPf69X3gclIlzFdoR6NUHOEUblywWjhNFiQhZfM2oT7qQl
 +VH3Ak51K48O8Ez+IQNKEWMuEl8GOIQlh1FCTEuSBBRg8oho5WA+1mt+AOlJ1cnt2WuQ
 aT6VwVxztKd4AtpRCQHtj8RQ/I4+lH6/D8UdMBsfvHQK8WBF6lA3GoJfnmWfRiNn3pVY
 TWWJIVek15OspSpPvLAoxfX814rE+YwKqf5F2VibwehAYQBKOelNWmXbN7PjLLjKbS8a 0A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtynhrba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 16:18:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385GIkIc028067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 16:18:46 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 09:18:45 -0700
Message-ID: <80f6ccde-d873-4191-962d-585dc59e1f3d@quicinc.com>
Date:   Tue, 5 Sep 2023 09:18:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: validate AP phy operation before starting
 it
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>
References: <20230905064857.1503-1-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230905064857.1503-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cB83n6MedB3Xgw3iZFHYTPoIVpEP-Ps5
X-Proofpoint-ORIG-GUID: cB83n6MedB3Xgw3iZFHYTPoIVpEP-Ps5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/4/2023 11:48 PM, Aditya Kumar Singh wrote:
> Many regulatories can have HE/EHT Operation as not permitted. In such
> cases, AP should not be allowed to start if it is using a channel
> having the no operation flag set. However, currently there is no such
> check in place.
> 
> Fix this issue by validating such IEs sent during start AP against the
> channel flags.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   net/wireless/nl80211.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index de47838aca4f..0c989a839e56 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5909,6 +5909,21 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
>   	nlmsg_free(msg);
>   }
>   
> +static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params)
> +{
> +	struct ieee80211_channel *channel = params->chandef.chan;
> +
> +	if ((params->he_cap ||  params->he_oper) &&
> +	    (channel->flags & IEEE80211_CHAN_NO_HE))
> +		return -EOPNOTSUPP;
> +
> +	if ((params->eht_cap || params->eht_oper) &&
> +	    (channel->flags & IEEE80211_CHAN_NO_EHT))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>   static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
> @@ -6178,6 +6193,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>   	if (err)
>   		goto out_unlock;
>   
> +	err = nl80211_validate_ap_phy_operation(params);
> +	if (err)
> +		goto out_unlock;
> +
>   	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
>   		params->flags = nla_get_u32(
>   			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);
> 
> base-commit: dae4464939025d38940a6bc6b80734adad0ff944

