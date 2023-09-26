Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341B67AEAA7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 12:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjIZKoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIZKoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 06:44:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6DBE9
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 03:44:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q8rtAI001828;
        Tue, 26 Sep 2023 10:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x/q0yrM9dUprVMkYwxIKy/DQhFhc/xipxRZbvbeXGv0=;
 b=p1SiBXxy80KcVRYK/5dzTAlYtkbBW7Z+hC9ydsfVckU4ui5zYYJzWWw0KBhb5eAKdEy7
 iYYU6s5L3s9lehcJ4aL5xxdsQfGYNmG43z0ue21IlxM2A+FaL1Aunrne5X8uGwwncoTB
 mvfgon2123E+8x6rMseVE09zPRD4u3BruvVrc6GdBKFOKURATx8i6uLyxwcjw+S9m+3x
 vO5VIl2r6EOsKXRdUAe6Z8ZeFlSu328FXvjk6gmSu2GzI+uIHI9FhpYqDpgT7ClzlCgj
 u24+pJXCSpWXPo4ADYho+4gTgAbjKhH6yLOpo1wZV3j4ziWa9rLXbGBNMUcE4Slgb9UD EA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbv6608d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:44:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QAi6al011514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:44:06 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 03:44:04 -0700
Message-ID: <7ac4b560-26d5-2125-b1be-2f1313097d0a@quicinc.com>
Date:   Tue, 26 Sep 2023 18:44:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] wifi: mac80211: add support to allow driver to
 generate local link address for station
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
 <20230906103458.24092-2-quic_wgong@quicinc.com>
 <cd762f33b1c15566237c85f1e265ee8a00006f5c.camel@sipsolutions.net>
 <d23b617e-5ca0-e721-0c2a-fcca8942efef@quicinc.com>
 <4dac29f3844309fb62afe6acd4c4ebd379b0a194.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4dac29f3844309fb62afe6acd4c4ebd379b0a194.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5nA07PYgGmmMpwjJPJydCHI-2JUuDcbM
X-Proofpoint-GUID: 5nA07PYgGmmMpwjJPJydCHI-2JUuDcbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=487 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260091
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/26/2023 5:45 PM, Johannes Berg wrote:
> On Fri, 2023-09-15 at 16:11 +0800, Wen Gong wrote:
>> On 9/13/2023 4:55 PM, Johannes Berg wrote:
>>> On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
>> [...]
>>> Maybe after all this explanation, all we need is a flag "reuse MLD
>>> address for assoc link"?
>> yes. It is similar as I said before here:
>>
>> https://lore.kernel.org/linux-wireless/b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com/
>>
>>>
>>>> +		ret = drv_generate_link_addr(sdata->local, sdata,
>>>> +					     link_id, link->conf->addr);
>>>> +		if (ret)
>>>> +			eth_random_addr(link->conf->addr);
>>> should probably refactor this into a separate function though.
>> OK.
>>> I'm also not sure how the driver even knows that a link it's being asked
>>> to get the address for *is* the assoc link? Do you want to rely on that
>>> being the first address handed out?
>> Current I used (vif->valid_links==0) check for assoc link. When
>> drv_generate_link_addr() called for the assoc link, vif->valid_links
>> is 0, and it is not 0 for other links.
> That seems a bit questionable?

Also we can change to indicate a new flag(e.g. 
IEEE80211_HW_MLO_FIXED_ASSOC_LINK_ADDR) to

mac80211 from driver, if the flag is not set, then keep current logic.

If it is set, then copy vif->addr to the link->conf->addr for assoc link 
in ieee80211_mgd_setup_link().

The logic keep not change for other links.

> Well then again, what do you want for AP mode? Anyway you can still
> distinguish, and if we later need to change an internal API that's not
> the end of the world either ...
I do not want any change for AP mode.
>
> So OK, I guess we can live with this, just would like to see it wrapped
> up into a single function.
>
> johannes
