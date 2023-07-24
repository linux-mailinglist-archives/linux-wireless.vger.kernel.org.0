Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56575FEFA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGXSY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGXSY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 14:24:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528DE4D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:24:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OHWjuK003433;
        Mon, 24 Jul 2023 18:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NHlNKYctdsDtW9Sj16H5Ck6B6KRi5eEDAoockdqhAfU=;
 b=TPhMVSlJV10FYvwqIL/bEk1wWtYAMnyTXN7O+krVIkM65vdzUJZg0l38awsHcogEmI23
 My4xJPSCun2s3uv1jrVhVXaUTxR5lGeQHPdd6xFBYM4et3lx0tg5Q51fMKFwsT8ZQzRt
 lSEtw7QcLXTxjWnOztll8RXBYSHXuQzOGYdD8z33M4BDQsmnw5bsdDR5qtc8XXVc55Wq
 79i9l03G/xoUhtNQpGWxsnrTNaJSn36Kzg2hMHIS1m47y0QKiirrKWRLfszvTuH7Bagu
 Oi7nIjOloWcwfhQzU9ZODAvyQ5JzhKj9/BFTF5f2E+mJAVcfnniwoVfFUQvK2v9LnrlE 9w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1u3t8m6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 18:24:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OIOL9m031618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 18:24:21 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 11:24:20 -0700
Message-ID: <cdfbb85a-f3be-8cdc-7117-7550d3808a13@quicinc.com>
Date:   Mon, 24 Jul 2023 11:24:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/11] wifi: ath12k: prepare EHT peer assoc parameters
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-7-quic_alokad@quicinc.com>
 <f4515520-1d3b-1b07-6ddd-ae269c12a91f@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <f4515520-1d3b-1b07-6ddd-ae269c12a91f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: In2ZJJEhe5Y6ln-e-XA2bzDY27JeNx2g
X-Proofpoint-ORIG-GUID: In2ZJJEhe5Y6ln-e-XA2bzDY27JeNx2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=866 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240163
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/24/2023 3:16 AM, Wen Gong wrote:
> On 6/3/2023 7:58 AM, Aloka Dixit wrote:
>> ...
>> +    default:
>> +        if (arg->peer_phymode == MODE_11BE_EHT20) {
>> +            const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20 =
>> +                    &eht_cap->eht_mcs_nss_supp.only_20mhz;
> 
> When ath12k used as station mode, it entered here as well as AP mode.
> 
> But remote is AP device for station mode, then remote AP device do not 
> have the only_20mhz data(EHT-MCS Map (20 MHz-Only Non-AP STA)).
> 

What issue are you seeing? Please elaborate.

The default case will be entered for both AP and non-AP STA modes for 
all bandwidths.

If the device is a 20-MHz-only device, it will skip 320, 160 and 
directly enter the default case where 'if' condition will be true.

If the device is not a 20-MHZ-only device then it will enter the 'else' 
condition after processing 320 and 160 as applicable.

> Also 20 MHz should be same for 5 GHz/6 GHz(MODE_11BE_EHT20) and 2.4 
> GHz(MODE_11BE_EHT20_2G), right?
> 

Good point, I will add a check for MODE_11BE_EHT20_2G as well here.

>> +
>> +            ath12k_mac_set_eht_mcs(bw_20->rx_tx_mcs7_max_nss,
>> +                           bw_20->rx_tx_mcs9_max_nss,
>> +                           bw_20->rx_tx_mcs11_max_nss,
>> +                           bw_20->rx_tx_mcs13_max_nss,
>> +                           &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
>> +                           &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
>> +        } else {
>> +            bw = &eht_cap->eht_mcs_nss_supp.bw._80;
>> +            ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
>> +                           bw->rx_tx_mcs9_max_nss,
>> +                           bw->rx_tx_mcs11_max_nss,
>> +                           bw->rx_tx_mcs13_max_nss,
>> +                           &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
>> +                           &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
>> +        }
>> +
>> +        arg->peer_eht_mcs_count++;
>> +        break;
>> +    }
>> +}
>> +
> 
> ...

