Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EC7CEE68
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjJSD0L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 23:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjJSD0J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 23:26:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA11131
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 20:26:07 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J3DEte028276;
        Thu, 19 Oct 2023 03:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8zIB2zq1+L7h/we1/kNNSoRHC+x0jNisIkz4X/WsBNQ=;
 b=ZP2JpDt759aeVe0sWq09wEsnQDHlmxxI9sy1LQ9xij2whdYJ9xLetGWrw0lsc4tcNyup
 FgoXjtBF9BoiH60aIILNoevKavsQgRaV7sxH6wDn0fR4oFMjafcrzaEPXYZQRq9rIuFZ
 BNUInZRubs4jh61v6iiHAcKqJfLFcGIeBi3bODBlaSyB7qLdIllY7+n+8B7uqr8avcH5
 I9655IkFvgXghgaujixoI62aLTvG1VbBjByYIqSxzURCaExG3efqTb6vv13H03T+VbT9
 k1dpAX6L+T65j1jMrlhNsksndJ7rSoc1tUX7MFVekHvVJqYkITkJq3WLNmUetQ/PmGnv nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttb7ajd3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 03:25:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J3Pcwe006976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 03:25:38 GMT
Received: from [10.253.33.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 20:25:37 -0700
Message-ID: <d85bd8f7-a6aa-6ff7-09a8-57005e4d0779@quicinc.com>
Date:   Thu, 19 Oct 2023 11:25:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] wifi: mac80211: mlme: fix verification of puncturing
 bitmap obtained from AP
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230928055022.9670-1-quic_kangyang@quicinc.com>
 <20230928055022.9670-2-quic_kangyang@quicinc.com>
 <08ff36664eb34bce8e7beb425233b1e8d4a4971c.camel@sipsolutions.net>
Content-Language: en-US
From:   Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <08ff36664eb34bce8e7beb425233b1e8d4a4971c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eDK4N0-bkt_MAj9fR2tuTKHIeuV2vK2S
X-Proofpoint-GUID: eDK4N0-bkt_MAj9fR2tuTKHIeuV2vK2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190027
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/18/2023 7:39 PM, Johannes Berg wrote:
>>   static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
>>   					const struct ieee80211_eht_operation *eht_oper,
>>   					u64 *changed)
>>   {
>> +	struct cfg80211_chan_def rx_chandef = link->conf->chandef;
>>   	u16 bitmap = 0, extracted;
>> +	u8 bw = 0;
>>   
>>   	if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
>>   	    (eht_oper->params &
>> @@ -5684,6 +5706,28 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
>>   		const u8 *disable_subchannel_bitmap = info->optional;
>>   
>>   		bitmap = get_unaligned_le16(disable_subchannel_bitmap);
>> +		bw = u8_get_bits(info->control, IEEE80211_EHT_OPER_CHAN_WIDTH);
>> +		rx_chandef.width = ieee80211_rx_bw_to_nlwidth(bw);
> 
> But looking here, it clearly _doesn't_ make sense. IEEE80211_STA_RX_BW_*
> is a purely internal API, has nothing to do with the spec.
> 
> All this might even be "accidentally correct", but it really isn't right
> at all - the values in IEEE80211_EHT_OPER_CHAN_WIDTH are
> IEEE80211_EHT_OPER_CHAN_WIDTH_*, not IEEE80211_STA_RX_BW_*.
> 



Oh, sorry that i didn't notice IEEE80211_EHT_OPER_CHAN_WIDTH_*, will 
replace them.


> 
> 
> More generally though, I don't even understand the change.


During assoc, downgrade may happen in func ieee80211_config_bw(). In 
this situation, the bandwidth in beacon and the bandwidth after 
downgrade(chandef->width, maybe i should call it local bandwidth during 
below context, will use this name in next version) during assoc will be 
different.

The change is based on this point.


> 
>> +		if (rx_chandef.width == NL80211_CHAN_WIDTH_80)
>> +			rx_chandef.center_freq1 =
>> +				ieee80211_channel_to_frequency(info->ccfs0,
>> +							       rx_chandef.chan->band);
>> +		else if (rx_chandef.width == NL80211_CHAN_WIDTH_160 ||
>> +			 rx_chandef.width == NL80211_CHAN_WIDTH_320)
>> +			rx_chandef.center_freq1 =
>> +				ieee80211_channel_to_frequency(info->ccfs1,
>> +							       rx_chandef.chan->band);
>> +	}
>> +
>> +	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
>> +						      &rx_chandef)) {


Here i change you code 
cfg80211_valid_disable_subchannel_bitmap(&bitmap,&link->conf->chandef) to
cfg80211_valid_disable_subchannel_bitmap(&bitmap,&rx_chandef)

As described above, downgrade may happen before enter 
ieee80211_config_puncturing(), so the bandwidth in link->conf->chandef 
may be different with bandwidth in beacon.

Here, the bitmap you used is from eht_oper in beacon, but the bandwidth 
you used is local bandwidth. They are not match. This is the first issue.


>> +		link_info(link,
>> +			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
>> +			  link->u.mgd.bssid,
>> +			  bitmap,
>> +			  rx_chandef.width);
>> +		return false;
>>   	}
>>   
>>   	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
> // I've filled in the context here in the patch


Here is move the cfg80211_valid_disable_subchannel_bitmap() before the 
ieee80211_extract_dis_subch_bmap(), cause i think check should done 
before extract.

This is the second issue i said(perhaps not a issue).



>>                                                       &link->conf->chandef,
>>                                                       bitmap);
>>
>>          /* accept if there are no changes */
>>          if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
>>              extracted == link->conf->eht_puncturing)
>>                  return true;
> 
> but ... ieee80211_extract_dis_subch_bmap actually already takes the
> bandwidth from eht_oper into account!
>   

Yes, the ieee80211_extract_dis_subch_bmap realy takes the bandwidth from 
eht_oper into account, and the local_bw in this func is the local 
bandwidth i discuss.

You already notice the difference between bandwidth from eht_oper and 
local bandwidth in ieee80211_extract_dis_subch_bmap(). I think you 
should also take it into account when you use 
cfg80211_valid_disable_subchannel_bitmap(), right?

BTW, do you want to verify the bitmap from eht_oper, or the extracted 
bitmap?

Anyway, whether you want to verify the bitmap from eht_oper or extracted 
bitmap in cfg80211_valid_disable_subchannel_bitmap(), the bitmap and 
bandwidth must correspond.



>> -	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
>> -						      &link->conf->chandef)) {
> 
> So are you saying that the real bug is that we're missing to update the
> link->conf->chandef with the EHT operation from the assoc response?
> 
> But you didn't fix that issue ... so not sure?


I have described my patch with the comments above, maybe i should make 
my commit log more coherent.


Besides, this is you first version, i made some comments on Nov. 21, 
2022, 7:29 a.m. Maybe you already forget them.
https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/


> 
> johannes
> 
