Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33373762B70
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGZGa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGZGa5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 02:30:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C874D1BC2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 23:30:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6SimZ029697;
        Wed, 26 Jul 2023 06:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oPOa//Mz6tsLcfVUiNna+BXRH2ABp9hZJUaMJLoFyOs=;
 b=jqHAVPrRO5WGj6LWWF40QEv4ihppULL8Wws7f3aZm3J6KMyq9jZj/QAVf4hiBrA5w4gk
 z3eby7gXfOoPtfNpMVGLtUCSPNXjKYfcavXrpLANpMIwNYxay5ombQSuDQe4l71FLHz3
 gXf+KIb9D5MoICwHL6brZjoaAeUaYUXnqXxl3gi9h0M2QepTSCsuTLr1WIbOCU1wxupM
 4C2ap+f69n1ZiD9tIhx+d/vah4l8nyG8C/rXCEfg4rmN7rXPSCbBT5bCo4cyVaAGWUD3
 4dxBq9xjAl1gbyNXHUctZj+G4LgOi1N/NwpkyYcpkfJOayEqabhVpYbCpIxuMSTiu5zo rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8tdbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:30:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q6UkR6027913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:30:46 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 23:30:45 -0700
Message-ID: <b5de662d-fd49-7b94-f617-89d4761c175b@quicinc.com>
Date:   Wed, 26 Jul 2023 14:30:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
 <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
 <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
 <e40ee96ab2a8d9d079d3a06b7b1c615ab25a2403.camel@sipsolutions.net>
 <2842f57c-e383-fb9e-d994-95336cb65e0d@quicinc.com>
 <6a33a41b5aa6c98d95ff934fbb6a10dfe78e6e6e.camel@sipsolutions.net>
 <2d3a6578-68c5-a0f3-b18b-bce2e67d3fdc@quicinc.com>
In-Reply-To: <2d3a6578-68c5-a0f3-b18b-bce2e67d3fdc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -7wk_xVlqXn2Wo4aCQ6tZd-eXOgfxoNA
X-Proofpoint-GUID: -7wk_xVlqXn2Wo4aCQ6tZd-eXOgfxoNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I guess you have already fix it in some patch, right?

On 5/11/2023 7:01 PM, Wen Gong wrote:
> On 4/18/2023 5:11 PM, Johannes Berg wrote:
>> On Tue, 2023-04-18 at 17:02 +0800, Wen Gong wrote:
>>> On 4/18/2023 4:48 PM, Johannes Berg wrote:
>>>> Hi,
>>>>
>>>>> My case is:
>>>>> When connect with 2 links AP, the cfg80211_hold_bss() is called by
>>>>> cfg80211_mlme_assoc()
>>>>> for each BSS of the 2 links,
>>>>>
>>>>> When asssocResp from AP is not success(such as status_code==1), the
>>>>> ieee80211_link_data of 2nd link(sdata->link[link_id])
>>>>> is NULL because 
>>>>> ieee80211_assoc_success()->ieee80211_vif_update_links()
>>>>> is not called.
>>>>>
>>>>> Then struct cfg80211_rx_assoc_resp resp in 
>>>>> cfg80211_rx_assoc_resp() and
>>>>> struct cfg80211_connect_resp_params cr in __cfg80211_connect_result()
>>>>> will only have the data of
>>>>> the 1st link, and finally cfg80211_connect_result_release_bsses() 
>>>>> only
>>>>> call cfg80211_unhold_bss()
>>>>> for the 1st link, then BSS of the 2nd link will never free because 
>>>>> its
>>>>> hold is awlays > 0 now.
>>>> Hah, yes, ouch.
>>>>
>>>>> I found it is not easy to refine it, so do you have any advise/idea?
>>>>>
>>>>> for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>>>>>            struct ieee80211_link_data *link;
>>>>>
>>>>>            link = sdata_dereference(sdata->link[link_id], sdata);
>>>>>            if (!link)
>>>>>                continue;
>>>>>
>>>>>            if (!assoc_data->link[link_id].bss)
>>>>>                continue;
>>>>>
>>>>>            resp.links[link_id].bss = assoc_data->link[link_id].bss;
>>>>>            resp.links[link_id].addr = link->conf->addr;
>>>>>            resp.links[link_id].status = 
>>>>> assoc_data->link[link_id].status;
>>>>>
>>>> But is it really so hard? We only need link for link->conf->addr, 
>>>> and we
>>>> can use assoc_data->link[link_id].addr for that instead, no? We 
>>>> need to
>>>> store those locally to avoid a use-after-free, but that's at most 15
>>>> addresses on the stack, which seems acceptable?
>>>>
>>>> Oh and there's the uapsd stuff but that only matters in the success 
>>>> case
>>>> anyway. In fact I'm not even sure the address matters in the
>>>> unsuccessful case but we have it pretty easily.
>>>>
>>>> johannes
>>> OK. So I guess you already have good way to refine it?
>>>
>> No, not really, was just thinking out loud here :)
>>
>> johannes
>
> Hi Johannes, if you have any patch to fix it, I can download and test.
>
