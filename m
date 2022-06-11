Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66755475A5
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiFKObo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiFKObn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 10:31:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DB70923
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 07:31:42 -0700 (PDT)
X-UUID: a8f246dced2f4972a5709118dc87bb08-20220611
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:badff68e-d206-4bb0-86fd-36e162371f19,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:badff68e-d206-4bb0-86fd-36e162371f19,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:bb7a87e7-1f03-4449-90ad-e6cb8f3d1399,C
        OID:f09c7cb062d4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: a8f246dced2f4972a5709118dc87bb08-20220611
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 669793663; Sat, 11 Jun 2022 22:31:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 11 Jun 2022 22:31:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 11 Jun 2022 22:31:35 +0800
Message-ID: <e41ccc07f21e72ab3291ce4a7fdefb9a32253881.camel@mediatek.com>
Subject: Re: [PATCH] mac80211: Add HE MU-MIMO related flags in
 ieee80211_bss_conf
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Muna Sinada <quic_msinada@quicinc.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Date:   Sat, 11 Jun 2022 22:31:34 +0800
In-Reply-To: <1654624440-30386-1-git-send-email-quic_msinada@quicinc.com>
References: <1654624440-30386-1-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-06-07 at 10:54 -0700, Muna Sinada wrote:
> Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and Full
> Bandwidth UL MU-MIMO for HE. This is utilized to pass MU-MIMO
> configurations from user space to driver.
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
>  include/net/mac80211.h | 10 ++++++++++
>  net/mac80211/cfg.c     | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index ebadb2103968..5c8d99e6bb1e 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -636,6 +636,12 @@ struct ieee80211_fils_discovery {
>   * @tx_pwr_env_num: number of @tx_pwr_env.
>   * @pwr_reduction: power constraint of BSS.
>   * @eht_support: does this BSS support EHT
> + * @he_su_beamformer: does this BSS support operation as an HE SU
> beamformer
> + * @he_su_beamformee: does this BSS support operation as an HE SU
> beamformee
> + * @he_mu_beamformer: does this BSS support operation as an HE MU
> beamformer
> + * @he_full_ul_mumimo: does this BSS support the reception (AP) or
> transmission
> + *	(non-AP STA) of an HE TB PPDU on an RU that spans the entire
> PPDU
> + *	bandwidth
>   */
>  struct ieee80211_bss_conf {
>  	const u8 *bssid;
> @@ -711,6 +717,10 @@ struct ieee80211_bss_conf {
>  	u8 tx_pwr_env_num;
>  	u8 pwr_reduction;
>  	bool eht_support;
> +	bool he_su_beamformer;
> +	bool he_su_beamformee;
> +	bool he_mu_beamformer;
> +	bool he_full_ul_mumimo;
>  };
>  
>  /**
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index f7896f257e1b..900046825981 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1178,6 +1178,21 @@ static int ieee80211_start_ap(struct wiphy
> *wiphy, struct net_device *dev,
>  			changed |= BSS_CHANGED_HE_BSS_COLOR;
>  	}
>  
> +	if (params->he_cap) {
> +		sdata->vif.bss_conf.he_su_beamformer =
> +					!!(params->he_cap-
> >phy_cap_info[3] &
> +					   IEEE80211_HE_PHY_CAP3_SU_BEA
> MFORMER);
> +		sdata->vif.bss_conf.he_su_beamformee =
> +					!!(params->he_cap-
> >phy_cap_info[4] &
> +					   IEEE80211_HE_PHY_CAP4_SU_BEA
> MFORMEE);
> +		sdata->vif.bss_conf.he_mu_beamformer =
> +					!!(params->he_cap-
> >phy_cap_info[4] &
> +					   IEEE80211_HE_PHY_CAP4_MU_BEA
> MFORMER);
> +		sdata->vif.bss_conf.he_full_ul_mumimo =
> +				   !!(params->he_cap->phy_cap_info[2] &
> +				      IEEE80211_HE_PHY_CAP2_UL_MU_FULL_
> MU_MIMO);
> +	}
> +
>  	if (sdata->vif.type == NL80211_IFTYPE_AP &&

What about VHT? I think we should also take them into account since
user space (hostap) doesn't propagate all (not just HE) MIMO related
configurations to kernel actually. 

So, I added a similar check into mt76 driver.

Ryder

