Return-Path: <linux-wireless+bounces-9318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB99910E56
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 19:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F8BB23356
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FF1B3757;
	Thu, 20 Jun 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLpIgkFR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE61ABCB1;
	Thu, 20 Jun 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903999; cv=none; b=rbDTusabzMXBQeN4L5d2S1JRzgysI6rygMvTL14DZmYW3ipl+xZKTNNynE2CCkfdWSGKHuVSr1QpjNDngYT6FVe/LeqIWBiGJd+UKLpNc6pCI+9EIZelLyXN6gqmBpvh7UX81tX1Sp9BfnnvtG2k32jArzpnhb2rlWed3aarTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903999; c=relaxed/simple;
	bh=0EITIsqCJubudjU1im913x1NvRsb6Pperj0ae9Q9IyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU+C58x+YPJGUxj9m21n8Ly31xp6f1ha+2NnPSALrBoJh3aXVXJsiilF61c1Ew+9+weuF/hYeO/YAtpCKTH5GGcazPq7zu+nN5rNyXCEXV9Jst76qpew87SF+G8Sj9CqgjTvOa2WlyCghvEoRcb8kGvOViww33Gi1pr7KuWWeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLpIgkFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0176DC2BD10;
	Thu, 20 Jun 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903998;
	bh=0EITIsqCJubudjU1im913x1NvRsb6Pperj0ae9Q9IyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLpIgkFReZvp3j40kOfUVwQGHXaTIeS3AMOoheI7XTX6TumouC+XX3vNgNYwFVfne
	 WkTAj/VyMueaQdhIPiL4/dCMZC9eoQ/AmzZzTegVtVuWETd/+YLWEz4+TD2Fjm5Gu5
	 pE8cTc+y2rjjNXVBpDYb1+L2Y+87x/6ezY+XiNcbxi8oPyypU4HYs5+9nerwx0yGHn
	 1AMgu0Mi47mD5o1DIDOuilphEj+WMRSGmJA6OxZu+YpSCDJOpfhg3HoBP4/YB2kzWX
	 V7aMDINbybSuZWpRRuu3sTSfAixoB28YYAf+LYn3oicANIdmQBzkSu+wlEzbCWgHXE
	 8aU4Qo/1wduqw==
Date: Thu, 20 Jun 2024 18:19:50 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, kees@kernel.org,
	Bo Jiao <Bo.Jiao@mediatek.com>, Alexander Couzens <lynxis@fe80.eu>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>, Ingo Rohloff <lundril@gmx.de>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v2] wifi: mt76: un-embedd netdev from mt76_dev
Message-ID: <20240620171950.GO959333@kernel.org>
References: <20240619105311.3144908-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619105311.3144908-1-leitao@debian.org>

On Wed, Jun 19, 2024 at 03:52:36AM -0700, Breno Leitao wrote:
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
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> 
> Changelog:
>  * v2:
> 	- Renamed mt76_from_netdev() to mt76_priv(), and returns a
> 	  void pointer instead of struct mt76_dev, avoiding the cast
> 	  later, as suggested by Simon Horman.

Thanks for the update, it looks good to me.

