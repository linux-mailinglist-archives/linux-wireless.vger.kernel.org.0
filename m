Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D27A6BE8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjIST6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjIST6K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 15:58:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2865119
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 12:58:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JJvren024565;
        Tue, 19 Sep 2023 19:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gSXCT8FQGMYJCRx1nPBYPzXJcvZK8EgMLWEp+YSX6uc=;
 b=H9+MJ5G5xuf7PVtmA+Qm3clpMNgnh/Bp6ceo/3wClQ6fSg0Uvj3UYWxfrxALKo4TWcVK
 AT7vjZ6FxiQGP4RorxQXsH7BcWzcxQMyH6V4hTm9yi7H7K/LiB2THxMRKBpJ5pRgfQHx
 ImR/I0cIh0NfQ/w4GCI1BADLEX9okv9qu3Rdb6ndoBS2eCCMzM5c6A/SAjNWJP60nCUZ
 ElcM1NWbprFDBcO260LRvpFkK9d0AGllcNkDc1wX8NpTilgL2NbfcAMVck/cKXiaqjmo
 ivlLnBI7InmK4MY5Y2RtKPwey7j5QQWsdE+NCz/NN4A0bnR3yw07+4//ejyC1/vH6hxB 7g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6vcmajqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 19:57:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JJvqfk015289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 19:57:52 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 12:57:52 -0700
Message-ID: <66901daa-0c69-4a22-82fd-e66f8b6a011b@quicinc.com>
Date:   Tue, 19 Sep 2023 12:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] wifi: ath12k: build 6 GHz regd based on vdev type and
 6 GHz power type
Content-Language: en-US
To:     Aishwarya R <quic_aisr@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-3-quic_aisr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919071724.15505-3-quic_aisr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r12FLG9m12hq9NV3ceUh9KAoBgYy5ofZ
X-Proofpoint-GUID: r12FLG9m12hq9NV3ceUh9KAoBgYy5ofZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=436 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2023 12:17 AM, Aishwarya R wrote:
> During bootup, WMI_REG_CHAN_LIST_CC_EXT_EVENTID event sent from firmware
> at an early stage and it expects the 6 GHz power type for 6 GHz reg rules.

what is "it"?

> As power mode is not defined at this point host selects IEEE80211_REG_UNSET_AP
> as default mode.
> 
> When interface is created, it updates regd rules accordingly.

Again what is "it"?

I'm having trouble discerning what is existing behavior and what is new 
behavior.

That distinction should be clear.  In the past the following template 
has been suggested:
   " Current code does (A), this has a problem when (B).
     We can improve this doing (C), because (D)."
<http://www.spinics.net/lists/kernel/msg1633438.html>

Obviously that exact format isn't required, but you should at least 
describe, if it isn't obvious:
1) what does the current code do
2) what is wrong with that code
3) what should be done to the code to fix the issue

I don't actually have an code patch comments

