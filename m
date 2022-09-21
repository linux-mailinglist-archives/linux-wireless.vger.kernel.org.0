Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479515C0097
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIUPAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIUPAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 11:00:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D74D17D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 07:59:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LERgQs010092;
        Wed, 21 Sep 2022 14:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zIVZOxjVRvKF8rXDWuDJiLE18YVUCmm7M5aE1NPXWx4=;
 b=kjAm2QuOaGdyP6MZKKif9frREtWJ80g0YLUSj13uSMUl2HCIm4120GKz1JSi3BRk0dvV
 A4vSGgKe1BJhufTCjSKPyMgfuF6TuEr0HdmfCX9sgTDXtif+4K54VMhsUwra7HaLkxLE
 n0srOuOYsnrRd7zGiqkKjw8A92qKVIZOblqhPF0/39pir9/oZrO732+E8S8II9Z2iV63
 HbnqDHtwyz4Ye7BXvAAYvyLE1c0zEqYZaKtn1IINL+yRmsR/sQ7wWaQLr7tNPyT0DpJ8
 ZlTVfPTH0bVsEfG1br+LoBjTP4zPdmzpa8QU5oNXohbcuTYTpbw3MQwFD6ikxa/WfIkN Lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq8fw550g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 14:59:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28LEsgN5019150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 14:54:42 GMT
Received: from [10.110.44.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 07:54:41 -0700
Message-ID: <2c0b33e9-8690-7a42-3eff-e18b52298357@quicinc.com>
Date:   Wed, 21 Sep 2022 07:54:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v2 1/6] mac80211: modify tx-power level annotation
Content-Language: en-US
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, <nbd@nbd.name>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-2-jelonek.jonas@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220920104032.496697-2-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Krzbd7JZ0zBjl-mXIKAolpHOIHvzLHh
X-Proofpoint-ORIG-GUID: 4Krzbd7JZ0zBjl-mXIKAolpHOIHvzLHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_08,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=570 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210102
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/2022 3:40 AM, Jonas Jelonek wrote:
> This patch modifies the annotation of supported tx-power levels for a
> wifi device in ieee80211_hw. This annotation was introduced with commit
> 44fa75f207d8a106bc75e6230db61e961fdbf8a8 to be able to operate on power

nit: preferred way to reference a commit is 12 characters of hash + subject:
44fa75f207d8 ("mac80211: extend current rate control tx status API")


