Return-Path: <linux-wireless+bounces-29462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEAC9D185
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 22:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B96E9347D31
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFD298CC4;
	Tue,  2 Dec 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZpOAkdr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EA218827;
	Tue,  2 Dec 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711101; cv=none; b=D+CMv4VLcwnnbiKLk82FGeWAr/XwpAPlnvnMish+qGXIuQevj+cWlLJ0V+Ksa+PU6t6iJBsElP3S+eHg+aWzCAltbNaaXkdrDRhadQ9rDbba1uZveBCeLe1B6C2cbSnXoiqMePKpwjD2wYyRMVgo+iGKj6lQ82M3cMnPHGNwiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711101; c=relaxed/simple;
	bh=LIsUpX46nz8hXTPl3ASkyok9wqGryCPo8iyJRm2nQFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA3AGohg11jlhBjRbqeZJOuSZu1ILiSc75voGFsF+2Aciqo5u4WEZwDYKLXdL3YaLLWcklvOoNTJMMpBl5JYWPLkyPNjWxNfWc15kMIHXbMdBhFJ7+Rym6LTQiWSYCsuO4s3mgdw6a5/W6d9lMUv8WR4f2hGitlQPwzpHqO/3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZpOAkdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88AAC4CEF1;
	Tue,  2 Dec 2025 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764711101;
	bh=LIsUpX46nz8hXTPl3ASkyok9wqGryCPo8iyJRm2nQFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZpOAkdrwJACnUdpSzBSxrBly0k1US5uT5Ymfi9n9+1mFsYFyzlLYBsIsi9UpS1mN
	 fGIzYhpWlYKpBnwleO7L8b7Z0UvRdyuFsmX7ELNxfFGU7eL9RLi4+fEeTAIxaGlzDF
	 SHNLcW47XrKMVLhSWJ+bNXakkZSeLRENfdA5NJijFV95B/n1n5c2FRByp4wRQO7yrV
	 KW8Yf9cdElo4G89A2o3mQdHTiZusBL0Zp009LTvd1fa+4NnTbe0kVAN4/But40i6nN
	 OiQF8BJKJ0giZObUop6+rMJMXMmMmiBGbGwfhnhFmtm+UKjUvqeXvM96F11YGIv0VB
	 mXUpj1nq9//hQ==
Date: Tue, 2 Dec 2025 15:37:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, netdev@vger.kernel.org, 
	mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
Subject: Re: [PATCH 3/4] net: mhi_net: Implement runtime PM support
Message-ID: <nj4ovttt4i7hsqfdv5zhdotxrx3upxfq4ozuligwuheubnsmkd@e6bwzgkn55kl>
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
 <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>

On Mon, Dec 01, 2025 at 06:13:19PM +0530, Krishna Chaitanya Chundru wrote:
> Add runtime power management support to the mhi_net driver to align with
> the updated MHI framework, which expects runtime PM to be enabled by client
> drivers. This ensures the controller remains active during data transfers
> and can autosuspend when idle.

This last sentence hints at there being an actual problem with the
current code. Perhaps we do this because it's the right thing to do,
perhaps we're making this change because devices are crashing and
burning?

Start your commit message with making the reason for your change clear.

Ask yourself https://en.wikipedia.org/wiki/Five_whys when you come up
with your problem description.

> 
> The driver now uses pm_runtime_get() and pm_runtime_put() around
> transmit, receive, and buffer refill operations. Runtime PM is initialized
> during probe with autosuspend enabled and a 100ms delay. The device is
> marked with pm_runtime_no_callbacks() to notify PM framework that there
> are no callbacks for this driver.

This looks like an AI prompt, does it add value to the commit message?

It can mostly be summarized as "Implement pm_runtime in the driver". The
only part that's not obvious is the 100ms autosuspend delay, but you
skipped explaining why you did choose this number.

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/net/mhi_net.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8e449b5a427993abf68e8d032fae2..c5c697f29e69e9bc874b6cfff4699de12a4af114 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -9,6 +9,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/skbuff.h>
>  #include <linux/u64_stats_sync.h>
>  
> @@ -76,6 +77,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct mhi_device *mdev = mhi_netdev->mdev;
>  	int err;
>  
> +	pm_runtime_get(&mdev->dev);

What happened to your error handling?

Regards,
Bjorn

>  	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
>  	if (unlikely(err)) {
>  		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
> @@ -94,6 +96,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	u64_stats_inc(&mhi_netdev->stats.tx_dropped);
>  	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>  
> +	pm_runtime_put_autosuspend(&mdev->dev);
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -261,6 +264,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
>  	}
>  	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>  
> +	pm_runtime_put_autosuspend(&mdev->dev);
>  	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
>  		netif_wake_queue(ndev);
>  }
> @@ -277,6 +281,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>  
>  	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
>  
> +	pm_runtime_get_sync(&mdev->dev);
>  	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>  		skb = netdev_alloc_skb(ndev, size);
>  		if (unlikely(!skb))
> @@ -296,6 +301,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>  		cond_resched();
>  	}
>  
> +	pm_runtime_put_autosuspend(&mdev->dev);
>  	/* If we're still starved of rx buffers, reschedule later */
>  	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
>  		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
> @@ -362,12 +368,19 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>  
>  	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>  
> +	pm_runtime_no_callbacks(&mhi_dev->dev);
> +	devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
> +	pm_runtime_set_autosuspend_delay(&mhi_dev->dev, 100);
> +	pm_runtime_use_autosuspend(&mhi_dev->dev);
> +	pm_runtime_get(&mhi_dev->dev);
>  	err = mhi_net_newlink(mhi_dev, ndev);
>  	if (err) {
>  		free_netdev(ndev);
> +		pm_runtime_put_autosuspend(&mhi_dev->dev);
>  		return err;
>  	}
>  
> +	pm_runtime_put_autosuspend(&mhi_dev->dev);
>  	return 0;
>  }
>  
> 
> -- 
> 2.34.1
> 
> 

