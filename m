Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED895B22D2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIHPvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiIHPv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 11:51:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D503F9102
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 08:51:23 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DZ7XN016223;
        Thu, 8 Sep 2022 15:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hO+v2K+CnjiTrtByQEx7JrMt47Y5cI/j3uTdiFeNulY=;
 b=AMHeQz9q0UC3VJbEzzP0pKFaY0IHRUx89ArzQNb2FYcqwYEr7+s5vwCi3JXb2gYhBQzZ
 cOnSQD7rdUSguXUXQwwNg6TZAnntw17OHzDxal8SDocyvyu1rgPUHz28cmMRhazAskpC
 yHSzWbdQ7oi4XNMiFqczzzuixhUirMUyAb3R+ctkZOZ0Mcj5Y86BXW1rZbyWlEf7pi/p
 WaxXKVmvzNN+2j5mAMy9FREOLcrjoTMGyN7h+y5b20aPR8vZh0mUqjxAKrPGU/pmBkUF
 zdlZvOvbKf+x9EP0ie/LbEPVbgCANbMopkIt5WPNszNnCfCVvdmL3gduLA2M39GhqoEk 8w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfcjkhadf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:51:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288FpH1h030973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 15:51:17 GMT
Received: from [10.253.74.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 08:51:16 -0700
Message-ID: <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
Date:   Thu, 8 Sep 2022 23:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uOo_aaRQeCGharpyRDHTgsLLi5TOkcy1
X-Proofpoint-ORIG-GUID: uOo_aaRQeCGharpyRDHTgsLLi5TOkcy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=993 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080057
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/8/2022 11:36 PM, Johannes Berg wrote:
> On Thu, 2022-09-08 at 23:23 +0800, Wen Gong wrote:
>> Now I found it only active the primay link(the link for
>> authentication/assoc request) in my station MLO test,
> Yes, that's intentional. It gives the driver choice about which links to
> activate; first of all because we don't have interface/link combinations
> stuff yet (waiting for your side on that), and secondly because we might
> very well (want to) negotiate more links than we can concurrently have
> active, e.g. a NIC that can have two active might still want to
> negotiate four and switch dynamically.
>
>> change_vif_links of struct ieee80211_ops *ops of driver will only be
>> called one time for the primary link.
> Correct.
>
>> it means only one link for MLO.
> Right.
>
>> I plan to revert this patch in my local test now.
>>
>> Will you implement muti-links later?
> Yes. I have patches pending to add API that the driver can call to pick
> the active links (as a bitmap).
>
> I'll send it out when I can, likely tomorrow.
>
> johannes
Thanks.
Another thing is what is the local MLD addr and local primary link(send 
authentication/assoc requset) addr relation?
I think they are same address for station, right?

And the others local link address is random generated by eth_random_addr 
in ieee80211_mgd_assoc() , right?
