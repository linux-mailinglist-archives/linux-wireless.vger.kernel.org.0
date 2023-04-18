Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15CF6E5D50
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDRJ1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjDRJ1t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:27:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F061170E
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:27:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6sfQJ007777;
        Tue, 18 Apr 2023 09:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8faAlypLPe1e1HG5LWGx9Kos22aWupKEa2+SCiIc3BY=;
 b=HlKE1Qtvg1OTwrxyQXX5elS6crzWoL7G/IcMbBtRkuqjVFq1BkKjiySiK1Dk9TgSoUA8
 53HrPKUv08b2FawtfzRIq/okz79AkHlHwLEQauxTYl7t4Mrahn/mmuw7bopx2iJo3Qm1
 N+FgB3EnSopctOJIJOTvsmqYMfIr8BcFDj+LMGIyvXzJx9Foqgp3pSegCiHwJ0BrrEyG
 tR2hcs6zLUwQ0o5oQDZ+a9DVYtx1DQUuLpK4duTa5uUo/cw46GLSfbte0bYA1R+pomXv
 kdf2J0LVJPB3haamap2S7eHmRJoR5F41yv81t5xW8Y/nDd6oM6Rbk3PsE0Tjth4jqt30 XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171gjcfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:27:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9RgU2021421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:27:42 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:27:41 -0700
Message-ID: <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
Date:   Tue, 18 Apr 2023 17:27:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
 <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
 <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DcFUHiZoGWDi28eYYFOkGGXldT-H-5rX
X-Proofpoint-ORIG-GUID: DcFUHiZoGWDi28eYYFOkGGXldT-H-5rX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=744 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180081
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 4:18 PM, Johannes Berg wrote:
> On Mon, 2023-04-17 at 22:13 +0800, Wen Gong wrote:
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
>> If I use ieee80211_set_active_links(),
>> then I need add BSS_CHANGED_ASSOC and key for 2nd link in lower-driver.
>>
>> I would like to active all links while assoc,
>> then BSS_CHANGED_ASSOC and key will auto set for the 2nd link to
>> lower-driver from mac80211.
> I'm not convinced that makes sense. You're going to have to be able to
> deal with changing links after association _anyway_, unless you plan on
> breaking the entire connection once any of the links is getting out of
> range or something?
>
> So anyway you're going to have to be able to this for new links anyway?
> I mean doing key management when link switching, and "association" (in
> quotes, because as a term doesn't even make sense since this state is on
> the MLD level, not the link level)...
>
> So not sure I get it?
>
> johannes

Yes, you are right.

Now lower driver I used do not store the key and do not trigger
BSS_CHANGED_ASSOC for new links after assoc.

So my suggestion is a way to active all links while assoc, this way is 
simple for lower driver I used.

Also ieee80211_set_active_links() is another way to active all links 
after assoc.

