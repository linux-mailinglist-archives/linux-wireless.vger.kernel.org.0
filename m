Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864B35B2205
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIHPY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIHPYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 11:24:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F845EB2D1
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 08:24:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288EF04T009254;
        Thu, 8 Sep 2022 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GnuPK1Lxn/06hIMVMFoy2tDsZ3AtCIX6OTwMkcY2R5c=;
 b=AaK8ktsTg3VpR70hO2mk3Wlk/0f7o2oN9IifjcogzrlSK456IdTuKRzwqKi+Q2yfigUl
 HURHYpaE48I/sqz11kpIT04D0z7bdzRVbJR7vRxNwzPu2Imz6OZtfbNoxkRH/7J0iJCP
 i/oCclUH9nBrfChmgWaREw8kWwNrhWYNBIEEkN2CgWOE+eEjYBb3LEYQ0XtrfeBXpOcd
 vsloSAq8y0wS/3EnmnSjbLAXmc17bN6DN/PCnmbEbRLIbpn6QgLAb32TtMpA45urSOWn
 yUxDXM0H6Psr/zXNExpL6gbEmQ6Z7xznUwxzOjGddACpQwsxmZaPWbbyRLhNaZ/bWbi2 Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jer1x51eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:24:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288FO04O001003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 15:24:00 GMT
Received: from [10.253.74.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 08:23:59 -0700
Message-ID: <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
Date:   Thu, 8 Sep 2022 23:23:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e_WaemDkP_sYNHFSYPTBPm7vcpxKDbGT
X-Proofpoint-GUID: e_WaemDkP_sYNHFSYPTBPm7vcpxKDbGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080056
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 10:12 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> In order to let the driver select active links and properly
> make multi-link connections, as a first step isolate the
> driver from inactive links, and set the active links to be
> only the association link for client-side interfaces. For
> AP side nothing changes since APs always have to have all
> their links active.
>
> To simplify things, update the for_each_sta_active_link()
> API to include the appropriate vif pointer.
>
> This also implies not allocating a chanctx for an inactive
> link, which requires a few more changes.
>
> Since we now no longer try to program multiple links to the
> driver, remove the check in the MLME code.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/net/mac80211.h    |  30 +++----
>   net/mac80211/chan.c       |   6 ++
>   net/mac80211/driver-ops.c | 172 ++++++++++++++++++++++++++++++++++++++
>   net/mac80211/driver-ops.h | 165 ++++++------------------------------
>   net/mac80211/key.c        |   8 ++
>   net/mac80211/link.c       |  66 ++++++++++++---
>   net/mac80211/mlme.c       |  25 ++----
>   net/mac80211/util.c       |   2 +-
>   8 files changed, 286 insertions(+), 188 deletions(-)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index d4e1d73d88cc..20a2f25a38fa 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1799,6 +1799,9 @@ struct ieee80211_vif_cfg {
>    * @link_conf: in case of MLD, the per-link BSS configuration,
>    *	indexed by link ID
>    * @valid_links: bitmap of valid links, or 0 for non-MLO.
> + * @active_links: The bitmap of active links, or 0 for non-MLO.
> + *	The driver shouldn't change this directly, but use the
> + *	API calls meant for that purpose.
>    * @addr: address of this interface
>    * @p2p: indicates whether this AP or STA interface is a p2p
>    *	interface, i.e. a GO or p2p-sta respectively
> @@ -1834,7 +1837,7 @@ struct ieee80211_vif {
>   	struct ieee80211_vif_cfg cfg;
>   	struct ieee80211_bss_conf bss_conf;
>   	struct ieee80211_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
> -	u16 valid_links;
> +	u16 valid_links, active_links;
>   	u8 addr[ETH_ALEN] __aligned(2);
>   	bool p2p;
>   
...
> @@ -123,11 +132,38 @@ static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
>   	return 0;
>   }
>   
> +static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
> +					    u16 links)
> +{
> +	sdata->vif.valid_links = links;
> +
> +	if (!links) {
> +		sdata->vif.active_links = 0;
> +		return;
> +	}
> +
> +	switch (sdata->vif.type) {
> +	case NL80211_IFTYPE_AP:
> +		/* in an AP all links are always active */
> +		sdata->vif.active_links = links;
> +		break;
> +	case NL80211_IFTYPE_STATION:
> +		if (sdata->vif.active_links)
> +			break;
> +		WARN_ON(hweight16(links) > 1);
> +		sdata->vif.active_links = links;
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +}
> +
Now I found it only active the primay link(the link for 
authentication/assoc request) in my station MLO test,
change_vif_links of struct ieee80211_ops *ops of driver will only be 
called one time for the primary link.
it means only one link for MLO.
I plan to revert this patch in my local test now.

Will you implement muti-links later?
> ...
