Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363F4617683
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 07:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKCGBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 02:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKCGA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76941A827
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 23:00:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A34tSuC008080;
        Thu, 3 Nov 2022 06:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=z+5ULWo3KaaE9AL1T32oa2danC5eliEBmQtVlAf46cM=;
 b=pi4tSSijRpnClibiqkdJI21hNmzfhw8RiN3/8BwBwjeQiTThQqfkc6ZsNE4o0WsnP+55
 yOEGU1aPp8SVvdvNOi6U+QiMUIRa6JBFvThHKZ5BEouIql5nHVBSQ0RM/PrIWXrCt07U
 GRdhicMtBCMOdVHlIUX6FjU4a3caTcuDxbEh+vvj85jMGXREm7DCdFuWseWETzBhoEQ7
 hGbWd9RfQvorFcin41cGOXH3Vqslm919GIZ4WoAgiC+ElH/XlxA/fs5WUHMmgOW08r4X
 9Grc2hRegag44vOpSz2b0VV0RX7/s/Hb9ljfBCCTqoATRJgF3u85wzuriUFXHPKacR6J AQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km71gg5j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 06:00:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A360V92017083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 06:00:31 GMT
Received: from [10.242.243.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 23:00:29 -0700
Message-ID: <09db29f1-e102-98da-520f-af4d13496f7a@quicinc.com>
Date:   Thu, 3 Nov 2022 11:30:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/7] mac80211: rework on 6 GHz power type definition
To:     Johannes Berg <johannes@sipsolutions.net>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
 <20220704102341.5692-3-quic_adisi@quicinc.com>
 <c6a0171e47046633518bffc58cd15542a883165a.camel@sipsolutions.net>
Content-Language: en-US
CC:     <linux-wireless@vger.kernel.org>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <c6a0171e47046633518bffc58cd15542a883165a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L9QYxPzMQfrtbg-XdCP6PBlSb6LhxOSJ
X-Proofpoint-ORIG-GUID: L9QYxPzMQfrtbg-XdCP6PBlSb6LhxOSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=812
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2022 16:29, Johannes Berg wrote:
> On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>>
>> +++ b/include/linux/ieee80211.h
>> @@ -2132,18 +2132,17 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
>>   /**
>>    * enum ieee80211_ap_reg_power - regulatory power for a Access Point
>>    *
>> - * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
>>    * @IEEE80211_REG_LPI: Indoor Access Point
>>    * @IEEE80211_REG_SP: Standard power Access Point
>>    * @IEEE80211_REG_VLP: Very low power Access Point
>>
> 
> So these other values *do* come from the spec? Otherwise I think we
> should move them somewhere else (e.g. cfg80211.h)
Yes, other values do come from spec.

> johannes

