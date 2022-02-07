Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B804AB5AE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiBGHWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiBGHJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 02:09:33 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:09:32 PST
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA4C043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644217772; x=1675753772;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aLQS6pqkqY/7fpUhMk0+paN4l81OGctsnF5bmn1ri+w=;
  b=us1CNJ+hXw7tCDyODY5rtjfnmUH8aGjz1EBMM64WZOfNOwISTeiBmK2a
   LbeqnyDZ8uVTKaTNTHYJnmvCVql10C/LPhhBC+Kzw1gsvdrhAW4MYnZD6
   qciw+7bjVxqs5ztF5hbwXihGc0BckffR/V4lCvchmJFwU56swI3UFnYuV
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Feb 2022 23:07:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 23:07:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 6 Feb 2022 23:07:29 -0800
Received: from [10.213.109.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 6 Feb 2022
 23:07:27 -0800
Subject: Re: [PATCH 04/19] ieee80211: Add EHT (802.11be) definitions
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>, Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
 <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Message-ID: <d51984f5-a035-36a5-75f6-3bff67d60b12@quicinc.com>
Date:   Mon, 7 Feb 2022 12:37:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
> From: Ilan Peer <ilan.peer@intel.com>
>
> Based on Draft P802.11be_D1.3.


"Based on Draft P802.11be_D1.0".

based on documentation and MACRO definitions, These changes are aligned 
with P802.11be_D1.0

> +
> +/**
> + * struct ieee80211_eht_mcs_nss_supp_bw - EHT max supported NSS per MCS (except
> + * 20MHz only stations).
> + *
> + * For each field below, bits 0 - 3 indicate the maximal number of spatial
> + * streams for Rx, and bits 4 - 7 indicate the maximal number of spatial streams
> + * for Tx.
> + *
> + * @rx_tx_mcs9_max_nss: indicates the maximum number of spatial streams
> + *     supported for reception and the maximum number of spatial streams
> + *     supported for transmission for MCS 8 - 9.


@rx_tx_mcs9_max_nss supported for transmission for MCS 0 - 9.

> +/**
> + * struct ieee80211_eht_mcs_nss_supp - EHT max supported NSS per MCS
> + *
> + * @only_20mhz: For a 20 MHz-only STA, indicates the maximum number of spatial
> + *     streams supported for reception and the maximum number of spatial streams
> + *     supported for transmission, for each MCS value. Optionally present in
> + *     &struct ieee80211_eht_cap_elem.
> + * @bw_80: If the operating channel width of the STA is greater than or equal to
> + *     80 MHz, indicates the maximum number of spatial streams supported fo

@bw_80 applicable for 20 and 40 MHz operating band widths also for non 20 MHz-only STA

> +/* EHT beamformee SU number of spatial streams <= 80MHz is split between octet 0
> + * and octet 1
> + */
> +#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE_SS_80MHZ  0x80
> +
> +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_80MHZ  0x03
> +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_160MHZ 0x1c
> +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_320MHZ 0xe0
> +


Append _MASK for the macros representing multi bit fields like above?

Or we can use GENMASK() to represent values


- veeru

