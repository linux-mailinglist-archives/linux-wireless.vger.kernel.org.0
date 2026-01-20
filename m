Return-Path: <linux-wireless+bounces-31005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CDD3C033
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1D508319
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986336B075;
	Tue, 20 Jan 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UFTVyrb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A02F99AD;
	Tue, 20 Jan 2026 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892688; cv=none; b=ZxPiZRZ9ZwJp+kG8/74aQY8FBCxfla1IIlSsylaEDCe98tMO7GPrn+RF9ZUgEN35Fd1k7T3y0TI2O+Ku5Jx1yC0gskluhYglcf0VcU4cNIBHBq/gtZ/OPwJnRw90HJx2/qjbMewvAJO1ZNbfAdjt2VXczhyA62liv0eao+n2ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892688; c=relaxed/simple;
	bh=hga3ue21UWAE2W0mgxOLtL/aZcuRm+XpQziyEdU1Vj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyZobmvlMepxgvsqlzYgA4BlyIOtN+Ryli75fQI8LOJ5YCE8hZYZInFfmr/heZ6CbacGz74k+L1/1hPD7INumEl+UXNNRfoIx+k5FTnljcVXzscu9CBn56hA0tKHQEoDAgLGnnPPeJAM6xtZFQlWVphCM1XBjDQlMzWV4OUGdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UFTVyrb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9497AC16AAE;
	Tue, 20 Jan 2026 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768892685;
	bh=hga3ue21UWAE2W0mgxOLtL/aZcuRm+XpQziyEdU1Vj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFTVyrb1xZIs2ufmuCCwRtf8OB8cRTfjy1Uxdju53XAZ+iTO4curPLJZKihuep/f0
	 FeljExq3kaoHiP0+Di24J92psqJ6EvSvgFWh+fSfsQCoKjYNltRX5LYUFCOjyLCRBI
	 NxUxCn5f25fhBY75qQjerpVu1WlfBSr34BFS6OXM=
Date: Tue, 20 Jan 2026 08:04:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zac <zac@zacbowling.com>
Cc: sean.wang@kernel.org, deren.wu@mediatek.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name,
	ryder.lee@mediatek.com, sean.wang@mediatek.com,
	stable@vger.kernel.org, linux@frame.work, zbowling@gmail.com
Subject: Re: [PATCH 02/11] wifi: mt76: mt792x: fix NULL pointer and firmware
 reload issues
Message-ID: <2026012028-barmaid-ouch-e53b@gregkh>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
 <20260120062854.126501-3-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120062854.126501-3-zac@zacbowling.com>

On Mon, Jan 19, 2026 at 10:28:45PM -0800, Zac wrote:
> From: Zac Bowling <zac@zacbowling.com>
> 
> This patch combines two fixes for the shared mt792x code used by both
> MT7921 and MT7925 drivers:
> 
> 1. Fix NULL pointer dereference in TX path:
> 
> Add NULL pointer checks in mt792x_tx() to prevent kernel crashes when
> transmitting packets during MLO link removal.
> 
> The function calls mt792x_sta_to_link() which can return NULL if the
> link is being removed, but the return value was dereferenced without
> checking. Similarly, the RCU-protected link_conf and link_sta pointers
> were used without NULL validation.
> 
> This race can occur when:
> - A packet is queued for transmission
> - Concurrently, the link is being removed (mt7925_mac_link_sta_remove)
> - mt792x_sta_to_link() returns NULL for the removed link
> - Kernel crashes on wcid = &mlink->wcid dereference
> 
> Fix by checking mlink, conf, and link_sta before use, freeing the SKB
> and returning early if any pointer is NULL.
> 
> 2. Fix firmware reload failure after previous load crash:
> 
> If the firmware loading process crashes or is interrupted after
> acquiring the patch semaphore but before releasing it, subsequent
> firmware load attempts will fail with 'Failed to get patch semaphore'.
> 
> Apply the same fix from MT7915 (commit 79dd14f): release the patch
> semaphore before starting firmware load and restart MCU firmware to
> ensure clean state.
> 
> Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
> Fixes: 583204ae70f9 ("wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module")
> Link: https://github.com/openwrt/mt76/commit/79dd14f2e8161b656341b6653261779199aedbe4
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
>  .../net/wireless/mediatek/mt76/mt792x_core.c  | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> index f2ed16feb6c1..05598202b488 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -95,6 +95,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
>  				       IEEE80211_TX_CTRL_MLO_LINK);
>  		sta = (struct mt792x_sta *)control->sta->drv_priv;
>  		mlink = mt792x_sta_to_link(sta, link_id);
> +		if (!mlink)
> +			goto free_skb;
>  		wcid = &mlink->wcid;
>  	}
>  
> @@ -113,9 +115,12 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
>  		link_id = wcid->link_id;
>  		rcu_read_lock();
>  		conf = rcu_dereference(vif->link_conf[link_id]);
> -		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
> -
>  		link_sta = rcu_dereference(control->sta->link[link_id]);
> +		if (!conf || !link_sta) {
> +			rcu_read_unlock();
> +			goto free_skb;
> +		}
> +		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
>  		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
>  
>  		if (vif->type == NL80211_IFTYPE_STATION)
> @@ -136,6 +141,10 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
>  	}
>  
>  	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
> +	return;
> +
> +free_skb:
> +	ieee80211_free_txskb(hw, skb);
>  }
>  EXPORT_SYMBOL_GPL(mt792x_tx);
>  
> @@ -927,6 +936,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
>  {
>  	int ret;
>  
> +	/* Release semaphore if taken by previous failed load attempt.
> +	 * This prevents "Failed to get patch semaphore" errors when
> +	 * recovering from firmware crashes or suspend/resume failures.
> +	 */
> +	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
> +	if (ret < 0)
> +		dev_dbg(dev->mt76.dev, "Semaphore release returned %d (may be expected)\n", ret);
> +
> +	/* Always restart MCU to ensure clean state before loading firmware */
> +	mt76_connac_mcu_restart(&dev->mt76);
> +
> +	/* Wait for MCU to be ready after restart */
> +	msleep(100);
> +
>  	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
>  	if (ret)
>  		return ret;
> -- 
> 2.52.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

