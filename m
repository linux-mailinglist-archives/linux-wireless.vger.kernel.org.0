Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8126A75F2F8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGXKXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjGXKXK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:23:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0D49D5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:16:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6FmuM000883;
        Mon, 24 Jul 2023 10:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cfewn56TVGilkmEgIByWqsa6Ek2mqMzLIsbNYs2uegI=;
 b=BMi/hewY69T7bB2FJgqpb1r5DleYLGVqj2+zGdAddmTGlHbZahU538M2SS2OQluxmLqL
 ObWANCPAwLfayEE9/+K0TXqHPefaSmHjuV/2DUfKRM7PHpi64cxvNAGaRfe9jR7B3NX0
 JYEz6Ggq4sXi39iky/zFrs9mwUpf0PbClYCMl+v28CRmz/ZaTGcW3qV+ys0qj9maXHRw
 /yROdztBapPu0xDF07Vr+nWw/cBtY3OOnXxii5i4p2mT6BBW/Gw8d/Fscbw6JtdIprpR
 /KcdvUVN2/Gy3ZJoRw0rR2Ahb25o8ru0AB8Jk2Ao8nOJAnvSYdTH4soVVFXROkxd4Tco +g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s089ttvvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 10:16:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OAGTiP019896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 10:16:29 GMT
Received: from [10.253.76.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 03:16:28 -0700
Message-ID: <f4515520-1d3b-1b07-6ddd-ae269c12a91f@quicinc.com>
Date:   Mon, 24 Jul 2023 18:16:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/11] wifi: ath12k: prepare EHT peer assoc parameters
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-7-quic_alokad@quicinc.com>
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230602235820.23912-7-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3riSjrm0_YjQubqt7MbLv5nz8B56jQiO
X-Proofpoint-ORIG-GUID: 3riSjrm0_YjQubqt7MbLv5nz8B56jQiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=794
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/3/2023 7:58 AM, Aloka Dixit wrote:
> ...
> +	default:
> +		if (arg->peer_phymode == MODE_11BE_EHT20) {
> +			const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20 =
> +					&eht_cap->eht_mcs_nss_supp.only_20mhz;

When ath12k used as station mode, it entered here as well as AP mode.

But remote is AP device for station mode, then remote AP device do not 
have the only_20mhz data(EHT-MCS Map (20 MHz-Only Non-AP STA)).

Also 20 MHz should be same for 5 GHz/6 GHz(MODE_11BE_EHT20) and 2.4 
GHz(MODE_11BE_EHT20_2G), right?

> +
> +			ath12k_mac_set_eht_mcs(bw_20->rx_tx_mcs7_max_nss,
> +					       bw_20->rx_tx_mcs9_max_nss,
> +					       bw_20->rx_tx_mcs11_max_nss,
> +					       bw_20->rx_tx_mcs13_max_nss,
> +					       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
> +					       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
> +		} else {
> +			bw = &eht_cap->eht_mcs_nss_supp.bw._80;
> +			ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
> +					       bw->rx_tx_mcs9_max_nss,
> +					       bw->rx_tx_mcs11_max_nss,
> +					       bw->rx_tx_mcs13_max_nss,
> +					       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
> +					       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
> +		}
> +
> +		arg->peer_eht_mcs_count++;
> +		break;
> +	}
> +}
> +

...
