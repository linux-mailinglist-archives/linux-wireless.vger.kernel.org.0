Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A047A17D2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjIOHxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIOHxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 03:53:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D6193
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 00:53:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7lo8U019770;
        Fri, 15 Sep 2023 07:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gx+acewLwbR91jAvzqmFeE1MidaDEoLC3cXvEcdCXQM=;
 b=oIVvYO/3lPIK5N65s8xwGKfcLRU/3e4CajaQY89zHCVgGEfAtzupkP1zyBf7viOyebPW
 m4oz4ENXaebB9SnzBCZKnqUz2xp0FJy5QTPcs/eqMQ0JIeh7X6jU1eIA7ait7dTKPrAe
 9U8OdaUrPSstye0iFEc5rWl3kgHlDQDyYw7mMEV1H7HxCCvJLKR5LLnpDedvMn6q6DbV
 zs2xRlVwFxq2P6G7PfBftx3BiSBLh+IbTJG6+f1UT9Up3yDZxYiw0kTEPY2va7afd0vE
 5BAVYHIZNHpOE1sBP0M/B5O1APh2qtO9UgKuKjQu7vf9bIh4quymwtGptvfPeen7BcsY Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3n8dh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 07:53:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F7rPHr030042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 07:53:25 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 00:53:10 -0700
Message-ID: <7e350410-0e45-910d-68db-ea1d85df958a@quicinc.com>
Date:   Fri, 15 Sep 2023 15:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
 <20230906103458.24092-4-quic_wgong@quicinc.com>
 <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QaF8VtYbuC2c_IM7uXxEhjbHuLb8E0Nn
X-Proofpoint-ORIG-GUID: QaF8VtYbuC2c_IM7uXxEhjbHuLb8E0Nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=868
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150068
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 5:04 PM, Johannes Berg wrote:
> On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
>> Currently for MLO connection, only deflink's rx_nss is set to correct
>> value. The others links' rx_nss of struct ieee80211_link_sta is
>> value 0 in ieee80211_set_associated(), because they are not pass into
>> ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
>> rate_control_rate_init(). This leads driver get NSS = 0 for other links.
>> Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
>> then the other links' rx_nss will be set to the correct value.
> This is pretty much true, but I also think it's problematic the way you
> phrase it. Software rate control is pretty much, at least currently,
> _not_ supported for MLO (and I don't really see how to support it, if
> firmware picks the link to transmit on, as it probably should).
>
> Thus, I'm not even sure we should be calling rate_control_rate_init().
> Clearly we do today, but it's also obviously wrong for everything except
> the call to ieee80211_sta_set_rx_nss().
>
> So while I agree that there's a problem with the RX NSS, I disagree that
> this patch is the right way to fix it. Yes, it also fairly obviously
> fixes the problem, but it just makes an existing design problem worse.
>
> Please change change the overall design here so that
> ieee80211_sta_set_rx_nss() isn't related to rate control at all.
>
> johannes
So should I delete ieee80211_sta_set_rx_nss() in rate_control_rate_init(),
and add it into ieee80211_assoc_config_link() as you said before here?
https://lore.kernel.org/linux-wireless/ca0f6ea2d78538ffb6640f2e56d65c89c86f5221.camel@sipsolutions.net/

I checked the git log, ieee80211_sta_set_rx_nss() is added into
rate_control_rate_init() here for VHT, so is it correct to delete
ieee80211_sta_set_rx_nss() in rate_control_rate_init()?
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=8921d04e8df7475d733d853564bdb001e83bf33f
>
