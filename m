Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCFA6FF056
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbjEKLBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbjEKLBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 07:01:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94912101
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 04:01:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BACVWU032335;
        Thu, 11 May 2023 11:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WKy8kmBhpVPjti8A8Z4JIB9qnscpRMGvPXjfG+OpgcQ=;
 b=Eqafg5qDJVO5H2dR0rO80xfjrtwNTPyV0gTIOrWqLJ25PLECAYBnQ2hwRNmVAoPZiaHK
 GCHWscXMDGioaqQpjoOa9GWzq+Fue2KS5zQwxrHaTDU1QB9DTM0dYR2gG4XYMadLJnvY
 NAkH56rtLN6BhEnt6+NB6ApNspxzksXmF6U6s5n0wvKet0WnJGZdljYidxDG8lOOXnN3
 LwCOMD40FH9g68strwCStG4uYdzhQLkSqVScorGpniidYBs/9/qGigz2OfOnPM52nKyB
 Y2MYS9vDRT4qG80yxdyDytatG2bnkqMcvbPHUJgDkNpOo2qfiVWaDSdV4LsVvUblPBp7 Xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qged2j0w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 11:01:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BB1QhY009435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 11:01:26 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 11 May
 2023 04:01:25 -0700
Message-ID: <2d3a6578-68c5-a0f3-b18b-bce2e67d3fdc@quicinc.com>
Date:   Thu, 11 May 2023 19:01:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
 <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
 <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
 <e40ee96ab2a8d9d079d3a06b7b1c615ab25a2403.camel@sipsolutions.net>
 <2842f57c-e383-fb9e-d994-95336cb65e0d@quicinc.com>
 <6a33a41b5aa6c98d95ff934fbb6a10dfe78e6e6e.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <6a33a41b5aa6c98d95ff934fbb6a10dfe78e6e6e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IBxAePh062ioRr7AhY3I3HG7yodxVpkS
X-Proofpoint-GUID: IBxAePh062ioRr7AhY3I3HG7yodxVpkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110094
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 5:11 PM, Johannes Berg wrote:
> On Tue, 2023-04-18 at 17:02 +0800, Wen Gong wrote:
>> On 4/18/2023 4:48 PM, Johannes Berg wrote:
>>> Hi,
>>>
>>>> My case is:
>>>> When connect with 2 links AP, the cfg80211_hold_bss() is called by
>>>> cfg80211_mlme_assoc()
>>>> for each BSS of the 2 links,
>>>>
>>>> When asssocResp from AP is not success(such as status_code==1), the
>>>> ieee80211_link_data of 2nd link(sdata->link[link_id])
>>>> is NULL because ieee80211_assoc_success()->ieee80211_vif_update_links()
>>>> is not called.
>>>>
>>>> Then struct cfg80211_rx_assoc_resp resp in cfg80211_rx_assoc_resp() and
>>>> struct cfg80211_connect_resp_params cr in __cfg80211_connect_result()
>>>> will only have the data of
>>>> the 1st link, and finally cfg80211_connect_result_release_bsses() only
>>>> call cfg80211_unhold_bss()
>>>> for the 1st link, then BSS of the 2nd link will never free because its
>>>> hold is awlays > 0 now.
>>> Hah, yes, ouch.
>>>
>>>> I found it is not easy to refine it, so do you have any advise/idea?
>>>>
>>>> for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>>>>            struct ieee80211_link_data *link;
>>>>
>>>>            link = sdata_dereference(sdata->link[link_id], sdata);
>>>>            if (!link)
>>>>                continue;
>>>>
>>>>            if (!assoc_data->link[link_id].bss)
>>>>                continue;
>>>>
>>>>            resp.links[link_id].bss = assoc_data->link[link_id].bss;
>>>>            resp.links[link_id].addr = link->conf->addr;
>>>>            resp.links[link_id].status = assoc_data->link[link_id].status;
>>>>
>>> But is it really so hard? We only need link for link->conf->addr, and we
>>> can use assoc_data->link[link_id].addr for that instead, no? We need to
>>> store those locally to avoid a use-after-free, but that's at most 15
>>> addresses on the stack, which seems acceptable?
>>>
>>> Oh and there's the uapsd stuff but that only matters in the success case
>>> anyway. In fact I'm not even sure the address matters in the
>>> unsuccessful case but we have it pretty easily.
>>>
>>> johannes
>> OK. So I guess you already have good way to refine it?
>>
> No, not really, was just thinking out loud here :)
>
> johannes

Hi Johannes, if you have any patch to fix it, I can download and test.

