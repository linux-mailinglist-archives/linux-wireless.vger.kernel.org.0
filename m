Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A276028C1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJRJvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJRJvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 05:51:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCFB0B2D
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 02:50:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I8JHAL011807;
        Tue, 18 Oct 2022 09:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=swtDZcSOjcRU1/N/5VrVyp60bjkmh7JSO6Cdb5BBVYc=;
 b=Inr3qq5KFJt+U3iBZyjhvbWrY/1YxTSnE0Af61xV0gAqkhg2rNVtHyIsVawb5OHWtVVf
 l8QlfpSYwBFWRkAP7gwyTUlOvB+064XYOA+oFt2J+ZTJtvRsrJrrxWDy9tO0TdqpRdjw
 TdF8jpYOZb7Py4dz0DKdAWGd9W7uMkT8o0vUtyL92GnTTLl7KiuhwJj4iNFyV/4tvCrV
 Vgl40DhQ4cAr68t7KZD0VavzLwfqKTVAKo4aieovBoY6Gfm8ROI9/YwOJcadTDJ6LRdy
 O5C0ngNku6+NkUtXD06tO2eVAzdKP7Il9q8SICdtD36mKocSqEdIxN0FmDuNL1vL8w/A Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9jjms4d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 09:50:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I9okWV016599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 09:50:46 GMT
Received: from [10.253.75.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 02:50:45 -0700
Message-ID: <7e72034a-497a-000c-d7bf-3ec974af9e1c@quicinc.com>
Date:   Tue, 18 Oct 2022 17:50:43 +0800
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <d0994456d3a9ea00b5cc472df7822d53d189399e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7U9IFpEUqW8WtnXJq_8-eoIfqmU1VeRz
X-Proofpoint-ORIG-GUID: 7U9IFpEUqW8WtnXJq_8-eoIfqmU1VeRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_03,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=605 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/2022 4:53 PM, Johannes Berg wrote:
> On Tue, 2022-10-18 at 16:52 +0800, Wen Gong wrote:
>> On 10/18/2022 4:50 PM, Johannes Berg wrote:
>>> On Tue, 2022-10-18 at 16:47 +0800, Wen Gong wrote:
>>>>> +	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
>>>>> +		/* FIXME: should be for each link */
>>>>> +		trace_drv_link_info_changed(local, sdata, 0, changed);
>>>>> +		if (local->ops->link_info_changed)
>>>>> +			local->ops->link_info_changed(&local->hw, &sdata->vif,
>>>>> +						      0, changed);
>>>> I think you/someone will change here later for the "/* FIXME: should be
>>>> for each link */", right?
>>> Maybe. I'm not actually sure it's really needed, it depends how we use
>>> this in the future.
>>>
>>>> It lead error/kernel crash as below while reconfig single MLO link which
>>>> link id is 2.
>>>> When test with single MLO link which link id is 0, not found
>>>> error/kernel crash.
>>> I'm not surprised, I just worked on fixing reconfig in the last few
>>> days, will post it after some more review/testing.
>> Thanks.
>>> So I think that might not need changes *here*, but rather a proper FW
>>> restart. Which I haven't tested in AP mode though -- was the crash in AP
>>> mode?
>> It is crash in station mode.
> try this?
>
> https://p.sipsolutions.net/0652bbbbe350b126.txt
>
> johannes

Conflict happened while run "git am" the patch.

Because missing the  "changed |= BSS_CHANGED_EHT_PUNCTURING;" in my 
local code,

also it is missing in 
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/util.c

Maybe "changed |= BSS_CHANGED_EHT_PUNCTURING;" is only existed in your 
local code?

