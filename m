Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127DC698D39
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 07:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBPGju (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 01:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBPGjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 01:39:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D72699
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 22:39:46 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G4i0cT002848;
        Thu, 16 Feb 2023 06:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bIusHu2UEZKLyDoQBo3iSkFUDZzQVX9PSMBBHKqR/DA=;
 b=AfX1GbeSMg7nS2dbmRBVg/wumuOg16FDnGqPeiE8Fk3ECOmojjwn7coOb5yAinKYSe7n
 o90j77F6N+DPdSKfW6zeOnFjNyYc+XCB2P7WgCAZpvnKhXL5/orWdVGZJQCnwA7Zys8E
 vkDl/FNZmiJMJSp5mrd1OQMWVGBbFSi3tmXtG5jJfgT9/Rjnq4sFpgPy4UTc8vSGg5X+
 Aw+SL/Q83kAnQPQJ485l1LNl8cbALZ4IqQRwrYOw7gFnLEPkQzEXn/OTYP+olteyJbdP
 0tGBRRzhWA5mwyL791ZRTb0AWwux8kL4j/UEFkPKbRvYIGNKpxS41dpJvruJk1f65m9D cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns23j9xk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 06:39:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31G6dSDr025536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 06:39:28 GMT
Received: from [10.242.242.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Feb
 2023 22:39:27 -0800
Message-ID: <554bb44c-f370-3729-aeb2-c77db7e63173@quicinc.com>
Date:   Thu, 16 Feb 2023 12:09:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/7] mac80211: add combined power type definition for 6
 GHz
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
 <20220704102341.5692-4-quic_adisi@quicinc.com>
 <52e4bd3a7d24fca06a507f86fe23d23a552c7c2d.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <52e4bd3a7d24fca06a507f86fe23d23a552c7c2d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UpyeT5gpBcwGlv3J63uKZlXk_PsEXfoX
X-Proofpoint-ORIG-GUID: UpyeT5gpBcwGlv3J63uKZlXk_PsEXfoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_04,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160056
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2022 16:31, Johannes Berg wrote:
> On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>>
>> +/**
>> + * enum nl80211_regulatory_power_modes - 6 GHz regulatory power
>> + *					 modes
>> + * @NL80211_REG_AP_LPI: Low Power Indoor (Access Point)
>> + * @NL80211_REG_AP_SP: Standard Power (Access Point)
>> + * @NL80211_REG_AP_VLP: Very Low Power (Access Point)
>> + * @NL80211_REG_REGULAR_CLIENT_LPI: Low Power Indoor (Regular
>> + *				    or Default Client)
> 
> REG_REGULAR reads a bit weird, and anyway "REG" as the prefix for
> "regulatory_power_mode" is a bit strange?
> 
> Maybe use something like REG_PWR_MODE_... ?
Sure will use. Thanks for the suggestion.


> 
>> +++ b/net/wireless/util.c
>> @@ -190,6 +190,66 @@ struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
>>   }
>>   EXPORT_SYMBOL(ieee80211_get_channel_khz);
>>   
>> +enum nl80211_regulatory_power_modes
>> +ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_type)
>> +{
>> +	switch (ap_type) {
>> +	case IEEE80211_REG_LPI_AP:
>> +		return NL80211_REG_AP_LPI;
>> +	case IEEE80211_REG_SP_AP:
>> +		return NL80211_REG_AP_SP;
>> +	case IEEE80211_REG_VLP_AP:
>> +		return NL80211_REG_AP_VLP;
>> +	default:
>> +		return NL80211_REG_MAX_POWER_MODES + 1;
>> +	}
>> +}
>> +EXPORT_SYMBOL(ieee80211_ap_reg_power_to_reg_power_mode);
> 
> What is the use of that, why export it? Same for the other function.
We have two enum - one defined in ieee80211 header file having
two separate enum of AP and client power modes respectively and one in 
nl80211 header which is combined power type. At times there can be 
use-case to convert from enum in ieee80211 to nl80211. These helper
function will do that.

And in kernel layer whenever we need we can call these function. But if 
driver needs to call it, at that point we need these functions to be 
exported (called from different kernel module).

> 
> johannes

