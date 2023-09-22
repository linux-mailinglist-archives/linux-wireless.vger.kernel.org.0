Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9206A7AAE64
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIVJkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjIVJkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 05:40:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D819D
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 02:40:07 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M9CIf1013527;
        Fri, 22 Sep 2023 09:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o0Nr3JaK4ACHBQ9cEw/9pzJX41KNkkCuXnAmbNGduk4=;
 b=ErEjijGhgGDc/zgm1giHPDP72cbwISdaqqpr6rzn7MbfoT+FmRi8XftbREQYeHKjPWSz
 TAbGKRMiNhVU05kGuMdMOYuttOSEamH1vId5l6h6L/3QlcEK+AqxjtspVNehF0ZOg8Cr
 oX25DQXBu+z/SBaQC6sBW+tQXAGcuDbG9DTJ3ro0hLI+tgyyTPCpXeDckbOruuaW4btQ
 QfDnS3cUiMW9KxxtNMK55SS1fEWm/yihYBcIS5pkCsY0UZMkUUjpThMRiWABuYfzdAtr
 +D9RHNlBDT6wwoj3Oochr0qVNy0JSvZ7vFGe7D5q2co2iY0D6GPIxV5Skq9PLVYDk8ue HA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u5n1hpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:40:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M9e0XZ014369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:40:00 GMT
Received: from [10.216.13.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 02:39:57 -0700
Message-ID: <5e9439c5-fc02-4a18-8cc8-c76998bfcbc6@quicinc.com>
Date:   Fri, 22 Sep 2023 15:09:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] wifi: ath11k: update regulatory rules when
 connect to AP on 6 GHz band for station
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-6-quic_wgong@quicinc.com>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20230920082349.29111-6-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2cd1UFnGnZkTrFlOnNJOA_Kc7zB3VbG5
X-Proofpoint-GUID: 2cd1UFnGnZkTrFlOnNJOA_Kc7zB3VbG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/23 13:53, Wen Gong wrote:

> +	if (ath11k_mac_supports_6ghz_cc_ext(ar) &&
> +	    ctx->def.chan->band == NL80211_BAND_6GHZ &&
> +	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
> +		reg_info = &ab->reg_info_store[ar->pdev_idx];
> +		power_type = vif->bss_conf.power_type;
> +		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
> +			   power_type);
> +		if (power_type == IEEE80211_REG_UNSET_AP)
> +			power_type = IEEE80211_REG_LPI_AP;
Why having _UNSET_ power type in vif->bss_conf.power_type is fine? 
Typically, during association, we would be setting this from the 
beacon/association response frame's HE 6 GHz Operation Info Field. So is 
it fine if the field is carrying some info which we don't know (or may 
be don't support it yet)? Why are we masking it with _LPI_ mode?

Also, I see that currently mac80211 only sets LPI or SP. So let's say 
STA is trying to connect to VLP AP, mac80211 will set it as _UNSET_. And 
then here, we will be treating it as LPI AP. Is that fine?



