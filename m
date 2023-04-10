Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7A6DC937
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDJQXB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDJQXA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 12:23:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09233171D
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 09:22:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFcFTx026807;
        Mon, 10 Apr 2023 16:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3lJMiVRfvN6h7n2bdTM/qCHW5/XoOFcofVx3jowYF/M=;
 b=jJSK2P2y+8fQ0f1IwRGlaAzppmAM7gGEZ4P9SuouZjIyLF/qHvgWahWOsRw/opJKhjzn
 Vb7R747V7f/o/pz36iMu8IScE59F7qPYKofXLHViTxJBY64ZSMVGSpgoFg1jZ7jroMJ6
 lwofEhaSu8aF9HKcs0bKy0QVkpT5zr2a9oFutDSJomKdDWf/3IxFzGkBAKfiOU1onwrW
 5u+unlSNzcKTIzvHgG+JuicQlm36kHNYEQAEy7tED27N0+esq7mHYJsKm5qHRg/oWTAn
 M8X6gyD0v6yne8HFawnK+ORhFQjDt5D8eeNsJnj8njM8RvNpsBXkdAcH4zUdeNtvGS+9 XQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu0c33cyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:22:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AGMsfb005885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:22:54 GMT
Received: from [10.110.38.151] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 09:22:54 -0700
Message-ID: <b3282c7d-07c5-8657-fca2-c286f82cb235@quicinc.com>
Date:   Mon, 10 Apr 2023 09:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 06/11] wifi: ath12k: prepare EHT peer assoc parameters
Content-Language: en-US
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230403225146.14139-1-quic_alokad@quicinc.com>
 <20230403225146.14139-7-quic_alokad@quicinc.com>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20230403225146.14139-7-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E8N7KmBj_Wjte4GR3RM9ZnvK1SVtU2TI
X-Proofpoint-ORIG-GUID: E8N7KmBj_Wjte4GR3RM9ZnvK1SVtU2TI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=569 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100140
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/3/2023 3:51 PM, Aloka Dixit wrote:
> Add new parameters and prepare the association data for an EHT peer.
> MCS data uses the format described in IEEE P802.11be/D2.0, May 2022,
> 9.4.2.313.4, convert it into the format expected by the firmware.
> 
> +	case IEEE80211_STA_RX_BW_320:
> +		bw = &eht_cap->eht_mcs_nss_supp.bw._320;
> +		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
> +				       bw->rx_tx_mcs9_max_nss,
> +				       bw->rx_tx_mcs11_max_nss,
> +				       bw->rx_tx_mcs13_max_nss,
> +				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320],
> +				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320]);
> +		arg->peer_eht_mcs_count++;
> +		fallthrough;
> +
> +	case IEEE80211_STA_RX_BW_160:
> +		bw = &eht_cap->eht_mcs_nss_supp.bw._160;
> +		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
> +				       bw->rx_tx_mcs9_max_nss,
> +				       bw->rx_tx_mcs11_max_nss,
> +				       bw->rx_tx_mcs13_max_nss,
> +				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160],
> +				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160]);
> +		fallthrough;
> +

'arg->peer_eht_mcs_count++' is missing for 160 MHz case.
Should I send a follow-up now for the series or wait for comments on the 
remaining part for some time.
Thanks.

