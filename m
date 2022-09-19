Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04635BD844
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiISX3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiISX27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 19:28:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E964E844
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 16:28:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JNDiER016722;
        Mon, 19 Sep 2022 23:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+JQ7W81fJLeXGAc/5OMEqLXZvEH/GOCC6VvHQZtM5kw=;
 b=nPU9gxDAqZFGDEaaK72mpEPeT2O8M3EjCHyfnBN28n2gsPVQwO1VeSbVoYa5SoMKZlBu
 OPNMVBqY+xkbU/RkaJumTBlu/TkcpjVKKfVe70Mabbke85ku8q+9i753SKVMSgykw6ba
 DkqB+SXVtB2rpu3qV35dqx422ND7q36RNn0Bh1ZCZ8tLQxQStkSLo5Nm41AW4YCvO8gj
 EtZ1ZyE5sXb9mmHTzbqDp+Xz/XUvx7/SClbzs/hO4j2ACy3a/HQ7WOMgw9stTNirOQkg
 f2CcCjQhx9EQCweYtRz6izZanJGY6xSYL5vipyyoL5CQIyaLJ2HhrB7Q+9QLK0Ms51Q8 8Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpt21hsys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 23:28:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JNSlQK022286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 23:28:47 GMT
Received: from [10.110.44.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 16:28:47 -0700
Message-ID: <a6b7588b-21f3-5ad3-8ad9-cd39e415ce32@quicinc.com>
Date:   Mon, 19 Sep 2022 16:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] wifi: ath11k: retrieve MAC address from system
 firmware if provided
Content-Language: en-US
To:     Jun Yu <junyuu@chromium.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220919185448.545399-1-junyuu@chromium.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220919185448.545399-1-junyuu@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p67-acICJ9NM6sg5ovGqiO-GqYCEv1bg
X-Proofpoint-GUID: p67-acICJ9NM6sg5ovGqiO-GqYCEv1bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 mlxlogscore=985
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190156
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2022 11:54 AM, Jun Yu wrote:
> Devices may provide their own MAC address via system firmware (e.g.,
> device tree), especially in the case where the device doesn't have a
> useful EEPROM on which to store its MAC address (e.g., for integrated
> ahb WCN6750).
> 
> Use the generic device helper to retrieve the MAC address, and (if
> present) honor it above the MAC address advertised by the card.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Jun Yu <junyuu@chromium.org>
> ---

v2 but no changelog?

>   drivers/net/wireless/ath/ath11k/mac.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

