Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5875F5EE01F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiI1PWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiI1PVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 11:21:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F0B4EA3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:21:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SEwopR015785;
        Wed, 28 Sep 2022 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lWXuHUpCAO4ShSVsUvTBOVhHkvv1Cv4qu1WFDI62iFs=;
 b=EpbB3WWMDmoHlWaOldSTNjOgekXH47FUbAn9yUXiasoxI25xaEm+oMi7wfP8p3rpkz8f
 mrPR/bw0ztwusW+MBtzzIWkBmFQA00bJP/taYLJprmm5tY8hvIObBxW5FxVtCEmfppSB
 pV8V//F8mShIo9ocGFuerul46PGL8QwYhTcTuG1NzVZRc5/2h0Ue6bAnPY55JJmuO0qK
 sGBJClORxAft95/iJP+gOctW4xRYV4jE8K8jyFb0HVm6iMstWCFFQ3hHX7BT2+p25cEX
 8JMDtDLD5alQ8ghi5CUHpiRGCLB6OJbWncInp0WWxWeHPMH8nRdJECrEfAEZsE0g6IhW Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juvnnm46d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:20:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SFKtfD020634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:20:55 GMT
Received: from [10.253.33.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:20:54 -0700
Message-ID: <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
Date:   Wed, 28 Sep 2022 23:20:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
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
In-Reply-To: <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VfEMD4drWKJD2-sx4Earv5sdGyHOxQTq
X-Proofpoint-GUID: VfEMD4drWKJD2-sx4Earv5sdGyHOxQTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=983 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280090
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi johannes,

May I know some more info/status about the "incoming  new method to let 
drivers set the link address"?

On 9/9/2022 4:58 PM, Wen Gong wrote:
> On 9/9/2022 3:28 PM, Johannes Berg wrote:
>
...
>> If we just change the first link's address to the same as the MLD
>> address without any changes then the code without the changes below
>> would overwrite the link ID because it can find the link STA address,
>> even if the device already did address translation. Of course this is
>> only relevant if it does address translation w/o indicating the link,
>> which it shouldn't ... hence the patch.
>>
>> In any case, I expect this will end up being some kind of driver policy,
>> so I can imagine that we could make a relatively simple patch with a new
>> method to let drivers set the link address that gets used. It cannot be
>> changing the link address when it's added to the driver since this patch
>> that this thread is based on means the driver doesn't get to know about
>> the links until it's far too late (and even before this patch, the links
>> were only created after assoc, when the link addresses were already sent
>> to the AP)
> Thanks for the incoming  new method to let drivers set the link address.
> It is better to let driver to fill all the links' address in load phase.
> And then it never change again. And one of the address array is always
> used for primary link.
>
...
