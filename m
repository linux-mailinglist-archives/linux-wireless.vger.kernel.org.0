Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31529681AAE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 20:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjA3TlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 14:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3TlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 14:41:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE145893
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 11:41:03 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UIiJ0F029687;
        Mon, 30 Jan 2023 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pP32zBAiqAmDz9cCagevcVq61OHi9byWv3NRFltmovM=;
 b=IYupvq8zKlZ/CO9qaa7299Px+S3UXBvCy+uTk85UmpU7oIKpOgiV5WjeitWhOWwVDLHQ
 cKv6WyUKGnprFyqVPxQs4/4B4NnZQl5B6tuc4ys1QGM6whwZDb+pbiiQ8opEix2XO6Ij
 p4czKE2aG5DQIEVPuQvsVuv0h5I+LL9SE9acTklimm2p0fq/mXIp55/4PVum7L13EhZs
 Zq7Y7GjAIPJj7BssUWn7dzl3LGapJk/k2yjZ+xzWWc+h/suK73djSe8wY9hDcKTUswVW
 c3vdr7wRA+LOzltrPxkcx0hxlFLaEJ7KvElUhyt66+gCM+RrBKHFJPEOaGuyx6YKenJU 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxamgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:41:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UJexqf013434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:40:59 GMT
Received: from [10.110.85.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:40:59 -0800
Message-ID: <fe83df50-0f81-4de3-8572-6c57b831fa79@quicinc.com>
Date:   Mon, 30 Jan 2023 11:40:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/6] wifi: nl80211: configure puncturing bitmap in
 NL80211_CMD_START_AP
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
 <20230130072239.26345-2-quic_alokad@quicinc.com>
 <3552eaee6a02d0b76dc4353b0d5556c3fe503d8e.camel@sipsolutions.net>
 <cab6f852-3898-e0ef-36b3-78a2ddbe6626@quicinc.com>
In-Reply-To: <cab6f852-3898-e0ef-36b3-78a2ddbe6626@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RmD64_ViLUpH9P-i226pH9zb_c2N_DYf
X-Proofpoint-GUID: RmD64_ViLUpH9P-i226pH9zb_c2N_DYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=792 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300184
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/30/2023 11:35 AM, Aloka Dixit wrote:
> On 1/30/2023 12:40 AM, Johannes Berg wrote:
>> On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
>>>
>>> v3: Validation and storing the bitmap moved to MAC80211.
>>
>> I think I'd prefer we move the validation function to cfg80211 so both
>> can use it, this way all potential non-mac80211 drivers have to do it as
>> well, and then they'll move the function _anyway_ to do the validation
>> in a single place, I'd hope?
>>
>>> +    u32 punct_bitmap;
>>
>> Internally I think we can continue to use u16, that's trivial to change
>> later.
>> >> + * @NL80211_EXT_FEATURE_EHT_PUNCTURING: Driver supports preamble 
> puncturing in
>>> + *    EHT.
>>
>> That should probably make some mention of AP mode? It's not optional in
>> any way for client, after all, and also not relevant to the API how
>> client does it.
>>
>>> +
>>> +    *bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]) & 
>>> 0xFFFF;
>>
>> As the top bits are *reserved* then you should check that they're indeed
>> zero - now they're ignored, which is generally bad. They might not
>> always be.
>>
> 
> I will address all next version.
> Will you be sending another patch which moves validation from mac80211 
> to cfg80211 or should I add that as the first patch?

Okay, saw your comments on 0/6 and one other late.
Will add 1/7 for moving the validation in next version.
Thanks!
