Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0F5EDFE8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiI1PPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiI1PPa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 11:15:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EFB3F1D5
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:15:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SD9XMq028978;
        Wed, 28 Sep 2022 15:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XXMZJOF4U/G1KdVZJFaEBgm2/7dhehp/e3bKTQDT9gY=;
 b=l06WA+2LV00v2YGMT5Q3YSgR3yzUlwadfo4EjXtD2kNLlGAPMympOILFWg4RzgwxDWrB
 6lEU1KZaOhixSdx/yqEJ6+YxUaPjrqC3Ewap/x0eKIUgakXRinVn9vT4tKjFIRVZfnOG
 udecipZ4g5YTslIBBLEmA2aR5oEqFYEOsuW5/6x/IfP8Q5DXOUZhiBjeuC9lEIlzfH8Q
 63GmwObA6EBdxgFjPkdog1IkKFPwvfpz7nyq3bETnQXq2z+DFEMdq5IuisR4C+iJnwqK
 LsOft1GvR3DvnA9ICdK+veXfrPtzPw4u5R0vrH+iRlGr6E9IWyiFrFH5FNo8bUNVXXTt Zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuv8ema-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:15:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SFFOaZ012525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:15:24 GMT
Received: from [10.253.33.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:15:23 -0700
Message-ID: <5771c6e4-b406-0535-d63d-981da1f607b1@quicinc.com>
Date:   Wed, 28 Sep 2022 23:15:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: unicast probe response bssid changed by "wifi: mac80211: do
 link->MLD address translation on RX"
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
In-Reply-To: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A_n0UFruUkxaSFVnBjmG9pIInRWhpobY
X-Proofpoint-ORIG-GUID: A_n0UFruUkxaSFVnBjmG9pIInRWhpobY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=669 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280090
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

May I get your comment about this?

On 9/14/2022 11:13 AM, Wen Gong wrote:
> Hi Johannes,
>
> The mac addr of unicast rx packet all changed to the MLD address by 
> below patch.
> Now the probe presponse which is unicast packet is also changed mac 
> address here.
> I found bssid which is the MLD address of my test AP in 
> cfg80211_get_bss().
> For example, if the AP has 2 mlo links, link 1 is 5 GHz band, link 2 
> is 2.4 GHz band,
> then the 2 probe reponse will be changed to a same one.
> seems we should skip probe presponse for the mac address change here, 
> right?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=42fb9148c078004d07b4c39bd7b1086b6165780c 
>
> wifi: mac80211: do link->MLD address translation on RX
>

