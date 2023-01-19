Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534F6743A3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjASUoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 15:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASUoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 15:44:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFCA9CB82
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 12:44:05 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKYKXW032758;
        Thu, 19 Jan 2023 20:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8Mi8H7B5yZSzP7ElEr50P8E5QG68AamriQ2Sscqtuuk=;
 b=KUgRGNq2iw0eAsgNtmSfWs0SYCLQW5cJ72kkk4i1hYFXJFyRjwadMgaJM9o61fuImI6c
 ndZ50HMT2QvJKBVzjoHtWoXBxyTl4E3bJxCfJ+F4J5BrQHm9RHNLfSNzSjaaT37v/LBB
 VAALZk15eJX+hKgMxNdBPfg/UDqCinxFLmugS/bJY4j/bUoW3FE4J4d/xYmHHY2c6fTQ
 4BECuJv5L1QEt+9F1NaUGtHHn4VyOgetiXDNRVd+aE1C/F/dsaJmiuWmC6HPlgmdjXyN
 iU9oxx/B2OTEPE9e8hUBHzxwo9hjp6ZIVtSqnjUzlZKi8vxbhM/OG97OhDdiJkXdECL+ tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6wbsaess-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 20:44:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JKi0Bf014029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 20:44:00 GMT
Received: from [10.110.52.22] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 12:43:59 -0800
Message-ID: <1598bf6d-1d0b-3753-73fa-2568d27d60b6@quicinc.com>
Date:   Thu, 19 Jan 2023 12:43:58 -0800
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
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <26ef0d67db3af16853915568585767b13a73ef9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cDpt8AwiBiQxsqcRCielR4EqwZcqXPJl
X-Proofpoint-GUID: cDpt8AwiBiQxsqcRCielR4EqwZcqXPJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190173
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/19/2023 12:12 PM, Johannes Berg wrote:
> On Thu, 2023-01-19 at 11:40 -0800, Aloka Dixit wrote:
>> On 1/18/2023 7:57 AM, Johannes Berg wrote:
>>> On Wed, 2022-11-09 at 13:47 -0800, Aloka Dixit wrote:
>>>> FILS discovery and unsolicited broadcast probe response transmissions
>>>> are configured as part of NL80211_CMD_START_AP, however both stop
>>>> after userspace uses the NL80211_CMD_SET_BEACON command as these
>>>> attributes are not processed in that command.
>>>
>>> That seems odd. Why would that *stop*? Nothing in the driver should
>>> actually update it to _remove_ it during change_beacon()?
>>>> Are you sure you didn't mean to "just" say "however both cannot be
>>> updated as these attributes ..."?
>>>
>>> johannes
>>
>> FILS discovery has primary channel, center frequency in the frame format
>> which should be changed depending on why the beacon changed.
> 
> Hmm? Sure, the frequency is important, but beacon can change for so many
> other reasons? Even just the greenfield bit in HT would cause a beacon
> change as far as cfg80211/mac80211 are concerned.
> 
>> Hence the
>> current design, at least ath11k, assumes that BSS_CHANGED_FILS_DISCOVERY
>> and BSS_CHANGED_UNSOL_BCAST_PROBE_RESP "not being set", when beacon is
>> changed, means disable these features.
>> What do you think?
> 
> I think that makes no sense? If mac80211 didn't clear struct
> ieee80211_bss_conf::fils_discovery, then surely it should stick around
> even if the beacon changes???
> 
"max_interval" was be used as the enable/disable knob for these 
features. Non-zero = enable, zero = disable.
But the side effect of that is if NL80211 does not receive these 
attributes then by default the interval is set to 0.

> Surely you can't be right - that'd basically mean the whole feature is
> useless right now because even the greenfield update or similar that
> basically *always* happens in hostapd would disable it, since the beacon
> changes and we don't have these patches?
>Pretty much, yeah.

>> Should I send a follow-up with a different commit log?
>>
> 
> Well seems like we need to first figure out the correct semantics here,
> and possibly fix things...
> 
> johannes

I can think of following:
(1) max_interval cannot be the enable/disable knob because then every 
code path in the userspace would still need to set it to non-zero to 
continue transmission. Are you okay with having extra members in enum 
nl80211_fils_discovery_attributes to ENABLE/DISABLE? I think that is 
what you suggested in your comment for the next patch in this series as 
well.

(2) If the template needs changing for any reason then the userspace 
will be responsible to send a new one. Until then the driver will 
continue the transmission with existing template and interval unless 
DISABLE is used.

Thanks.


