Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA236E4AF1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDQOIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDQOIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39A5BBD
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:07:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HDSied003998;
        Mon, 17 Apr 2023 14:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c/R4YruE4tvVGWHKp8wzCxR6bWK/oJX90T/kObXm1S0=;
 b=Q4DoVIue2pv1/hZHljSgAjSd5MM0EgpuwbXmxX5iBgAWCpr5WDE4c8VtL6z5CgFjvgss
 orNJ8pzlueXwvBwGqJEj4JwQaYoo4lQom9lft9d5deta2kB4rungWx/cCxHuOLJNzHii
 F+cM0trUpHWZ/hydsrV92tzzQQ5heQBcub7T/64rGDbBy0RsbF+L67K2fR32SZEuL81T
 i54tNuqKZbeDP6/G2JbLSg0vVyT4bnt6+B46rHBAmQnGQZprZSwjN+sszuEVgZNc8/R8
 GPMA4hWiOtuSIJcf/772X8strkV+t3LDmAHziaiqKAigt3F23amD/QnLJhx4CIV15Jv4 6Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171gg2s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:07:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HE7mWI030516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:07:48 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 07:07:47 -0700
Message-ID: <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
Date:   Mon, 17 Apr 2023 22:07:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
 <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
 <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
 <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
 <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
 <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
 <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
 <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
 <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
 <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
 <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VJe_swdghrZ5c4WbHUCgXltm8cVK_3pb
X-Proofpoint-ORIG-GUID: VJe_swdghrZ5c4WbHUCgXltm8cVK_3pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=680 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170126
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/2023 3:32 PM, Johannes Berg wrote:
> On Tue, 2023-04-04 at 10:54 +0800, Wen Gong wrote:
>> On 10/11/2022 3:26 PM, Johannes Berg wrote:
>>> On Tue, 2022-10-11 at 12:07 +0800, Wen Gong wrote:
>>>> On 9/28/2022 11:28 PM, Johannes Berg wrote:
>>>> ...
>>>>>> May I know some more info/status about the "incoming  new method to let
>>>>>> drivers set the link address"?
>>>>>>
>>>>> I wasn't actually planning to work on that myself, FWIW.
>>>>>
>>>>> johannes
>>>> OK. So has some body will work for that now?😁
>>>>
>>> Yes, I don't personally have a need for anything other than what we have
>>> right now.
>> May I add method to let low-drivers set the primay link address like below?
>> I add a field in struct wiphy_iftype_ext_capab, if it is valid, then it
>> will be used as
>>
>> local primary/assoc link addr in function ieee80211_mgd_setup_link() for
>> station.
>>
> I don't really think that it makes sense to push this to cfg80211 when
> we only need it in mac80211?
>
> johannes
OK. So I will try to put this in mac80211 layer, is it OK?
