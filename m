Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A60704423
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 05:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjEPDxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPDxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 23:53:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C730F8
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 20:52:58 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1ZSjX019135;
        Tue, 16 May 2023 03:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Fymx2p7lR5dUWxf7ZwkCwk+B0Kx/HChgAOGaiuQqrsI=;
 b=ItssiwIU3xlAgrDEiYCle7vvBa8wdr6hfnei/CiL/K6MaV4/FJIk5kfRS7V2gzmxSMka
 woPidnk28aJcDVqv+bHcm4ZnOAHmDvS2EFiedOGt9Lr8i62e0EWgcKr0dW83e7SZXc9f
 2S4fuzL5OWN80n0Vk0HBFSL7YnpkZqxjXzJ26cCQ1GIDHfZ3lKt5AAqdJfyxeym4efWg
 42Ajqh4Ts/UJxKJaia+/cs1wH1KMjMS5LPwxuFCuIEmGWOQzRfrLNvcX+yxC73bM1pRk
 1tiHGjhYG/QyzJCLoLXOFmjsiIQk7lzGBy2HPkOfQ3VvsSmtCTB2XFAqScHdyWMqVVVz 4g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkde22qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 03:52:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G3qpNd022382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 03:52:51 GMT
Received: from [10.253.38.18] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 20:52:48 -0700
Message-ID: <238d0a0d-6dde-de18-9854-e9c74efd2258@quicinc.com>
Date:   Tue, 16 May 2023 11:52:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: mac80211: mlme: handle EHT channel puncturing
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>
References: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
From:   Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pdub23FbJmiPXIMuEogKVjKKE6ifQOkA
X-Proofpoint-ORIG-GUID: pdub23FbJmiPXIMuEogKVjKKE6ifQOkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160031
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi，Johannes Berg，
	
	I find one problem in you patch:
	


On 1/27/2023 7:39 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Handle the Puncturing info received from the AP in the
> EHT Operation element in beacons.
> 
> If the info is invalid:
>   - during association: disable EHT connection for the AP
>   - after association: disconnect
> 
> This commit includes many (internal) bugfixes and spec
> updates various people.
> 
> Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/net/mac80211.h     |   5 +-
>   net/mac80211/cfg.c         |   2 +-
>   net/mac80211/chan.c        |   2 +-
>   net/mac80211/ieee80211_i.h |   2 +-
>   net/mac80211/mlme.c        | 224 ++++++++++++++++++++++++++++++++++++-
>   5 files changed, 228 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 2635e6de8101..54ffc0cc2918 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -340,7 +340,7 @@ struct ieee80211_vif_chanctx_switch {
>    * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
>    * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
>    *	status changed.
> - *
> + * @BSS_CHANGED_EHT_PUNCTURING: The channel puncturing bitmap changed.
>    */
>   enum ieee80211_bss_change {
>   	BSS_CHANGED_ASSOC		= 1<<0,
> @@ -375,6 +375,7 @@ enum ieee80211_bss_change {
>   	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
>   	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
>   	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
> +	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
>   
>   	/* when adding here, make sure to change ieee80211_reconfig */
>   };
> @@ -640,6 +641,7 @@ struct ieee80211_fils_discovery {
>    * @tx_pwr_env_num: number of @tx_pwr_env.
>    * @pwr_reduction: power constraint of BSS.
>    * @eht_support: does this BSS support EHT
> + * @eht_puncturing: bitmap to indicate which channels are punctured in this BSS
>    * @csa_active: marks whether a channel switch is going on. Internally it is
>    *	write-protected by sdata_lock and local->mtx so holding either is fine
>    *	for read access.
> @@ -736,6 +738,7 @@ struct ieee80211_bss_conf {
>   	u8 tx_pwr_env_num;
>   	u8 pwr_reduction;
>   	bool eht_support;
> +	u16 eht_puncturing;
>   
>   	bool csa_active;
>   	bool mu_mimo_owner;
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index f5d43f42f6d8..24b8648cfafa 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -4171,7 +4171,7 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
>   	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
>   	struct ieee80211_link_data *link;
>   	int ret;
> -	u32 changed = 0;
> +	u64 changed = 0;
>   
>   	link = sdata_dereference(sdata->link[link_id], sdata);
>   
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index e72cf0749d49..dbc34fbe7c8f 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -1916,7 +1916,7 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
>   
>   int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
>   				    const struct cfg80211_chan_def *chandef,
> -				    u32 *changed)
> +				    u64 *changed)
>   {
>   	struct ieee80211_sub_if_data *sdata = link->sdata;
>   	struct ieee80211_bss_conf *link_conf = link->conf;
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index d16606e84e22..e833d472ff72 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2478,7 +2478,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link);
>   int __must_check
>   ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
>   				const struct cfg80211_chan_def *chandef,
> -				u32 *changed);
> +				u64 *changed);
>   void ieee80211_link_release_channel(struct ieee80211_link_data *link);
>   void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link);
>   void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 0aee2392dd29..a14a5ea2bffd 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -8,7 +8,7 @@
>    * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2022 Intel Corporation
> + * Copyright (C) 2018 - 2023 Intel Corporation
>    */
>   
>   #include <linux/delay.h>
> @@ -88,6 +88,141 @@ MODULE_PARM_DESC(probe_wait_ms,
>    */
>   #define IEEE80211_SIGNAL_AVE_MIN_COUNT	4
>   
> +struct ieee80211_per_bw_puncturing_values {
> +	u8 len;
> +	const u16 *valid_values;
> +};
> +
> +static const u16 puncturing_values_80mhz[] = {
> +	0x8, 0x4, 0x2, 0x1
> +};
> +
> +static const u16 puncturing_values_160mhz[] = {
> +	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
> +};
> +
> +static const u16 puncturing_values_320mhz[] = {
> +	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
> +	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
> +	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
> +};
> +
> +#define IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
> +	{ \
> +		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
> +		.valid_values = puncturing_values_ ## _bw ## mhz \
> +	}
> +
> +static const struct ieee80211_per_bw_puncturing_values per_bw_puncturing[] = {
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(80),
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(160),
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(320)
> +};
> +
> +static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap,
> +						      enum nl80211_chan_width bw)
> +{
> +	u32 idx, i;
> +
> +	switch (bw) {
> +	case NL80211_CHAN_WIDTH_80:
> +		idx = 0;
> +		break;
> +	case NL80211_CHAN_WIDTH_160:
> +		idx = 1;
> +		break;
> +	case NL80211_CHAN_WIDTH_320:
> +		idx = 2;
> +		break;
> +	default:
> +		*bitmap = 0;
> +		break;
> +	}
> +
> +	if (!*bitmap)
> +		return true;
> +
> +	for (i = 0; i < per_bw_puncturing[idx].len; i++)
> +		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
> +			return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Extract from the given disabled subchannel bitmap (raw format
> + * from the EHT Operation Element) the bits for the subchannel
> + * we're using right now.
> + */
> +static u16
> +ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
> +				 struct cfg80211_chan_def *chandef, u16 bitmap)
> +{
> +	struct ieee80211_eht_operation_info *info = (void *)eht_oper->optional;
> +	struct cfg80211_chan_def ap_chandef = *chandef;
> +	u32 ap_center_freq, local_center_freq;
> +	u32 ap_bw, local_bw;
> +	int ap_start_freq, local_start_freq;
> +	u16 shift, mask;
> +
> +	if (!(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) ||
> +	    !(eht_oper->params &
> +	      IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
> +		return 0;
> +
> +	/* set 160/320 supported to get the full AP definition */
> +	ieee80211_chandef_eht_oper(eht_oper, true, true, &ap_chandef);
> +	ap_center_freq = ap_chandef.center_freq1;
> +	ap_bw = 20 * BIT(u8_get_bits(info->control,
> +				     IEEE80211_EHT_OPER_CHAN_WIDTH));
> +	ap_start_freq = ap_center_freq - ap_bw / 2;
> +	local_center_freq = chandef->center_freq1;
> +	local_bw = 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
> +	local_start_freq = local_center_freq - local_bw / 2;
> +	shift = (local_start_freq - ap_start_freq) / 20;
> +	mask = BIT(local_bw / 20) - 1;
> +
> +	return (bitmap >> shift) & mask;
> +}
> +
> +/*
> + * Handle the puncturing bitmap, possibly downgrading bandwidth to get a
> + * valid bitmap.
> + */
> +static void
> +ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
> +				   const struct ieee80211_eht_operation *eht_oper,
> +				   u16 bitmap, u64 *changed)
> +{
> +	struct cfg80211_chan_def *chandef = &link->conf->chandef;
> +	u16 extracted;
> +	u64 _changed = 0;
> +
> +	if (!changed)
> +		changed = &_changed;
> +
> +	while (chandef->width > NL80211_CHAN_WIDTH_40) {
> +		extracted =
> +			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
> +							 bitmap);
> +
> +		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
> +							      chandef->width))
> +			break;
> +		link->u.mgd.conn_flags |=
> +			ieee80211_chandef_downgrade(chandef);
> +		*changed |= BSS_CHANGED_BANDWIDTH;
> +	}
> +
> +	if (chandef->width <= NL80211_CHAN_WIDTH_40)
> +		extracted = 0;
> +
> +	if (link->conf->eht_puncturing != extracted) {
> +		link->conf->eht_puncturing = extracted;
> +		*changed |= BSS_CHANGED_EHT_PUNCTURING;
> +	}
> +}
> +
>   /*
>    * We can have multiple work items (and connection probing)
>    * scheduling this timer, but we need to take care to only
> @@ -413,7 +548,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
>   			       const struct ieee80211_he_operation *he_oper,
>   			       const struct ieee80211_eht_operation *eht_oper,
>   			       const struct ieee80211_s1g_oper_ie *s1g_oper,
> -			       const u8 *bssid, u32 *changed)
> +			       const u8 *bssid, u64 *changed)
>   {
>   	struct ieee80211_sub_if_data *sdata = link->sdata;
>   	struct ieee80211_local *local = sdata->local;
> @@ -4145,6 +4280,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
>   							    link_sta);
>   
>   			bss_conf->eht_support = link_sta->pub->eht_cap.has_eht;
> +			*changed |= BSS_CHANGED_EHT_PUNCTURING;
>   		} else {
>   			bss_conf->eht_support = false;
>   		}
> @@ -5477,6 +5613,45 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
>   	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
>   }
>   
> +static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
> +					const struct ieee80211_eht_operation *eht_oper,
> +					u64 *changed)
> +{
> +	u16 bitmap = 0, extracted;
> +
> +	if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
> +	    (eht_oper->params &
> +	     IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)) {
> +		const struct ieee80211_eht_operation_info *info =
> +			(void *)eht_oper->optional;
> +		const u8 *disable_subchannel_bitmap = info->optional;
> +
> +		bitmap = get_unaligned_le16(disable_subchannel_bitmap);
> +	}
> +
> +	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
> +						     &link->conf->chandef,
> +						     bitmap);
> +
> +	/* accept if there are no changes */
> +	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
> +	    extracted == link->conf->eht_puncturing)
> +		return true;
> +
> +	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap,
> +						       link->conf->chandef.width)) {
> +		link_info(link,
> +			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
> +			  link->u.mgd.bssid,
> +			  bitmap,
> +			  link->conf->chandef.width);
> +		return false;
> +	}



	You want to verify the subchannel bitmap from AP here right?


	But i think the bandwidth-'link->conf->chandef.width' is wrong, cause 
this bandwidth is the negotiated bandwidth. This bandwidth could be 
downgraded in ieee80211_config_bw()(such as 160Mhz downgrade to 80Mhz).
	Once downgrade happen, the verification could be wrong cause the 
downgrade bandwidth should match the extracted bitmap.



	I saw you use the correct bandiwdth in version 1 patch:

+    bw = u8_get_bits(eht_oper->chan_width,
IEEE80211_EHT_OPER_CHAN_WIDTH);
+
+    if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw)) {
+        sdata_info(sdata,
+               "Got an invalid disable subchannel bitmap from AP %pM: 
bitmap = 0x%x, bw = 0x%x. disconnect\n",
+                sdata->u.mgd.associated->bssid, bitmap, bw);
+        return false;
+    }


	Aloka has move this function to 
cfg80211:cfg80211_valid_disable_subchannel_bitmap() in patch [cfg80211: 
move puncturing bitmap validation from mac80211], but the problem is 
still exist.

	Has your team fixed this issue already?


> +
> +	ieee80211_handle_puncturing_bitmap(link, eht_oper, bitmap, changed);
> +	return true;
> +}
> +
>   static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
>   				     struct ieee80211_hdr *hdr, size_t len,
>   				     struct ieee80211_rx_status *rx_status)
> @@ -5494,7 +5669,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
>   	struct ieee80211_channel *chan;
>   	struct link_sta_info *link_sta;
>   	struct sta_info *sta;
> -	u32 changed = 0;
> +	u64 changed = 0;
>   	bool erp_valid;
>   	u8 erp_value = 0;
>   	u32 ncrc = 0;
> @@ -5791,6 +5966,21 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
>   					       elems->pwr_constr_elem,
>   					       elems->cisco_dtpc_elem);
>   
> +	if (elems->eht_operation &&
> +	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
> +		if (!ieee80211_config_puncturing(link, elems->eht_operation,
> +						 &changed)) {
> +			ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
> +					       WLAN_REASON_DEAUTH_LEAVING,
> +					       true, deauth_buf);
> +			ieee80211_report_disconnect(sdata, deauth_buf,
> +						    sizeof(deauth_buf), true,
> +						    WLAN_REASON_DEAUTH_LEAVING,
> +						    false);
> +			goto free;
> +		}
> +	}
> +
>   	ieee80211_link_info_change_notify(sdata, link, changed);
>   free:
>   	kfree(elems);
> @@ -6892,9 +7082,12 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
>   		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
>   	}
>   
> +	link->conf->eht_puncturing = 0;
> +
>   	rcu_read_lock();
>   	beacon_ies = rcu_dereference(cbss->beacon_ies);
>   	if (beacon_ies) {
> +		const struct ieee80211_eht_operation *eht_oper;
>   		const struct element *elem;
>   		u8 dtim_count = 0;
>   
> @@ -6923,6 +7116,31 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
>   			link->conf->ema_ap = true;
>   		else
>   			link->conf->ema_ap = false;
> +
> +		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION,
> +					      beacon_ies->data, beacon_ies->len);
> +		eht_oper = (const void *)(elem->data + 1);
> +
> +		if (elem &&
> +		    ieee80211_eht_oper_size_ok((const void *)(elem->data + 1),
> +					       elem->datalen - 1) &&
> +		    (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
> +		    (eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)) {
> +			const struct ieee80211_eht_operation_info *info =
> +				(void *)eht_oper->optional;
> +			const u8 *disable_subchannel_bitmap = info->optional;
> +			u16 bitmap;
> +
> +			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
> +			if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
> +								      link->conf->chandef.width))
> +				ieee80211_handle_puncturing_bitmap(link,
> +								   eht_oper,
> +								   bitmap,
> +								   NULL);
> +			else
> +				conn_flags |= IEEE80211_CONN_DISABLE_EHT;
> +		}
>   	}
>   	rcu_read_unlock();
>   
