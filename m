Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2617DBC7F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjJ3PVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJ3PVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 11:21:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B9C9
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 08:21:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UEjY5t026097;
        Mon, 30 Oct 2023 15:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E7VXTweBTjFRGjzdzmSFzaXO7Tpr1NwxGwtvrC4I/ZE=;
 b=p8reeQ/UTG4KLl7DvVXfQjI7v8sLdlFmOUhRcCYx30QDKedZuZ6uDuAlAWtpKxUnpGcd
 EJMfcYTc8WfHFLe6rTyendEO60dXtp+QORMkXdPVEQHRBtsR1zALjhMN4YCXKnfk6qTY
 Eeu31RQkIXZpHXvOXkLSzXFqcgOWMKudfDsancLlMp43R6aAQtHaXz3Rw7vegbzaeQuV
 tOaxNcJA5E9uuzsyW78mV/Jj8jOKjabrw61BWME/6D7JXOviyvmzn4xaHSxIkzj8pSEd
 AuLTIxxMRgSutmMYJfx4QaUTryRv1hXKuxD6aUz0u427NHKX6wud14dyL3P/MTVn7wXn 6Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7v6g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 15:21:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UFLC18032594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 15:21:12 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 08:21:11 -0700
Message-ID: <37452ae3-3006-41ca-9b31-f0d4bed75e35@quicinc.com>
Date:   Mon, 30 Oct 2023 08:21:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ath12k: Factory test mode support
Content-Language: en-US
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lty-8jUdwIdU3R1GEM_-wN4m7hbuAo5r
X-Proofpoint-GUID: Lty-8jUdwIdU3R1GEM_-wN4m7hbuAo5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 1:27 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (3):
>    wifi: ath: create common testmode_i.h file for ath drivers
>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>    wifi: ath12k: add factory test mode support
> 
> Rajat Soni (1):
>    wifi: ath12k: Fill pdev id for fw test cmd
> 
>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>   drivers/net/wireless/ath/ath12k/core.c        |  19 +-
>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>   drivers/net/wireless/ath/ath12k/mac.c         |  13 +-
>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>   drivers/net/wireless/ath/ath12k/testmode.c    | 413 ++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/testmode.h    |  42 ++
>   drivers/net/wireless/ath/ath12k/wmi.c         |  38 +-
>   drivers/net/wireless/ath/ath12k/wmi.h         |  22 +-
>   .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
>   13 files changed, 624 insertions(+), 72 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
> 
> 
> base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85

That base-commit is pretty old (tag: ath-202309051328) and your series 
fails to apply to current ath-next, please rebase:
Applying: wifi: ath: create common testmode_i.h file for ath drivers
Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
Applying: wifi: ath12k: add factory test mode support
Patch failed at 0003 wifi: ath12k: add factory test mode support

In addition, please use
