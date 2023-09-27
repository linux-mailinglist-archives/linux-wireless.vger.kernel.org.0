Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319BA7B0B96
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjI0SDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjI0SDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 14:03:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B7A1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 11:03:31 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RE8M7w030246;
        Wed, 27 Sep 2023 18:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5ci5D/l1rMpQFW8/P1CYrRSQKPA6FGzjNAKvDgfqRXI=;
 b=LyV2b1xMj93fyb3fX8x2KM49+XnH5H18xvPEjaAbShNUOso0LvMztD+ucmKyVGopz26J
 gMc1JWLq0Zaclucik6zNpi/ViXuv01NFYExTYTdYcyXz2Eh6GxF9K4JI2N23gg5XvVrw
 ATPMRT4FasJg+of3WDV1WMdWEy5H/ebZ0Cj8jnim5qU6qcAX0CA5c6b1/x3/QUpLcWg4
 iYS4ig14oTaMQCxf1PCpZed3A8pP8igaI8xsFKDvbIZaQLLnkr+Mrr9EE85UZtCv+uDz
 VhjHkgPgzjJh/XBZ22/g8COVblAg0nPv8N9JRqFmZy8xLbpDkXIAGnG7N9bJXZCdizWm vA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc6hrt7pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 18:03:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RI3RCu016438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 18:03:27 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 11:03:26 -0700
Message-ID: <3f2323b2-de9e-4f1d-b302-cc20c15bc105@quicinc.com>
Date:   Wed, 27 Sep 2023 11:03:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: remove set_fils_aad support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230926160950.d698c25528e3.If118a835a25c59de20e1728ab71949fdb4172fb2@changeid>
 <9ddcbc2f-5e40-48cd-bdbd-943bd86acb61@quicinc.com>
 <9a544a1b9385a150f779ac35a780dbb50200a962.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <9a544a1b9385a150f779ac35a780dbb50200a962.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eRwPg6rN5IAQwLdE_-TelGVadGOguS_v
X-Proofpoint-ORIG-GUID: eRwPg6rN5IAQwLdE_-TelGVadGOguS_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/27/2023 12:00 AM, Johannes Berg wrote:
> On Tue, 2023-09-26 at 13:35 -0700, Jeff Johnson wrote:
>> On 9/26/2023 7:09 AM, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> There's no user for this, so remove the support.
>>>
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> if you are going to remove it, why not just revert e306784a8de0
>> ("cfg80211: AP mode driver offload for FILS association crypto") to make
>> sure you get all of the artifacts? for example, I believe your patch
>> will leave behind an unused struct cfg80211_fils_aad and unused
>> FILS_AAD_ASSIGN() trace helper macro.
> 
> Hah, good point, I didn't do this well.
> 
>> the caveat to reverting is that it should only be a partial revert; the
>> UAPI definitions would need to be retained (and should be documented as
>> obsolete).
> 
> Yeah, that's why I didn't do it as a revert.
> 
>> however, let me check to make sure there is no plan to actually utilize
>> this interface upstream. as i've indicated earlier, we are in the
>> process of trying to transition to an "upstream first" mentality, but
>> this is not going to happen overnight, but instead will take years. that
>> said, i'd hate to rip out an interface now just to need to add it back
>> in the future.
> 
> Sure. I don't mind keeping something around that really _has_ a future,
> but it's been two years and nobody showed up ... but yeah, I also think
> that "has a future" means upstream.
> 
> And clearly the old "other people can use it" argument doesn't work any
> more either, the only other vendors who are doing something in AP mode
> are Mediatek and maybe to some extent Realtek, and they all work on top
> of mac80211 with thinner firmware. Broadcom has disappeared as far as I
> can tell, with the occasional patch like recently that I'm also
> suspecting serves pure out-of-tree driver purposes...

Based on internal discussion I don't see a path forward to using this 
interface upstream, so please continue with the extraction, 
incorporating my prior comments.

Thanks!
/jeff
