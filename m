Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34978D2F5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 07:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjH3FYm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 01:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjH3FYR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 01:24:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803BCC5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 22:24:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U4m8KP025490;
        Wed, 30 Aug 2023 05:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lyu7OEQZkh5MJI6BKMzccYh0ifOhFn2iy2fJa8bAz/8=;
 b=nmX25WAsYe7AsktZI5yEmLfSDpC5kDLv2EBG6Fhba4hH8MH+CQ6/K0SW2bXaZelCaMzu
 ND1vNXKdwGMt4GVQSbxD4J7qryuWtjeotLpifB3oxaDBgt2PbeNWc8wfvmHSbodpQL/3
 zVW4uNpE6biN8s6KmCrP2J8ojaMpnxOm6iAjhDpEM+OxdTH9MqwiLOxhMGtZC+qPQjM6
 Fmalb7T75cd4ZDfSZyQNozm8MxIgf47SBsUu+MLLtq6qIxW4roR6k9FGm5ZVX33cL9lp
 jidD5btnQ5NkWJiKyQL6zbwhG9iFSxcXacjp32nlzh0cC31lAgcsXSvrxwlt/pwPMhzF Gg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss7meu994-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:24:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U5Dq0B012241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:13:52 GMT
Received: from [10.201.207.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 22:13:51 -0700
Message-ID: <afd7a85c-e1ce-6a6e-a29e-74ccc0d8bd08@quicinc.com>
Date:   Wed, 30 Aug 2023 10:43:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D_B5Wr9NDor-Cu42u_D8dYHDEiNLnA_R
X-Proofpoint-GUID: D_B5Wr9NDor-Cu42u_D8dYHDEiNLnA_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300050
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/23 23:20, Johannes Berg wrote:
> Hi,
> 
> So ... yeah. I shied away from even reviewing this because it's such a
> messy topic and we've had so many threads about this. Sorry about that.
> 
> 
> On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
>> 6 GHz introduces various power modes of operation. Currently, based
>> on the power mode, channel's Power Spectral Density (PSD) value,
>> Regulatory power value, as well as channel disabled flag can change.
>> For single interface, current implementation works just fine. But for
>> multi-interfaces, for example AP-STA concurrency, two different channel
>> context needs to be maintained. This is because, STA power mode also
>> depends on the AP's power mode it is going to associate with. Hence,
>> PSD value, regulatory power value and channel disabled flag might vary.
>> In this case, same channel context cannot be used for both AP and STA.
>>
>> Therefore, to support multiple channel space for each power mode, the
>> 6 GHz channels needs a separate storage space in data structure
>> ieee80211_supported_band. Because of this, the existing APIs to get the
>> channel/frequency from frequency/channel will not work for 6 GHz band.
>>
>> Add support to store all possible 6 GHz channel pools according to the
>> power mode as well as add API support for getting channel/frequency info
>> from the new struct ieee80211_6ghz_channel.
>>
>>
>> Why different channel pools and not array of varying member in the same channel?:
> 
> 
> I really don't understand.
> 
> Why do you even need to set *from userspace* the power mode for a
> client? That ... doesn't make that much sense?
Because there are two possibilities? Default client and also connect to 
Low Power Indoor AP as well as sub-ordinate client. So to let the kernel 
know which mode originally the client is in, the command was introduced.

I do understand the concern here about possible misuse for the command 
from the user space, I would re-visit this area and try to cover the 
loop holes if any. But don't you think it should be the case? Basically 
same like how we tell via user space the SSID, keys/suite info. freq 
list and all for a client, in a similar way tell the power mode.

> 
> I mean, you're explaining here the mechanics, which is all fine, but
> what's the "theory of operation"? Yes, I get that 6 GHz spectrum use
> introduced power modes, but why do we even need to handle it this way?
> None of this or the patches actually introduce any rationale?
> 
> Also, I'll note that the patch subjects with "cfg80211" or "mac80211"
> are _really_ unclear. Sometimes you have "cfg80211" patches that mostly
> change mac80211, etc. It'd make reviewing easier if you actually did
> limit cfg80211 patches to touching cfg80211 only (with the exception of
> necessary API updates, of course), and mac80211 patches to implementing
> the new cfg80211 APIs. The first patch is probably neither, you can mark
> it as ieee80211.
Sure. I had the same thought but unfortunate in few patches, named the 
title wrongly. My bad, sorry for that. I will correct it in next version.

> 
> And then trivial things like - don't introduce a bug only to fix it in
> the next patch! I mean, really?
> 
> I _still_ don't like "(A)" operation with different channel pointers -
> you talk about introducing bugs with (B) but at least those would be
> bugs in the new parts; (A) is almost certainly introducing bugs in
> existing code that compares pointers and you never even know about it.
Got it.

> Also, related to that, is kind of a fundamental question - should we
> really think that two *channels* are different because you use different
> (TX) power control/scheme on them? That seems a bit strange, and you've
> not gotten into that at all, from a semantic POV, only from a code POV.
> I actually currently don't think that makes sense, but convince me
> otherwise?
Sure, let me work on this and get back.

> 
> For a chandef, _maybe_? But also see the discussion around puncturing,
> I'm not sure that's actually the right solution either.
Okay will check that out too.


