Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04B5A94B4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiIAKd0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiIAKdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 06:33:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E64122073
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 03:33:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819brUD026597;
        Thu, 1 Sep 2022 10:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jKyxdskRcJkY16D6PL6dclnqIlwk2yGgekvQB+FQBoQ=;
 b=INDLiazdSYf2cfg2zSVGDHkl4rOHrBP3yH8oV5LJjutAVZbpfIVg5klLYR5YqsnJaivb
 FkLHM2m1QPIiSMbewiXq2iftI/cGhetkYpcBpFOyoA59+TQXpE0sV9RSE7pYTTP+lhCW
 wzA0IPffIGaT4H0L1Eod3axGR4ZeuTs6RM4wIhz3e77dAXOmpYa+chuw5IrOZ9+H2rz9
 wRLxosIhkQn8WO91lRXTOnI9hRcOpVbS/gPSipRSMqMyLbgq6BQ3+yd+okKjlrAop6zd
 lmEseJJAgDvoIR4sYCFOXHj2mgNx4Ywltag7uR20UvihxBphWXMHgaCVbT7vwBquHuqT GA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jab5gk6cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 10:33:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281AXLXT006994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 10:33:21 GMT
Received: from [10.216.26.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 03:33:19 -0700
Message-ID: <e69b7d24-a9a1-a022-e59b-f400532d0da0@quicinc.com>
Date:   Thu, 1 Sep 2022 16:03:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] nl80211: Allow transmitting auth frames with random
 TA
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220708165212.2069149-1-quic_vjakkam@quicinc.com>
 <27395558c865424f9b20d8b976e650926c9322dd.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <27395558c865424f9b20d8b976e650926c9322dd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 88gjjhWIRdp9mBCByW0_itqtHEjfaAd7
X-Proofpoint-GUID: 88gjjhWIRdp9mBCByW0_itqtHEjfaAd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_07,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=793 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/26/2022 2:17 PM, Johannes Berg wrote:
>
>> - To allow user space to use link address indicated by driver as
>>    transmit address for authentication frames triggered by
>>    NL80211_CMD_EXTERNAL_AUTH for MLO connection.
> Maybe this is already covered by the changes that are actually
> responsible for it not applying any more?
>
> You can use the link address now, due to commit 6df2810ac9a9 ("wifi:
> cfg80211: Allow MLO TX with link source address").


The pointed commit changes not helpful in external authentication case 
due to WDEV won't have link addresses information when external 
authentication triggered. The link addresses in WDEV gets updated only 
after association during connect response processing.


>
> The PASN privacy thing seems something that would be desirable also for
> mac80211, how would you think it would work there? Also for hwsim
> testing I guess :)
>

Need to check what additional changes needed in mac80211 to support this 
feature. I will check and post required mac80211 changes in v2 series.

>>   	if (!ether_addr_equal(mgmt->sa, wdev_address(wdev))) {
>> +		/* Allow random TA to be used with authentication frames if the
>> +		 * driver has indicated support for this. Otherwise, only allow
>> +		 * the local address to be used.
>> +		 */
>> +		if (ieee80211_is_auth(mgmt->frame_control) &&
>> +		    wiphy_ext_feature_isset(
>> +			   &rdev->wiphy,
>> +			   NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA))
>> +			goto out_tx;
> Could use else/if instead of goto? Not sure that's better though :)


sure, will do required changes in v2 series

- veeru

