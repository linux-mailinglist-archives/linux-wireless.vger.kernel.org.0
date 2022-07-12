Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF612572938
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiGLWXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 18:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGLWXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 18:23:09 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474A32EF8
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657664588; x=1689200588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TMs1D58L8noQwFWIUf9YfRARmfjXroSc9l9XZhraDUI=;
  b=gM4sxl/vRhMEdkQ3AGFg+ZFRAXA1FTKUK3ZneLS149tz/8eMTqf/94Za
   1SaQh+16z+IbvPMl2pU+yItYnSUBUVY8eSQB1yrerB2kBaoOdc0FRClXO
   k2+Yzm/cbr57mEt3+sZBqJyk4RfEciwlNyAQLp+ag30khcE77ZzCn9FbN
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Jul 2022 15:23:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:23:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 15:23:07 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 15:23:06 -0700
Message-ID: <c79dca8b-ae49-a015-8ce9-e22c8dd1ceda@quicinc.com>
Date:   Tue, 12 Jul 2022 15:23:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/12] mac80211: S1G capabilities information element in
 probe request
Content-Language: en-US
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Bassem Dawood <bassem@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
 <20220711010816.45927-8-kieran.frewen@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220711010816.45927-8-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/10/2022 6:08 PM, Kieran Frewen wrote:
> Add the missing S1G capabilities information element to probe requests.
> 
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
> ---
>   net/mac80211/util.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index bccc3a309ed0..51a2c1dee360 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -1832,6 +1832,43 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
>   	rate_flags = ieee80211_chandef_rate_flags(chandef);
>   	shift = ieee80211_chandef_get_shift(chandef);
>   
> +	/* For direct mac80211 scan (probe request), add S1G IE and consider its override bits */
> +	if (band == NL80211_BAND_S1GHZ) {
> +		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
> +		struct ieee80211_s1g_cap s1g_capab;
> +
> +		*pos++ = WLAN_EID_S1G_CAPABILITIES;
> +		*pos++ = sizeof(s1g_capab);
> +

why create s1g_capab on the stack and then copy into place?
why not create it directly in place and avoid the copy?

> +		memcpy(s1g_capab.capab_info,
> +		       sband->s1g_cap.cap,
> +		       sizeof(sband->s1g_cap.cap));
> +		memcpy(s1g_capab.supp_mcs_nss,
> +		       sband->s1g_cap.nss_mcs,
> +		       sizeof(sband->s1g_cap.nss_mcs));
> +
> +		/* override the capability info */
> +		for (i = 0; i < sizeof(ifmgd->s1g_capa.capab_info); i++) {
> +			u8 mask = ifmgd->s1g_capa_mask.capab_info[i];
> +
> +			s1g_capab.capab_info[i] &= ~mask;
> +			s1g_capab.capab_info[i] |= ifmgd->s1g_capa.capab_info[i] & mask;
> +		}
> +
> +		/* then MCS and NSS set */
> +		for (i = 0; i < sizeof(ifmgd->s1g_capa.supp_mcs_nss); i++) {
> +			u8 mask = ifmgd->s1g_capa_mask.supp_mcs_nss[i];
> +
> +			s1g_capab.supp_mcs_nss[i] &= ~mask;
> +			s1g_capab.supp_mcs_nss[i] |= ifmgd->s1g_capa.supp_mcs_nss[i] & mask;
> +		}
> +
> +		memcpy(pos, &s1g_capab, sizeof(s1g_capab));
> +		pos += sizeof(s1g_capab);
> +		/* No more IEs relevant for S1G */
> +		goto done;
> +	}
> +
>   	num_rates = 0;
>   	for (i = 0; i < sband->n_bitrates; i++) {
>   		if ((BIT(i) & rate_mask) == 0)

