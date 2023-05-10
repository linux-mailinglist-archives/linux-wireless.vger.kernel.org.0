Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A96FDC52
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEJLIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbjEJLHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 07:07:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A00868D
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 04:06:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AAsbWx008015;
        Wed, 10 May 2023 11:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JErtuWGSqc9V/q5r1R29GLPFC1WZUCfCZdCNnlP7EIM=;
 b=Ml5IXZC88tHbnHct7Ld6elsVog9bIq/GQiZJWpuvfWlLPvrJP0+a0QhOrc3VF9T6mNoY
 l90AQg+PiJBl6cek77IOQ3eVKfwKOR20TtJF/ELjvMjwC12WjlCVv4zlPsMepWPqidOz
 YNtId1EQ/yenJvno+CY3w0WLXfOHPO/nMdKw2ZzJqf81tEnJDpkFoIb5dtrezAS1ll/y
 03DorwFVvlOfx3h2EmjIW8vh7LddoYN3u45c7Y0x79ZB3oNRSTHKJKVLU6DhFMXA8G0b
 PivZC4a2sLISMae2e3GFoDbYw421ab5/vLW2qrOLTQh5NXZLLah1qugaQ9TXHgx9P7u8 Sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfr50a3cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 11:06:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AB6OMK026829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 11:06:24 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 04:06:23 -0700
Message-ID: <5e3ec5f8-1462-5de6-2b5a-4cf62f23deb7@quicinc.com>
Date:   Wed, 10 May 2023 19:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
 <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iTg8xEAHFCIE9xGewc8cQWQDWxFhX5GP
X-Proofpoint-ORIG-GUID: iTg8xEAHFCIE9xGewc8cQWQDWxFhX5GP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=878 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100088
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/2023 3:38 PM, Johannes Berg wrote:
> On Tue, 2023-04-04 at 11:28 +0800, Wen Gong wrote:
>> May I also add a field such as "u16 active_links_count" in struct
>> wiphy_iftype_ext_capab,
>> and add logic in function ieee80211_set_vif_links_bitmaps() for station
>> like this ?:
>> if (active_links_count && hweight16(links) <= active_links_count)
>>       then sdata->vif.active_links = links;
>>
> Also here, not sure it makes sense in cfg80211 level?
>
> Though I'm not sure what the idea here is at all - you can refuse to
> link switch etc, what would you use this for?
>
> Then again, we haven't really designed out all the link selection stuff,
> do we want wpa_s to do it, driver to do it, etc.? Hence debugfs. So
> depending on what end up doing there, we will obviously need to
> advertise some level of link-concurrency to userspace.

So will you plan to do something to let wpa_s/userspace app 
active/deactive links?

Or you already have implemented that?

>
> johannes
