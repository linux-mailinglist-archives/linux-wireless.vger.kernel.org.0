Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABF7AD644
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjIYKnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIYKnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 06:43:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ECC6
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 03:43:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9Oiwb028120;
        Mon, 25 Sep 2023 10:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OUoEKTmMxCx+vq623ICuvH1JQjknRMxyE0mOmxlcN40=;
 b=YWJK5eiXz5b4YEujnaTMMXzjWSx1bI0c3H8GpOcs7j7KLCtOA2phyQWMzaaGAzNiOmUq
 5QitnkY4ph5hIWn78xdK+FOPb09ZxJ7icG+GcYFshUq7HuBEVc3qmnbLuDsEgcIom2gi
 9vtNCpMwa8e1UKX9xIYCx1+XAtgGkYmim8yvV+PBIXcTdfKDYdpHUpKVp54jfC2U9X5i
 NEy/fSPC8lHAlZO+kS7aAFxP1jOCdFnSIJhrJ0FMStG+QNiDdcCCXL2YK4+bCK/i/jxy
 bhgGJOD07qx5ZNxk++lIXHQcuSwRcRagYXgpInHl8lepyHkZTAAABXEDBdx537CGGVFS ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb3hfrwjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:43:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PAh9CU005745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:43:09 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 03:43:06 -0700
Message-ID: <2aae986b-1d16-3b75-d2c9-a740f6817650@quicinc.com>
Date:   Mon, 25 Sep 2023 18:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 05/13] wifi: ath11k: update regulatory rules when
 connect to AP on 6 GHz band for station
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-6-quic_wgong@quicinc.com>
 <5e9439c5-fc02-4a18-8cc8-c76998bfcbc6@quicinc.com>
 <1f739d62-d5c0-a64b-ef9b-d5fd7b79755e@quicinc.com>
 <47e2ce79-2885-489c-b567-fdbcb120d056@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <47e2ce79-2885-489c-b567-fdbcb120d056@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WptxZKIoz6kQ0QIGK4y_brGWcPRKO1zU
X-Proofpoint-ORIG-GUID: WptxZKIoz6kQ0QIGK4y_brGWcPRKO1zU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250078
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2023 9:18 PM, Aditya Kumar Singh wrote:
> On 9/22/23 15:32, Wen Gong wrote:
>> On 9/22/2023 5:39 PM, Aditya Kumar Singh wrote:
>>> On 9/20/23 13:53, Wen Gong wrote:
>>>
>>>> +    if (ath11k_mac_supports_6ghz_cc_ext(ar) &&
>>>> +        ctx->def.chan->band == NL80211_BAND_6GHZ &&
>>>> +        arvif->vdev_type == WMI_VDEV_TYPE_STA) {
>>>> +        reg_info = &ab->reg_info_store[ar->pdev_idx];
>>>> +        power_type = vif->bss_conf.power_type;
>>>> +        ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
>>>> +               power_type);
>>>> +        if (power_type == IEEE80211_REG_UNSET_AP)
>>>> +            power_type = IEEE80211_REG_LPI_AP;
>>> Why having _UNSET_ power type in vif->bss_conf.power_type is fine? 
>>> Typically, during association, we would be setting this from the 
>>> beacon/association response frame's HE 6 GHz Operation Info Field. 
>>> So is it fine if the field is carrying some info which we don't know 
>>> (or may be don't support it yet)? Why are we masking it with _LPI_ 
>>> mode?
>>>
>>> Also, I see that currently mac80211 only sets LPI or SP. So let's 
>>> say STA is trying to connect to VLP AP, mac80211 will set it as 
>>> _UNSET_. And then here, we will be treating it as LPI AP. Is that fine?
>>
>> Currently only SP/LPI are defined in "Table E-12—Regulatory Info 
>> subfield encoding in the United States" of IEEE Std 802.11ax™‐2021.
>>
>> So maybe I need to set power_type to VLP when it is UNSET here.
> Yeah, or may be deny association if we don't support that mode? I 
> would let others comment on this.
Do you know how to check which mode support by ath11k?
