Return-Path: <linux-wireless+bounces-9017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F2909715
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA82CB2128D
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4361BDD3;
	Sat, 15 Jun 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUHdpuUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E618EB8;
	Sat, 15 Jun 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441499; cv=none; b=qaEKi6V9sgppfpoO+u5+rAMrjU0VeGezHDBHMC1RNCnLN8XYDcaCKi0g0x0+1P+oqsCJrEaoUqLxufHlPsjm+McSQ44jBZRvwvERiVLZWDT8zGWzUByIWvMGqIpoS3Sbik0oUa22FKO1G6Y2GLwI0x7wOgHO1qdhLQ4px/YsGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441499; c=relaxed/simple;
	bh=HYiqFF+X1hj20xOiB2JhIQkGc5pdm6XVantm2REZnCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB0xzJfDYrG84SjFOO6o4+J0RPccCeiYUBezQ67YdQuDst/IdrF/Hc58rKtRYGsuM6pMKSKfAhexLvORXeecup/j1Xwlx3AbVt5D6a8NlF2dEObWnMvEdCpzJvmN6s6e3URAZioTnmoIadk2j6F3jMIYo5PoW3tEqBqdHCudg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUHdpuUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22816C116B1;
	Sat, 15 Jun 2024 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718441499;
	bh=HYiqFF+X1hj20xOiB2JhIQkGc5pdm6XVantm2REZnCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUHdpuUStcII3fnnhUSWfO5aDsz8l0wO0e4gjJa4FGd1lfClNKSIPNemAjl8QUqbF
	 KtZ9qBOoci4D5QO/yN4yFtviwWs028zh7uck1q1FUgmmaA94H4TFxG/e5KZy3jmL1+
	 P8nNuxhjUq/I0S7kDFE3EZnJgdAnKBwz4S6c9RLKie7xeuOpAORlxJl03nSBt+f/jN
	 JOE5op4pEZM+bgeuBLNm2K/jTsPKinLpdPBLJmiqafnuzmgl8k2VNnMR1QXTP9rwnc
	 8TWoL4ty1mWY1O1sDCZHC5UqZTLDyo/xDodqiFyP2axAuavNJ7MijmRBTUdrqLigOz
	 vvMRobF6RDP5A==
Date: Sat, 15 Jun 2024 09:51:33 +0100
From: Simon Horman <horms@kernel.org>
To: michael.nemanov@ti.com
Cc: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] wifi: cc33xx: Add init.c, init.h
Message-ID: <20240615085133.GA234885@kernel.org>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
 <20240609182102.2950457-12-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609182102.2950457-12-michael.nemanov@ti.com>

On Sun, Jun 09, 2024 at 09:20:56PM +0300, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <Michael.Nemanov@ti.com>
> 
> High-level init code for new vifs
> ---
>  drivers/net/wireless/ti/cc33xx/init.c | 236 ++++++++++++++++++++++++++
>  drivers/net/wireless/ti/cc33xx/init.h |  15 ++
>  2 files changed, 251 insertions(+)
>  create mode 100644 drivers/net/wireless/ti/cc33xx/init.c
>  create mode 100644 drivers/net/wireless/ti/cc33xx/init.h
> 
> diff --git a/drivers/net/wireless/ti/cc33xx/init.c b/drivers/net/wireless/ti/cc33xx/init.c

...

> +int cc33xx_init_vif_specific(struct cc33xx *cc, struct ieee80211_vif *vif)
> +{
> +	struct cc33xx_vif *wlvif = cc33xx_vif_to_data(vif);
> +	struct conf_tx_ac_category *conf_ac;
> +	struct conf_tx_ac_category ac_conf[4];
> +	struct conf_tx_tid tid_conf[8];
> +	struct conf_tx_settings *tx_settings = &cc->conf.host_conf.tx;
> +	struct conf_tx_ac_category *p_wl_host_ac_conf = &tx_settings->ac_conf0;
> +	struct conf_tx_tid *p_wl_host_tid_conf = &tx_settings->tid_conf0;
> +	bool is_ap = (wlvif->bss_type == BSS_TYPE_AP_BSS);
> +	u8 ps_scheme = cc->conf.mac.ps_scheme;
> +	int ret, i;

...

> +	/* Default TID/AC configuration */
> +	WARN_ON(tx_settings->tid_conf_count != tx_settings->ac_conf_count);
> +	memcpy(ac_conf, p_wl_host_ac_conf, 4 * sizeof(struct conf_tx_ac_category));
> +	memcpy(tid_conf, p_wl_host_tid_conf, 8 * sizeof(struct conf_tx_tid));

Hi Michael,

allmodconfig builds on x86_64 with gcc-13 flag the following:

In file included from ./include/linux/string.h:374,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:13,
                 from ./arch/x86/include/asm/paravirt.h:21,
                 from ./arch/x86/include/asm/irqflags.h:60,
                 from ./include/linux/irqflags.h:18,
                 from ./include/linux/spinlock.h:59,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/firmware.h:8,
                 from drivers/net/wireless/ti/cc33xx/init.c:6:
In function 'fortify_memcpy_chk',
    inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:156:2:
./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'fortify_memcpy_chk',
    inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:157:2:
./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/net/wireless/ti/cc33xx/rx.o

I believe that this is because the destination for each of the two memcpy()
calls immediately above is too narrow - 1 structure wide instead of 4 or 8.

I think this can be resolved by either using:
1. struct_group in .../cc33xx/conf.h:struct conf_tx_settings
   to wrap ac_conf0 ... ac_conf3, and separately tid_conf0 ... tid_conf7.
2. Using arrays for ac_conf and tid_conf in
   .../cc33xx/conf.h:struct conf_tx_settings, in which case perhaps
   .../wlcore/conf.h:struct conf_tx_settings can be reused somehow
   (I did not check closely)?


Similar errors are flagged elsewhere in this series.
Please take a look at allmodconfig builds and make sure
no warnings are introduced.

Lastly, more related to the series as a whole than this patch in
particular, please consider running checkpatch.pl --codespell

Thanks!

...

