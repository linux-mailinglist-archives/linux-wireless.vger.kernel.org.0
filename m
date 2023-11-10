Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A87E8259
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjKJTQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 14:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjKJTQq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 14:16:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEB7E2D
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 10:54:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAIckbC026572;
        Fri, 10 Nov 2023 18:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hUIa1xw7MNKdlnHkIlbisQWeSZuSkGwfRvkO7Fyg85c=;
 b=RAbZhXxb7hC3UxM+M6toWjoNEWNRtpls/IkGTMpcZGFaUiC8r+Uk7EkN6FEGglGh7Z26
 I3ghKLCeWu4XdnyQMS6bLwvOmgb/r4NNmHfGOg4k82QZqB8Ssl0qBBqrZv8BMHKY8S3H
 yQMmIVI50hKSV9Gt7YX8Nl1g9oELZtUFkEjDrw4h6wFhsRjLzQF1efum9VsNm+Em5f0v
 JPdMKSw2UM/n7/kOJ/tOeoqy9tin9gZA1oQrRS4V2FLGyAe/YcQGdsOGq8ayJopdu985
 3n1xXtFPVocsmCUU7ZKinQhFEDT9aF3Gs9fobbKwFDEh87LSicWBJeWHxmpM359d3b3i Zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9q0w0fft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 18:54:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AAIrxok013208
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 18:53:59 GMT
Received: from [10.110.6.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 10:53:59 -0800
Message-ID: <3d54205c-46a0-4353-b1c0-1f5afe8d4c5d@quicinc.com>
Date:   Fri, 10 Nov 2023 10:53:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ath12k: Refactor Rxdma replenish arguments
Content-Language: en-US
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231110081317.19608-1-quic_periyasa@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231110081317.19608-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7KZH7TBnPdqIj9UdsCnZYXjYmI9BqNMO
X-Proofpoint-ORIG-GUID: 7KZH7TBnPdqIj9UdsCnZYXjYmI9BqNMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=372 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2023 12:13 AM, Karthikeyan Periyasamy wrote:
> Avoid the explicit arguments of Rxdma replenish to optimize the per packet
> rx data path CPU cycles. Also refactor the Rxdma ring structure.
> 
> Karthikeyan Periyasamy (4):
>    wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
>    wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
>    wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
>    wifi: ath12k: refactor DP Rxdma ring structure
> 
>   drivers/net/wireless/ath/ath12k/dp.c     |   4 +-
>   drivers/net/wireless/ath/ath12k/dp.h     |  11 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c |  10 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.h |   2 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 143 ++++++++++-------------
>   drivers/net/wireless/ath/ath12k/dp_rx.h  |   6 +-
>   6 files changed, 76 insertions(+), 100 deletions(-)

Can you respin and update the QuIC copyright to 2023?

