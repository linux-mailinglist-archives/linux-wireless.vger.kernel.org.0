Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B83590E87
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiHLJz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHLJzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 05:55:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8026AD3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 02:55:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C4h1IF032585;
        Fri, 12 Aug 2022 09:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zJj1r+TB/TXyKesqJlQ91x2+VE8ln7PWYgyRg1eyrQ8=;
 b=gPHmOIzotCIXkjJv/4mkn6hviNN/2uTzixpcQaAb3lGk3j18PP+LR8Cot/PBWCGIJUol
 BKiqnltQslO8b09x8c5WM0YFh+OXRMxgQI7nxECk1AZr3i/ScvqLKyXIdooJp+fU+qqo
 W1FYTPPnDluviaOGX2ygiAoWJP77DITQ3gdbuNwG2+jRK6Ht361OOf8fBpxFqidp+zcs
 rPbMcfa5yXTdc2PEw3Gicxy+4yLmOUgRE544QRohDGqnZ97Jo/5uWU5MmG+UXVzi12yv
 Tt9SB/krSdR1PWBvbTXuzyx8zg/RLQsfDtf2wqT33cMWxz5lwMmhvznonr7nn8pkvkIZ Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hw7gw1ra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 09:53:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27C9rQfw019872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 09:53:26 GMT
Received: from [10.110.62.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 12 Aug
 2022 02:53:26 -0700
Message-ID: <0882eff5-e1c3-8478-a7a8-8344ccd87c22@quicinc.com>
Date:   Fri, 12 Aug 2022 02:53:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/4] cfg80211: validate RU puncturing bitmap
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
References: <224a3fb3-df3f-7da3-8130-416a80f116f3@quicinc.com>
 <c1484632-bd03-9992-741f-05b389cd1907@quicinc.com>
From:   Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
In-Reply-To: <c1484632-bd03-9992-741f-05b389cd1907@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vrRk7VRzTM9xxWIA3fpovNsY1ShxHN3Y
X-Proofpoint-ORIG-GUID: vrRk7VRzTM9xxWIA3fpovNsY1ShxHN3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_06,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120027
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>
>
>
> -------- Forwarded Message --------
> Subject: Re: [PATCH v2 2/4] cfg80211: validate RU puncturing bitmap
> Date: Thu, 24 Mar 2022 09:35:27 -0700
> From: Aloka Dixit <quic_alokad@quicinc.com>
> To: Johannes Berg <johannes@sipsolutions.net>, 
> linux-wireless@vger.kernel.org
>
> On 3/24/2022 3:37 AM, Johannes Berg wrote:
>>
>> (and also, you included all kinds of random other things in these
>> patches, specifically in nl80211.h, so there's no way I can apply them
>> as is anyway)
>>
>
> I had added the other nl80211 parts to match local user-space
> nl80211 order during testing, forgot to take it out.
>
> Let's discuss once your client side version is sent out.
>
> Thanks.


9.4.2.45 Multiple BSSID element (excerpts from Draft 2.0 version)
The Timestamp and Beacon Interval fields, TIM, DSSS Parameter Set, IBSS 
Parameter Set, Coun
try, Channel Switch Announcement, Extended Channel Switch Announcement, 
Wide Bandwidth Channel Switch, Transmit Power Envelope, Supported 
Operating Classes, IBSS DFS, ERP Informa
tion, HT Capabilities, HT Operation, VHT Capabilities, and VHT 
Operation, S1G Beacon Compati
bility, Short Beacon Interval, S1G Capabilities, and S1G Operation, HE 
Capabilities, HE 6 GHz Band Capabilities, HE Operation, BSS Color Change 
Announcement,
and Spatial Reuse Parameter Set , EHT Capabilities, and EHT Operation
elements are not included in the Nontransmitted BSSID Profile 
subelement; the values of these elements for each nontransmitted BSSID 
are always the same as the corresponding transmitted BSSID element values.




Hi Johannes,


I am looking at the change in design and i see the below concerns.

While a BSS level RU puncturing gives the flexibility of configuring 
different puncturing bitmaps in MBSSID scenario, the same cannot be 
advertised on a per BSS basis over the beacon to the stations trying to 
associate with the AP. (with reference to text above from Spec)

1. There is a only one EHT operation element (which holds the disabled 
subchannel bitmap) that can be announced in a MBSSID beacon.
     The spec doesn't allow to announce EHT operation on a per BSS basis.
2. Having a ru_puncturing_bitmap at the chandef level for the AP mode 
could also help us decide easily whether DFS is needed or not (Skip DFS 
if the dfs channels are punctured) .  Having RU puncturing at BSS level 
could again lead to confusion if certain BSSes of a single phy are 
configured with different RU puncturing bitmaps some including the DFS 
channel and some puncturing out all the  DFS channels.

Shall we retain the RU puncturing bitmap at chandef level for the AP 
mode and keep the RU puncturing bitmap at BSS level for the STA scenarios?


From: Johannes

that's probably a discussion better had on the mailing list, rather than 
long-form chat here? :)

not sure it's easy to do with AP/client modes different since we also 
have AP + client concurrency scenarios


Hi Johannes,

I have captured the offline discussions above to set the context for others.

Even in the AP & STA concurrent scenario, i believe this approach should 
work.
     1. In the STA case, The STA shall use the puncture pattern from its 
BSS conf for all transmission to its connected AP.
     2. In the AP case ( MBSSID case as well), the AP  shall use the 
puncture pattern from the chandef while it transmits frame to its 
connected stations.
         The chandef ru_punct_bitmap ultimately gets assigned to the 
virtual interfaces at the driver when virtual interfaces are created.
         The AP vif shall use the value to control the transmissions to 
all its connected stations.
         Since the ru_punct_bitmap is announced over EHT Operation IE, 
the connected stations would limit its transmission only to the 
non-punctured channels.


Could you please share your comments on the above approach?


Thanks

Maha

