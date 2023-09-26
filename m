Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C47AEAAF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjIZKql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjIZKqk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 06:46:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E8E9
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 03:46:31 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4tARm005606;
        Tue, 26 Sep 2023 10:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ndizang7TydwiwJImdwpJlQyi+OoeOrfjPz1tQuJ+hI=;
 b=Ut+uhX2VwDsjU6h9Rlyk3Z2QEWQhnRn8OACF7veQRTjB/OtpwLZBXN0lNEY+WlEP0iSj
 OGskIpYNkQ0vc8sN3B4HjeA26QyNDAWctj03oA89+qvvxbM4vxS3G19t/gbXw+MgP0NG
 WQqgVxE7AsVelVIoB4hgkN2CnRvIqBSZjUd816EjjtTu2HBOoGBK4FxC7FoabGkutgE3
 l4RtDSBSe3TwWq1EmbxeH/7c38E3Ujd03zzz6QU6ssIjdCmMZK1L6DDNk6aW4Q1wAgqK
 30XuZtyo+VdhKE5+7yp3haYwy9CSHboSJY+B3R7/Yk9Y4wGcG3Iq/DdPOzNpSsJlGmv+ Ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb6tt3097-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:46:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QAkKSF030226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:46:20 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 03:46:19 -0700
Message-ID: <3a9cf522-85d3-fa42-378c-56467fb50636@quicinc.com>
Date:   Tue, 26 Sep 2023 18:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
 <20230906103458.24092-4-quic_wgong@quicinc.com>
 <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
 <7e350410-0e45-910d-68db-ea1d85df958a@quicinc.com>
 <d42b46d628c1d0d09d8772f19cec0b572251c02b.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <d42b46d628c1d0d09d8772f19cec0b572251c02b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FndFLqQlAWOpJ4J9rf1x_m5fhy1Pnvpa
X-Proofpoint-ORIG-GUID: FndFLqQlAWOpJ4J9rf1x_m5fhy1Pnvpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=938 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260092
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/26/2023 5:42 PM, Johannes Berg wrote:
> On Fri, 2023-09-15 at 15:53 +0800, Wen Gong wrote:
>> On 9/13/2023 5:04 PM, Johannes Berg wrote:
>>> On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
>>>> Currently for MLO connection, only deflink's rx_nss is set to correct
>>>> value. The others links' rx_nss of struct ieee80211_link_sta is
>>>> value 0 in ieee80211_set_associated(), because they are not pass into
>>>> ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
>>>> rate_control_rate_init(). This leads driver get NSS = 0 for other links.
>>>> Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
>>>> then the other links' rx_nss will be set to the correct value.
>>> This is pretty much true, but I also think it's problematic the way you
>>> phrase it. Software rate control is pretty much, at least currently,
>>> _not_ supported for MLO (and I don't really see how to support it, if
>>> firmware picks the link to transmit on, as it probably should).
>>>
>>> Thus, I'm not even sure we should be calling rate_control_rate_init().
>>> Clearly we do today, but it's also obviously wrong for everything except
>>> the call to ieee80211_sta_set_rx_nss().
>>>
>>> So while I agree that there's a problem with the RX NSS, I disagree that
>>> this patch is the right way to fix it. Yes, it also fairly obviously
>>> fixes the problem, but it just makes an existing design problem worse.
>>>
>>> Please change change the overall design here so that
>>> ieee80211_sta_set_rx_nss() isn't related to rate control at all.
>>>
>>> johannes
>> So should I delete ieee80211_sta_set_rx_nss() in rate_control_rate_init(),
>> and add it into ieee80211_assoc_config_link() as you said before here?
>> https://lore.kernel.org/linux-wireless/ca0f6ea2d78538ffb6640f2e56d65c89c86f5221.camel@sipsolutions.net/
> I think that would make sense. After all, rate_control_rate_init() is
> related to the software rate control which isn't really supported with
> MLD, and the NSS init is unrelated, it's just updating a piece of per
> (link) station data.
>
>> I checked the git log, ieee80211_sta_set_rx_nss() is added into
>> rate_control_rate_init() here for VHT, so is it correct to delete
>> ieee80211_sta_set_rx_nss() in rate_control_rate_init()?
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=8921d04e8df7475d733d853564bdb001e83bf33f
> Well we'll have to call it appropriately when rate_control_rate_init()
> is called today, and then the new places in your patch, I guess.
>
> But I per the above that makes more sense semantically, since we don't
> support software rate control on link stations.
>
> johannes

OK. So I will send new version patch to remove the

ieee80211_sta_set_rx_nss() in rate_control_rate_init() as you said.

