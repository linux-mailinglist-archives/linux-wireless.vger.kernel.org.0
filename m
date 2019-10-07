Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C039ECE82B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGPrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 11:47:07 -0400
Received: from muru.com ([72.249.23.125]:35600 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGPrG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C68380A5;
        Mon,  7 Oct 2019 15:47:39 +0000 (UTC)
Date:   Mon, 7 Oct 2019 08:47:03 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Message-ID: <20191007154703.GP5610@atomide.com>
References: <20191007153731.58045-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007153731.58045-1-tony@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191007 08:38]:
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -692,6 +687,9 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
>  
>  	mutex_unlock(&wl->mutex);
>  
> +out_handled:
> +	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
> +
>  	return IRQ_HANDLED;
>  }

Sorry looks like I again sent out the patch too fast. The clear_bit()
here should have spin_lock_irqsave() and spin_unlock_irqrestore()
around it like we do elsewhere in the code currently.

Regards,

Tony
