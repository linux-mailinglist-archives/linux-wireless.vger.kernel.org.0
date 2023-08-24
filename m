Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218E2786552
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 04:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjHXC0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 22:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjHXC02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 22:26:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EC4CF1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 19:26:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O1UFKV025158;
        Thu, 24 Aug 2023 02:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aNdtgVnyPdNHvAsrEU+7y4frtvGGc70j5dBulEvO9+k=;
 b=dH1FHGKLWTtu2s1G9FC3610RYDXDjRaEOCokBoOI6D79t7mlyuhxTX4Lwg2vfPMP906L
 zlqJfguzgHCcuJFx3YRVdlBkqrye+XC1Hl5d5yc7LPlIdtrEdDdVKwX0lAK/picXePzO
 8N/+8fIXfIZ8ivr4soRs5F05OE9mH21ZvdYVbcrSVKscoPJeNtW291QvdO+8eFnRrne2
 EodIsFOQVwXpUJeGTyk3wjL4H/9A9UO6zulhOJ/24XODZD5guCzwo+uECBancTyHzFjS
 ndBHSdqF2TiL7IhKiU/8xcAN1YsZHziVXEf6N218k/I0Y83uRA+Qt0C7AJsVCNT7uz0w 2g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2exuby2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 02:26:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O2Q8fg025802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 02:26:08 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 19:26:07 -0700
Message-ID: <1a193edc-23a8-6631-5beb-2020de489934@quicinc.com>
Date:   Thu, 24 Aug 2023 10:26:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when
 assoc response fail for MLO connection
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230822100409.1242-1-quic_wgong@quicinc.com>
 <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
 <bcf65017-0dbc-e957-f382-98c6dc406346@quicinc.com>
 <941b1bdb6852f20722fa3a5b01f546f054f9e8a8.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <941b1bdb6852f20722fa3a5b01f546f054f9e8a8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v7hH1cNyCZZJZce6gmJk8vwwOpYa_518
X-Proofpoint-ORIG-GUID: v7hH1cNyCZZJZce6gmJk8vwwOpYa_518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_17,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=633
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240018
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 2:34 PM, Johannes Berg wrote:
> On Wed, 2023-08-23 at 10:28 +0800, Wen Gong wrote:
>>>                   /* need to have local link addresses for MLO connections */
>>>
>>>                   WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
>>>
>>> makes no sense anymore. Not sure if that's the only one.
>> After this patch, the cr.links[link_id].addr will be a valid local link
>> address from
>>
>> struct cfg80211_rx_assoc_resp, so I think it is not needed remove now.
> You don't understand.
>
> The issue is that it's set the line above.
>
>>                  cr.links[link_id].addr = data->links[link_id].addr;
>>                  /* need to have local link addresses for MLO connections */
>>                  WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
> But look at that! What values can cr.links[link_id].addr get? Note how
> it's a pointer - assigned from an array.

Oh, I know it now. the cr.links[link_id].addr will always NOT 0 because 
it is pointer

to an array "u8 addr[ETH_ALEN]" of struct cfg80211_rx_assoc_resp.

So maybe we can choose one of the 2 things to do:

1. remove the "WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);"

2. change like this:

WARN_ON(cr.ap_mld_addr && !is_valid_ether_addr(cr.links[link_id].addr));

What about your advise?

>
> johannes
