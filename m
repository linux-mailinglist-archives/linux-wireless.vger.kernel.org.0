Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9388B6D97C9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjDFNRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjDFNRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 09:17:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124586AE
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 06:17:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336AqjJG011962;
        Thu, 6 Apr 2023 13:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/ppvI6fnUpghn+077WCg+ALx2n28YXtv4ldhXV/eZm0=;
 b=gw3AukbWG3m9Lu19HgItVapqt0zGs4gx4frgZNQmWAKmaYRTadMq+yEAxIuPXJ2aG8Ni
 mOVP6Hrbk5yt1dtRiTlLBoo5p1lwpMGG0aY8uGK6iIx1DNLR6gWhINaO4XeyoDSn2C/B
 TJib9jAMC66mr1TUXmuFJlcGs/YnK4qdYNJQciNAYvlj2MbuEfn7qhoUiRmd4XgRKY4G
 KjGcHy0UJza5snniM1GXnrSWSdDoeg4cxhNbY0rH7/YggLPP+UHBEZ2mTVVHX+Ar8ECn
 oEqfdWIDICGQFg/aPNyQCMT9K3GIheHKXjz1P4e88BNPBKvdYqkvlDcv4LOg2p9Hwzr1 oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psv4dgd06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 13:17:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336DHC5Z025745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 13:17:12 GMT
Received: from [10.216.38.134] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 06:17:10 -0700
Message-ID: <bd40816c-9759-a0af-9075-cc684f81fd70@quicinc.com>
Date:   Thu, 6 Apr 2023 18:47:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] wifi: mac80211: Add support to randomize TA of auth and
 deauth frames
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
 <20230307102225.74883-1-johannes@sipsolutions.net>
Content-Language: en-US
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <20230307102225.74883-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qofspH99Jtp81e-xJdzU8o0IPcLghD2f
X-Proofpoint-ORIG-GUID: qofspH99Jtp81e-xJdzU8o0IPcLghD2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=979 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060117
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/7/2023 3:52 PM, Johannes Berg wrote:
> ---
> So this is the patch I ended up with after some cleanups, but
> then at the end I noticed you didn't unset the temp address
> when the remain-on-channel expires, and wasn't sure exactly
> how that should be handled, and you probably have the better
> test setup right now too ...
>
> johannes
> ---


Apologies for the delayed response. Thanks for the cleaning up the patch.

Regarding the comment on clearing temp address, I think the temp address 
should get cleared with below changes added in 
ieee80211_roc_notify_destroy() when remain-on-channel expires. Please 
let me know if I am missing something.


> diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
> index d78c82d6b696..74d2b826916a 100644
> --- a/net/mac80211/offchannel.c
> +++ b/net/mac80211/offchannel.c
> @@ -187,6 +187,12 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
>   					 roc->mgmt_tx_cookie,
>   					 roc->chan, GFP_KERNEL);
>   
> +	if (!is_zero_ether_addr(roc->sdata->vif.cfg.temp_addr)) {
> +		eth_zero_addr(roc->sdata->vif.cfg.temp_addr);
> +		ieee80211_vif_cfg_change_notify(roc->sdata,
> +						BSS_CHANGED_TEMP_ADDR);
> +	}
> +
>   	list_del(&roc->list);
>   	kfree(roc);
>   }

--

veeru

