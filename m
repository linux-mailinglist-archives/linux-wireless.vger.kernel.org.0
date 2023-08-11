Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73072778A65
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjHKJy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjHKJy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:54:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A626B6
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:54:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B4vDM9029032;
        Fri, 11 Aug 2023 09:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=czV3SHta8Iw3Ga3vbsaBj6VIqSHhqc4SyELz2wDepHk=;
 b=ZUo3F59eHX6qssrWlLoNsr9odQimEJVjCop1DvDFpZ2J2A28SA3QeMCrACmTsND5MbWp
 dlVGlsVp6rWNiaAadzJqcLYVsI4jfqCCDv6WlvXHZYKWi7Y9e1ecX1Paa/Ssg46ZxPew
 4j99lw5TB/sWIZuav3fiQrfiw07TzBdmYHGMHr8LXY+xRf8ZKRBkPD2f914aljf7d3F/
 LW1Fsh/aAnZ5SkdTK/BMZekncW0NRi84t4M6gzPI/klkz1M3NOOlKhHbWmv5oHXnzaP7
 2rtvlPRQkrIfcobXu09lGq6T6ZTmkiGwW88sszqwXu9xe4wmXfpt+8T/TS0mBMxrnvZs wA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ywh9en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:54:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B9sItM029246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:54:18 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 02:54:17 -0700
Message-ID: <f29e5ba9-ef30-b954-7608-79604930ac1c@quicinc.com>
Date:   Fri, 11 Aug 2023 17:54:14 +0800
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
 <29ab2b41-0adf-3a04-6eb9-3d5666253eb9@quicinc.com>
 <1ec93eca79a7bc96c1498b771c3b6ea2ebc78d95.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <1ec93eca79a7bc96c1498b771c3b6ea2ebc78d95.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G3XRzibD2U1mNEub9tecomQdaCxohTIo
X-Proofpoint-GUID: G3XRzibD2U1mNEub9tecomQdaCxohTIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=532 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110089
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/11/2023 5:27 PM, Johannes Berg wrote:
> On Fri, 2023-08-11 at 17:24 +0800, Wen Gong wrote:
>
[...]
> OK, at least that answers the question what you'd want to do with it :)
>
>> For dynamic link change, it is another new topic, so I have not good advise
>> for that.😁
> But everyone's looking at that?
I see there hare some patches in mac80211/cfg80211 for dynamic link 
removal such as
"wifi: mac80211: Support link removal using Reconfiguration ML element". 
For link
removal, it does not effect the EML issue I said. Only link add 
operation without (re)assoc
(35.3.6 ML reconfiguration of IEEE P802.11be™/D3.2 disallow (re)assoc 
for link add)
will impact the EML issue I said. But I did not see dynamic link add 
patch now. Will
you also do the patches for dynamic link add without (re)assoc?
>
> Honestly I'm not even sure - and you might know better - what the EML
> capabilities matter for if you never enable EML.
>
> So almost feels like if you never send the EML OMN frame (thanks for the
> name!) the AP wouldn't really care, and that's something you could do
> very easily without changing it, i.e. you pretend that your 2.4 GHz
> actually has EML, you just never enable it in case 2.4 GHz is active?
Your advise maybe feasible. Then no change is needed in nl80211 here for 
the EML.
> johannes
