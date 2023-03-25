Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A06C8EDB
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCYOeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Mar 2023 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYOeG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Mar 2023 10:34:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F2FF34
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 07:34:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PEB3ri021076;
        Sat, 25 Mar 2023 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WASG4cmFJyzzNH4fhRfxhgn8SsEhYoYGlby18+FOxCI=;
 b=h9GDRWDRb6BURjljVyV8KHlbcF3rXS7DQXO7Pi1C798LyWR/PmdscQDfmkcyYHJEpuCh
 UtPs1Cb5fZybflJzZ5AcsEM1fd89TTMDwRzED4qBlELrM/z1MBnF+7p45htof5+eR6jQ
 AAI1PbV0i8SKTX2TlzN73H/vQ/TKB4cZAMp+flrEgYriQPtyiB+kAZoHduPjNkzdNuGs
 SHobab7Olxael9qbP2hkjgFFH7VcqfjRORLtaRJur3ld4862AHxbA3+nHEx179CB9bne
 HbTse5vVw1b8QGneZJ66kY4sn9btBROJiTY9LaLEJGzwMMfP82trKBMoAO9mEXreDMJr lQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsvj0rwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:33:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32PEXm0Z001104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:33:48 GMT
Received: from [10.253.37.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 25 Mar
 2023 07:33:46 -0700
Message-ID: <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
Date:   Sat, 25 Mar 2023 22:33:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <quic_wgong@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fsRLthm7BdeFa06CMS4v0TiAMJVzncqv
X-Proofpoint-ORIG-GUID: fsRLthm7BdeFa06CMS4v0TiAMJVzncqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250120
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 10:12 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Implement an API function and debugfs file to switch
> active links.
>
> Also provide an async version of the API so drivers
> can call it in arbitrary contexts, e.g. while in the
> authorized callback.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/net/mac80211.h        |  41 ++++++++
>   net/mac80211/debugfs_netdev.c |  26 ++++++
>   net/mac80211/ieee80211_i.h    |   4 +
>   net/mac80211/iface.c          |  12 +++
>   net/mac80211/key.c            |  34 +++++++
>   net/mac80211/key.h            |   3 +
>   net/mac80211/link.c           | 171 ++++++++++++++++++++++++++++++++++
>   7 files changed, 291 insertions(+)
>
> ...
> +static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
> +				       u16 active_links)
> +{
> +	struct ieee80211_bss_conf *link_confs[IEEE80211_MLD_MAX_NUM_LINKS];
> +	struct ieee80211_local *local = sdata->local;
> +	u16 old_active = sdata->vif.active_links;
> +	unsigned long rem = old_active & ~active_links;
> +	unsigned long add = active_links & ~old_active;
> +	struct sta_info *sta;
> +	unsigned int link_id;
> +	int ret, i;
> +
> +	if (!ieee80211_sdata_running(sdata))
> +		return -ENETDOWN;
> +
> +	if (sdata->vif.type != NL80211_IFTYPE_STATION)
> +		return -EINVAL;
> +
> +	/* cannot activate links that don't exist */
> +	if (active_links & ~sdata->vif.valid_links)
> +		return -EINVAL;
> +
> +	/* nothing to do */
> +	if (old_active == active_links)
> +		return 0;
> +
> +	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
> +		link_confs[i] = sdata_dereference(sdata->vif.link_conf[i],
> +						  sdata);
> +
> +	if (add) {
> +		sdata->vif.active_links |= active_links;
> +		ret = drv_change_vif_links(local, sdata,
> +					   old_active,
> +					   sdata->vif.active_links,
> +					   link_confs);
> +		if (ret) {
> +			sdata->vif.active_links = old_active;
> +			return ret;
> +		}
> +	}
> +
> +	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
> +		struct ieee80211_link_data *link;
> +
> +		link = sdata_dereference(sdata->link[link_id], sdata);
> +
> +		/* FIXME: kill TDLS connections on the link */
> +
> +		ieee80211_link_release_channel(link);
> +	}
> +
> +	list_for_each_entry(sta, &local->sta_list, list) {
> +		if (sdata != sta->sdata)
> +			continue;
> +		ret = drv_change_sta_links(local, sdata, &sta->sta,
> +					   old_active,
> +					   old_active | active_links);
> +		WARN_ON_ONCE(ret);
> +	}
> +
> +	ret = ieee80211_key_switch_links(sdata, rem, add);

I see ieee80211_key_switch_link() only handler the per-link(link_id >= 
0) keys,

So I think lower driver also install the pairwise keys(link_id = -1) for 
the added links at this moment?

> +	WARN_ON_ONCE(ret);
> +
> +	list_for_each_entry(sta, &local->sta_list, list) {
> +		if (sdata != sta->sdata)
> +			continue;
> +		ret = drv_change_sta_links(local, sdata, &sta->sta,
> +					   old_active | active_links,
> +					   active_links);
> +		WARN_ON_ONCE(ret);
> +	}
> +

I see 2 times to call drv_change_sta_link() above, and with sequence  
old_active->old_active | active_links->active_links

May I know is it has some design here?

> +	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
> +		struct ieee80211_link_data *link;
> +
> +		link = sdata_dereference(sdata->link[link_id], sdata);
> +
> +		ret = ieee80211_link_use_channel(link, &link->conf->chandef,
> +						 IEEE80211_CHANCTX_SHARED);

For the 1st link of MLO connection/NON-MLO connetion, ieee80211_link_use_channel() is called before drv_change_sta_link(),
And now it is after drv_change_sta_link(), May I know is it also has some design here?

Also I see commit(8fb7e2ef4bab mac80211_hwsim: always activate all links) and ieee80211_if_parse_active_links()
will use ieee80211_set_active_links(), so I think ieee80211_set_active_links() has passed test case with some type lower driver/chip?

> +		WARN_ON_ONCE(ret);
> +
> +		ieee80211_link_info_change_notify(sdata, link,
> +						  BSS_CHANGED_ERP_CTS_PROT |
> +						  BSS_CHANGED_ERP_PREAMBLE |
> +						  BSS_CHANGED_ERP_SLOT |
> +						  BSS_CHANGED_HT |
> +						  BSS_CHANGED_BASIC_RATES |
> +						  BSS_CHANGED_BSSID |
> +						  BSS_CHANGED_CQM |
> +						  BSS_CHANGED_QOS |
> +						  BSS_CHANGED_TXPOWER |
> +						  BSS_CHANGED_BANDWIDTH |
> +						  BSS_CHANGED_TWT |
> +						  BSS_CHANGED_HE_OBSS_PD |
> +						  BSS_CHANGED_HE_BSS_COLOR);
> +		ieee80211_mgd_set_link_qos_params(link);
> +	}
> +
> +	old_active = sdata->vif.active_links;
> +	sdata->vif.active_links = active_links;
> +
> +	if (rem) {
> +		ret = drv_change_vif_links(local, sdata, old_active,
> +					   active_links, link_confs);
> +		WARN_ON_ONCE(ret);
> +	}
> +
> +	return 0;
> +}
> +
...
