Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DE6E5DE6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDRJwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDRJwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:52:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F582D4C
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:52:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9OJd8014737;
        Tue, 18 Apr 2023 09:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=feChK+Xv7Pkb9WzfW4jsPTJiklFO8j+gdnrXC8uIr+U=;
 b=mb+ed36+7afd1Rs2iJuPiMFgCDn9TKckx5Wpa5HeB4UDGKlTqE/dP7LWBh2aA32/HWuG
 uWfJGM2+NP0n4VDDfjxtwmZKu5lottf87mhx+h14ArkJCdgb5eZCeTqEK9QgjaJciAjB
 j+uiuspESfpTKOhAIQ3xmUFc4HdPITo9lZGIbNMQifjI2OERnMK3n1ylU5ruIllOsjyL
 cy1gsUWtRdWAKtW4IsgfxlbUsukYXkShnFlYpdR44b7ceWq35V1z+XVEgLgeg/sak6cu
 5c085rlNbMppHaJIP2GRoQSzlE0UsCSE4LIoexnu7apIiyNxCrqH+N1w4D1TDRNqwiiS UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q19kg1tr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:52:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9qVLP028161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:52:31 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:52:30 -0700
Message-ID: <6c822410-9711-1166-d67d-4fa6b7996f86@quicinc.com>
Date:   Tue, 18 Apr 2023 17:52:27 +0800
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
 <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
 <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
 <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
 <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
 <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
 <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZIwWj1ipNotlUYP9i56jdXunQ4ijB10k
X-Proofpoint-ORIG-GUID: ZIwWj1ipNotlUYP9i56jdXunQ4ijB10k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_06,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=854
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180085
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 5:34 PM, Johannes Berg wrote:
> On Tue, 2023-04-18 at 17:27 +0800, Wen Gong wrote:
>> Now lower driver I used do not store the key
>>
> Sure, that's fine.
>
>> and do not trigger
>> BSS_CHANGED_ASSOC for new links after assoc.
> I think you need to think hard about this ... whatever BSS_CHANGED_ASSOC
> causes is likely no longer correct in MLO. Again, the assoc state
> *itself* is only changed once, when the whole MLD associated.
>
>> So my suggestion is a way to active all links while assoc, this way is
>> simple for lower driver I used.
> Sure, and we do that.
>
> But that's not what you're asking - you're asking to re-do some *MLD*
> state when a new link is added, and I'm saying that it doesn't make
> sense to "add" (again) a key to the MLD that was already added, nor
> calling a vif (MLD!) level method saying the MLD changed state to
> associated (again).

My purpose it to:

add logic in function ieee80211_set_vif_links_bitmaps() for station,

and to active all link as same as AP type.

>
> I really think you should solve this in the driver, that doesn't mean
> you have to _store_ he key, you can use one of the iteration functions
> as well.
Ok, I will try to find the iteration functions.
>
>> Also ieee80211_set_active_links() is another way to active all links
>> after assoc.
>>
> Sure.
>
> johannes
