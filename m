Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D47602920
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJRKLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJRKKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 06:10:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6833B3B1A
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 03:10:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I7r2M7009310;
        Tue, 18 Oct 2022 10:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QHuIq1vgVmjuGXdr/qI9gfCBLvs4mMLFNVhWxyub4xo=;
 b=HsnigEyilReLPbEoMkRBlAnKI+7Dubmhwx39nIbrQAhvc2RghhGGL0E5gIi4vSpgE+kF
 oiP/ktuN1eO6E8K6umIczAwUGqaONcvEOzJyxg4YzWF8X9XFlLiPVg8DUjE8C4jF1Wdo
 SGM9mXANyetyPcuucYIg6v9Muk2Us85ahukUFS0P5mz9d8lKeDUxLqhA60njXHJJgCNX
 cGu7CNzEe29lzMJCwhWLdve6adEsDllqMFc85LZMjKf5har17i33l474yFQGkS9nawr/
 TRSJtRyZlt5kSIfBP7pbWRE1mv05RfkcDqDwN7b4lm1jVONar/V7AdwFMMvRnReBnBIJ kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9jjms5xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 10:10:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29IAAVn2015151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 10:10:31 GMT
Received: from [10.253.75.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 03:10:30 -0700
Message-ID: <95a1604c-f323-0fea-46a8-bf554da28fca@quicinc.com>
Date:   Tue, 18 Oct 2022 18:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
 <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
 <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
 <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
 <d0994456d3a9ea00b5cc472df7822d53d189399e.camel@sipsolutions.net>
 <7e72034a-497a-000c-d7bf-3ec974af9e1c@quicinc.com>
 <f210cf2a6e3f62156ae6a9d6c7de20e16bd4d6e6.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f210cf2a6e3f62156ae6a9d6c7de20e16bd4d6e6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3h-MauTJnnZfK5fVkQc8QiZ7JUaAFwbW
X-Proofpoint-ORIG-GUID: 3h-MauTJnnZfK5fVkQc8QiZ7JUaAFwbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_03,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=829 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/2022 5:51 PM, Johannes Berg wrote:
> On Tue, 2022-10-18 at 17:50 +0800, Wen Gong wrote:
>>> https://p.sipsolutions.net/0652bbbbe350b126.txt
>> Conflict happened while run "git am" the patch.
>>
>> Because missing the  "changed |= BSS_CHANGED_EHT_PUNCTURING;" in my
>> local code,
>>
>> also it is missing in
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/util.c
>>
>> Maybe "changed |= BSS_CHANGED_EHT_PUNCTURING;" is only existed in your
>> local code?
>>
> Ah yes, we didn't upstream that because there's still this discussion
> about handling puncturing. But you can probably apply around that.
>
> johannes

Yes, after apply it.

and apply "commit 3d901102922723eedce6ef10ebd03315a7abb8a5 wifi: 
mac80211: implement link switching" to

fix build error because my local code is not latest.

it is built success, I will try it later.

