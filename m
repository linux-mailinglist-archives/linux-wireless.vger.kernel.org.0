Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E278D306
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 07:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjH3FgO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjH3Ffx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 01:35:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FAEFC
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 22:35:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U5Ln9Y026576;
        Wed, 30 Aug 2023 05:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ksAUVXNcSsyM+KExRSn74GqHSJlYitD3InTVBAjbk50=;
 b=c+ahCpebcR65IH8ZB5P8d9ir8U2rWLhZBnDUdMoet+19hbn8T93Z2OOosnkBiEqp9lGW
 D0GZbKXCFmCG8r5KI/cVNttZds+X8wmdohWGbW/Pxv/eCOSVKKRLrU31tW8Zpz2mHzNf
 vgnqKdmRzPT2qBmLHu8Aww1N9/eW8vYsdKwP7RNzp/EdxGE/JZWzPbe8JVWaAE/dispJ
 MhdW8OuLd9iYTAryLa4gfGb+ez8zry4/kTw3RXsYjbyzJpbB1ZstAWJ5ceacv7N2sAio
 5HxXDUoOkmu6gWR2N5BDP588PxehvO2yJctPPDVhhTB2gmR6iNKjShXdkbEkYDAxX2TP xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr3n8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:35:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U5OKpn029999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:24:20 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 22:24:18 -0700
Message-ID: <0d3aae8c-95a8-9e0a-a8ba-8e96f5623e43@quicinc.com>
Date:   Wed, 30 Aug 2023 10:54:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nigUZFFXQM7u6NFp3QSXCZ6AX-t3XTNb
X-Proofpoint-ORIG-GUID: nigUZFFXQM7u6NFp3QSXCZ6AX-t3XTNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300051
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
Cause client also has two power modes? Default client can also connect 
and sub-ordinate client too connect to all the AP types. So user space 
would tell what is the power mode.

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
Yeah, I too have the same thought but unfortunately by mistake named it 
wrong. Sorry! Will rectify it in next version.

> 
> And then trivial things like - don't introduce a bug only to fix it in
> the next patch! I mean, really?
> 
> I _still_ don't like "(A)" operation with different channel pointers -
> you talk about introducing bugs with (B) but at least those would be
> bugs in the new parts; (A) is almost certainly introducing bugs in
> existing code that compares pointers and you never even know about it.
Got it.

> 
> Also, related to that, is kind of a fundamental question - should we
> really think that two *channels* are different because you use different
> (TX) power control/scheme on them? That seems a bit strange, and you've
> not gotten into that at all, from a semantic POV, only from a code POV.
> I actually currently don't think that makes sense, but convince me
> otherwise?
Hmm... Sure, let me think again and get back.

> For a chandef, _maybe_? But also see the discussion around puncturing,
> I'm not sure that's actually the right solution either.
> 
Okay.

> johannes

