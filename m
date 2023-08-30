Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B478D2EB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjH3FLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 01:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjH3FLC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 01:11:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC942CC5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 22:10:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U3UC30019692;
        Wed, 30 Aug 2023 05:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fcRGDTsxBkygtAOSywiGs2O7W2zOW6eTNXpAPg4e0CA=;
 b=Lt1hQ/FEIRRNHeXISIoQaWB52gPnHGOgd8C0JzGFR0hZz6oPVeL7Q/81M9bsOekcPvLs
 zn/cLi21gQYYsoC+5sXAUQ2loDQY3lgpzVJoHxG/IXmlE+kTvNztKrshpNw7puDKqzap
 mUUYnPjXyAqZacW26MDqs1Em175lwMOp6xAqse6O5Yy27gdHRLJBZw3DkW5Z2M0dCXAj
 SP8yE9lDH796zJ+MmSAgTDYQXDSSAlWHhy9uBFNzcLjCJrr3Oulb9obA2IDPc3mTysSX
 OMep18wUvF2YA+w0Zs7t4p3W5HJsff929p/OqRP4eTdLTV7fjtdsTw57N6gaVHhZDC/Q IQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss2xbbngx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:10:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U55Zxx030436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:05:35 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 22:05:34 -0700
Message-ID: <d3740fa2-a59e-d6e2-394c-9b289564b832@quicinc.com>
Date:   Wed, 30 Aug 2023 10:35:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 4/9] wifi: cfg80211: add NL command to set 6 GHz power
 mode
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <20230315132904.31779-5-quic_adisi@quicinc.com>
 <59e2364e9085f725c03d05e3f720f8fae7b336ce.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <59e2364e9085f725c03d05e3f720f8fae7b336ce.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MI-zCIw5BKezVGgnMLBHOjmw6DXsAAXg
X-Proofpoint-GUID: MI-zCIw5BKezVGgnMLBHOjmw6DXsAAXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300047
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/23 23:21, Johannes Berg wrote:
> On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
>>
>> +	{
>> +		.cmd = NL80211_CMD_SET_6GHZ_POWER_MODE,
>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>> +		.doit = nl80211_set_6ghz_power_mode,
>> +		.flags = GENL_UNS_ADMIN_PERM,
>> +		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
>> +					 NL80211_FLAG_MLO_VALID_LINK_ID),
>> +	},
> 
> Why is this even a new command, rather than a parameter to start AP or
> similar?
> 
A new command was introduced because to give user space a knob to change 
power mode as and when required. Let's suppose AFC response has not yet 
arrived, AP could be started in Low Power mode. Now once AFC rules are 
applied (not going in detail here how that will happen) and user space
knows about it, it can send command to switch to Standard Power Mode right?


> Why do we even set it in client mode from userspace?
> 
>>   static struct genl_family nl80211_fam __ro_after_init = {
>> @@ -17409,7 +17473,7 @@ static struct genl_family nl80211_fam __ro_after_init = {
>>   	.n_ops = ARRAY_SIZE(nl80211_ops),
>>   	.small_ops = nl80211_small_ops,
>>   	.n_small_ops = ARRAY_SIZE(nl80211_small_ops),
>> -	.resv_start_op = NL80211_CMD_REMOVE_LINK_STA + 1,
>> +	.resv_start_op = NL80211_CMD_SET_6GHZ_POWER_MODE + 1,
>>
> 
> Obviously, this should not be done.
If this hunk is not there, the command was not going through. Upon 
digging further found out that the number of commands declared in the 
array and the count provided here has some relation. And that too with 
the last element added. Since a new element was added, modified it 
accordingly.

> 
> But in any case, I don't think there's a lot of value in doing a
> detailed review of the code if we haven't gotten a good grasp of the
> semantics that you want.
> 
> johannes
Sure let me try to address all your comments and then come up with new 
version probably which clears the doubts. Anyways, thanks for your 
comments.

Aditya

