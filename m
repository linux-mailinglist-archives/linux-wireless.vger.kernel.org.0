Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046BB58FAB3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiHKKdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHKKdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 06:33:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530C89CC5
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 03:33:35 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B9Ooph013197;
        Thu, 11 Aug 2022 10:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4QK6Wpz69ebAUjN5V8Jl9Hs05j9jWrNVMJBofc/8KoE=;
 b=g5rDOZtcBT0Wie6a/CzaYLc8Lmy4mx4z50p4LoasNXFkI/wms0aATznvZsT9VamKqtv5
 C7XpB63i4fX6d2G7qvnWhTBKUfWFaQbMDgQZj6q/QRcZ34YHdXaOe+5k9MnaidcOf97D
 q3LkvaZs633GcA/9dEZbmvAju/W6xs4kMlDgcdXZXJ/HLkPGMh+9IYnGqTgt8YGpY38n
 UIWKc2eBM9XIKAZ3+liT7nXVZWYn5vdpvxGXnhw2k1S4NcKwPte4HpXUI9gaHHfSrgMG
 xYUszysyGeRguOXk+ddFYZYnQu6S6C89j6hgbabHYlrPMqqi90+bxK/sZAbYsjALuG/L tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvdg1u327-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:33:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27BASVKS002235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:28:31 GMT
Received: from [10.201.164.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 03:28:30 -0700
Message-ID: <124e5f40-04b4-21be-9e37-bc01633e8e7a@quicinc.com>
Date:   Thu, 11 Aug 2022 15:58:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC 2/2] wifi: mac80211: use link_id from ieee80211_rx_status to
 retrieve rx link
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
 <20220802065019.20791-3-quic_vthiagar@quicinc.com>
 <103f62efc89d86773fbd07729326f3ba08f4ea23.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <103f62efc89d86773fbd07729326f3ba08f4ea23.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5-ehh2pngPZKd8ysCptU1F8LxWTF7Psx
X-Proofpoint-ORIG-GUID: 5-ehh2pngPZKd8ysCptU1F8LxWTF7Psx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=494 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/9/2022 11:45 PM, Johannes Berg wrote:
> On Tue, 2022-08-02 at 12:20 +0530, Vasanthakumar Thiagarajan wrote:
>> Fill rx.link with respective data_link from the reported link_id
>> in rx_status. Any link_id > 15 is invalid. Non-MLO connections
>> can use either 0 or 15 as the link_id. Please note that link_id
>> 0 is used with non-MLO connections to avoid changes in the
>> drivers not supporting MLO. For a 802.11 MLD address translated
>> frame, driver must report the right link_id for the
>> frame to get processed. When processing 802.3 frame format,
>> link_id is not that critical, used only with stats update.
>> In such case, all the stats will be updated for the deflink.
> 
> I think it might be worth splitting this patch a bit different - putting
> some parts into the first patch already (that fill rx.link_id), and
> keeping some others (statistics etc.) in this patch, which is then more
> related to statistics?

Sure.

> 
>>
>>   	if (rx->link_id >= 0) {
>> -		link = rcu_dereference(rx->sdata->link[rx->link_id]);
>> -
>> +		link =  rcu_dereference(sdata->link[rx->link_id]);
> 
> that has some spurious whitespace changes
> 
>> +	/*
>> +	 * TODO: In MLO, should the frame be dropped if the right link_id is not
>> +	 * available? Or may be it is fine in the current form to proceed with
>> +	 * the frame processing because with frame being in 802.3 format,
>> +	 * link_id is used only for stats purpose and updating the stats on
>> +	 * the deflink is fine?
>> +	 */
>> +	if (pubsta->mlo && status->link_id != IEEE80211_LINK_UNSPECIFIED)
>> +		rx.link_id = status->link_id;
> 
> If the driver *does* give a link ID, it better be valid?

Sure, we can remove IEEE80211_LINK_UNSPECIFIED. If now valid
link_id is set for an MLO link, we still try to retrieve it from
the addr2 in case the MLD address translation is not done in the
lower layers but when this happens with already translated packets
then we may need to drop the packet?

> 
> OTOH, could there be races, e.g. while disabling a link?

I assume this is for the packets where the received on a
link which is disabled? May be driver sets that link but
that link will not be valid in mac80211 while processing
this packet and the packet will be dropped? Or may be
a different race you are mentioning?

Vasanth
