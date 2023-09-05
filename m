Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D3792FA2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjIEUM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjIEUM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 16:12:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F67E46
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 13:11:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385HNHv8008843;
        Tue, 5 Sep 2023 20:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8EdnbG3zxxM/awbyUfqnLAXNADRb96h/KrvxtnRAUC4=;
 b=JxUys3JX2HjE0egs2h/xslJVJqIwsK8Q/BSKaho+845FAdAv/wXezl/dIeJuscssk1dW
 7hFiMzgLzM4RbsdOjhg6eTjX+qnUIWdDAJJsWyRNK/VRqWVuU5fki5Ir/21No/odlccL
 CYbY9ug32brHWJMWvPjAOMdLLJWLQBMs2XOyGhHjAqpHcA8LJ76oRTHklFJfYyUjHrwC
 8wPG6VhD657xbvgO57Lzsv3GEQNvlpdvHKbR5hBFBBqMJXOSUbMUnQrRagq2prZWci/6
 hxRU6gfHjVnUbbMoLf1aSUjdlfuEyFPfOfzXdgvk5uQMgQtM0jFlWmTrRjknMRjRy7N/ qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swsp5a8h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 20:11:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385KBIWb016306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 20:11:19 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 13:11:18 -0700
Message-ID: <7ce004c6-2767-4100-867d-a47e210eb876@quicinc.com>
Date:   Tue, 5 Sep 2023 13:11:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: call ath12k_mac_fils_discovery() without
 condition
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        <ath12k@lists.infradead.orgi>
CC:     <linux-wireless@vger.kernel.org>
References: <20230905174324.25296-1-quic_alokad@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230905174324.25296-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PHCZ1xy9g2NX0So9PCjINZfBF7w578Qk
X-Proofpoint-GUID: PHCZ1xy9g2NX0So9PCjINZfBF7w578Qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=964 clxscore=1011 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/5/2023 10:43 AM, Aloka Dixit wrote:
> Mac80211 does not set flags BSS_CHANGED_FILS_DISCOVERY and
> BSS_CHANGED_UNSOL_BCAST_PROBE_RESP if there are no updates to
> FILS discovery and unsolicited broadcast probe response transmission
> configurations respectively. For BSS change operations such as channel
> switch, this results in the transmissions getting stopped because the
> driver does not send WMI command to firmware if the flags are not set.
> Remove the checks for the flags to always send the existing
> configuration to firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 88346e66bb75..94967f810093 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2761,9 +2761,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>   		}
>   	}
>   
> -	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
> -	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
> -		ath12k_mac_fils_discovery(arvif, info);
> +	ath12k_mac_fils_discovery(arvif, info);
>   
>   	if (changed & BSS_CHANGED_EHT_PUNCTURING)
>   		arvif->punct_bitmap = info->eht_puncturing;
> 
> base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85

