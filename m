Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DF77863E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjHKDwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 23:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHKDwO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 23:52:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D22D7D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 20:52:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B3DIO8023061;
        Fri, 11 Aug 2023 03:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t+2PDn/47SHvW5c4pBCdYCKq2jYDjcrj7A860UumZa8=;
 b=bUE9NheaNXygnf2S2BTGsBM8PYhiLss/59Ba/55KUDZPRCohQsH1DzYGq63SA9PIX5dw
 neHD3p/WzkFtPgmWi3WUFx1bHMEx8jx2FLivh7r2T2XUnATYpfFxMWogyk1fbqBel6jJ
 ttUUy5FBXhH5DA04DG6acuCN2rkRAzbQLpddxNQmsOTzvsAIUDKUkXBbXpPBEiZNUHY2
 cnjck2ntqP5SBgD2LB/m0/AErZ5TAEE2eapk/Or0WnTzWaE03UZNhtq4bVfM6jUH15Li
 T1JZbpGn42eqsV7We7awMUa2C+QagPOkUFVwGAciMpT8e4xrLxbJ/4ZxH6lijMSGlawl jA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yd8cn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 03:51:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B3pNNS001903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 03:51:23 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 20:51:21 -0700
Message-ID: <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
Date:   Fri, 11 Aug 2023 11:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <ath12k@lists.infradead.org>, <quic_rkaliapp@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
 <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U9MN4OosFzdYnUO7C6NGe8iUTz95Dyey
X-Proofpoint-ORIG-GUID: U9MN4OosFzdYnUO7C6NGe8iUTz95Dyey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=913 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308110035
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/13/2022 5:44 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> We have the per-interface type capabilities, currently for
> extended capabilities, add the EML/MLD capabilities there
> to have this advertised by the driver.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/net/cfg80211.h       |  4 ++++
>   include/uapi/linux/nl80211.h | 12 ++++++++++--
>   net/wireless/nl80211.c       |  9 +++++++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index ca26e3b7341a..44abaa9d74ea 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4993,12 +4993,16 @@ struct wiphy_vendor_command {
>    *	802.11-2012 8.4.2.29 for the defined fields.
>    * @extended_capabilities_mask: mask of the valid values
>    * @extended_capabilities_len: length of the extended capabilities
> + * @eml_capabilities: EML capabilities (for MLO)
> + * @mld_capa_and_ops: MLD capabilities and operations (for MLO)
>    */
>   struct wiphy_iftype_ext_capab {
>   	enum nl80211_iftype iftype;
>   	const u8 *extended_capabilities;
>   	const u8 *extended_capabilities_mask;
>   	u8 extended_capabilities_len;
> +	u16 eml_capabilities;
> +	u16 mld_capa_and_ops;
>   };
>   

Now there are many nl80211_band such as NL80211_BAND_2GHZ/
NL80211_BAND_5GHZ/NL80211_BAND_6GHZ... In the same interface, if some bands
support EML, and other bands not support EML, then how to handler this
case?

Could move the "u16 eml_capabilities" into struct 
ieee80211_sband_iftype_data
as well as "struct ieee80211_sta_eht_cap eht_cap"? Also same for "u16
mld_capa_and_ops".

[...]

