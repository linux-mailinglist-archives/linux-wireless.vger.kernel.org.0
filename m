Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37C6512D9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiLSTX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 14:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiLSTX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 14:23:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43CDB7
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 11:23:02 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJ0i3n011615;
        Mon, 19 Dec 2022 19:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B9N9x8jTnmY1O8wwSpad+aLHa5CyCfDPPZSyJjVJiIk=;
 b=DNKLava22+SFEF26WjaNU3GPhoujSuz9Q9xJlGHD0Ef2asmTzKoZvu0yL3rcweeyhi+c
 /Yd6SfV3X88tbrcymC3Lx/HGIspWszZyz/evmHtqbdGmca+9I2CHITM2tNa6A93h+ra5
 OM+AXqV4CxpxAONemH1IEMmbkLR6I3rSnPW66ynwpWyQyXEDmh8bdAtWYqRQc2E3lnF0
 H9wKGRJG9UncW1XrEXAoeRyudpw5/CZWgB2gnsjHtktNy23NtUGpRmquVHvkPnaJhN7O
 ZiwM5Tj01OCgPQBqAvJBM5XOxGqtynonfGfKTsD2/pGwLUxepEMSlIw+7eHdjlpiSMDG 6w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh3fpn36s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:22:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJJMwPZ030858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:22:58 GMT
Received: from [10.110.47.99] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 11:22:58 -0800
Message-ID: <43bd3a96-7ed7-625a-cdf1-615f53373613@quicinc.com>
Date:   Mon, 19 Dec 2022 11:22:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v12 2/4] mac80211: MBSSID support in interface handling
Content-Language: en-US
To:     Jouni Malinen <j@w1.fi>
CC:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
 <20210916025437.29138-3-alokad@codeaurora.org>
 <20221218152420.GA906762@w1.fi>
 <441771f8-6269-0ce4-fce8-513f7f3f7d95@quicinc.com>
 <20221219191506.GA17184@w1.fi>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20221219191506.GA17184@w1.fi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FMysEcRKmRTSA4Dr4DKhOwnj8PBvt6LA
X-Proofpoint-GUID: FMysEcRKmRTSA4Dr4DKhOwnj8PBvt6LA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190171
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/19/2022 11:15 AM, Jouni Malinen wrote:
> On Mon, Dec 19, 2022 at 10:53:55AM -0800, Aloka Dixit wrote:
>> On 12/18/2022 7:24 AM, Jouni Malinen wrote:
>>> On Wed, Sep 15, 2021 at 07:54:35PM -0700, Aloka Dixit wrote:
>>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>>> +static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
>>>> +					   struct cfg80211_mbssid_config params)
>>>
> @@ -1268,10 +1268,17 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>   	if (sdata->vif.type == NL80211_IFTYPE_AP &&
>   	    params->mbssid_config.tx_wdev) {
>   		err = ieee80211_set_ap_mbssid_options(sdata,
> -						      params->mbssid_config,
> +						      &params->mbssid_config,
>   						      link_conf);
>   		if (err)
>   			return err;
> +	} else {
> +		/* FIX: Is this the correct thing to do here and under which
> +		 * conditions? At least ema_ap needs to be cleared for AP mode
> +		 * if mbssid_config.tx_wdev is not set. */
> +		link_conf->bssid_index = 0;
> +		link_conf->nontransmitted = false;
> +		link_conf->ema_ap = false;

Will need to clean MBSSID elements in stored beacon as well.
Would the two HWSIM testcases you mentioned earlier be sufficient for 
testing? I've never used P2P related tests, and in fact I only even ran 
one testcase at a time so stale configurations didn't show up.

Thanks.
