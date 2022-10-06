Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77125F64E7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiJFLKM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiJFLJw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:09:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB4B80
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:09:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2968oV3V008266;
        Thu, 6 Oct 2022 11:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JOU6sAf6K59sYTg+SjQ6b0QFX7OSsS+9DqOQIY3Xao8=;
 b=UxJx6logFvb2mPHCWfhoRXjM0wCk+sL2aWBKEyiKfqjG28mCVT78F2VVo5Vz6jCxcY7e
 WhSppDarvFg3qGciT12DYjLWV8XusbWhGK0D2diNKd0rJmdPkbVkVGh6z+RjPdZfvDoj
 wabmgtCny03jg5KNCILsVq5WV/2wX9hrGx+g8C36UgTlX3NuwUHPuWlTblO/pDkoRFV6
 UxJK72dDEqEF/3BejOgSzeY5gxF+ou4iJiZSkLLkmV63VyL08HTJRPDebCNnAsh6Funp
 eEzO0+hGxkXDfdF6AnGr8pooy28vk2fEnQY9Dmnne8Cp3I80pXOoax2LgswPQMxlZNgf Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1qykrruy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:09:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B9UkY002559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:09:30 GMT
Received: from [10.216.43.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 04:09:28 -0700
Message-ID: <13b44ce9-e000-cdcf-c057-b176edb6d31f@quicinc.com>
Date:   Thu, 6 Oct 2022 16:39:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 05/28] wifi: cfg80211: support reporting failed links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
 <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
 <0fd2932c29adcc6be5fe5528d297b7deb0e0617b.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <0fd2932c29adcc6be5fe5528d297b7deb0e0617b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hj74eK2pFKY0zcOaKIVuiQCyElaeEX13
X-Proofpoint-GUID: hj74eK2pFKY0zcOaKIVuiQCyElaeEX13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=748 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060067
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/6/2022 4:21 PM, Johannes Berg wrote:
> On Thu, 2022-10-06 at 16:19 +0530, Veerendranath Jakkam wrote:
>> I think similar enhancement needed for cfg80211_roamed/NL80211_CMD_ROAM
>> also to know accepted and rejected links info during roaming.
>>
> Not sure, in that case we might care only about the successful links
> since wpa_s didn't request the others, so maybe it doesn't matter?

Drivers can offload EAPOL 4WHS to wpa_supplicant during roaming with 
non-FT AKMs. In that case supplicant needs to know rejected links info 
to validate AP's MLO Link KDEs in 3/4 frame.

Ex: Driver handles only re-association request and response frames while 
doing roaming with non-FT AKM then offload 4WHS to wpa_supplicant

>
> In any case, I have no driver I deal with that would ever use this API,
> so I can't really do anything about it.

No problem, I will post the required changes for 
cfg80211_roamed/NL80211_CMD_ROAM path, hope that is fine.

>
> johannes
