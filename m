Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562D17839D2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjHVGR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 02:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHVGR0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 02:17:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2AF11C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 23:17:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M5s4hx012332;
        Tue, 22 Aug 2023 06:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3RxpdlHfWyHj7vPr3U2RYb7ILp/F3TSdWusFcL5zx0Q=;
 b=D95DvkwwFQmsIY97NBwW8UROUmvRAGCqhiP5sla+VCaS4XQ0bkjC8GIs+emE56RqTba8
 jr3cE4uE4FRNI+q7qgG74VJCQoZbeZF4EGYKn8fjKA3EbYbbH7M5LDF6Ylg/mFsGRcXJ
 w9LEyY5OGp4TJZ1A9sNEe3I/3tzS0uZhCEJZm85CC0JDdWHveYYw68yHvNTRzZ/wRwy1
 qV/W/Rzz9XQeuXEX0gH7bhX2mdaHBMMZCDehkl3QNscLo2+A459hCEXc02s3cBDTUECa
 GtNvvCvRWLA5CBA/79se7Dsr+zHKOyb40UWMo/lmBQ81LQ76C7JCzciQVva45CqpmOOD +A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm5mct8va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:17:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M6HKF6011708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:17:20 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 23:17:19 -0700
Message-ID: <ee8b37a1-0a5e-cc2f-8b88-a1263ee1b761@quicinc.com>
Date:   Tue, 22 Aug 2023 14:17:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
 <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
 <9ce54e8e-556b-976c-06d9-145b747705db@quicinc.com>
 <714fd7374225db9e8d8225197931c5183f12e534.camel@sipsolutions.net>
 <6adeb7be-9c7a-c122-71be-cc0143115fe6@quicinc.com>
 <0f34540e71e7ba63a3d38e85aefec74350384a33.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <0f34540e71e7ba63a3d38e85aefec74350384a33.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zLD8ul9WAM55S3nG5UbguyZM4jxGLtcS
X-Proofpoint-ORIG-GUID: zLD8ul9WAM55S3nG5UbguyZM4jxGLtcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220050
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/21/2023 7:34 PM, Johannes Berg wrote:
> On Mon, 2023-08-21 at 19:11 +0800, Wen Gong wrote:
>> On 8/21/2023 6:57 PM, Johannes Berg wrote:
>>> On Mon, 2023-08-21 at 18:36 +0800, Wen Gong wrote:
>>>> On 8/21/2023 5:06 PM, Johannes Berg wrote:
>>>>> On Mon, 2023-08-21 at 10:59 +0200, Johannes Berg wrote:
>>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>>
>>>>>> This reverts commit cb751b7a57e5 ("mac80211: add parse regulatory info
>>>>>> in 6 GHz operation information") which added a station type bss_conf
>>>>>> assignment in a parsing helper function, which will corrupt mesh data.
>>>>>>
>>>>> Ah crap this won't work, rtw89 already uses this.
>>>>>
>>>>> Wen please send a fix for this ASAP.
>>>>>
>>>>> johannes
>>>> Hi Johannes,
>>>>
>>>> I looked the patch some times, but I do not know how it corrupt mesh data,
>>>>
>>>> Is there any clue for me?
>>> Hah, no, I'm wrong ... I looked at it and for some reason thought of
>>> u.mgd instead of vif.bss_conf. Sorry!
>>>
>>> Still it's not correct though to write to vif.bss_conf in this function
>>> because it's called from mesh_matches_local() to see if it's even
>>> compatible, for example, so the mere calling a "give me the 6 GHz
>>> chandef" function doesn't indicate we actually are going to use it now.
>> Do you mean mesh_matches_local() is only a try to call
>> ieee80211_chandef_he_6ghz_oper(),
>>
>> NOT real use the 6 GHz chandef?
> Yes, I believe so.
>
> Anyway it would seem better for a utility function to have clearer
> defined output, I think?
>
> johannes

Do you mean move the logic of set bss_conf->power_type to another new 
function from

ieee80211_chandef_he_6ghz_oper()?

