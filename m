Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAAE20ABF2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFZFvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 01:51:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24373 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgFZFvq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 01:51:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593150706; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=I+oDje7IH8rGHPsr6BSuIr/mZUO7T7yxK98ZU0LaSJg=; b=iXUx+2I2MOhtEXpairVg3aD0p6umQFFUGolfMn2OEsmt/EI2bXrmMbj4trx9DAhny/nohu/T
 MDCr+Hm5H4kSlFygtvlsU6PgKIqe4z3q/7/gl8FKxpENnDE1unpmlpgF4GE1G1xpvcQA+nUF
 +fpL+Dl++TXPoch1oY5Zr8jPPPE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ef58cf0356bcc26ab096ae4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 05:51:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1FF81C433C8; Fri, 26 Jun 2020 05:51:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6DDAC433C6;
        Fri, 26 Jun 2020 05:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6DDAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
Date:   Fri, 26 Jun 2020 08:51:37 +0300
In-Reply-To: <20200625123712.14156-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Thu, 25 Jun 2020 12:37:23 +0000")
Message-ID: <87a70qe5na.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> WILC1000 is an IEEE 802.11 b/g/n IoT link controller module. The
> WILC1000 connects to Microchip AVR/SMART MCUs, SMART MPUs, and other
> processors with minimal resource requirements with a simple
> SPI/SDIO-to-Wi-Fi interface.
>
> WILC1000 driver has been part of staging for few years. With
> contributions from the community, it has improved significantly. Full
> driver review has helped in achieving the current state.
> The details for those reviews are captured in 1 & 2.
>
> [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

[...]

> --- a/drivers/net/wireless/Kconfig
> +++ b/drivers/net/wireless/Kconfig
> @@ -47,6 +47,7 @@ source "drivers/net/wireless/st/Kconfig"
>  source "drivers/net/wireless/ti/Kconfig"
>  source "drivers/net/wireless/zydas/Kconfig"
>  source "drivers/net/wireless/quantenna/Kconfig"
> +source "drivers/net/wireless/microchip/Kconfig"

This should be in alphabetical order.

> --- a/drivers/net/wireless/Makefile
> +++ b/drivers/net/wireless/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_WLAN_VENDOR_ST) += st/
>  obj-$(CONFIG_WLAN_VENDOR_TI) += ti/
>  obj-$(CONFIG_WLAN_VENDOR_ZYDAS) += zydas/
>  obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
> +obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/

And this as well.

I fixed these in the topic branch, please double check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=wilc1000-move-out-of-staging&id=5625f965d7644b4dc6a71d74021cfe093ad34eea

I have not pulled that branch yet into master so we can make changes
still.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
