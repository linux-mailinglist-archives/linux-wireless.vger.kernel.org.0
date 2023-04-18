Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E366E5CBD
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDRJCw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDRJCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:02:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246F4216
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:02:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6rXVt001531;
        Tue, 18 Apr 2023 09:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l/0BZGTzjvZ6dX24FI/6K0xb+b3mKb3sBi5RawShN7c=;
 b=H1b+DFg5tdpQybiNh5YlsdlVecBr8uZ0M1WUp+/GZCIiWa3SgYYhSqEsu7grGM/IZAxj
 q19F3jDxlvhCCv/qsUlRcNpFpXcuCHnXmSopFQEm6okAYuL0VhysILCUlEHpGJk2Y6aT
 pquzZwp18Mp1n+gCDcW88LDADOxpwsR0ONTZmUSWdRB4ATG0/mkVceT6R7HwwTzwc4yG
 xnPDsxUrxqH9AC2ZuRL0sTKb/DonXEuKEXp6VPa0H9bgY3Z4tn/Wngwc04BKJEjH3hQ3
 d+lpXzpFw1queS4TjFwyzgByo4mgLtXMDy1ma9A6Cwn/MJCAn+k2oZTbmVCX2hMSCNXU Eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nf8gc5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:02:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I92iJx020523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:02:44 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:02:43 -0700
Message-ID: <2842f57c-e383-fb9e-d994-95336cb65e0d@quicinc.com>
Date:   Tue, 18 Apr 2023 17:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e40ee96ab2a8d9d079d3a06b7b1c615ab25a2403.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hT7ueim_ejWawQJLZ-42Dgb8gZuC8mMQ
X-Proofpoint-ORIG-GUID: hT7ueim_ejWawQJLZ-42Dgb8gZuC8mMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180077
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 4:48 PM, Johannes Berg wrote:
> Hi,
>
>> My case is:
>> When connect with 2 links AP, the cfg80211_hold_bss() is called by
>> cfg80211_mlme_assoc()
>> for each BSS of the 2 links,
>>
>> When asssocResp from AP is not success(such as status_code==1), the
>> ieee80211_link_data of 2nd link(sdata->link[link_id])
>> is NULL because ieee80211_assoc_success()->ieee80211_vif_update_links()
>> is not called.
>>
>> Then struct cfg80211_rx_assoc_resp resp in cfg80211_rx_assoc_resp() and
>> struct cfg80211_connect_resp_params cr in __cfg80211_connect_result()
>> will only have the data of
>> the 1st link, and finally cfg80211_connect_result_release_bsses() only
>> call cfg80211_unhold_bss()
>> for the 1st link, then BSS of the 2nd link will never free because its
>> hold is awlays > 0 now.
> Hah, yes, ouch.
>
>> I found it is not easy to refine it, so do you have any advise/idea?
>>
>> for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>>           struct ieee80211_link_data *link;
>>
>>           link = sdata_dereference(sdata->link[link_id], sdata);
>>           if (!link)
>>               continue;
>>
>>           if (!assoc_data->link[link_id].bss)
>>               continue;
>>
>>           resp.links[link_id].bss = assoc_data->link[link_id].bss;
>>           resp.links[link_id].addr = link->conf->addr;
>>           resp.links[link_id].status = assoc_data->link[link_id].status;
>>
> But is it really so hard? We only need link for link->conf->addr, and we
> can use assoc_data->link[link_id].addr for that instead, no? We need to
> store those locally to avoid a use-after-free, but that's at most 15
> addresses on the stack, which seems acceptable?
>
> Oh and there's the uapsd stuff but that only matters in the success case
> anyway. In fact I'm not even sure the address matters in the
> unsuccessful case but we have it pretty easily.
>
> johannes
OK. So I guess you already have good way to refine it?
