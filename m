Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D137F4C65
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjKVQbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjKVQbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 11:31:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A09A
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 08:30:42 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM9NIx3017219;
        Wed, 22 Nov 2023 16:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ooLwiKr7YFkuWv+mAjo2CKrIt+gr47FgPEncR9VXhxU=;
 b=Aghy6+eHdURUFgEQFGi7+2WVF7e9QhYHOb3IhtMBnOmxgB2500a9TY9b2z/myLVnbGXN
 /AWj5ptSApaJQkdW73IB6nmjkJfJCROILx5y7lC+vbXyTGg+3FC9d/IpoYLZNP3TPtdH
 DpLEXKRSjbgTj9mwBua7r9VyphseQxIi/Cn/H4FIbr4MNWU+Lq5bZ1tE7V8fJ/jzw0bW
 yZEOjG8VaDZeVcKqooIDlJca/MQJ5SiS+wsp/z+SouCIXYQcq562wrwK1sZy7I1LXQtw
 jGiKKxhdKUKpDVcpAGfGTXRzngBoEZ46W4+60y0eAMSUoWGhS13njvM1yBboT8rB1adI qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhey591rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:30:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMGUOPY006343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:30:24 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 08:30:24 -0800
Message-ID: <2204a1a1-d437-4c69-9e3a-bcc7807c8069@quicinc.com>
Date:   Wed, 22 Nov 2023 08:30:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: fix calling correct function for rx
 monitor mode
Content-Language: en-US
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
 <20231122063932.10321-2-quic_tamizhr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231122063932.10321-2-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1JDC1QUZtYwUmoA-MAJnb-7Ai8jiEYd8
X-Proofpoint-GUID: 1JDC1QUZtYwUmoA-MAJnb-7Ai8jiEYd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=804
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/21/2023 10:39 PM, Tamizh Chelvam Raja wrote:
> Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
> ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called
> twice. Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().
> 
> Currently monitor mode is disabled in driver so the change is compile
> tested and boot sequence verified.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Since monitor mode is currently disabled, perhaps we should drop the
Fixes tag since there is no reason to backport to prior kernels?
I'll let Kalle make the call on that.

> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

