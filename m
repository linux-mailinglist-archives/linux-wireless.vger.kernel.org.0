Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC6661426
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjAHIrI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjAHIrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 03:47:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC4B16
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 00:47:04 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3088iF26009992;
        Sun, 8 Jan 2023 08:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kcs6id3qrBsvoMjQ1gVec5Tsn02DIz+0x/mXnJP6M1s=;
 b=hMbebc78nFalpLthxOsf8yHyTIPJ1uqhiSazq9w84HomwlrlJgrs8piIAYLWKgzaqlQ0
 /WkJ5m3p8W66jxJZ+tAwYHbGD0kPw2xHT3FmD/LR0k6HhlXKfhEO288kNwaRfuCCzQL/
 qw4FtmbMZ+vnwtkeig1BDOEs6acMyU1V1iGtM7HtsIDe2STX1JNhgSdvjVQ6v0TYJVXH
 WiSpdy6nw08cHKOPucOhNIGdtq7VgqDR06edJPNtwCYkOcBMFKCHwo3ZhtOM5/6KoR/R
 2qBYXQtG/bSu0l9fkTtelUtwoW+CkfjdzfU6pAhiRnIf4fevyc15m9KOzk2LMFRfJsif wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0ya9aa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Jan 2023 08:47:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3088l0H0017234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Jan 2023 08:47:00 GMT
Received: from [10.216.50.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 8 Jan 2023
 00:46:59 -0800
Message-ID: <15beaf63-aba5-0b19-e6f7-368cac8e97f9@quicinc.com>
Date:   Sun, 8 Jan 2023 14:16:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] wifi: nl80211: Add support for randomizing TA of
 auth and deauth frames
Content-Language: en-US
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230108071552.2646591-1-quic_vjakkam@quicinc.com>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <20230108071552.2646591-1-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 35EWO8zKgS2v5xOB5-ZzbtaAwkkv4iIo
X-Proofpoint-ORIG-GUID: 35EWO8zKgS2v5xOB5-ZzbtaAwkkv4iIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_04,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=931 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301080060
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 1/8/2023 12:45 PM, Veerendranath Jakkam wrote:
> Add support to use a random local address in authentication and
> deauthentication frames sent to unassociated peer when the driver
> supports.
>
> The driver needs to configure receive behavior to accept frames with
> random transmit address specified in TX path authentication frames
> during the time of the frame exchange is pending and such frames need to
> be acknowledged similarly to frames sent to the local permanent address
> when this random address functionality is used.
>
> This capability allows use of randomized transmit address for PASN
> authentication frames to improve privacy of WLAN clients.
>
> Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>


The changes submitted in this patch series can be verified with 
hostap.git HWSIM test case changes submitted in below link

https://patchwork.ozlabs.org/project/hostap/list/?series=335502&state=*

---

veeru

