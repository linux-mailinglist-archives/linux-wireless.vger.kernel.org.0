Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3F7A18E9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjIOIdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 04:33:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5915F7
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 01:33:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7lM6e001937;
        Fri, 15 Sep 2023 08:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d6GoOfZPp5VEkUdNwP6AULivoZYPDHWIgGUFmaBrP2A=;
 b=Gm7KgtygTVRSDaM/kna126oh+43twBpPrN+SYFpBzcXQNbj/nlocpF4E4y9pJieC3LlA
 YqEE8duuulH+n7wI1GKs7NX4loxC/bpYvnDj7E3PWbHXnxey2bWpg+vq0p7TTjyrRvlK
 Lk5tUaJ3GVKUKVWLTjNZ20WNuqFPlW/fAlJAIgp0E9P6FvCer6Dxvvni2ckG5RHna3Ws
 cIF+PtCYW/w23D1Tz31UI6Buxnw+h6SB7hy40cs2paZd+c+i6yIFsyd1lT5MKB1DKuuH
 HNRast7pV8mt2mIjR9NpFdXwjCl+c+8ZFkC4gq4GSG/NMkN0ibY3xez6n1lq9y40bf2m HA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3grft6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:33:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F8XX3W013920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:33:33 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 01:33:32 -0700
Message-ID: <96ae3c1d-274b-00b1-cb19-a9a301b6aa56@quicinc.com>
Date:   Fri, 15 Sep 2023 16:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] wifi: mac80211: add support to allow driver to set
 active link while connection for station
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
 <20230906103458.24092-3-quic_wgong@quicinc.com>
 <4b597bba9dc13c3260f174826de38b4f1bc3bf6e.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4b597bba9dc13c3260f174826de38b4f1bc3bf6e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vvh9bk3Yr0F213uiupCkg-Y6XCmx4Eua
X-Proofpoint-ORIG-GUID: Vvh9bk3Yr0F213uiupCkg-Y6XCmx4Eua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=903 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150074
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 4:58 PM, Johannes Berg wrote:
> On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
>> There are 2 fields valid_links and active_links in struct ieee80211_vif
>> of mac80211. For station mode, valid_links is always include the bitmap
>> of active_links. valid_links stores the bitmap of links which is created
>> in mac80211, and mac80211 only indicate the info of links which is existed
>> in active_links to driver. Finally, the active_links is the bitmap of
>> links which station can interactive with MLO AP it is connected to.
>>
>> Currently the active links is always only contain the primary link,
>> primary link means the link used by the latest exchange of successful
>> (Re)Association Request/Response frames. Then it will always have only
>> one link in driver after connected.
>>
>> Hence add this ops in struct ieee80211_ops to allow driver to determine
>> the active links bit map dynamically while connecting to MLO AP.
> This commit log does nothing to address the question "why do we need
> this", particularly since we already have
> ieee80211_set_active_links(/_async), so the driver can pretty much
> immediately enable all the links it wants.
>
> I see no value in this patch whatsoever.
For ieee80211_set_active_links(), driver need save and install pairwise
keys for the other links as you said in link below. But driver do not
save the key data currently. So driver could not install the pairwise
keys by itself.
https://lore.kernel.org/linux-wireless/50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net/

And driver could ensure this rule in spec as I said before in link below:
"For MLO, if RSNA has not been established, each message of the 4-way
handshake shall be sent on the same link used by the latest exchange of
successful (Re)Association Request/Response frames."
https://lore.kernel.org/linux-wireless/b6314b61-0700-0e1c-7b39-21c305dc28b3@quicinc.com/

It will be complext for driver/ath12k to use 
ieee80211_set_active_links(/_async).
>
>> @@ -166,6 +167,13 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
>>   		WARN_ON(dormant_links);
>>   		break;
>>   	case NL80211_IFTYPE_STATION:
>> +		active_links = drv_calculate_active_links(sdata->local, sdata,
>> +							  valid_links & ~dormant_links);
>> +		if (active_links) {
>> +			sdata->vif.active_links = active_links;
>> +			break;
>> +		}
>>
> I also _really_ don't think this should operate at this low-level
> infrastructure.

I really want to know the reason why active *only* the assoc link for 
station, but

active *all* links for AP here😁?

> johannes
