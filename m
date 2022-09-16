Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF05BB13A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIPQrF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPQrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 12:47:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A72A6ADD
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 09:47:02 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GG31m7021724;
        Fri, 16 Sep 2022 16:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zqi4EV6qPnp3p1tyr1Elb5opL0fitFGRnaLyZHpX6BE=;
 b=DXiasinW6rOpdqMq8IsLWaUEeJa6fsSOv4jwU2EDtFKRFB2vUVsykcXAqq93j4tb/A86
 s06uMPsuIP31zcv12JuuakR6/54MRfTudEsiRLMJOwWXYKi6HRYVrYEmVQEAHaq22CK4
 mwG6n4EtogHqv2YiKgJaxCTZOgrfAv6Ysu/CGVutwrc2GfaB3V8M6qucJW7uh2RulqzZ
 bvlvSI51gg2203FuG/FszxObirdAo30HP0b/qLcjpt9N/Xpre+GjIcWAU2EsbSjw6Vz7
 rov/Euml0A4qcA70AUicxV1EnDN9jFdp5/Na+vTwWZcYybsbKU4gFsTL4J4qq53zP3it Dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm9m1bqwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 16:46:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28GGPtdd017565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 16:25:55 GMT
Received: from [10.110.7.80] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 16 Sep
 2022 09:25:54 -0700
Message-ID: <29fe28db-622d-7784-128f-8ec6b4d5a0a3@quicinc.com>
Date:   Fri, 16 Sep 2022 09:25:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] wifi: mac80211: Align with Draft P802.11be_D1.5
Content-Language: en-US
To:     Howard Hsu <howard-yh.hsu@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220916141700.28378-1-howard-yh.hsu@mediatek.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220916141700.28378-1-howard-yh.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z8WkJoe3Q_HbCQjLdR0s1q1VDCN9qXGy
X-Proofpoint-GUID: Z8WkJoe3Q_HbCQjLdR0s1q1VDCN9qXGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_10,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160123
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/16/2022 7:17 AM, Howard Hsu wrote:
> Fix ieee80211_prep_channel to aligh with Draft P80211.be_D1.5. It shall

s/aligh/align/

why refer to D1.5? Current code is using D2.0 definitions.

further note it seems at some point we should move all definitions to 
D2.1 (in which case EHT operation information is now at offset 8 of the 
EHT operation element)



> shift 4 byte to fetch EHT Operation information.
> 
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> ---
>   net/mac80211/mlme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index ff449e0c2e62..9bb085eab12a 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -4735,7 +4735,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   						   cbss_ies->data, cbss_ies->len);
>   		if (eht_oper_ie && eht_oper_ie[1] >=
>   		    1 + sizeof(struct ieee80211_eht_operation))
> -			eht_oper = (void *)(eht_oper_ie + 3);
> +			eht_oper = (void *)(eht_oper_ie + 4);
>   		else
>   			eht_oper = NULL;
>   	}

