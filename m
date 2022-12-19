Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA0651233
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 19:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiLSSy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 13:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiLSSy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 13:54:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A1AF55
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 10:54:25 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIUDcc016684;
        Mon, 19 Dec 2022 18:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eoLXTHSVFWoS1/pJBL7DpY/AmnaYeVB6IxIwjlk83cc=;
 b=En1OqXG53Lj0kozBA5avkJ1ua4MYdstLSmM1lmNTKKda1nCvgWU14ZxTStdF3UTCgE1e
 kQzvjbPnP5cHai/3aADV8PGQfEoDeR7IPW3GYi7G0AnAa3wHKsxFDKX/UFtnGI3HJjUP
 cMgrRyojS0qU9C97sXwM+nr24tWM0TYFbofOeEiaqh7gbIbY1ETPQR8xWqA/wbC36UCP
 X5fw/MjNFdR1W+MUNhni7r94KjPK0DgvwP9ira4VvmJPKsjLOFih4+ACt9oDiLZkkS8k
 LPUo1ZRDu8CdOkbpmRa0vLhiU5Q74SRbCyi1JmeDHUuEcNoKCWQaEHHyS06o+7ZTkG47 LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjw8tg1gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:53:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJIrusg031287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:53:57 GMT
Received: from [10.110.47.99] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 10:53:56 -0800
Message-ID: <441771f8-6269-0ce4-fce8-513f7f3f7d95@quicinc.com>
Date:   Mon, 19 Dec 2022 10:53:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v12 2/4] mac80211: MBSSID support in interface handling
Content-Language: en-US
To:     Jouni Malinen <j@w1.fi>, Aloka Dixit <alokad@codeaurora.org>
CC:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
 <20210916025437.29138-3-alokad@codeaurora.org>
 <20221218152420.GA906762@w1.fi>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20221218152420.GA906762@w1.fi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oq0cFXFj88pt2YwyaVxhIl1ow2KQkRFJ
X-Proofpoint-GUID: oq0cFXFj88pt2YwyaVxhIl1ow2KQkRFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212190167
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/18/2022 7:24 AM, Jouni Malinen wrote:
> On Wed, Sep 15, 2021 at 07:54:35PM -0700, Aloka Dixit wrote:
>> Configure multiple BSSID and enhanced multi-BSSID advertisement (EMA)
>> parameters in mac80211 for AP mode.
>>
>> For each interface, 'mbssid_tx_vif' points to the transmitting interface of
>> the MBSSID set. The pointer is set to NULL if MBSSID is disabled.
>>
>> Function ieee80211_stop() is modified to always bring down all the
>> non-transmitting interfaces first and the transmitting interface last.
> 
> This has already been applied, but this has some apparent issues that
> are now showing up with mac80211_hwsim testing being available..
> 
>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>> +static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
>> +					   struct cfg80211_mbssid_config params)
> 
> While that does not really break behavior, why is that params argument
> passed by value instead of by reference? I see no point in copying
> struct cfg80211_mbssid_config members for this call since the function
> is only reading the value.
> 

Hi Jouni, the only reason for value instead of reference is that this 
function does not need to change anything in 'params'. I didn't 
understand your question. Are you suggesting moving the assignments to 
ieee80211_start_ap() instead of this separate function?

>> +	sdata->vif.mbssid_tx_vif = NULL;
>> +	sdata->vif.bss_conf.bssid_index = 0;
>> +	sdata->vif.bss_conf.nontransmitted = false;
>> +	sdata->vif.bss_conf.ema_ap = false;
> 
> This cleanup is important, but it is done only here in this helper
> function..
> And that is the only place where the help function is called and this
> happens only under the params->mbssid_config.tx_wdev condition. In other
> words, those bssid_index/nontransmitted/ema_ap values are not cleared in
> all cases. This results in issue when the bss_conf (link_conf in the
> current kernel snapshot) is left in the previous mbssid configuration.
> 

Will send a patch to fix this part.

Please let me know regarding the first question above so that I can 
include that in the same patch.

Thanks.

