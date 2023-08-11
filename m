Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61FF7789A7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHKJZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKJZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:25:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB731110
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:24:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B46rnl023427;
        Fri, 11 Aug 2023 09:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Fik4AOmkAiuXh6Y+8wsosQLraV2ygOWCdEQUeMqhDYY=;
 b=gu9ErSiLlX0yoIIvBFXrPaqCs53XuhCdDf1eCUJ9s4Jm5Mq2g7ivjkBHjRULMgt0G1Mh
 nT20ANuGwQEI4dV1ugXwPbLLnX3iP0TPORim0R1AHIYuB2M/7ev77YyhAWEMV2o9V6Gw
 rM4L+5tlDkx21y5wqU/bzU9oRkxBB+U2Z+SrG/5DWpWb3tfww5kGlamwVIyr888aA+Gu
 dM0ERT49KiGuV3NGiQF7KBpbnzMxabfiE7GFix/0+DiPxnKHV3uQ6CvDIN/UFbeE00VW
 NBH5PAlZhU2v5LI1RgVioV+0Y2AvCMPZTm7B2QxL6MBKlXP7jvShW+0OZ+iqdfutwXM/ 2Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd90616t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:24:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B9OqIi021984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:24:52 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 02:24:51 -0700
Message-ID: <29ab2b41-0adf-3a04-6eb9-3d5666253eb9@quicinc.com>
Date:   Fri, 11 Aug 2023 17:24:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>, <quic_rkaliapp@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
 <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
 <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
 <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
 <cc6b83eb-ac30-34fc-4827-290a9ae25378@quicinc.com>
 <8627bb8a3dddc33be7f1f97f30fc0f716328ff81.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <8627bb8a3dddc33be7f1f97f30fc0f716328ff81.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gNemDvBs5srueKs-s-6bZx7plnwrq18R
X-Proofpoint-ORIG-GUID: gNemDvBs5srueKs-s-6bZx7plnwrq18R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=632 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110085
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/11/2023 5:08 PM, Johannes Berg wrote:
> On Fri, 2023-08-11 at 17:05 +0800, Wen Gong wrote:
>> On 8/11/2023 5:03 PM, Johannes Berg wrote:
>>> On Fri, 2023-08-11 at 11:51 +0800, Wen Gong wrote:
>>>> Now there are many nl80211_band such as NL80211_BAND_2GHZ/
>>>> NL80211_BAND_5GHZ/NL80211_BAND_6GHZ... In the same interface, if some bands
>>>> support EML, and other bands not support EML, then how to handler this
>>>> case?
>>> But ... these are MLD capabilities, not of the (associated) STA?
>> Yes, I know it.
> Then you can't honestly be suggesting we move "MLD capa and ops" into
> per-band, no?
I know it just now after I send the suggestion😁
>>> So not sure how that would make sense? What would you even _do_ with
>>> that?
>> I think another change is not move "u16 eml_capabilities", and only add
>> a new
>> field "u16 eml_supp_bands" together with the "u16 eml_capabilities", the
>> eml_supp_bands is filled with the bit map of enum nl80211_band. Is that OK?
>>
> And again, what would you do with it? Not advertise EML when you have
> selected links that are not in the map? And if the links change
> dynamically in the future? You'd probably need a bunch of validation for
> that.
For example, for station, NOT support EML on 2 GHz, support EML on 5 
GHz/6 GHz.

When connect to 2/3 links AP, then EML should NOT add in assoc req while 
connect
to AP which is 2 GHz+5 GHz or 2 GHz+6 GHz or 2 GHz+5 GHz+6 GHz.

EML should add in assoc req while connect to AP which is 5 GHz+6 GHz.

For dynamic link change, it is another new topic, so I have not good advise
for that.😁
>
> And usually you'd probably always connect to all the bands?
>
> I really don't get it.

Sometimes AP is 3 links (2 GHz+5 GHz+6 GHz), but station only support 2 
links,

then station will not connect all bands, station need choose 2 bands to 
connect.

>
> Btw this is all client - so your client implementation can just not send
> the EML action frame (forgot the name right now) when the currently
> active links are not compatible.
I guess you are refer to "EML Operating Mode Notification frame".
> johannes
