Return-Path: <linux-wireless+bounces-28308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E10C0D6CB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055023AA1FC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3852F7AD6;
	Mon, 27 Oct 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="cjNBp01g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRwdVSof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE900136E37;
	Mon, 27 Oct 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566773; cv=none; b=oj2/VgaJZgOMVg1GPGWIM7WSCjzTZ5RiHIl71UwyuPeBwIJsgS51MpRGsS1nzTpcK/Uk83CGHf6Xz+45qmytjl3A1+qhiGcWraBsPNOfZPGxWVOGa+GuTaldJ6jbQYGWvZq18TwgH4bByydbNHSHMM5/vBBfkXimYq6p0tR73aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566773; c=relaxed/simple;
	bh=xlvgYppU6vrWbDkOre9VGjPhmY41zEzjFJehkuY0Ya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBcci9J0EM9n48hUi3ypI5wTR2YAb3tK90O7cP4Zf2MP0G4GCmySgww+hh/C51AlO23Ik5zRTT5a+8AS1c22COUZ8Af+tbRzIJQqGG0EwhfDwfalz9WmVTr8TI3KCWVNFUv4CmXPiUZdDRZg91OEizoDKzlpSqgA8UjTuEb9Y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=cjNBp01g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRwdVSof; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id DA2B81380433;
	Mon, 27 Oct 2025 08:06:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 08:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761566768;
	 x=1761573968; bh=obydwKRf78xq6p+vbhUIwD78jMX6wxjnOG1pdFgCN10=; b=
	cjNBp01gixuCQodlMTPqWVqxTwnPRoNY/DB2R25etvVgxgR1/APK38Lw+AZ1Zndp
	DqCV9nYsiaeR8MbQTwIHK6I14UFNKI6k2xBzvEVRRn8L50eV7AhnE4HhJsfonXBz
	+o2t58cF7O7vnZWsSF787D8zmKjo6e1z0Q4c9luGeJtC++7mXlkQEnrQqQ6i+cXT
	eFiyEfT6UE6nMXmLMTkPzAwp6/kCzRD0bgUkfdGkOkc+tOtc00zpNajUSYC5YqNA
	VdrVgelODIV6QsQDj70kL2x/sG5lfH3fXz2cIuRZWzbTF2POiv+G0jFFlZx6LmLj
	BmSwk+2bEog8Ac9SBH9B+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761566768; x=
	1761573968; bh=obydwKRf78xq6p+vbhUIwD78jMX6wxjnOG1pdFgCN10=; b=i
	RwdVSofLwUMzMTqcIVwD/mF0uXOT/AO834mxca5Ti2J7H6DBwzQCSca06TRreXTo
	4xlZF+xK8Q4JtncDawNYybAlT7PndY5WVchPdwvezEK2WrfNmzC/s38XcvatRrwQ
	qHgTfYUrQVaNwYGoEKsrO9etxerxbYJQxLiZixxSmQSoxItP2BfNS5pnkYPFJWP5
	lXUzwWEFmYf7o5PZRXc1Iwv2S0bBwQQi488u/XqnWFZYPCp/5i+SD2PJFYAwfdt8
	Okgh7IbR1lJMFEE+JU5igtcCHBBx5sCY1yzyXADZUqNDk9HIDdREi+oFN7Mp0KF8
	4C8DJeBziatinymCdTOsQ==
X-ME-Sender: <xms:LmD_aGysJ_U_9H29oPZYjT1NybZPSL2ElDxgLRbCUM7W_DwciI6Sow>
    <xme:LmD_aP78Er8xJPMjiJttIsTm4eo-oGnRrRkT2Kfg-Wkreu73Yy3lTeT0Wats7uXub
    u9GG6tpnCSMobNqpXBn8UXXYJJMFkDQuXLujDF9a5nU77tYgMIFWT0>
X-ME-Received: <xmr:LmD_aN6xAEBpHuwSyVm7JJ2whkZwq_oO6tkOFkj-0haRaam9BI0SLHKocIXfa0tFSP7me4bj-w-jF8fat09mqfW2Hlo7ZWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgr
    shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrg
    htvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheet
    heekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhn
    rghtvggthhdrshgvpdhnsggprhgtphhtthhopeeggedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghomhdprhgtphht
    thhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhope
    grnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:LmD_aAJDnhPSOc7gPdVVw2jhRYyu-VX8gktGoXUSJAorWl7cqhcP3Q>
    <xmx:LmD_aHGjujAE5x9F7a6WKdoBc1THfcZwbU-4VfC_kubY6XtsvtD40g>
    <xmx:LmD_aF05Qto5ySZM3PAfaz_PjA9iCBoPDERvkxnW7aWEtMJ9PWGvjw>
    <xmx:LmD_aByJkKrdTdqyhoxWN8s3inA-YszNn9W7eQ4MMYgVvaW20EAa5A>
    <xmx:MGD_aDs_4bhiPgTqn0gze5FcQ9Os22-HmZQOY-qBzZHFiXeYQBKf_Fb_>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:06:06 -0400 (EDT)
Date: Mon, 27 Oct 2025 13:05:59 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,	Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,	Clark Wang <xiaoning.wang@nxp.com>,
 Paul Barker <paul@pbarker.dev>,	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Alex Elder <elder@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ingo Molnar <mingo@kernel.org>,	Thomas Gleixner <tglx@linutronix.de>,
	Michael Nemanov <michael.nemanov@ti.com>,	Kalle Valo <kvalo@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,	imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org,	linux-omap@vger.kernel.org,
 linux-wireless@vger.kernel.org,	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] net: ethernet: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20251027120559.GA365372@ragnatech.se>
References: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027115022.390997-1-sakari.ailus@linux.intel.com>

Hi Sakari,

Thanks for your work cleaning this up!

On 2025-10-27 13:50:19 +0200, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c  | 5 -----
>  drivers/net/ethernet/freescale/fec_main.c | 8 --------
>  drivers/net/ethernet/renesas/ravb_main.c  | 4 ----
>  drivers/net/ethernet/ti/davinci_mdio.c    | 7 -------
>  4 files changed, 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 39673f5c3337..847c4ab9df23 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -327,7 +327,6 @@ static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
>  	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
>  
>  mdio_read_exit:
> -	pm_runtime_mark_last_busy(&bp->pdev->dev);
>  	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  mdio_pm_exit:
>  	return status;
> @@ -373,7 +372,6 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int mii_id, int devad,
>  	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
>  
>  mdio_read_exit:
> -	pm_runtime_mark_last_busy(&bp->pdev->dev);
>  	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  mdio_pm_exit:
>  	return status;
> @@ -405,7 +403,6 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>  		goto mdio_write_exit;
>  
>  mdio_write_exit:
> -	pm_runtime_mark_last_busy(&bp->pdev->dev);
>  	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  mdio_pm_exit:
>  	return status;
> @@ -451,7 +448,6 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
>  		goto mdio_write_exit;
>  
>  mdio_write_exit:
> -	pm_runtime_mark_last_busy(&bp->pdev->dev);
>  	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  mdio_pm_exit:
>  	return status;
> @@ -5564,7 +5560,6 @@ static int macb_probe(struct platform_device *pdev)
>  		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
>  		    dev->base_addr, dev->irq, dev->dev_addr);
>  
> -	pm_runtime_mark_last_busy(&bp->pdev->dev);
>  	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1edcfaee6819..4875101c4f3f 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2231,7 +2231,6 @@ static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
>  	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
>  
>  out:
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
> @@ -2280,7 +2279,6 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
>  	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
>  
>  out:
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
> @@ -2312,7 +2310,6 @@ static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>  	if (ret)
>  		netdev_err(fep->netdev, "MDIO write timeout\n");
>  
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
> @@ -2356,7 +2353,6 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
>  		netdev_err(fep->netdev, "MDIO write timeout\n");
>  
>  out:
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
> @@ -2839,7 +2835,6 @@ static void fec_enet_get_regs(struct net_device *ndev,
>  		buf[off] = readl(&theregs[off]);
>  	}
>  
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  }
>  
> @@ -3616,7 +3611,6 @@ fec_enet_open(struct net_device *ndev)
>  err_enet_alloc:
>  	fec_enet_clk_enable(ndev, false);
>  clk_enable:
> -	pm_runtime_mark_last_busy(&fep->pdev->dev);
>  	pm_runtime_put_autosuspend(&fep->pdev->dev);
>  	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
>  	return ret;
> @@ -3647,7 +3641,6 @@ fec_enet_close(struct net_device *ndev)
>  		cpu_latency_qos_remove_request(&fep->pm_qos_req);
>  
>  	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
> -	pm_runtime_mark_last_busy(&fep->pdev->dev);
>  	pm_runtime_put_autosuspend(&fep->pdev->dev);
>  
>  	fec_enet_free_buffers(ndev);
> @@ -4616,7 +4609,6 @@ fec_probe(struct platform_device *pdev)
>  
>  	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
>  
> -	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index c3fc15f9ec85..21a45583e7e1 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1975,7 +1975,6 @@ static int ravb_open(struct net_device *ndev)
>  out_set_reset:
>  	ravb_set_opmode(ndev, CCC_OPC_RESET);
>  out_rpm_put:
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  out_napi_off:
>  	if (info->nc_queues)
> @@ -2404,7 +2403,6 @@ static int ravb_close(struct net_device *ndev)
>  	if (error)
>  		return error;
>  
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
> @@ -3116,7 +3114,6 @@ static int ravb_probe(struct platform_device *pdev)
>  	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
>  		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
>  
> -	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
> @@ -3301,7 +3298,6 @@ static int ravb_resume(struct device *dev)
>  
>  out_rpm_put:
>  	if (!priv->wol_enabled) {
> -		pm_runtime_mark_last_busy(dev);
>  		pm_runtime_put_autosuspend(dev);
>  	}

You could drop the { } here. With this fixed for RAVB,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 68507126be8e..9f049ebbf107 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -234,7 +234,6 @@ static int davinci_mdiobb_read_c22(struct mii_bus *bus, int phy, int reg)
>  
>  	ret = mdiobb_read_c22(bus, phy, reg);
>  
> -	pm_runtime_mark_last_busy(bus->parent);
>  	pm_runtime_put_autosuspend(bus->parent);
>  
>  	return ret;
> @@ -251,7 +250,6 @@ static int davinci_mdiobb_write_c22(struct mii_bus *bus, int phy, int reg,
>  
>  	ret = mdiobb_write_c22(bus, phy, reg, val);
>  
> -	pm_runtime_mark_last_busy(bus->parent);
>  	pm_runtime_put_autosuspend(bus->parent);
>  
>  	return ret;
> @@ -268,7 +266,6 @@ static int davinci_mdiobb_read_c45(struct mii_bus *bus, int phy, int devad,
>  
>  	ret = mdiobb_read_c45(bus, phy, devad, reg);
>  
> -	pm_runtime_mark_last_busy(bus->parent);
>  	pm_runtime_put_autosuspend(bus->parent);
>  
>  	return ret;
> @@ -285,7 +282,6 @@ static int davinci_mdiobb_write_c45(struct mii_bus *bus, int phy, int devad,
>  
>  	ret = mdiobb_write_c45(bus, phy, devad, reg, val);
>  
> -	pm_runtime_mark_last_busy(bus->parent);
>  	pm_runtime_put_autosuspend(bus->parent);
>  
>  	return ret;
> @@ -332,7 +328,6 @@ static int davinci_mdio_common_reset(struct davinci_mdio_data *data)
>  	data->bus->phy_mask = phy_mask;
>  
>  done:
> -	pm_runtime_mark_last_busy(data->dev);
>  	pm_runtime_put_autosuspend(data->dev);
>  
>  	return 0;
> @@ -441,7 +436,6 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
>  		break;
>  	}
>  
> -	pm_runtime_mark_last_busy(data->dev);
>  	pm_runtime_put_autosuspend(data->dev);
>  	return ret;
>  }
> @@ -478,7 +472,6 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
>  		break;
>  	}
>  
> -	pm_runtime_mark_last_busy(data->dev);
>  	pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
> -- 
> 2.47.3
> 

-- 
Kind Regards,
Niklas Söderlund

