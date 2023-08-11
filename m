Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6477896C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHKJG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKJG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:06:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF92D5B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:06:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5nh1D003965;
        Fri, 11 Aug 2023 09:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HAM0a6ZcEdfIQ+/jAQH8K4x73Bm8DVo1K9GQ29uGrB4=;
 b=LhqU6nWwuBGpB89GY8BROXqBmyqPAl11kmKaqQ9HkAl/RQsp4bOlsh5k3WQMawEU8N3U
 SJgBOfog8clg2r0IImFw4q8gCpaeU3O3sQzMpDbIrn6HTICIoNB48kUSNaCLRVWutKm/
 9rlJ5M5QLmmXN6ADF7/o6uZKlTxcwcCv34bAaX6z2o3hQIQFhSb969bDOu0eTEnw3cgl
 KGeR+AH2vHj/JpeGpYfOPS/3EDv97dQWWxOMqqzCn6nIja9poswtOqMeuWkTJokX5o/D
 2fMJ3bQHCQfgcwJyJNPUlMb4ilbC1WopwxMXl2fdEeZecS1dXqCwHUJEdU9wIjWfKPRB dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yb974k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:05:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B95Jlv027918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:05:20 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 02:05:18 -0700
Message-ID: <cc6b83eb-ac30-34fc-4827-290a9ae25378@quicinc.com>
Date:   Fri, 11 Aug 2023 17:05:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>, <quic_rkaliapp@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
 <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
 <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
 <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 201CXb8VyLz4Lc9t7ncOAn4mZGI3gPsY
X-Proofpoint-GUID: 201CXb8VyLz4Lc9t7ncOAn4mZGI3gPsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=347 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110082
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/11/2023 5:03 PM, Johannes Berg wrote:
> On Fri, 2023-08-11 at 11:51 +0800, Wen Gong wrote:
>> Now there are many nl80211_band such as NL80211_BAND_2GHZ/
>> NL80211_BAND_5GHZ/NL80211_BAND_6GHZ... In the same interface, if some bands
>> support EML, and other bands not support EML, then how to handler this
>> case?
> But ... these are MLD capabilities, not of the (associated) STA?
Yes, I know it.
>
> So not sure how that would make sense? What would you even _do_ with
> that?
I think another change is not move "u16 eml_capabilities", and only add 
a new
field "u16 eml_supp_bands" together with the "u16 eml_capabilities", the
eml_supp_bands is filled with the bit map of enum nl80211_band. Is that OK?
>
> johannes
