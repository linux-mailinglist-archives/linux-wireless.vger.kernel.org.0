Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F678D9E4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjH3Se0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbjH3IAj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:00:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7ACD8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:00:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U7x93o002118;
        Wed, 30 Aug 2023 08:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8RZdUtZmXv/klRTPQ3Ec+nUJbjlbfxEwgoCRLy7pPiQ=;
 b=pNlBHh1aqW7m1CIth8zxoAQCW1LIPML4/D/DWBiUo36xm0ZuMiqqzlqzvcTcWkhX20Ru
 TEdOorAzI/YtO7W4AVkHYEWU0ErI7csHO85daL83TJ8LLJDKRM7aVwQquGP+6akppcIo
 FN92UiqbiVuFm0qqZnTX5FM8G819fQciI2d1UqtpbtJjpcwI8vZVy2RgAAuE6AzP97zi
 n/zKiuGwv3m7V2J+gQ0MU1P44CQ6IpweUs6GaGIjTaaCs6d2yLj2xX+4NOPcz7NGXEO+
 FrXVm8l9YDkfO62LSJTPLeHht88FCJsN32WZtqLy4SxCee1m1uVzXOaWc7YnGGSFMJmA Sw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss0523x61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 08:00:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U80Clu015295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 08:00:12 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 01:00:11 -0700
Message-ID: <8dfb323b-1bb2-c586-c29f-2af9c598ceb7@quicinc.com>
Date:   Wed, 30 Aug 2023 13:30:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
 <afd7a85c-e1ce-6a6e-a29e-74ccc0d8bd08@quicinc.com>
 <6390d2b539b7da5fe2e0d891de26917654a6aa1a.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <6390d2b539b7da5fe2e0d891de26917654a6aa1a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DV98Ln4geHqRqlc9uqHfCjM07yZkfJ9a
X-Proofpoint-GUID: DV98Ln4geHqRqlc9uqHfCjM07yZkfJ9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300074
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/23 13:14, Johannes Berg wrote:
> On Wed, 2023-08-30 at 10:43 +0530, Aditya Kumar Singh wrote:
>>>
>>> Why do you even need to set *from userspace* the power mode for a
>>> client? That ... doesn't make that much sense?
> 
> Oh so you addressed that here, sorry.
> 
>> Because there are two possibilities? Default client and also connect to
>> Low Power Indoor AP as well as sub-ordinate client. So to let the kernel
>> know which mode originally the client is in, the command was introduced.
>>
>> I do understand the concern here about possible misuse for the command
>> from the user space, I would re-visit this area and try to cover the
>> loop holes if any. But don't you think it should be the case? Basically
>> same like how we tell via user space the SSID, keys/suite info. freq
>> list and all for a client, in a similar way tell the power mode.
> 
> I just don't understand how userspace would possibly know what to do.
> You can't really expect the _user_ to select this. So how does
> wpa_supplicant know what to do? How does it know better than the driver?
> Where does it get the information from?
> 
The power mode selection for client purely depends on how much tx power 
the user wants for the client. In short, subordinate mode type client 
can operate on more tx-power when compared to Default mode type client.
For example, let's assume they are going to connect to LPI AP. PSD for 
Default client should be -1 dBm/MHz or less and for sub-ordinate client 
should be 5 dBM/MHz or less​ (US regulatory). Technically, the power 
mode of client affects the PSD which has indirect relation with the 
Tx-power.

So if user wants more PSD, in supplicant, it can be configured with 
Subordinate or else default type.

Reg your other question:
 > Anyway you're tied to what the AP is doing, no?
Yeah since for AP the command was introduced, leveraged the same for 
client to. But now since we have option to leverage from update beacon 
infra, something similar for client need to explore.

> johannes

