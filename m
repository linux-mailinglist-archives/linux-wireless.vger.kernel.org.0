Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC967444F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 22:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjASV0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 16:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjASVYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 16:24:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B3133
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 13:20:04 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKvRnN005481;
        Thu, 19 Jan 2023 21:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Bx7OfbtSM290p1EoLA4UGkrnlBncCzyOn8vC+rLJk0M=;
 b=ct0/4Rufdzu3FKwWVYtmQ9vnGKh3gDqX300AG12zLq0y7I+OS9lXY4inHHCW/2wM8mjj
 ihScaEVvDWIzYGPg2dQ9ZDKg97f93DNAt2wvnITMbeSMOorE5gVwzPU8a+UBU6aH0RMI
 xvWSDoobUjCI6AxhmIbp3XxyR0XZIz4cVtjbzQvlBI8mzF6EwRCmT5O88C6ehxpFHaIo
 Fqi6IO35Ax9EsQ3yLQUv+I6/u12RYguwohUQeI7+GcrBfmBvoXVWXG6c+EU+U7aZ/UzJ
 9W+DRS7lRsOkrrKBBw/B0vIuF4Sbd45T3VnFGEQtGsiLME7W0aG3/2A+xu6Krh/HyY6N NA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vg02kcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:20:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JLK0s8026321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:20:00 GMT
Received: from [10.110.52.22] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 13:20:00 -0800
Message-ID: <5accd9bb-b172-be8f-2045-a55b2695b2d4@quicinc.com>
Date:   Thu, 19 Jan 2023 13:19:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
 <20221109214720.6097-3-quic_alokad@quicinc.com>
 <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
 <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
 <26ef0d67db3af16853915568585767b13a73ef9a.camel@sipsolutions.net>
 <1598bf6d-1d0b-3753-73fa-2568d27d60b6@quicinc.com>
 <733b35861bbed8d3b7cf8625d3bf59f1c34e08da.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <733b35861bbed8d3b7cf8625d3bf59f1c34e08da.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Me1iZhPmPNiymGHZO3wFwWz8QysWn1EV
X-Proofpoint-GUID: Me1iZhPmPNiymGHZO3wFwWz8QysWn1EV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=646 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190179
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/19/2023 12:47 PM, Johannes Berg wrote:
> On Thu, 2023-01-19 at 12:43 -0800, Aloka Dixit wrote:
>>>
>>>> Hence the
>>>> current design, at least ath11k, assumes that BSS_CHANGED_FILS_DISCOVERY
>>>> and BSS_CHANGED_UNSOL_BCAST_PROBE_RESP "not being set", when beacon is
>>>> changed, means disable these features.
>>>> What do you think?
>>>
>>> I think that makes no sense? If mac80211 didn't clear struct
>>> ieee80211_bss_conf::fils_discovery, then surely it should stick around
>>> even if the beacon changes???
>>>
>> "max_interval" was be used as the enable/disable knob for these
>> features. Non-zero = enable, zero = disable.
>> But the side effect of that is if NL80211 does not receive these
>> attributes then by default the interval is set to 0.
> 
> 
> But it doesn't change in bss_conf if you send change beacon, at least
> not before these patches?
> 
> Or am I confusing myself?
> 

Your understanding is correct, however, without these patches there is a 
cascading effect.
-> NL80211: If the attribute is not sent by user-space/processed in this 
layer then cfg80211_ap_settings->fils_discovery->max_interval is 0 
(default).
-> MAC80211: max_interval=0, hence BSS_CHANGED_FILS_DISCOVERY is not set
-> ath11k: BSS_CHANGED_FILS_DISCOVERY is not set hence driver doesn't 
configure/re-configure. Unless target doesn't receive it every beacon 
change, it disables it.

I can make changes up to the driver to fix this part.

>> I can think of following:
>> (1) max_interval cannot be the enable/disable knob because then every
>> code path in the userspace would still need to set it to non-zero to
>> continue transmission. Are you okay with having extra members in enum
>> nl80211_fils_discovery_attributes to ENABLE/DISABLE? I think that is
>> what you suggested in your comment for the next patch in this series as
>> well.
>>
>> (2) If the template needs changing for any reason then the userspace
>> will be responsible to send a new one. Until then the driver will
>> continue the transmission with existing template and interval unless
>> DISABLE is used.
>>
> 
> Were those meant to be mutually exclusive, because it doesn't seem like
> that to me? I think (2) must be what happens now, before these patches,
> because I don't see where it would be changed? Like I said above.
> 

Not exclusive. I meant I can make both the changes above to not have the 
above mentioned cascading effect

> I agree that we'd now need an explicit way to indicate "disable", but we
> could for example say you disable by adding a nested
> NL80211_ATTR_FILS_DISCOVERY attribute without any of the sub-attributes,
> which logically kind of makes sense - you're changing
> NL80211_ATTR_FILS_DISCOVERY, but you're not including a new set of
> parameters, so logically that means disable?
> 
> johannes

Sure, will update nl80211_parse_fils_discovery() to allow this case and 
reset all to 0/null etc.

I can start a new series with all the changes, and include current 
patches last.

Will that work?
