Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2358FA1C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiHKJcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 05:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 05:32:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943492F63
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 02:32:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B7h18L004171;
        Thu, 11 Aug 2022 09:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=acRp96zai+UPcwC93lUUtppAtOPu6uz+ObdeVL4xzEI=;
 b=JD4gLKFSuAeRhJN7HkCdwPtYb0o5wyLNZEMdQ/nlYZMbGHO0pwIVbRHifi887fiS5WHb
 GHTMYdO7PzbKoLIFNSXgwXosJrKyE7/xuNF1UkSIiJZF+BrDBEB5X+h0BSkung9Kngwf
 rAVtq7bQt9/OOgkt+fF+c3GlVLCAKfxMNKPiGWqqhjxka/AC9LKQvAX9uQRVxr7fHr9o
 Um/kEtZoNOPlNDu2WwWAGVuilE00XSKehyaYk6zxmwdpYjJBUxxzqab8dy0hGTghToXP
 efFY9670+j7OocRN9tcFkr2qy4hOsr2SwOAIqe3bh177MB9F3ZCUzTS44MpFREfKh4al 5Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvh25t9uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 09:32:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27B9WEOd005865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 09:32:14 GMT
Received: from [10.201.164.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 02:32:12 -0700
Message-ID: <5b71e308-0783-fa98-77a8-c17121ca53fc@quicinc.com>
Date:   Thu, 11 Aug 2022 15:01:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC 1/2] wifi: mac80211: add a new field in ieee80211_rx_status
 for link id
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
 <20220802065019.20791-2-quic_vthiagar@quicinc.com>
 <29694008-63ef-4cd3-a6c6-f82fc8377be6@quicinc.com>
 <733b6f1a-8b07-4b23-2b10-af1ce68b6227@quicinc.com>
 <9e37eb24f63dbac0b13ae8b36393c8f393599d1e.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <9e37eb24f63dbac0b13ae8b36393c8f393599d1e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5IfMrlhOXadESC9ZQxslQAWjQIXRl0Bf
X-Proofpoint-ORIG-GUID: 5IfMrlhOXadESC9ZQxslQAWjQIXRl0Bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=786 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110027
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/9/2022 11:42 PM, Johannes Berg wrote:
> On Wed, 2022-08-03 at 22:16 +0530, Vasanthakumar Thiagarajan wrote:
>>
>>>> +    u8 link_id;
>>>>    };
>>>>    static inline u32
>>>
>>> in other parts of the MLO code the link_id is defined as int and a value
>>> of -1 is used for a non-MLO link. but I don't know if that is currently
>>> universally true.
>>>
>>> if that is curently universally true, do we want to now have divergent
>>> definitions of a link_id?
>>
>> Good point, i see link_id is used both as unsigned and int based on
>> their usage. The reason I preferred unsigned is that we can make use of
>> the remaining 4-bits for some other purpose in future,
>> ieee80211_rx_status has size limitation.
>>
> 
> It's a bit tricky though - do we want to have 0 for all the drivers that
> don't support MLO? Might not really be an issue, but OTOH not
> initializing it should probably not result in a valid value otherwise
> you might test something, think it's fine, and it really isn't. >
> I think we should spend a bit to have a validity indication in this
> case. Even -1 wouldn't address it since you'd have to initialize to
> that.
> 

Sure, a new valid bit looks cleaner. Ill make the changes.

> It works better the other way around in APIs etc. where we have a few
> producers and many consumers (cfg80211 down to drivers), but less well
> this way where we'd have to change drivers...

I agree.

Thanks!

Vasanth
