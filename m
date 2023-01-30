Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161DE681A9A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbjA3TgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 14:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbjA3TgB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 14:36:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000A457C7
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 11:35:58 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UIwjUY003850;
        Mon, 30 Jan 2023 19:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1o5C10TD6FWsTSIWKG38c4LZCiZeg5Cy6nZgFf1r5TE=;
 b=OiHuQO9PDBAMO+io+Go1cJtgUUbhjF/dyd3sFaGAqmjlzlcFx50TFb8xbKBKQ93OkaHA
 AZA67YqHSzN/s0lL7mbhxp0rrv6BcS4n/sUEBMsVVNoLD+pK6OPyaPMtmkNFzH59RfFi
 8EMkphSTyRpFSdVyWh4OlbN1IPhE5aFYfZZK04/xDfnWq4w7yy7piirS7wuCyHNYI09I
 dwVVQbk3B/ibrGXBHYGREKUi61DH3AvzFpM47Us++ZBLeoluOBH9HSk3iTIRDBAQ7TaW
 Fy6UTeqR4Zm+pJl6E84zRiNzyAX0EuIHqdrAj/eMz0MXqmqmp2J2nZEOtv/3nOwcy8z2 XQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncu1tvw6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:35:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UJZskZ028039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:35:54 GMT
Received: from [10.110.85.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:35:54 -0800
Message-ID: <cab6f852-3898-e0ef-36b3-78a2ddbe6626@quicinc.com>
Date:   Mon, 30 Jan 2023 11:35:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/6] wifi: nl80211: configure puncturing bitmap in
 NL80211_CMD_START_AP
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
 <20230130072239.26345-2-quic_alokad@quicinc.com>
 <3552eaee6a02d0b76dc4353b0d5556c3fe503d8e.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <3552eaee6a02d0b76dc4353b0d5556c3fe503d8e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7WMIhmlCJbPWDMnJX5dlKIa_x5JGGW7f
X-Proofpoint-ORIG-GUID: 7WMIhmlCJbPWDMnJX5dlKIa_x5JGGW7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=707 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300183
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/30/2023 12:40 AM, Johannes Berg wrote:
> On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
>>
>> v3: Validation and storing the bitmap moved to MAC80211.
> 
> I think I'd prefer we move the validation function to cfg80211 so both
> can use it, this way all potential non-mac80211 drivers have to do it as
> well, and then they'll move the function _anyway_ to do the validation
> in a single place, I'd hope?
> 
>> +	u32 punct_bitmap;
> 
> Internally I think we can continue to use u16, that's trivial to change
> later.
> >> + * @NL80211_EXT_FEATURE_EHT_PUNCTURING: Driver supports preamble 
puncturing in
>> + *	EHT.
> 
> That should probably make some mention of AP mode? It's not optional in
> any way for client, after all, and also not relevant to the API how
> client does it.
> 
>> +
>> +	*bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]) & 0xFFFF;
> 
> As the top bits are *reserved* then you should check that they're indeed
> zero - now they're ignored, which is generally bad. They might not
> always be.
> 

I will address all next version.
Will you be sending another patch which moves validation from mac80211 
to cfg80211 or should I add that as the first patch?
