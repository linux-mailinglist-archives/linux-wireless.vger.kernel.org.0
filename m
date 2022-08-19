Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD2599257
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 03:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiHSBMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 21:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBMW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 21:12:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90BDDA85
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 18:12:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J0xtSX006967;
        Fri, 19 Aug 2022 01:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PP51UZsJ2Azw9ascxyzGNbbWKrwLLSR0Rk3q2TbHAGk=;
 b=d//NXGM13mmeUD7OXJJKqADOSn25VzKoL3WHVAI7pjwoKascvrfbud50Rl7PI2w1BP2Q
 1VOut0fMBargDkRwymbxJ89l3n/PFgeCMxQYy/qVWAB8XXMKSNqj5xgKv5klwjtLbzJp
 AeKb+I64+V070pZfTau8JW25LHZkwKQzrbAJLMUif+CRtrgS11FU7V9xlxeusXaRE+af
 I0FOQvlATCymXt7iEIJUoHAg4Kl0CA3Td337MLlU5jG7hJCA74hNrDhVu0SgjfUINtpM
 eGImqnumJfJHj9GNegV/N1bQlKzARQ9r+hDHkTEMGHXpmJZmpmQtb/bwqDvYOaHWFrhL Kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1wtcrba7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 01:12:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27J1CBqL009559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 01:12:11 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 18:12:11 -0700
Message-ID: <5460619d-38e3-9960-5bc7-63854bd01b46@quicinc.com>
Date:   Thu, 18 Aug 2022 18:11:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 47/50] wifi: ath12k: add wmi.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-48-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-48-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GkHJ2dzLTHPSk3AgIqW5RJRyRVeVo8ek
X-Proofpoint-GUID: GkHJ2dzLTHPSk3AgIqW5RJRyRVeVo8ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:10 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.h | 4796 +++++++++++++++++++++++++++++++++
>   1 file changed, 4796 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
[...]
> +/* defines to set Packet extension values whic can be 0 us, 8 usec or 16 usec */

s/whic/which/

[...]

> +enum {

naming the enum allows you to reference the enum in code and comments

> +	WMI_HOST_WLAN_2G_CAP	= 0x1,
> +	WMI_HOST_WLAN_5G_CAP	= 0x2,
> +	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
> +};

[...]

> +#define WMI_CMD_UNSUPPORTED 0

why not just add this to enum wmi_tlv_cmd_id?

> +
> +enum wmi_tlv_cmd_id {
> +	WMI_INIT_CMDID = 0x1,
> +	WMI_START_SCAN_CMDID = WMI_TLV_CMD(WMI_GRP_SCAN),
[...]
> +#define WMI_PEER_MIMO_PS_STATE                          0x1
> +#define WMI_PEER_AMPDU                                  0x2
> +#define WMI_PEER_AUTHORIZE                              0x3
> +#define WMI_PEER_CHWIDTH                                0x4
> +#define WMI_PEER_NSS                                    0x5
> +#define WMI_PEER_USE_4ADDR                              0x6
> +#define WMI_PEER_MEMBERSHIP                             0x7
> +#define WMI_PEER_USERPOS                                0x8
> +#define WMI_PEER_CRIT_PROTO_HINT_ENABLED                0x9
> +#define WMI_PEER_TX_FAIL_CNT_THR                        0xA
> +#define WMI_PEER_SET_HW_RETRY_CTS2S                     0xB
> +#define WMI_PEER_IBSS_ATIM_WINDOW_LENGTH                0xC
> +#define WMI_PEER_PHYMODE                                0xD
> +#define WMI_PEER_USE_FIXED_PWR                          0xE
> +#define WMI_PEER_PARAM_FIXED_RATE                       0xF
> +#define WMI_PEER_SET_MU_WHITELIST                       0x10
> +#define WMI_PEER_SET_MAX_TX_RATE                        0x11
> +#define WMI_PEER_SET_MIN_TX_RATE                        0x12
> +#define WMI_PEER_SET_DEFAULT_ROUTING                    0x13

perhaps create an enum for these?

> +
> +#define WMI_VDEV_SLOT_TIME_LONG         0x1
> +#define WMI_VDEV_SLOT_TIME_SHORT        0x2

another enum?

> +#define WMI_VDEV_PREAMBLE_LONG          0x1
> +#define WMI_VDEV_PREAMBLE_SHORT         0x2

another enum?
[...]

> +/* Regaulatory Rule Flags Passed by FW */

s/Regaulatory/Regulatory/

[...]

> +#define WMI_KEY_PAIRWISE 0x00
> +#define WMI_KEY_GROUP    0x01

create an enum?

> +
> +#define WMI_CIPHER_NONE     0x0 /* clear key */
> +#define WMI_CIPHER_WEP      0x1
> +#define WMI_CIPHER_TKIP     0x2
> +#define WMI_CIPHER_AES_OCB  0x3
> +#define WMI_CIPHER_AES_CCM  0x4
> +#define WMI_CIPHER_WAPI     0x5
> +#define WMI_CIPHER_CKIP     0x6
> +#define WMI_CIPHER_AES_CMAC 0x7
> +#define WMI_CIPHER_ANY      0x8
> +#define WMI_CIPHER_AES_GCM  0x9
> +#define WMI_CIPHER_AES_GMAC 0xa

create an enum?

[...]
