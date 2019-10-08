Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A5CFBE6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJHOGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 10:06:00 -0400
Received: from muru.com ([72.249.23.125]:35914 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHOGA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 10:06:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A0CE78081;
        Tue,  8 Oct 2019 14:06:32 +0000 (UTC)
Date:   Tue, 8 Oct 2019 07:05:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Message-ID: <20191008140556.GZ5610@atomide.com>
References: <20191007172800.64249-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007172800.64249-1-tony@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191007 17:29]:
> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), and test
> for it in wlcore_runtime_resume(). But WL1271_FLAG_IRQ_RUNNING currently
> gets cleared too early by wlcore_irq_locked() before wlcore_irq() is done
> calling it. And this will race against wlcore_runtime_resume() testing it.
> 
> Let's set and clear IRQ_RUNNING in wlcore_irq() so wlcore_runtime_resume()
> can rely on it. And let's remove old comments about hardirq, that's no
> longer the case as we're using request_threaded_irq().
> 
> This fixes occasional annoying wlcore firmware reboots stat start with
> "wlcore: WARNING ELP wakeup timeout!" followed by a multisecond latency
> when the wlcore firmware gets wrongly rebooted waiting for an ELP wake
> interrupt that won't be coming.
> 
> Note that I also suspect some form of this issue was the root cause why
> the wlcore GPIO interrupt has been often configured as a level interrupt
> instead of edge as an attempt to work around the ELP wake timeout errors.

So this fixed a reproducable test case where loading some webpages
often produced ELP timeout errors. But looks like I'm still seeing ELP
timeouts elsewhere. So best to wait on this one. Something is still
wrong with the ELP timeout handling.

Regards,

Tony

> Fixes: fa2648a34e73 ("wlcore: Add support for runtime PM")
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Eyal Reizer <eyalr@ti.com>
> Cc: Guy Mishol <guym@ti.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Add locking around clear_bit like we do elsewhere in the driver
> 
>  drivers/net/wireless/ti/wlcore/main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -544,11 +544,6 @@ static int wlcore_irq_locked(struct wl1271 *wl)
>  	}
>  
>  	while (!done && loopcount--) {
> -		/*
> -		 * In order to avoid a race with the hardirq, clear the flag
> -		 * before acknowledging the chip.
> -		 */
> -		clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
>  		smp_mb__after_atomic();
>  
>  		ret = wlcore_fw_status(wl, wl->fw_status);
> @@ -668,7 +663,7 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
>  		disable_irq_nosync(wl->irq);
>  		pm_wakeup_event(wl->dev, 0);
>  		spin_unlock_irqrestore(&wl->wl_lock, flags);
> -		return IRQ_HANDLED;
> +		goto out_handled;
>  	}
>  	spin_unlock_irqrestore(&wl->wl_lock, flags);
>  
> @@ -692,6 +687,11 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
>  
>  	mutex_unlock(&wl->mutex);
>  
> +out_handled:
> +	spin_lock_irqsave(&wl->wl_lock, flags);
> +	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
> +	spin_unlock_irqrestore(&wl->wl_lock, flags);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.23.0
