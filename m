Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304760414D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJSKmN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiJSKlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 06:41:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76065EC
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 03:19:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J9ZI35009963;
        Wed, 19 Oct 2022 09:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bFpZcVHn4IvcPTJRMp+kub7pip4UrC6+M4EsMtCI4Dw=;
 b=H8ffm7EX//WlW7+26V0vwL6kJih14hd0tzwBKQJWVCNrC7RUHKdLIbtKBdIQrO7eyiR5
 KIayQKeAxt1nQBubUE2OaXiaULkBnegInAOXxHFIcTbWlwAjMfv+HLbBFlEzCj4d1B7z
 Kf7yt65fFiLcVfs6TvW8ShN5sp5zDf/K1TZnWDmBP7VL/d09wom9V+VQvVBmoalZi+a/
 Li+vy92hyk671x1sv622rnI8JDm3q7qOQ5JnLOLRr7x3sSuWFxuS4IbA9YpTooL26nAJ
 xzunGH7Kt8IOdbxxNNd9aDV47m/BpWZNPVjW8mGlpnQyUGEjO9JQ4bgJ31KMH0I4+OtU Pw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9yq1j2qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:40:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J9eTCn032409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:40:29 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 02:40:27 -0700
Message-ID: <1258a2cf-af82-3a58-a4b5-e0fcd961bf4b@quicinc.com>
Date:   Wed, 19 Oct 2022 17:40:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: wifi: mac80211: Re: unicast probe response bssid changed by
 "wifi: mac80211: do link->MLD address translation on RX"
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
 <9fe7c0f2-e02f-e87f-dced-90e973c8992f@quicinc.com>
 <5f652efb43226f67e932f5aaf97cd717992bfd81.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5f652efb43226f67e932f5aaf97cd717992bfd81.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x4sE1l9eeT91MWxBBi-jFmVMow3aB8FE
X-Proofpoint-GUID: x4sE1l9eeT91MWxBBi-jFmVMow3aB8FE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/19/2022 5:38 PM, Johannes Berg wrote:
> On Wed, 2022-10-19 at 17:35 +0800, Wen Gong wrote:
>> On 9/14/2022 11:13 AM, Wen Gong wrote:
>>> Hi Johannes,
>>>
>>> The mac addr of unicast rx packet all changed to the MLD address by
>>> below patch.
>>> Now the probe presponse which is unicast packet is also changed mac
>>> address here.
>>> I found bssid which is the MLD address of my test AP in
>>> cfg80211_get_bss().
>>> For example, if the AP has 2 mlo links, link 1 is 5 GHz band, link 2
>>> is 2.4 GHz band,
>>> then the 2 probe reponse will be changed to a same one.
>>> seems we should skip probe presponse for the mac address change here,
>>> right?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=42fb9148c078004d07b4c39bd7b1086b6165780c
>>>
>>> wifi: mac80211: do link->MLD address translation on RX
>>>
>> Hi Johannes,
>>
>> May I get your comment about this?
> Yes I've actually seen this issue as well.
>
>> I did below change in my local test to workaround the issue.
>>
>> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
>> index a57811372027..eaff5353520a 100644
>> --- a/net/mac80211/rx.c
>> +++ b/net/mac80211/rx.c
>> @@ -4858,7 +4858,8 @@ static bool ieee80211_prepare_and_rx_handle(struct
>> ieee80211_rx_data *rx,
>>            shwt->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
>>        }
>>
>> -    if (unlikely(link_sta)) {
>> +    if (unlikely(link_sta) &&
>> +        !(ieee80211_is_probe_resp(hdr->frame_control))) {
>>            /* translate to MLD addresses */
>>
> Maybe it should also be for beacons or so?
>
> johannes
Yes, it should also for beacons.
