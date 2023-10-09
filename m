Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA07BE73E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377138AbjJIRAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376950AbjJIRAO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 13:00:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1898CC
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 10:00:10 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EjWGu025532;
        Mon, 9 Oct 2023 17:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UlDOppxQT3UIpZ3cnTZKUVvTyWX3ee38hDdLgDHBERk=;
 b=I86If8pikm9OC5xuE9XyRB0rqrRhhsWI0ApqpqWf/1FhRmtmz0FDzZZAEGmKDxyEk/dQ
 LSEvH7Gbrwg599ClUkXWgW1hXKQ/B1foPhsCjj6QNlGb14A4njeHULrcyChrOq5jEjw/
 UyhRotLX7ytcxfs57UEdllDaCg9tez7W3QX1rsaKFN0X4fe3Ca/W7qyie1zN8/vV6LWJ
 g6TvTZRH5fVE0TegG+vAwp4Qtm13DSs0p5wW16rbm7MAN+sVw4yrg7HV9tUmNErmUi94
 Ervt2z75deQV5+rJECC13nY+m25iChlvxy3EnLyYK/nQohLR2E1n0Oz6vTq6RslNQJro Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh87b0eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 17:00:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399Gxx8E011531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 16:59:59 GMT
Received: from [10.111.180.41] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 09:59:59 -0700
Message-ID: <757d6d82-b4fd-4bce-98e5-bbf09724e37e@quicinc.com>
Date:   Mon, 9 Oct 2023 09:59:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] wifi: ath12k: add TAS capability for WCN7850
Content-Language: en-US
To:     Lingbo Kong <quic_lingbok@quicinc.com>,
        <ath12k@lists.infradead.org>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231009090149.247211-1-quic_lingbok@quicinc.com>
 <20231009090149.247211-2-quic_lingbok@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231009090149.247211-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YjLcXZUcm76j6AKWOcZbvClyVYFfy4kp
X-Proofpoint-GUID: YjLcXZUcm76j6AKWOcZbvClyVYFfy4kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=1 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=1 malwarescore=0 mlxlogscore=218
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/9/2023 2:01 AM, Lingbo Kong wrote:

...

> +void ath12k_acpi_remove_notify(struct ath12k_base *ab)
> +{
> +	acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
> +				   ACPI_DEVICE_NOTIFY,
> +				   acpi_dsm_notify);
> +}

As flagged by the kernel test robot, there is no prototype defined for 
this public function. In addition, I don't see any callers anywhere in 
your patch series, so it seems either this should be removed, or a 
correct call site should be identified and the function prototype should 
be defined in the appropriate header file.

/jeff

