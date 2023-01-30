Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48152681AB6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjA3TpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 14:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjA3TpJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 14:45:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF4C163
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 11:45:09 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHpa9F001975;
        Mon, 30 Jan 2023 19:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fmdFfCXae2/+A2tNgdqxHkCV7q2wywqo/lRwl+PCFTw=;
 b=YXjcQM1jPhqASdxhAcXMoF1coGXI0eiqgOZ76vPUU9uSAgU/hyrRNjp6Hl9ahpR+XOki
 5Z4+kIv1H9+yoQKphVvt8PP34hQf+T1FUvA+I48Q4qH+8TDPhP7A81zBUod/Y+MDQ4H4
 Fq+4uLeYpuo7DgztUxIP8vN+JDSdgM2eMkeGqiJ+W1Ofk6QPLmZy87KBiWMz9Mp3XM4U
 Iwo7aUAkyx0uGsooY/XNQZVTtarxIGL2X1wNk7nomlic7cD7xRN2Mo6DcDKzzXlS8z7F
 Z6gk7Wj0oEaJ7IHmt16h1AqDmw0kq7vN5RfSoh8flOXL1CBGlzGeXJ4jkCGrzUhM2LSC yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nehdm8ea8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:45:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UJj5X9003852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:45:05 GMT
Received: from [10.110.85.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:44:56 -0800
Message-ID: <92008406-413a-be85-a442-a3cf5b46192e@quicinc.com>
Date:   Mon, 30 Jan 2023 11:44:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/6] Puncturing support in AP mode
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
 <a22a32c66189dc715c6faf00778e44dccb8fb5ac.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <a22a32c66189dc715c6faf00778e44dccb8fb5ac.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o3sJnIGhS19U7kd0_mNaviOgVtzdy5sX
X-Proofpoint-GUID: o3sJnIGhS19U7kd0_mNaviOgVtzdy5sX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=764 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300185
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/30/2023 12:48 AM, Johannes Berg wrote:
> Thanks!
> 
>> Aloka Dixit (6):
>>    wifi: nl80211: configure puncturing bitmap in NL80211_CMD_START_AP
>>    wifi: mac80211: validate and configure puncturing bitmap in start_ap()
>>    wifi: nl80211: configure puncturing in NL80211_CMD_CHANNEL_SWITCH
>>    wifi: mac80211: configure puncturing bitmap in channel_switch()
>>    wifi: cfg80211: add puncturing bitmap in channel switch notifications
>>    wifi: nl80211: add puncturing bitmap in channel switch events
>>
> 
> I feel like maybe you can/should squash 1 and 3, 2 and 4, and 5 and 6?
> 
> 1/3 are cfg80211 for config, 2/4 are mac80211 for config, and 5/6 are
> basically both cfg80211 anyway? Of course 5 updates the users.
> 
> And maybe I'd then reorder and put them in this order:
> 
>   - new: validation move
>   - 1/3
>   - 5/6
>   - 2/4
> 
> so 5/6 just pass 0 from mac80211 to cfg80211_ch_switch_started_notify()
> and cfg80211_ch_switch_notify(), and the mac80211 patch (2/4) fills in
> the actual values. That way the cfg80211 patch is 'pure' API, no
> functionality changes.
> 
> What do you think?
> 
> johannes

I added separate patches for channel switch because it kept the patches 
small. No worries, will combine those.

Thanks.
