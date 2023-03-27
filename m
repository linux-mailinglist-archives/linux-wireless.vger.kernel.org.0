Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756A6C9F04
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjC0JKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjC0JKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 05:10:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA89E9
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:10:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R40nFJ015017;
        Mon, 27 Mar 2023 09:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C+FboeoZ/bFE8+DOViTg+lZYffF8U9jm8mht5SIImDc=;
 b=CcOG537NYudKIFQWwoVsWD+HNMi9N4raZoLnoH3x92RXY8O2blb9dKOEUiunUHVK6YuJ
 pAE7ZIkZVutu3+gXYRHwPM35YPLLxeyShcONXaNUaMUYNfp5FwSh4SsAWdm/C2AMRUTm
 5V6Y9akXxMGEx0ACCBIlLekeGRcGXGgezhFfRAmAbVlUxATEMl0Rs1P2oqM3y8NoPdIM
 EefVXq0LihV6gwPVd3ZdmbguDvqHvme9mv4e1/mKgas4qqyQyA+uz7iZ/GQQF9LjSrTr
 +30az5BTWU16tTcf1enlhjLDlBm51F3jc17QI2a5STF7grI+Le4A7h4i2lPdpZ6u2Ak+ Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phte8btww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:10:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R9A6u1023501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:10:06 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 02:10:04 -0700
Message-ID: <baf27fe2-4702-fb8b-49f5-f5b1541c0d0e@quicinc.com>
Date:   Mon, 27 Mar 2023 17:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
 <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
 <50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net>
 <31b91fad-bd14-b6e1-8abe-fceb66085ecb@quicinc.com>
 <a20e39027ca0b89cae2259d35ff19d03c3c6951a.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <a20e39027ca0b89cae2259d35ff19d03c3c6951a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9t0_hyFabZfktjVANHhH0jKQxVwHIkMq
X-Proofpoint-ORIG-GUID: 9t0_hyFabZfktjVANHhH0jKQxVwHIkMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=400 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270074
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/27/2023 5:04 PM, Johannes Berg wrote:
> On Mon, 2023-03-27 at 16:40 +0800, Wen Gong wrote:
>>>>> +	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
>>>>> +		struct ieee80211_link_data *link;
>>>>> +
>>>>> +		link = sdata_dereference(sdata->link[link_id], sdata);
>>>>> +
>>>>> +		ret = ieee80211_link_use_channel(link, &link->conf->chandef,
>>>>> +						 IEEE80211_CHANCTX_SHARED);
>>>> For the 1st link of MLO connection/NON-MLO connetion, ieee80211_link_use_channel() is called before drv_change_sta_link(),
>>>> And now it is after drv_change_sta_link(), May I know is it also has some design here?
>>> Hmm, probably not really, at least I don't remember anything about that.
>>>
>>> Not sure it makes a huge difference? But I suppose we could change it, I
>>> don't really see why not either.
>> Not huge difference, I have made little change in lower-driver to match
>> that. So it is OK now.
> OK. Still maybe we should change it for consistency? I can try that
> later with our driver.
>
> johannes

I think it is not urgent for that:)

And lower-drvier should also handler different case.

>
