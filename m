Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0827AF54B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjIZUfv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 16:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZUfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 16:35:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BB120
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 13:35:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QKZT2M016186;
        Tue, 26 Sep 2023 20:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D/bNwOqtS1ISH7SHXWgwB1q8xkZ8HCCaKWX9WmnNCI0=;
 b=fdVv4PMQsSJMXVJwDtUxvyLB25U9Qok+i4zYWcHwfWeKWJQzVAhepJXlEwuKImu2JFhS
 xKqGBzwsPNFD303mmRd/zODrB72nocZKSxSZsEP4ebyoDaH/p3/h47GqmWbxJhe/ApFL
 RoL/JUzGx3i41BylVy9zEO1AySivJnXczYC/fLbh00Gsm5x3UURm+uNZZG0V+xRcnMSe
 LYblDM/MCnsFc6IwOeRlAdCrJsQZIK3u+Z+OpWr24urgMfdUzYV7BrZhv0yClBKniPjo
 Hf73hU0fIwzWDwz5ZJHkh1plFyISPBxBrB0DhIIVdk8QYxlL3SnMHB7uqnQibq5FWPrP mA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbgfv3394-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:35:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QKZc6M015960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:35:38 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 13:35:38 -0700
Message-ID: <9ddcbc2f-5e40-48cd-bdbd-943bd86acb61@quicinc.com>
Date:   Tue, 26 Sep 2023 13:35:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: remove set_fils_aad support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
References: <20230926160950.d698c25528e3.If118a835a25c59de20e1728ab71949fdb4172fb2@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230926160950.d698c25528e3.If118a835a25c59de20e1728ab71949fdb4172fb2@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V_GEQameMRfQEbQj4Cdd7NyjdqRPCFzB
X-Proofpoint-ORIG-GUID: V_GEQameMRfQEbQj4Cdd7NyjdqRPCFzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=827 mlxscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260177
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/26/2023 7:09 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's no user for this, so remove the support.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

if you are going to remove it, why not just revert e306784a8de0 
("cfg80211: AP mode driver offload for FILS association crypto") to make 
sure you get all of the artifacts? for example, I believe your patch 
will leave behind an unused struct cfg80211_fils_aad and unused 
FILS_AAD_ASSIGN() trace helper macro.

the caveat to reverting is that it should only be a partial revert; the 
UAPI definitions would need to be retained (and should be documented as 
obsolete).

however, let me check to make sure there is no plan to actually utilize 
this interface upstream. as i've indicated earlier, we are in the 
process of trying to transition to an "upstream first" mentality, but 
this is not going to happen overnight, but instead will take years. that 
said, i'd hate to rip out an interface now just to need to add it back 
in the future.

/jeff

