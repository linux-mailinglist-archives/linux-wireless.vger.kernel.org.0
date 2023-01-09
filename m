Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336796621D3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjAIJkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 04:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjAIJkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 04:40:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121C64D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 01:40:19 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3098h8Qv030005;
        Mon, 9 Jan 2023 09:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K4wq11DfWu5N/17+iiCpGthkHxvKT155yOBJf//IEEs=;
 b=LtRwuNgTsnXAVrz2p+aTujuBM3sgN0T/Wql+RiU8XAoHsOQWLt7V/LONaQP6u2S2vSSF
 74r7sM+D/VpS/a21PI0J5Zz3XbQze/HSzjvi6PrOQaqXKfrWEZ6M+K6HNmIGlA3Vmqb8
 AI6TJo9Y+XnF+cLZ7CYCUBvyn8rztrKYusA37a6jUzhhCs/tp30h9ap5p58NBgI2w5s9
 TwV9Wy+j3nM227Pg+O140/TWzSwccQpQEI+4omERHyiCtx7nOf45pxA8lb7wKFKBoKu/
 cqtGOBklfOVKV2Mo0mE5Gn+jfyNYGadv6j/tM3KwnbW0uPYWDwOiKgRmmGxW6cKVtJBj DA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0b92r7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 09:39:55 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3099dsoQ024325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 09:39:54 GMT
Received: from [10.253.34.122] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 01:39:51 -0800
Message-ID: <4de1f964-b623-2b31-c044-60cc188fc134@quicinc.com>
Date:   Mon, 9 Jan 2023 17:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 3/5] cfg80211/mac80211: move interface counting for
 combination check to mac80211
Content-Language: en-US
To:     Luciano Coelho <luciano.coelho@intel.com>,
        <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, <michal.kazior@tieto.com>,
        <sw@simonwunderlich.de>, <andrei.otcheretianski@intel.com>,
        <eliad@wizery.com>, <ath11k@lists.infradead.org>
References: <1394547394-3910-1-git-send-email-luciano.coelho@intel.com>
 <1394547394-3910-4-git-send-email-luciano.coelho@intel.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <1394547394-3910-4-git-send-email-luciano.coelho@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v1tYP6z3NXpfbBYbV1NHTm6HBd95eYrj
X-Proofpoint-ORIG-GUID: v1tYP6z3NXpfbBYbV1NHTm6HBd95eYrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=802 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/11/2014 10:16 PM, Luciano Coelho wrote:
> ...
> +int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
> +				 const struct cfg80211_chan_def *chandef,
> +				 enum ieee80211_chanctx_mode chanmode,
> +				 u8 radar_detect)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_sub_if_data *sdata_iter;
> +	enum nl80211_iftype iftype = sdata->wdev.iftype;
> +	int num[NUM_NL80211_IFTYPES];
> +	struct ieee80211_chanctx *ctx;
> +	int num_different_channels = 1;
> +	int total = 1;
> +
> +	lockdep_assert_held(&local->chanctx_mtx);
> +
> +	if (WARN_ON(hweight32(radar_detect) > 1))
> +		return -EINVAL;
> +
> +	if (WARN_ON(chanmode == IEEE80211_CHANCTX_SHARED && !chandef->chan))
> +		return -EINVAL;
> +
> +	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
> +		return -EINVAL;
> +
> +	/* Always allow software iftypes */
> +	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
> +		if (radar_detect)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	memset(num, 0, sizeof(num));
> +
> +	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
> +		num[iftype] = 1;
> +
> +	list_for_each_entry(ctx, &local->chanctx_list, list) {
> +		if (ctx->conf.radar_enabled)
> +			radar_detect |= BIT(ctx->conf.def.width);
> +		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE) {
> +			num_different_channels++;
> +			continue;
> +		}
> +		if ((chanmode == IEEE80211_CHANCTX_SHARED) &&
> +		    cfg80211_chandef_compatible(chandef,
> +						&ctx->conf.def))
> +			continue;
> +		num_different_channels++;
> +	}
> +
> +	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> +		struct wireless_dev *wdev_iter;
> +
> +		wdev_iter = &sdata_iter->wdev;
> +
> +		if (sdata_iter == sdata ||
> +		    rcu_access_pointer(sdata_iter->vif.chanctx_conf) == NULL ||
> +		    local->hw.wiphy->software_iftypes & BIT(wdev_iter->iftype))
> +			continue;
> +
> +		num[wdev_iter->iftype]++;
> +		total++;
> +	}
> +
> +	if (total == 1 && !radar_detect)
> +		return 0;
> +

should also check with cfg80211_check_combinations() when total == 1 and 
num_different_channels > 1 ?

When MLO is enabled, it could have 2 channels for one ieee80211_sub_if_data.

> +	return cfg80211_check_combinations(local->hw.wiphy,
> +					   num_different_channels,
> +					   radar_detect, num);
> +}
> ...
