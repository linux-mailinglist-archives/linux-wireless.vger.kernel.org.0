Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10C4AB5C3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiBGHVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiBGHJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 02:09:51 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:09:50 PST
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F250AC043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 23:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644217791; x=1675753791;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8g5obKYiKUG0wNcN3FqPH1GW/r9QX0L7WsYlU4JNk80=;
  b=NpreCayk6H2GJEQSRDysb+t64AqJOij/aS8IzXhplFwRtwX7AXLsQxDt
   uDJ7Xe1mce1Nj+06qm0/DWrOJkFq9SETwgb6JaiNXc9ta8Fxuo7zCns8N
   uZwX6Sq/LZ0T7hpefrt0RhIT6tiJ1EXzlk2XMUquxVkxGEfpbkAtGLWiC
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Feb 2022 23:07:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 23:07:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 6 Feb 2022 23:07:47 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 6 Feb 2022
 23:07:45 -0800
Subject: Re: [PATCH 06/19] cfg80211: Add data structures to capture EHT
 capabilities
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>, Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
 <20220204230119.b0eeb527d761.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <620cb5ab-ff70-d429-74cd-d968f884fb49@quicinc.com>
Date:   Mon, 7 Feb 2022 12:37:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220204230119.b0eeb527d761.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/5/22 3:32 AM, Johannes Berg wrote:
> + *
> + * @has_he: true iff HE data is valid.


@has_eht: true iff EHT data is valid.

> + * @eht_cap_elem: Fixed portion of the eht capabilities element.
> + * @eht_mcs_nss_supp: The supported NSS/MCS combinations.
> + * @eht_ppe_thres: Holds the PPE Thresholds data.
> + */
> +struct ieee80211_sta_eht_cap {
> +	bool has_eht;
> +	struct ieee80211_eht_cap_elem_fixed eht_cap_elem;
> +	struct ieee80211_eht_mcs_nss_supp eht_mcs_nss_supp;
> +	u8 eht_ppe_thres[IEEE80211_EHT_PPE_THRES_MAX_LEN];
> +};
> +

