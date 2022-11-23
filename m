Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74904634DBD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiKWCTL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 21:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWCTK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 21:19:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7777C67CE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 18:19:09 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN1tYSf006405;
        Wed, 23 Nov 2022 02:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wZiGRUD8pICgSrnKIV/sCb3bdYv5bb+NUF8wLk/vf6o=;
 b=IgVYhZojDsY2Uv7DeF6fWkUw9464ITt9VHaM5mxE6ZZYQYxZpqOEZl7HkFmy9Sl7YFaD
 WirY01uDzFzt7QUf7ujKuV/XXqretQPnkd36fcj0qlu42vBiiz3iSvI99sCUU8XdcBab
 DrU4VrP5PenN1MtB8vLJ2JcSCkN8XGETxFhA9zT1gyJ8wpaO4u2NEOdbBY12RmBNQscT
 MevZTkxYVIFl0sBFjLBsCyBFhaUiZ1cjW731dZJkYF+zeUgmEvpSrS6rS7rBDEcSmTfn
 A0+NbKKPte0rD9bY0+dIrzxMmLB5kHoUvAmM/o/BRhN2d8sJJvek+SFaBrTUJcG+XWWp rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0twqa5jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 02:19:04 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AN2J3nJ007495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 02:19:03 GMT
Received: from [10.253.13.32] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 18:19:01 -0800
Message-ID: <76266a0b-d371-53c1-9ad0-fbff7a506d0c@quicinc.com>
Date:   Wed, 23 Nov 2022 10:18:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information
 received from the AP
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
 <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
 <95ad4207e62b4990476d867bd240fef3ede31369.camel@sipsolutions.net>
From:   Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <95ad4207e62b4990476d867bd240fef3ede31369.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LsYwkQpYRRCrriRVuN7WgMUpGZ4vL3Js
X-Proofpoint-ORIG-GUID: LsYwkQpYRRCrriRVuN7WgMUpGZ4vL3Js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211230015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi:

	Thanks for your reply!

On 11/23/2022 12:43 AM, Johannes Berg wrote:
> On Mon, 2022-11-21 at 15:29 +0800, Kang Yang wrote:
>> Hi:
>> 	1.Do you have any new version about this RFC patch?
> 
> Not really, no.
> 
> 
>> 	2.I have some questions about this patch:
> 
> (a couple of blank lines and some trimming of the context really would
> help ... please try next time)
> 
>>> +static u16
>>> +ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
>>> +				 struct cfg80211_chan_def *chandef, u16 bitmap)
>>> +{
>>> +	int sta_center_freq = ieee80211_channel_to_frequency(eht_oper->ccfs,
>>> +							     chandef->chan->band);
>>> +	u32 center_freq = chandef->chan->center_freq;
>> The shift is calculated by the difference of old and new channel center
>> frequency.The new channel center frequency should be
>> "chandef->center_freq1" after BW negotitaion.
>> "chandef->chan->center_freq" is the primary channel frequency.
> 
> 
> Yeah I think we did fix a couple of bugs in this area later.
> 
>>> +	u8 sta_bw = 20 * BIT(u8_get_bits(eht_oper->chan_width,
>>> +					 IEEE80211_EHT_OPER_CHAN_WIDTH));
>>> +	u8 bw = 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
>>> +	int sta_start_freq = sta_center_freq - sta_bw / 2;
>>> +	int start_freq = center_freq - bw / 2;
>>> +	u16 shift = (start_freq - sta_start_freq) / 20;
>>> +	u16 mask = BIT(sta_bw / 20) - 1;
>> The mask is used to extra the valid bit according to the new BW,
>> but current algorithm is using the old bandwidth.
> 
> 
> :)
> 
>>> +	while (chandef->width > NL80211_CHAN_WIDTH_40) {
>>> +		extracted =
>>> +			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
>>> +							 bitmap);
>>> +
>>> +		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
>>> +							      chandef->width))
>> Here extract the bitmap according new negotiated BW. After extracting,
>> check whether it is valid.
>> I think you should use "&extracted"  instead of "&bitmap"
> 
> Yeah I guess that makes sense.
> 
> I don't know what fixes we have and what version of this patch this is.
> 
>>> +static bool ieee80211_config_puncturing(struct ieee80211_sub_if_data *sdata,
>>> +					const struct ieee80211_eht_operation *eht_oper,
>>> +					u64 *changed)
>>> +{
>>> +	u16 bitmap, extracted;
>>> +	u8 bw;
>>> +
>>> +	if (!u8_get_bits(eht_oper->present_bm,
>>> +			 IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
>>> +		bitmap = 0;
>>> +	else
>>> +		bitmap = get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
>>> +
>> Should check initial bitmap here.
> 
> 
> What do you mean by "initial" here?


"Initial bitmap" is the original bitmap that AP send in beacon . STA 
will extract it according to the negotiated BW. So i call it "Initial 
bitmap".

This is my personal statement.



> 
>>> +	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
>>> +						     &sdata->vif.bss_conf.chandef,
>>> +						     bitmap);
>>> +
>>> +	/* accept if there are no changes */
>>> +	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
>>> +	    extracted == sdata->vif.bss_conf.eht_puncturing)
>>> +		return true;
>>> +
>>> +	bw = u8_get_bits(eht_oper->chan_width, IEEE80211_EHT_OPER_CHAN_WIDTH);
>>> +
>>> +	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw)) {
>>> +		sdata_info(sdata,
>>> +			   "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
>>> +			    sdata->u.mgd.associated->bssid, bitmap, bw);
>>> +		return false;
>>> +	}
>> The initial bitmap received from the AP is checked here.
>> I think it should be carried out before the extraction above.
> 
> Ah, yes I guess that makes sense.
> 
> 
> Anyway the more fundamental thing we have to figure out here (and thanks
> for bringing this back) is how we treat the puncturing - QCOM's AP-side
> puncturing patch treated it as part of the chandef, but that's not
> working well for client side ...
> 


Yes, to my understanding, I think it's more appropriate to define it 
like you in "ieee80211_bss_conf".

But this should be discussed by people like you. I'm just responsible 
for developing according to these definitions.





> johannes

My question is over.

Thanks again for your patient reply.



Best regard
Kang
