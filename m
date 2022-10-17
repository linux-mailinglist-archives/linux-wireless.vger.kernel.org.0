Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F4600870
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJQINS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJQINO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 04:13:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4AC5C371
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 01:13:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H76mLa010493;
        Mon, 17 Oct 2022 08:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3d0S8us5fCRajoxspRPCrW3ITmp7ZLBwHZbQkm2wguQ=;
 b=BVm/dr5vERBayUKuTCUv9Y6sowO8MnJnjMCM8LdVe5EYdWsO8ZPDZyu0I4qC9pxtk9XP
 r55KQbrq3OnbOL2rMaBcku7n54JSYWUc1Le/J0TuoDXv0CcxUUiIbvLaGotaR9jcNJp5
 Kq4c7hUEnorVU2wR7U6dOO1ZKs5VXuCx48OR8yV17XITx+reKy500pKU9CJY+t1lL613
 UwiLTluiqxnGaJIfxEQH522ed6YAisx0gpjfKvUkgzMajA45edHxzJLtHJYtg9lSYn7n
 4QWfEszbrRZG/HlEeTj2VwsRTAGqE0XTRb10jezoXVcbZCGIDLo1pYbfyv7bQbfFm3Fh 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7nmqv1wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 08:13:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29H8D0vn012931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 08:13:00 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 01:12:59 -0700
Message-ID: <191042d8-7781-808f-71aa-db76ed763bec@quicinc.com>
Date:   Mon, 17 Oct 2022 16:12:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: wifi: mac80211: mlo rx nss value 0 of wifi
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
 <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
 <91b975e2116521cfa9f9371a976039a53ed9a85c.camel@sipsolutions.net>
 <2a2c466fbdcc2c3cc7af81bcd4d370d0119ea865.camel@sipsolutions.net>
 <c52e6634-4a90-f165-9f41-8f23df9414a4@quicinc.com>
 <ca0f6ea2d78538ffb6640f2e56d65c89c86f5221.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <ca0f6ea2d78538ffb6640f2e56d65c89c86f5221.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hFcpIhoECYMbq3QemDMzZUrw7UQfmEHF
X-Proofpoint-ORIG-GUID: hFcpIhoECYMbq3QemDMzZUrw7UQfmEHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/17/2022 4:02 PM, Johannes Berg wrote:
> On Mon, 2022-10-17 at 16:00 +0800, Wen Gong wrote:
>> On 10/17/2022 3:49 PM, Johannes Berg wrote:
>>> On Mon, 2022-10-17 at 09:48 +0200, Johannes Berg wrote:
>>>> Hi,
>>>>
>>>>>> Currently for MLO test, the others links's rx_nss of struct
>>>>>> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
>>>>>> becaue they are not pass into ieee80211_sta_set_rx_nss() in
>>>>>> mac80211 except the deflink which means the primary link in
>>>>>> rate_control_rate_init(). This lead driver get nss = 0 for
>>>>>> other links. Will you fix it or is it design by default?
>>>>>>
>>>>>> Only primary link has valid rx_nss value which is not 0 by below call
>>>>>> stack.
>>>>>> ieee80211_assoc_success()
>>>>>>       ->rate_control_rate_init(sta);
>>>>>>           ->ieee80211_sta_set_rx_nss(&sta->deflink);
>>>> Right, none of the rate scaling related stuff was updated yet.
>>>>
>>> Though for this case maybe we can just move ieee80211_sta_set_rx_nss()
>>> to some better place outside of rate_control_rate_init() and have it
>>> done with the right link, and also on changes?
>>>
>>> johannes
>> I did below change in my internal test, and not found the NSS=0 issue
>> again for 2 link MLO.
>>
>> wifi: mac80211: update all links rx nss by ieee80211_sta_set_rx_nss() in
>> ieee80211_assoc_success()
>>
> I guess valid links wasn't set at that point yet?
>
> Anyway should also move out of rate_control_rate_init() and probably
> into something like ieee80211_assoc_config_link()? That already does
> some rx_nss calculations which is probably not great ...

OK. I will test with my change internal now. And replace to use upstream 
change

after someone fix it.

> johannes
