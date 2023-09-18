Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FC7A547E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIRUxD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 16:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIRUxD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 16:53:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10683112
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 13:52:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKhGuk018613;
        Mon, 18 Sep 2023 20:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mctBDYMlH4+Pv3ZRy8+KRngjGXuesSGZeVDnq7kRlBE=;
 b=IRqcSfEAnOPXCK7mNdxsD+/8MOCODUkrmykSLSvrcp6MyY3ZrIBZmS92OpIKFjLkaGAf
 66y1/2nI1mYI7kcEIHwdejJ/Wf4DOHiIleMXuxwj6N3pBPJ6eafxEhFRcuN8rPLXg4AT
 Cyo2Ber5wwzArJUBC0HFymlzrWoNFyPDcySVI8tbedX1c6ukwEQb0KKFeiPSQC09WqSG
 gUZmWtyi5fQnwsvQVPRjFPLT8ol2XgJ1+TkRzkj/Ra3olvMJSWMiGnuzDvQJ0xeg4bWn
 5HYJVGzZqRtXV8Av8hNGeicX/x2S0H21tOjnUXRgDIdH+Cnu9vAGH2O4hoI7DmGhv20V VQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t54f141xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 20:52:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38IKqob3027207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 20:52:50 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 13:52:50 -0700
Message-ID: <9d46505f-7df7-40c6-8a9a-203e6687b713@quicinc.com>
Date:   Mon, 18 Sep 2023 13:52:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] wifi: mac80211: add support for parsing TID to Link
 mapping element
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
 <20230918140607.5398d9c5df2a.I2281ab2c70e8b43a39032dc115db6a80f1f0b3f4@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230918140607.5398d9c5df2a.I2281ab2c70e8b43a39032dc115db6a80f1f0b3f4@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lRtf-85EOtuz4zsy7qzmoz69BJz-LAl7
X-Proofpoint-GUID: lRtf-85EOtuz4zsy7qzmoz69BJz-LAl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_09,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/2023 4:10 AM, gregory.greenman@intel.com wrote:
> From: Ayala Beker <ayala.beker@intel.com>
> 
> Add the relevant definitions for TID to Link mapping element
> according to the P802.11be_D3.0.

Is there a reason to not reference Draft 4 since it is the most recent?

> 
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   include/linux/ieee80211.h  | 51 ++++++++++++++++++++++++++++++++++++++
>   net/mac80211/ieee80211_i.h |  3 +++
>   net/mac80211/util.c        |  8 ++++++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index f11b7022d9eb..6e8913dbbff6 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -1246,6 +1246,23 @@ struct ieee80211_twt_setup {
>   	u8 params[];
>   } __packed;
>   
> +#define IEEE80211_T2L_MAP_MAX_CNT			2

is there a reason to not use the same TTLM abbreviation that is used by
the draft? please consider a global s/t2l_map/ttlm/

> +#define IEEE80211_T2L_MAP_CONTROL_DIRECTION		0x03
> +#define IEEE80211_T2L_MAP_CONTROL_DEF_LINK_MAP		0x04
> +#define IEEE80211_T2L_MAP_CONTROL_SWITCH_TIME_PRESENT	0x08
> +#define IEEE80211_T2L_MAP_CONTROL_EXPECTED_DUR_PRESENT	0x10
> +#define IEEE80211_T2L_MAP_CONTROL_LINK_MAP_SIZE		0x20
> +
> +#define IEEE80211_T2L_MAP_DIRECTION_DOWN		0
> +#define IEEE80211_T2L_MAP_DIRECTION_UP			1
> +#define IEEE80211_T2L_MAP_DIRECTION_BOTH		2
> +
> +struct ieee80211_t2l_map_elem {

perhaps add kernel-doc, and document the spec reference, which in D4 is 
9.4.2.314 TID-To-Link Mapping element

> +	/* the second part of control field is in optional[] */
> +	u8 control;
> +	u8 optional[];
> +} __packed;
> +
>   struct ieee80211_mgmt {
>   	__le16 frame_control;
>   	__le16 duration;
> @@ -3618,6 +3635,7 @@ enum ieee80211_eid_ext {
>   	WLAN_EID_EXT_EHT_OPERATION = 106,
>   	WLAN_EID_EXT_EHT_MULTI_LINK = 107,
>   	WLAN_EID_EXT_EHT_CAPABILITY = 108,
> +	WLAN_EID_EXT_TID_TO_LINK_MAPPING = 109,
>   	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
>   };
>   
> @@ -5155,6 +5173,39 @@ static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
>   	       fixed + prof->sta_info_len - 1 <= len;
>   }
>   
> +static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
> +{
> +	const struct ieee80211_t2l_map_elem *t2l = (const void *)data;
> +	u8 control, fixed = sizeof(*t2l), elem_len = 0;
> +
> +	if (len < fixed)
> +		return false;
> +
> +	control = t2l->control;
> +
> +	if (control & IEEE80211_T2L_MAP_CONTROL_SWITCH_TIME_PRESENT)
> +		elem_len += 2;
> +	if (control & IEEE80211_T2L_MAP_CONTROL_EXPECTED_DUR_PRESENT)
> +		elem_len += 3;
> +
> +	if (!(control & IEEE80211_T2L_MAP_CONTROL_DEF_LINK_MAP)) {
> +		u8 bm_size;
> +
> +		elem_len += 1;
> +		if (len < fixed + elem_len)
> +			return false;
> +
> +		if (control & IEEE80211_T2L_MAP_CONTROL_LINK_MAP_SIZE)
> +			bm_size = 1;
> +		else
> +			bm_size = 2;
> +
> +		elem_len += hweight8(t2l->optional[0]) * bm_size;
> +	}
> +
> +	return len >= fixed + elem_len;
> +}
> +
>   #define for_each_mle_subelement(_elem, _data, _len)			\
>   	if (ieee80211_mle_size_ok(_data, _len))				\
>   		for_each_element(_elem,					\
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 6c56ec42dde9..fde956f8a939 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1678,6 +1678,7 @@ struct ieee802_11_elems {
>   	const struct ieee80211_multi_link_elem *ml_basic;
>   	const struct ieee80211_multi_link_elem *ml_reconf;
>   	const struct ieee80211_bandwidth_indication *bandwidth_indication;
> +	const struct ieee80211_t2l_map_elem *t2l_map[IEEE80211_T2L_MAP_MAX_CNT];
>   
>   	/* length of them, respectively */
>   	u8 ext_capab_len;
> @@ -1711,6 +1712,8 @@ struct ieee802_11_elems {
>   	/* The reconfiguration Multi-Link element in the original IEs */
>   	const struct element *ml_reconf_elem;
>   
> +	u8 t2l_map_num;
> +
>   	/*
>   	 * store the per station profile pointer and length in case that the
>   	 * parsing also handled Multi-Link element parsing for a specific link
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 97c5823da0eb..648d4b883d43 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -995,6 +995,14 @@ ieee80211_parse_extension_element(u32 *crc,
>   			elems->bandwidth_indication = data;
>   		calc_crc = true;
>   		break;
> +	case WLAN_EID_EXT_TID_TO_LINK_MAPPING:
> +		calc_crc = true;
> +		if (ieee80211_tid_to_link_map_size_ok(data, len) &&
> +		    elems->t2l_map_num < ARRAY_SIZE(elems->t2l_map)) {
> +			elems->t2l_map[elems->t2l_map_num] = (void *)data;
> +			elems->t2l_map_num++;
> +		}
> +		break;
>   	}
>   
>   	if (crc && calc_crc)

