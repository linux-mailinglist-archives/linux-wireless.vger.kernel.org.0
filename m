Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743506D5735
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 05:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDDD3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 23:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjDDD3F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 23:29:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCE19AB
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 20:29:03 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3340Z4SI003797;
        Tue, 4 Apr 2023 03:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V1j893hACUTw9r0p8d8gMQXdB00Y80DLJrGvSl1tZ0U=;
 b=mAv13cvigqOEMZp0u6bU5jr3QXMJsCXInT8ii4xspIbd4pXLWjL5f1okUPWSUc+oBBQW
 4Q+xs+NTV7FsgynpYM6uZYzFWsVo6Dq6E5FmOH+YGHHFnydT+qbztjENe3ZmtTvC8UXI
 oGM3w+jl46B45yJ4UfbHob2b8ph54sOJV2cOrdPtIgHpW8X28gNdG9OJnEjBu+xZxCol
 gjxtct7uK57eU8jGBJqFs3tKFgX2lvf34/J/DbpXQ+n72hHn5eEu8M3Mn9lED7MZ78A8
 0jEh7v4DjHHw9d0rJ9ZwvTwcOD7sVDAAEzsKyb7uTZbWN5mKoeXHGKL+5ErDQbJwuInj 1w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtdnajgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 03:28:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3343Si9Y020209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 03:28:44 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 20:28:43 -0700
Message-ID: <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
Date:   Tue, 4 Apr 2023 11:28:40 +0800
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dGbWrLjfc6vzCpyOKhiAy9uoOPjMnv9K
X-Proofpoint-GUID: dGbWrLjfc6vzCpyOKhiAy9uoOPjMnv9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040030
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/8/2022 11:36 PM, Johannes Berg wrote:
> On Thu, 2022-09-08 at 23:23 +0800, Wen Gong wrote:
>> Now I found it only active the primay link(the link for
>> authentication/assoc request) in my station MLO test,
> Yes, that's intentional. It gives the driver choice about which links to
> activate; first of all because we don't have interface/link combinations
> stuff yet (waiting for your side on that), and secondly because we might
> very well (want to) negotiate more links than we can concurrently have
> active, e.g. a NIC that can have two active might still want to
> negotiate four and switch dynamically.
>
>> change_vif_links of struct ieee80211_ops *ops of driver will only be
>> called one time for the primary link.
> Correct.
>
>> it means only one link for MLO.
> Right.
>
>> I plan to revert this patch in my local test now.
>>
>> Will you implement muti-links later?
> Yes. I have patches pending to add API that the driver can call to pick
> the active links (as a bitmap).
>
> I'll send it out when I can, likely tomorrow.
>
> johannes
The patches should be "wifi: mac80211: implement link switching" for 
ieee80211_set_active_links().

May I also add a field such as "u16 active_links_count" in struct 
wiphy_iftype_ext_capab,
and add logic in function ieee80211_set_vif_links_bitmaps() for station 
like this ?:
if (active_links_count && hweight16(links) <= active_links_count)
     then sdata->vif.active_links = links;
