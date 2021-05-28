Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBDD3942F1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhE1MxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhE1MxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 08:53:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A17C061574
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k/+M1sKBjC5GKmu+DERy9KJMuRoPW65z3WcZazvAzLk=; b=ZJHkyfb+eZ0z8u5lusZGKChf9m
        J5bukcQzpxfIc0ukldOZ8Ue8JCuacXVtOiTxhErPOXP91OQcvIF679C915Q7u6UvgiDDjC2MzvBPD
        w01AmrTIf2rnk/svLSQtkvImMBZc6vAdZ8ZFuQ8rrsyVgY76G1lMQjbQeEb7E98FdJKI=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lmbxS-0003Ki-PW; Fri, 28 May 2021 14:51:22 +0200
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
 <1620659697-12048-4-git-send-email-sean.wang@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 4/9] mt76: mt7921: enable deep sleep at runtime
Message-ID: <6020930d-14dd-4150-3d91-454128bb9fc7@nbd.name>
Date:   Fri, 28 May 2021 14:51:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620659697-12048-4-git-send-email-sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Sean,

On 2021-05-10 17:14, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Enable the deep sleep mode with that firmware is able to trap into
> the doze state at runtime to reduce the power consumption further.
> 
> The deep sleep mode is not allowed in the STA state transition with
> the firmware to have the fast connection experience as we've done in
> the full power mode
> 
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 20 +++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  6 +++-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 28 +++++++++++++++++--
>  4 files changed, 54 insertions(+), 3 deletions(-)
> 
>  void mt7921_unregister_device(struct mt7921_dev *dev)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 39b3e769925e..5dbccbefe047 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -848,6 +848,31 @@ mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  			      IEEE80211_STA_NOTEXIST);
>  }
>  
> +static int mt7921_sta_state(struct ieee80211_hw *hw,
> +			    struct ieee80211_vif *vif,
> +			    struct ieee80211_sta *sta,
> +			    enum ieee80211_sta_state old_state,
> +			    enum ieee80211_sta_state new_state)
> +{
> +	struct mt7921_dev *dev = mt7921_hw_dev(hw);
> +
> +	if (dev->pm.enable) {
> +		mt7921_mutex_acquire(dev);
> +		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
> +		mt7921_mutex_release(dev);
> +	}
> +
> +	if (old_state == IEEE80211_STA_AUTH &&
> +	    new_state == IEEE80211_STA_ASSOC) {
> +		return mt7921_sta_add(hw, vif, sta);
> +	} else if (old_state == IEEE80211_STA_ASSOC &&
> +		   new_state == IEEE80211_STA_AUTH) {
> +		return mt7921_sta_remove(hw, vif, sta);
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  mt7921_get_stats(struct ieee80211_hw *hw,
>  		 struct ieee80211_low_level_stats *stats)
> @@ -1191,8 +1216,7 @@ const struct ieee80211_ops mt7921_ops = {
>  	.conf_tx = mt7921_conf_tx,
>  	.configure_filter = mt7921_configure_filter,
>  	.bss_info_changed = mt7921_bss_info_changed,
> -	.sta_add = mt7921_sta_add,
> -	.sta_remove = mt7921_sta_remove,
> +	.sta_state = mt7921_sta_state,
>  	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
>  	.set_key = mt7921_set_key,
>  	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
Unfortunately, we can't switch from sta_add/remove to .sta_state here.
When .sta_state is implemented, mac80211 assumes that the station entry
is usable after the NOTEXIST->NONE transition, while the driver state is
only created after the AUTH->ASSOC transition.

Can you please send a fix, or a replacement patch?

Thanks,

- Felix
