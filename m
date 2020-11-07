Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD492AA668
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgKGPpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:45:55 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:26283 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKGPpz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:45:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604763955; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GQpQ+kIAOw0EPN1x4HcqCBk3Y+l49wmbwv6R4j76CKk=; b=lAAlTcAK8p8lkFkdhhi6sJpHh89dQF5OxKOYP3XNC8k0cpUh7gpVybaD3EsIeHUkgbgetEvA
 dOY90OZK0IgOYGL+z27wZ8MC6F80Msj4rBnkbM8xX3DPpUWib9FsA+i0bqahdJ9zJqs7/LhH
 Um7QEWirN+2b4KxPG79+paOpgAw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa6c13082aad55dcb4c4dfd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:45:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C24E5C433CB; Sat,  7 Nov 2020 15:45:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23D03C433C6;
        Sat,  7 Nov 2020 15:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23D03C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org (open list:SONICS SILICON BACKPLANE
        DRIVER (SSB)), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] Drivers: ssb: remove unnecessary CONFIG_PM_SLEEP
References: <20201029075430.228760-1-coiby.xu@gmail.com>
Date:   Sat, 07 Nov 2020 17:45:47 +0200
In-Reply-To: <20201029075430.228760-1-coiby.xu@gmail.com> (Coiby Xu's message
        of "Thu, 29 Oct 2020 15:54:30 +0800")
Message-ID: <87361l6uhg.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Coiby Xu <coiby.xu@gmail.com> writes:

> SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/ssb/pcihost_wrapper.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/ssb/pcihost_wrapper.c b/drivers/ssb/pcihost_wrapper.c
> index 410215c16920..6510f57469a0 100644
> --- a/drivers/ssb/pcihost_wrapper.c
> +++ b/drivers/ssb/pcihost_wrapper.c
> @@ -18,7 +18,6 @@
>  #include <linux/ssb/ssb.h>
>  
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int ssb_pcihost_suspend(struct device *d)
>  {
>  	struct pci_dev *dev = to_pci_dev(d);
> @@ -62,8 +61,6 @@ static const struct dev_pm_ops ssb_pcihost_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ssb_pcihost_suspend, ssb_pcihost_resume)
>  };
>  
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static int ssb_pcihost_probe(struct pci_dev *dev,
>  			     const struct pci_device_id *id)
>  {
> @@ -125,9 +122,7 @@ int ssb_pcihost_register(struct pci_driver *driver)
>  {
>  	driver->probe = ssb_pcihost_probe;
>  	driver->remove = ssb_pcihost_remove;
> -#ifdef CONFIG_PM_SLEEP
>  	driver->driver.pm = &ssb_pcihost_pm_ops;
> -#endif
>  
>  	return pci_register_driver(driver);
>  }

I'm not convinced that this is correct. How have you confirmed that
there are no compiler or sparse warnings?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
