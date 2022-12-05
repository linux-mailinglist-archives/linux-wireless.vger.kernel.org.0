Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A16438DC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiLEXBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 18:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiLEXAt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769391E710
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 15:00:47 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5MihG7020735;
        Mon, 5 Dec 2022 23:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P1tzvXu1YwE8hTgGjseo1t/ZQ7jW5xJow3glKQdd/l8=;
 b=pBTD9W3Omz336nePLoitpCtklvRgctOdSRgIN43wwgUN9fbon+LCw77RH4+R4SQeJp9j
 ysUt4uOBaBjS0jffGYXKsbPdmOaxxwPRIABwKT8ejfeLdRTkberpDNZhUE3Nkfq0VoZh
 ZFgR27i+jD+mvwnC0yc1+060MM6G4VeT8tOLIsj2B0sChtXm+wNHMixsc9ZpuwAdPcPq
 QdneQX+jDxcqF43gtKDzHwQpGdmY7rHOSJFOta9nluYNG6yiEC09eMI3vqI/3Y17mqne
 pKKEXI+Eh3FQO2A7fYu2epeyrcxYVgSSZB9Q3zXY0jjsYnp/dEc7Y7S0m5i3FjZa29Wc qA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7utunane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 23:00:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5N0an3022403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 23:00:36 GMT
Received: from [10.110.39.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 5 Dec 2022
 15:00:35 -0800
Message-ID: <ad0909b7-99dc-1ef0-dbca-9cc27f2d83b1@quicinc.com>
Date:   Mon, 5 Dec 2022 15:00:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 01/10] mac80211: generate EMA beacons in AP mode
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Jouni Malinen <j@w1.fi>, Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
 <20221114201912.22893-2-quic_alokad@quicinc.com>
 <20221202164439.GA700414@w1.fi>
 <ac0506a5-fa37-3fe4-8051-e1febd58d538@quicinc.com>
In-Reply-To: <ac0506a5-fa37-3fe4-8051-e1febd58d538@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Q0Hbi5i20IJMMzcgJaMJVb-xUDpttRs
X-Proofpoint-GUID: -Q0Hbi5i20IJMMzcgJaMJVb-xUDpttRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050190
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/2022 11:40 AM, Aloka Dixit wrote:
> On 12/2/2022 8:44 AM, Jouni Malinen wrote:
>> On Mon, Nov 14, 2022 at 12:19:03PM -0800, Aloka Dixit wrote:
>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>> @@ -3338,7 +3338,8 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data 
>>> *beacon)
>>>       len = beacon->head_len + beacon->tail_len + 
>>> beacon->beacon_ies_len +
>>>             beacon->proberesp_ies_len + beacon->assocresp_ies_len +
>>>             beacon->probe_resp_len + beacon->lci_len + 
>>> beacon->civicloc_len +
>>> -          ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
>>> +          ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
>>> +                          beacon->mbssid_ies->cnt);
>>
>> beacon->mbssid_ies can be NULL here and that is going to result in a
>> kernel panic. For example, check with hostap.git test case
>> ap_ht_20_to_40_csa.
>>
> 
> Oh, thank you, will fix it.
> 
> @Johannes, I noticed that commit 2b3171c6fe0af24b5506
> missed freeing old->mbssid_ies (2 places) and old_beacon->mbssid_ies 
> that were part of 
> https://patchwork.kernel.org/project/linux-wireless/patch/20210916025437.29138-4-alokad@codeaurora.org/.
> I will add those in the next version as well.
> Any better way to catch missing free() calls that you can recommend?
> 
> Thanks.

My bad, please ignore above comment. The design was changed a bit 
between those two versions and the current one does not allocate 
separate memory for mbssid_ies, instead adds required length to the 
original allocation.

