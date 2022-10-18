Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC516602767
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJRIqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJRIqK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 04:46:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C26242
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 01:46:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I74gCi018496;
        Tue, 18 Oct 2022 08:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L5jCjMpDzZ03jpPZWSRZ+HovW1q0xDO1nNMxbrDfvx4=;
 b=gAPiY+JnlX223e0G6Pu3kPhnkJ9KZwKV+Kky+teqYRZSP4U8ERNasGEdED+7M7reU/LU
 LuHzAzsbQ0dTam/tr9CjgTT434upF5Co6yOJz+TwIrGzO7MsnHsHmtHmCcMDDmTCy9to
 dh2o+RdB8GuhCWmAmENoa8GR+/j+p7F6Wd4odr0Z6bN0K48D0CImDtC6QavqQ2AWSROo
 eTVl7ywwvZUO6TPDy1LA9EKMuYUOPxG3jqABFqcWg5L4d+PE/FtDoLmOXt08qJf7fkK5
 vpGytfSA/inP8cU6/RR/7pu649sOS0JUZaVxKik+fTJLTHXkBRhFBK2NUaQY434gz78Y 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9hnb0yrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:45:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I8jwLf016827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:45:58 GMT
Received: from [10.253.75.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 01:45:57 -0700
Message-ID: <4630025f-5cbf-1b5c-cd73-2797d10ec81e@quicinc.com>
Date:   Tue, 18 Oct 2022 16:45:55 +0800
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
 <191042d8-7781-808f-71aa-db76ed763bec@quicinc.com>
 <dbb569976328b5442c6373a8aaacfec9a157ac56.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <dbb569976328b5442c6373a8aaacfec9a157ac56.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LR7ud1brEowB-9OwXw-scJidQguXLuP1
X-Proofpoint-GUID: LR7ud1brEowB-9OwXw-scJidQguXLuP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=909 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/17/2022 4:14 PM, Johannes Berg wrote:
> On Mon, 2022-10-17 at 16:12 +0800, Wen Gong wrote:
>>> I guess valid links wasn't set at that point yet?
>>>
>>> Anyway should also move out of rate_control_rate_init() and probably
>>> into something like ieee80211_assoc_config_link()? That already does
>>> some rx_nss calculations which is probably not great ...
>> OK. I will test with my change internal now. And replace to use upstream
>> change
>>
>> after someone fix it.
>>
> Well, I think you should try to fix it and submit the patch, I'm not
> going to do it in the short term ... :)
unfortunately I am also busy at other place in at present:).😁
>
> johannes
