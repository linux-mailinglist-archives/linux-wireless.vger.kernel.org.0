Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4E787753
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbjHXRzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbjHXRy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 13:54:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D391BD9
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 10:54:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEZH1m002147;
        Thu, 24 Aug 2023 17:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=axJ9BPmx8wV0N98OsonZlC+Fs4E3KvTFeWp45IGIo90=;
 b=K5ilHratgik+RZiYvwLom7h7I4TXxhIkhlAbUsCZTWV1GANsV4DXJ3O2LXl/QLO9X+75
 BCAGqv3hFaI/is0nVR3wgLs2b0LLlRtyqmWu7OTfLugiU5C8tbM33OBM/7k5s6vXu1PN
 7Gg0kBmLSI8m4Zr7PzziVJi1dKCsUzfxt2trwqd5AAfu9nNQBEIgaUm/bMajr1m3p2TQ
 NgRsqjk3Fp5T7NEkos9f4cQ9V+UEAHwNeDqXLLtjgg7MvzvfFJ4vv5JDxDh67UcULKBn
 fFAYG+gGC7NcV02RII3gMDREoXS6g2eTjjM5RY8fqj0cQU3IOSrnXZXoTedKd//VY1n2 xA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumuc1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:54:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OHsjvc005720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:54:45 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 10:54:35 -0700
Message-ID: <5354cefc-f3d5-44c5-a886-bcdf91ffc2a7@quicinc.com>
Date:   Thu, 24 Aug 2023 10:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] wifi: ath11k: remove unused members of 'struct
 ath11k_base'
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        <ath11k@lists.infradead.org>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
 <20230824075121.121144-2-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824075121.121144-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LJNhENoLPhMEVUuKRKyoY2ZRKRwGQPQ6
X-Proofpoint-ORIG-GUID: LJNhENoLPhMEVUuKRKyoY2ZRKRwGQPQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_14,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=813
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/24/2023 12:50 AM, Dmitry Antipov wrote:
> Remove set but otherwise unused 'wlan_init_status' and
> 'wmi_ready' members of 'struct ath11k_base', adjust
> 'ath11k_wmi_tlv_rdy_parse()' accordingly.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/core.h | 2 --
>   drivers/net/wireless/ath/ath11k/wmi.c  | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index b04447762483..650972f9d146 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -901,8 +901,6 @@ struct ath11k_base {
>   	struct list_head peers;
>   	wait_queue_head_t peer_mapping_wq;
>   	u8 mac_addr[ETH_ALEN];
> -	bool wmi_ready;
> -	u32 wlan_init_status;
>   	int irq_num[ATH11K_IRQ_NUM_MAX];
>   	struct ath11k_ext_irq_grp ext_irq_grp[ATH11K_EXT_IRQ_GRP_NUM_MAX];
>   	struct ath11k_targ_cap target_caps;
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 23ad6825e5be..a5cf97368a14 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -7222,14 +7222,12 @@ static int ath11k_wmi_tlv_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len,
>   		memset(&fixed_param, 0, sizeof(fixed_param));
>   		memcpy(&fixed_param, (struct wmi_ready_event *)ptr,
>   		       min_t(u16, sizeof(fixed_param), len));
> -		ab->wlan_init_status = fixed_param.ready_event_min.status;
>   		rdy_parse->num_extra_mac_addr =
>   			fixed_param.ready_event_min.num_extra_mac_addr;
>   
>   		ether_addr_copy(ab->mac_addr,
>   				fixed_param.ready_event_min.mac_addr.addr);
>   		ab->pktlog_defs_checksum = fixed_param.pktlog_defs_checksum;
> -		ab->wmi_ready = true;
>   		break;
>   	case WMI_TAG_ARRAY_FIXED_STRUCT:
>   		addr_list = (struct wmi_mac_addr *)ptr;

