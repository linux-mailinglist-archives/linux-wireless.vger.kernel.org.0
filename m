Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA315A9140
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 09:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiIAHwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiIAHwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 03:52:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11A26AC1
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 00:51:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2817fXKN012735;
        Thu, 1 Sep 2022 07:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Eue0sgk6Iw3bZUoNX6C5z7ZR+QgUaCW+vtC2/KkgeWM=;
 b=kQuE34P24KCd/FqEHX0l1tPu9uzAOd3x4kZB5W5CcRyC6UHqQKxywnz4ebSuZVU3cAlE
 +7VCLxfkzcPi3widY1O6MpHEL7u8cUx1cWFCW3SquqlH1AhxbXVmzdKyEr2TQ9MYtDvD
 ItYDb9FM+OyQn4ys+wCHkY5Zr1ZTtScJfYKbXYmG7fLhixpFgu9JlLZiq8hR2boqEdF8
 ZCkqQSnH4d9FD8Hg0v/YZNpMlzH5YEKkhTMqvcai1iVMlRrBe6HOoTUrKyxGX6xkslks
 QNOXzzHhUGjJNUMBAEA6DBPwiT1qf2LvKMkZFoJPalisoAVwu5Co9l5LN7ZYh9VEei74 Nw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9txbn9yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 07:51:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2817pcmk010552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 07:51:38 GMT
Received: from [10.216.18.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 00:51:36 -0700
Message-ID: <0b6f1484-0e07-dde5-6c33-a898f5711c17@quicinc.com>
Date:   Thu, 1 Sep 2022 13:21:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ath11k: Add support to connect to non-transmit MBSSID
 profiles
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220720134622.15293-1-quic_mpubbise@quicinc.com>
 <166192554340.26203.2447393721716803657.kvalo@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <166192554340.26203.2447393721716803657.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v6BB_cZCBHJIyKx5c0LQtxE0QAM8n93P
X-Proofpoint-ORIG-GUID: v6BB_cZCBHJIyKx5c0LQtxE0QAM8n93P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_05,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=953 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/31/2022 11:29 AM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:
> 
>> Add support to connect to a non-transmit MBSSID AP profile.
>>
>> Non-transmit MBSSID profile parameters are passed to the firmware
>> via WMI VDEV UP command and this helps firmware to track MBSSID
>> profile within the multi-BSS beacon and report beacon loss if
>> any.
>>
>> WCN6750, QCA6390 & WCN6855 firmwares have the support and hence
>> enable the support on these hardwares.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Failed to apply. Again please use --base.

Sure, I'll rebase and send the next revision.

Thanks,
Manikanta
