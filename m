Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D97AAF0B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjIVKCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjIVKCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 06:02:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162298F
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 03:02:36 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M9Atmi009375;
        Fri, 22 Sep 2023 10:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0TnD9f6FxYg7gX07CI55x4QpAZLP9HkdLxSmNetS2us=;
 b=TX9peuJd2ntDIJhkJtFvN5huuNF5yxVVfsM7lC0hPvJ+6r8IQRFAOZi/AZLz/fSm6knS
 NgCsoMYX/C7GI6A5iV2dOeU8xt8k7RWx/5TcbHmTrMLnUmH2ot6C0KDvKPYGatyET6yL
 pvtba9ilwoWtoqKk3/kp7xqnLSBDzh4UR6hA/j0ZI3FOxb73aAN0MGTOjm7nWfwfAYHH
 NUmW4YWxKXBtaj9VLYgA+N0HhwexJ3BopR7fzVR2viMP+rc0A7CsDSwcOXPEEh50gSN8
 dIdEMKu6vDhiDaamhfAq8DOewklphfnjSAe68f1P9KkYgfZWOabsWgKMSmgHdd9Y1aev LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0hhhm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:02:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MA2PUD029887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:02:25 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 03:02:23 -0700
Message-ID: <1f739d62-d5c0-a64b-ef9b-d5fd7b79755e@quicinc.com>
Date:   Fri, 22 Sep 2023 18:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5e9439c5-fc02-4a18-8cc8-c76998bfcbc6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WblmAIz8XkOvMWNTHTD8ZOpnw6TteJvH
X-Proofpoint-GUID: WblmAIz8XkOvMWNTHTD8ZOpnw6TteJvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220083
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2023 5:39 PM, Aditya Kumar Singh wrote:
> On 9/20/23 13:53, Wen Gong wrote:
>
>> +    if (ath11k_mac_supports_6ghz_cc_ext(ar) &&
>> +        ctx->def.chan->band == NL80211_BAND_6GHZ &&
>> +        arvif->vdev_type == WMI_VDEV_TYPE_STA) {
>> +        reg_info = &ab->reg_info_store[ar->pdev_idx];
>> +        power_type = vif->bss_conf.power_type;
>> +        ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
>> +               power_type);
>> +        if (power_type == IEEE80211_REG_UNSET_AP)
>> +            power_type = IEEE80211_REG_LPI_AP;
> Why having _UNSET_ power type in vif->bss_conf.power_type is fine? 
> Typically, during association, we would be setting this from the 
> beacon/association response frame's HE 6 GHz Operation Info Field. So 
> is it fine if the field is carrying some info which we don't know (or 
> may be don't support it yet)? Why are we masking it with _LPI_ mode?
>
> Also, I see that currently mac80211 only sets LPI or SP. So let's say 
> STA is trying to connect to VLP AP, mac80211 will set it as _UNSET_. 
> And then here, we will be treating it as LPI AP. Is that fine?

Currently only SP/LPI are defined in "Table E-12—Regulatory Info 
subfield encoding in the United States" of IEEE Std 802.11ax™‐2021.

So maybe I need to set power_type to VLP when it is UNSET here.

>
>
>
