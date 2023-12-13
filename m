Return-Path: <linux-wireless+bounces-695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A180EE11
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ACD281790
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BD6F602;
	Tue, 12 Dec 2023 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1bcz+Ll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F76DD02;
	Tue, 12 Dec 2023 13:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1063C433C7;
	Tue, 12 Dec 2023 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702388919;
	bh=vMWkOLosreYFfJ9xVON5sXNCA2fynG36OvDNxFrE51s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1bcz+LlvgB6SRxGT6ZdgATiv1KLf3q9mLiOckLOH//Bt/WfHe+7KJ4pbFikHCrFd
	 qinaFVog666Obq0FK2VsYMwyGYl78WaUh9i5/l3r1GPgscTC2S+QgVEDEk45EOEOb7
	 l+JB3Lc3Pke9d+OyFaOvCmY34jxCo/DG2g76bTPjQW0SRGR6BCKhbMLmFvTSCMmU0d
	 fQUool7HZlBQtY2ymybxrXQtnzo4alFNJsup3EQhmQBQ1MyjAU6w3ZDvAgWqDQynrX
	 fqcIm0zsaTs7nbljdzhOr2nUNP/jaTsp25PQ1td9yIfjPwBY/vMyUnkzvfaGwD/Mxm
	 cKHo+xDe9ZFRA==
Date: Tue, 12 Dec 2023 13:48:31 +0000
From: Lee Jones <lee@kernel.org>
To: Zheng Wang <zyytlz.wz@163.com>
Cc: aspriel@gmail.com, franky.lin@broadcom.com, hante.meuleman@broadcom.com,
	kvalo@kernel.org, johannes.berg@intel.com, marcan@marcan.st,
	linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
	linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	arend.vanspriel@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
	linux-kernel@vger.kernel.org, security@kernel.org,
	stable@vger.kernel.org, hackerzheng666@gmail.com
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in
  brcmf_cfg80211_detach
Message-ID: <20231212134831.GA564365@google.com>
References: <20231106141704.866455-1-zyytlz.wz@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106141704.866455-1-zyytlz.wz@163.com>

On Mon, 06 Nov 2023, Zheng Wang wrote:

> This is the candidate patch of CVE-2023-47233 :
> https://nvd.nist.gov/vuln/detail/CVE-2023-47233
> 
> In brcm80211 driver,it starts with the following invoking chain
> to start init a timeout worker:
> 
> ->brcmf_usb_probe
>   ->brcmf_usb_probe_cb
>     ->brcmf_attach
>       ->brcmf_bus_started
>         ->brcmf_cfg80211_attach
>           ->wl_init_priv
>             ->brcmf_init_escan
>               ->INIT_WORK(&cfg->escan_timeout_work,
> 		  brcmf_cfg80211_escan_timeout_worker);
> 
> If we disconnect the USB by hotplug, it will call
> brcmf_usb_disconnect to make cleanup. The invoking chain is :
> 
> brcmf_usb_disconnect
>   ->brcmf_usb_disconnect_cb
>     ->brcmf_detach
>       ->brcmf_cfg80211_detach
>         ->kfree(cfg);
> 
> While the timeout woker may still be running. This will cause
> a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
> 
> Fix it by deleting the timer and canceling the worker in
> brcmf_cfg80211_detach.
> 
> Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Cc: stable@vger.kernel.org
> ---
> v5:
> - replace del_timer_sync with timer_shutdown_sync suggested by
> Arend and Takashi
> v4:
> - rename the subject and add CVE number as Ping-Ke Shih suggested
> v3:
> - rename the subject as Johannes suggested
> v2:
> - fix the error of kernel test bot reported
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 667462369a32..a8723a61c9e4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -8431,6 +8431,8 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
>  	if (!cfg)
>  		return;
>  
> +	timer_shutdown_sync(&cfg->escan_timeout);
> +	cancel_work_sync(&cfg->escan_timeout_work);
>  	brcmf_pno_detach(cfg);
>  	brcmf_btcoex_detach(cfg);
>  	wiphy_unregister(cfg->wiphy);

Has there been any progress on this please?

Are we expecting a v6 to this?

-- 
Lee Jones [李琼斯]

