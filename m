Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6372615A50
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiKBD26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 23:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKBD2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 23:28:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37426116
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 20:28:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A226mLS006108;
        Wed, 2 Nov 2022 03:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JMKf0yFfJ/EUEI0jPVKLy9oPtmYLoJuU7VfHNXHZHtE=;
 b=pWVmTT44tyDFpAF3bsIIhlrf+p3JfYIweAEjNVLg+F8BjW+339zm3RcC/4CAUgUYbXUp
 hfgdFN4RB32P/HURxVzLhdkZa0/fujaGOqZDgF7yxqqWfrG89n35e2PI7pXPGMlOrHku
 G4VGVNb1doi8sBtgtW38z4UCv6sGKTLPeF0IxfKEfVTfqTtZPiMsTxExU8hfjTGwo4nz
 79UHwY9lOzmJHALvs/LHuI+krdZhe1gGfLiiT2+fTFo5QSp6tP4HSCUqlYT7d+w4MK/U
 GW1jOBGZT7c807RDgPfSQ/gjYXqnQtmwuRbqayW82jP66URkB0KGY6OuifmyxQ5WeztF Qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7nfh2x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 03:26:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A23QCuN025729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 03:26:12 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 20:26:11 -0700
Message-ID: <04ad44c0-4012-50a4-f24a-64723a1c0a4f@quicinc.com>
Date:   Wed, 2 Nov 2022 11:26:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mac80211: Add 802.11h CSA support
Content-Language: en-US
To:     Sujith <Sujith.Manoharan@atheros.com>, <linville@tuxdriver.com>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <Jouni.Malinen@Atheros.com>, <ath11k@lists.infradead.org>
References: <18786.55021.734826.472061@gargle.gargle.HOWL>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <18786.55021.734826.472061@gargle.gargle.HOWL>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fva6eJHitJ8FhqXY-PU8AdIiwyNOTKoY
X-Proofpoint-GUID: Fva6eJHitJ8FhqXY-PU8AdIiwyNOTKoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_12,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/6/2009 11:58 AM, Sujith wrote:
> Move to the advertised channel on reception of
> a CSA element. This is needed for 802.11h compliance.
>
> Signed-off-by: Sujith <Sujith.Manoharan@atheros.com>
> ---
> v2
> --
> * Add a new variable to hold the CSA channel
> * Use msecs_to_jiffies for calculating expiration time
> * Add a check to drop beacons in case of a frequency mismatch
>
> v3
> --
> * Add a BSSID check when handling CSA action frame
>
>   net/mac80211/ieee80211_i.h |   11 ++++++-
>   net/mac80211/iface.c       |    2 +
>   net/mac80211/mlme.c        |   13 +++++++
>   net/mac80211/rx.c          |   20 +++++++++++
>   net/mac80211/spectmgmt.c   |   77 ++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 122 insertions(+), 1 deletions(-)
>
> ...
> +void ieee80211_process_chanswitch(struct ieee80211_sub_if_data *sdata,
> +				  struct ieee80211_channel_sw_ie *sw_elem,
> +				  struct ieee80211_bss *bss)
> +{
> +	struct ieee80211_channel *new_ch;
> +	struct ieee80211_if_sta *ifsta = &sdata->u.sta;
> +	int new_freq = ieee80211_channel_to_frequency(sw_elem->new_ch_num);
> +
> +	/* FIXME: Handle ADHOC later */
> +	if (sdata->vif.type != NL80211_IFTYPE_STATION)
> +		return;
> +
> +	if (ifsta->state != IEEE80211_STA_MLME_ASSOCIATED)
> +		return;
> +
> +	if (sdata->local->sw_scanning || sdata->local->hw_scanning)
> +		return;
> +
May I know why channel switch should not go ahead while it is doing scan?
It lead channel switch fail sometimes.
For example, channel switch count is 10, then it has 10 becaons with 
channel switch IE
in the 1 second, if it is doing a hw scan(time cost is more than 1 
second) at that moment,
the channel switch of 10 beacons will not be handle, and lead channel 
switch fail.

Currently it is changed like this in net/mac80211/mlme.c
ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
...

     if (local->scanning)
         return;
...
