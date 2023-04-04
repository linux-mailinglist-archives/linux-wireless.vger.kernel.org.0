Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5506D56EA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjDDCyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCyR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 22:54:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9101BE5
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 19:54:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3342nAIi012868;
        Tue, 4 Apr 2023 02:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YO8xpiiFRkM7ohelTiAjHSXvuPCQhgmTSseP61xd34g=;
 b=k8eoRsbhK5z3D/5bBqJD7qcx6wwXvKcSQImV8iDwZFHC4MtsuqlxzzDLH62AvSNw9v3/
 W/GZeNXd4BVwt1rm66YOYpuWmBeoMSoU+qvqg9DyDLjThOEf8lTGYCno4Z0NaCo32cYL
 +M+XKYtuwY60ooONa6+jmwGshs904Yg26RoZpRezNyH2jvVFi48VN+VFKJxE+5hG1qvY
 jqWubu9HDu1eOBPNn/XzGiRLpgqW/5LaCaIqGqH2YqkR+T3iNRgsVNtKLL16WU7f0Nk2
 uXcHav0AbTXnxyYMfmH9c/UwStWE1yp9nuCqnLgTpv650fCmnpReeO1H4wJ4TTAGDC6p HQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqus5a919-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 02:54:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3342s8p3014952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 02:54:08 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 19:54:07 -0700
Message-ID: <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
Date:   Tue, 4 Apr 2023 10:54:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
 <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
 <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
 <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
 <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
 <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
 <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
 <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
 <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lnsgSqN0jOsGDySGRdk1atThTXzp55E5
X-Proofpoint-GUID: lnsgSqN0jOsGDySGRdk1atThTXzp55E5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=808
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040024
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/11/2022 3:26 PM, Johannes Berg wrote:
> On Tue, 2022-10-11 at 12:07 +0800, Wen Gong wrote:
>> On 9/28/2022 11:28 PM, Johannes Berg wrote:
>> ...
>>>> May I know some more info/status about the "incoming  new method to let
>>>> drivers set the link address"?
>>>>
>>> I wasn't actually planning to work on that myself, FWIW.
>>>
>>> johannes
>> OK. So has some body will work for that now?😁
>>
> Yes, I don't personally have a need for anything other than what we have
> right now.

May I add method to let low-drivers set the primay link address like below?

I add a field in struct wiphy_iftype_ext_capab, if it is valid, then it 
will be used as

local primary/assoc link addr in function ieee80211_mgd_setup_link() for 
station.

--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5079,6 +5079,7 @@ struct wiphy_iftype_ext_capab {
         u8 extended_capabilities_len;
         u16 eml_capabilities;
         u16 mld_capa_and_ops;
+       struct mac_address assoc_link_addr;
  };

...

