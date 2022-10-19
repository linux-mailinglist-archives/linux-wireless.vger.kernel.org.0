Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681E6038DD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJSEZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJSEZM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 00:25:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368943ED51
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 21:25:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J4OtMk014018;
        Wed, 19 Oct 2022 04:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZbrFBG6lFJkw4Q4wzOuFUmNS3JEp4jd6QUO2qeVXHzk=;
 b=Pw6yFHmfq7YPs/a4RzGR+jOWyeAZwVzcf2a0btennMcpekpiAbM3ddBlXd3lG8FBN9s6
 oLlwb4JI5f3BJOI26AsRKfLhBqSacMOZHYleJX6UGIHVtCgaUTrzLqjpcvD2u2wwHg0C
 SwKWut8Uftt87MhiSd5BeB8SY5q1TtLuTC2Bdc5s/lyGrxxBL2SaGunkVvwWvZFPL5xN
 v2wksBhqGzIrGNhTMXQtoRjIj5gbPJANCkRa7rAVqeLAfOQXGwx76/XmNFjJUaGn63z3
 +Qayg9oEWcW6ZOIL+O8TG+RLfMFGeWqf6gSoAf9YtpoXvGzYtwe9h5V/b56hm9v0FmVK 9g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka6brrff8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 04:24:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J4Os5G030761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 04:24:54 GMT
Received: from [10.242.242.80] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 21:24:53 -0700
Message-ID: <df0b368c-3b84-653e-6ef8-5446b75ce797@quicinc.com>
Date:   Wed, 19 Oct 2022 09:54:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/7] cfg80211: add NL command to set 6 GHz power mode
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
 <20220704102341.5692-5-quic_adisi@quicinc.com>
 <b36799bc1129baebbb64032deeaae72e4ca1af7b.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <b36799bc1129baebbb64032deeaae72e4ca1af7b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ADtKWmbE8g-blhROsPIAYV1AOurKtqtj
X-Proofpoint-GUID: ADtKWmbE8g-blhROsPIAYV1AOurKtqtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_01,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2022 16:35, Johannes Berg wrote:
> On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>>
>> + * @NL80211_ATTR_6GHZ_REG_AP_POWER_MODE: Configure 6 GHz regulatory power mode
>> + *	for access points. Referenced from &enum ieee80211_ap_reg_power.
>> + *
>> + * @NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE: Configure 6 GHz regulatory power
>> + *	mode for clients. Referenced from &enum ieee80211_client_reg_power.
> 
> I don't really see a good reason to have two attributes for this, rather
> than validating their value based on the iftype?
> 
The policy for each varies. For AP power mode, it can vary from 0 to 2 
(total 3 power modes currently), and for clients 0 to 1 (total 2 power 
modes). So, if we have just 1 NL_ATTR, while parsing obviously we can do 
based on iftype but in NL_ATTR policy validation, for clients it will 
pass value 2 where actually it should not. Will that be fine?


>>   	err = __cfg80211_stop_ap(rdev, dev, link_id, notify);
>> +
>> +	if (wdev->reg_6ghz_pwr_configured)
>> +		wdev->reg_6ghz_pwr_configured = false;
> 
> no need to check first
Sure, will improvise in next version.

> 
>>
...
> 
> Btw, all of that probably also needs to be per *link* rather than per
> *interface* now, with MLO?
Yes, it should be per *link*. Im working on the changes, will send next 
version soon.

> 
>> +	if (!info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE] &&
>> +	    !info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE])
>> +		return -EINVAL;
>> +
>> +	wdev_lock(wdev);
>> +	if (wdev->reg_6ghz_pwr_configured) {
>> +		wdev_unlock(wdev);
>> +		return -EALREADY;
>> +	}
>> +
>> +	if (iftype == NL80211_IFTYPE_AP &&
>> +	    info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]) {
>> +		wdev->ap_6ghz_power =
>> +		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]);
>> +		ret = 0;
>> +	}
>> +
>> +	if (iftype == NL80211_IFTYPE_STATION &&
>> +	    info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]) {
>> +		wdev->client_6ghz_power =
>> +		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]);
>> +		ret = 0;
>> +	}
>> +
>> +	if (!ret)
>> +		wdev->reg_6ghz_pwr_configured = true;
> 
> and honestly that logic here with the two attributes is pretty
> strange...
> 
> I'd even say you should remove the union in the wdev struct since you
> only can have one of them at a time anyway
Sure will do.

> 
>> +	{
>> +		.cmd = NL80211_CMD_SET_6GHZ_POWER_MODE,
>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>> +		.doit = nl80211_set_6ghz_power_mode,
>> +		.flags = GENL_UNS_ADMIN_PERM,
>> +		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
> 
> if you have netdev then you have wdev too, later
Yes, got it.

> 
>>   
>> +	if (wdev->reg_6ghz_pwr_configured)
>> +		wdev->reg_6ghz_pwr_configured = false;
>>
> 
> No need for if
Got it, thanks. Will rectify.

> 
> johannes

Aditya

