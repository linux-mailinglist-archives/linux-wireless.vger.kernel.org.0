Return-Path: <linux-wireless+bounces-9023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C1909C98
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592721C209F5
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402349635;
	Sun, 16 Jun 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKITIvAf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698233C0;
	Sun, 16 Jun 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526938; cv=none; b=j8dT1qHBD2GNMd/gDe3emHP/i2y+psqVr2Qere0bvmgDgA+n1cje3ipOWFe0R4iMl+HmjtYKU5QlkNyoWa9IrOO0len/886amxg4rSiEcUBkE+Y4mK1PlPG1eUBHoOFKhT/9DWwz8e5yLNnvf3c4Myzh0Vhi11QUBVTRPgnVs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526938; c=relaxed/simple;
	bh=gMHw0zgKhT2FIrKEWVvNVX2awLi4Bqd58VLtETxGG0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DId5aX/M/ePWsBDRK3tQioycrPbJLW5kqCNW+oMiLX3B5xrbbDK6qfsUsFgi3/cxtOxwmeJiKWbT4iqUHE7AzlBEja58xeRR1qQGA4szS5IdzbrXy9MmiYZ2K4Rzccs4ycIz2TMlnRnBevmv/bYPoLkoH/e0zQegvnSOaAp7qUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKITIvAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53123C2BBFC;
	Sun, 16 Jun 2024 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526937;
	bh=gMHw0zgKhT2FIrKEWVvNVX2awLi4Bqd58VLtETxGG0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKITIvAfZUzTfAk4VH+3dgKt1FYvHBwTTDgWvZjE9b4QyI4fiF3jwQe3H1Gm5wTuQ
	 wP5EF/gxM+BNzy7Nm/FSZEHtQKlvHJhya2+2vUU95C+bMWunrs9RCLPRS6rztYwjtB
	 FAK7IPVBszykFDvXKjJoMv6unq66JO9et4sXrnrts8I9FZgB8BNQCsf5/BldVITew4
	 Ci01x0bm3SH3g8ESfXOWgd/1wf2LYuR8Jvs/XMB2FCGsCEj/BTDKtxnG1eODq28tM9
	 p4GpUn/huIZIoi4Ep+yzqvxjQkIeppSf0YbLZmEca4RwFz4ntP49lpadQVN/40Uywe
	 SZCRyHmKxjmDg==
Date: Sun, 16 Jun 2024 09:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, kees@kernel.org, kuba@kernel.org,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Alexander Couzens <lynxis@fe80.eu>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>, Ingo Rohloff <lundril@gmx.de>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: un-embedd netdev from mt76_dev
Message-ID: <20240616083529.GH8447@kernel.org>
References: <20240614115317.657700-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614115317.657700-1-leitao@debian.org>

On Fri, Jun 14, 2024 at 04:52:42AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_devices from struct mt76_dev by converting them
> into pointers, and allocating them dynamically. Use the leverage
> alloc_netdev_dummy() to allocate the net_device object at
> mt76_dma_init().
> 
> The free of the device occurs at mt76_dma_cleanup().
> 
> Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> 
> PS: Due to the lack of hardware, this patch was not tested on a real
> hardware, unfortunately.
> 
> PS2: this is the last driver that is still using embedded netdevices.

...

> diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
> index 1de5a2b20f74..6454a5eca13e 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.h
> +++ b/drivers/net/wireless/mediatek/mt76/dma.h
> @@ -116,4 +116,9 @@ mt76_dma_should_drop_buf(bool *drop, u32 ctrl, u32 buf1, u32 info)
>  	}
>  }
>  
> +static inline struct mt76_dev *mt76_from_netdev(struct net_device *dev)
> +{
> +	return *(struct mt76_dev **)netdev_priv(dev);
> +}
> +
>  #endif

Hi Breno,

I agree that the above is correct, but I wonder if somehow it
is nicer to avoid explicit casts and instead take advantage of
implicit casting too and from void *.

Maybe something like this:

static inline struct mt76_dev *mt76_from_netdev(struct net_device *dev)
{
        struct mt76_dev **priv;

        priv = netdev_priv(dev);

        return *priv;
}

Further, some of the callers of mt76_from_netdev() cast the return value to
(struct mt7615_dev *). Which seems a bit awkward seeing as it was very
recently a void * (i.e. netdev_priv() returns void *).

I wonder if something like this makes sense, which I believe would avoid
the need for any callers to cast.

static inline void *mt76_priv(struct net_device *dev)
{
        struct mt76_dev **priv;

        priv = netdev_priv(dev);

        return *priv;
}

Ideas above compile tested only.

Other than the above, which is clearly more about style than substance,
this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


