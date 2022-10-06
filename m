Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E415F6485
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJFKuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJFKuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 06:50:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F05E1F2FA
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 03:49:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296AAWEM012506;
        Thu, 6 Oct 2022 10:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : references : subject : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Oy1CobSRLDS9NfLG++btYc6aIBOA5o8Ci4YRBY9NT1g=;
 b=JV4hjtbN6PkCxb1Lhcl2xbB/OdpiPeliBVBgPoH9DARdMe91OPrZCeMvzX5osCB1XhNd
 bzsnM5pVj1gQWEdYfTo0T19w6OPr1o9s8vj9pmcxdxzxGIDlZVHMO4SWH2d8SHmtGhSh
 khXMQVc4kl/Ou2VLttiRq6Wdg6YxaQkqdhGe3D5SMAqebsHOvevdu7IbbsIVG+rDYu2Q
 HFLlAWSsgwy/dgexOTbG0lCAJZrviuf+McWqhiNsVjzihafeX6aKyVC8JVZSauXOKvi1
 TGgQukrtDOwHc5XofD3h+XCEswdKHywBMd7gflAN8PsEYLkRO8PEHQ0heZFsx+PvtdfR yg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0rf43ubu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 10:49:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296AnqCi011440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 10:49:52 GMT
Received: from [10.216.43.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 03:49:50 -0700
Message-ID: <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
Date:   Thu, 6 Oct 2022 16:19:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
To:     <johannes@sipsolutions.net>
CC:     <johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>
References: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
Subject: Re: [PATCH 05/28] wifi: cfg80211: support reporting failed links
Content-Language: en-US
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c3NV7EADGrP7b93DIyjBBSxg4xpHTyT5
X-Proofpoint-ORIG-GUID: c3NV7EADGrP7b93DIyjBBSxg4xpHTyT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=593 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060064
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I think similar enhancement needed for cfg80211_roamed/NL80211_CMD_ROAM 
also to know accepted and rejected links info during roaming.

- veeru

