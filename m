Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05E6FDDC2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjEJMZR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjEJMZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 08:25:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE0F1
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 05:25:13 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ABD4dO009190;
        Wed, 10 May 2023 12:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kY+qCZY9zsqCirQ76ORKCt5A0pN2zqswkApy+5L+cDQ=;
 b=KsLn+sVZ1ei0JRZjtg9IWcg61lPTabr1Bt3p5sQRSxZ4kijrDimk5MnjGSAp6PyM+BBA
 +/MELtUoqFfqJDbxjnv6tvKZ8dmbJIBbpWV4H6Q1s6Gtx+bKm/YhD1ZvPAQ3wyKHtonH
 HJqSAp/jbys2frSjSoLIAzpEIzO/VBY7TujV5nOuCvsATFkv2E3rpP1YFUN/LniUF7VU
 uY5g+GPooLWtDsejPIJUiI/OAGZKIVtA22vc1tmSV+a/MsVjYq0BRGLFFBu/UCB7APCa
 q5LaZZrSHEHAjc7qY0L5qu+GsN1Kif1Vev5fAYcvP3yRzfFzEyxRQmpExHSCOyW5FrcF Gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrvm22q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 12:25:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ACP6Ce013388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 12:25:06 GMT
Received: from [10.253.78.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 05:25:05 -0700
Message-ID: <de1f920b-66f5-fb0a-47a5-622ba6bbbff8@quicinc.com>
Date:   Wed, 10 May 2023 20:25:02 +0800
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
 <5e3ec5f8-1462-5de6-2b5a-4cf62f23deb7@quicinc.com>
 <0e7023062f44d0ea68625c27cb13731d17857311.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <0e7023062f44d0ea68625c27cb13731d17857311.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BvGK_38CqSnf3veBSI6ZM44VL-9LWegt
X-Proofpoint-GUID: BvGK_38CqSnf3veBSI6ZM44VL-9LWegt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=899 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100097
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/10/2023 7:24 PM, Johannes Berg wrote:
> On Wed, 2023-05-10 at 19:06 +0800, Wen Gong wrote:
>> On 4/11/2023 3:38 PM, Johannes Berg wrote:
>>> On Tue, 2023-04-04 at 11:28 +0800, Wen Gong wrote:
>>>> May I also add a field such as "u16 active_links_count" in struct
>>>> wiphy_iftype_ext_capab,
>>>> and add logic in function ieee80211_set_vif_links_bitmaps() for station
>>>> like this ?:
>>>> if (active_links_count && hweight16(links) <= active_links_count)
>>>>        then sdata->vif.active_links = links;
>>>>
>>> Also here, not sure it makes sense in cfg80211 level?
>>>
>>> Though I'm not sure what the idea here is at all - you can refuse to
>>> link switch etc, what would you use this for?
>>>
>>> Then again, we haven't really designed out all the link selection stuff,
>>> do we want wpa_s to do it, driver to do it, etc.? Hence debugfs. So
>>> depending on what end up doing there, we will obviously need to
>>> advertise some level of link-concurrency to userspace.
>> So will you plan to do something to let wpa_s/userspace app
>> active/deactive links?
>>
>> Or you already have implemented that?
>>
> No plans right now, and honestly not sure what the right thing even is.
OK. For "advertise some level of link-concurrency to userspace", do you 
have any plan/idea?
>
> johannes
