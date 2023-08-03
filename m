Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F376E4B2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjHCJlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjHCJlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69472213F
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 02:41:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3736cd0E006446;
        Thu, 3 Aug 2023 09:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oMFOj4CPTdcUMCz1lZPzPS2D1UbuapHX2+Br3qM+YoM=;
 b=JfyqC8bBbOHSENtv4kgLWqmouGOCyWxi7FGghTBngg/h7FA9L65NP+0IaQcklkf4Udl6
 66ZbjbBXIDKOufrc8aX7LW7/8ZFHtrgske7E7tBdDrw5id/uhBAp/QLe1vVct2hAQqIH
 nBC/8aB3GNjD/J/fpgHz1jKqTL4XToBudpItInc4oHBVOz5ra3uRrCtxgEJPa9c4h8gJ
 Oogh2XlVjdgwr2OPPDwfNLqgIgij2SsTvDIy/w1wzfo6cC+2urVA8WBdj7HFxRwp9tc+
 pJchoIABHjgR+lMHIVjI1XwmX/OMMwXJJbCVxheNrkhXQMD63rgNtMmBMwveRcBJn3Y8 aQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s83q0gnp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 09:41:00 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3739egMr017999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 09:40:42 GMT
Received: from [10.231.195.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 02:40:41 -0700
Message-ID: <1bbe5e90-1f37-3926-98f7-a685578fef8f@quicinc.com>
Date:   Thu, 3 Aug 2023 17:40:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for
 device recovery
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230721055305.20420-2-quic_wgong@quicinc.com>
 <169105464227.894438.15435946207134709277.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <169105464227.894438.15435946207134709277.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cl9LxbwMu0gRTia_nU6i8A79p_SDW18l
X-Proofpoint-GUID: cl9LxbwMu0gRTia_nU6i8A79p_SDW18l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_08,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=696 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/3/2023 5:24 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> RDDM is RAM DUMP DEBUG module, it is used to debug issues when firmware
>> encounters an error.
>>
>> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
>> to support device recovery when ath12k receive MHI_CB_EE_RDDM message.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> I'm not sure what "support device recovery" means exactly. How does this patch
> change functionality from user's point of view?
>
> No need to resend because of this, I can add that to the commit log.
Device recovery means SSR(subsystem restart), when firmware happen 
crash, ath12k
will receive the RDDM event, and then ath12k/mac80211 begin to re-start 
wifi/firmware,
after that, the wifi become normal again.

This patch is to let firmware report RDDM event correctly to ath12k. 
Without this patch,
firmware will not report RDDM event to ath12k correctly, then ath12k 
will not begin SSR
process.

I think it should be changed like this:
The rddm_size is needed by firmware while MHI enter RDDM state. Add it
and then firmware will report MHI_CB_EE_RDDM correctly while firmware
encounters an error, then ath12k could start the device recovery process.
