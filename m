Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF16C324180
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhBXP7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 10:59:15 -0500
Received: from z11.mailgun.us ([104.130.96.11]:22040 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235897AbhBXP3C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 10:29:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614180520; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Dae0f9U6E+9GOr1dKpBCXM9r+HlFhHqF/NDbotMjmZA=; b=I7e412dy0dQtKhhKy9rwJjlcUCDwrAy8UPgc4UKCuaikqbgQbBVFif5vCSn3dusli41yJCCa
 3ryej8n98bS3fT7OUKJhbSIa3ItfFH5wFCykg21DPjVAi0KaXW1EHcuBVZrRu2WcQG98Ogwa
 h3JcDr7/9hA3DLutH1nnPPcJLD4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 603670a7095efe1816a0d0f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 15:28:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96798C433CA; Wed, 24 Feb 2021 15:28:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21172C433ED;
        Wed, 24 Feb 2021 15:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21172C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wilc1000: use wilc handler as cookie in request_threaded_irq()
References: <20210224122044.15146-1-ajay.kathat@microchip.com>
Date:   Wed, 24 Feb 2021 17:28:35 +0200
In-Reply-To: <20210224122044.15146-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Wed, 24 Feb 2021 12:21:28 +0000")
Message-ID: <87tuq1fpss.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Use same cookie for request_threaded_irq() & free_irq() to properly free
> IRQ during module unload. free_irq() already uses *wilc* handler so the
> changes are required for request_threaded_irq().
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/netdev.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
> index 1b205e7d97a8..66f725aad209 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
> @@ -24,12 +24,10 @@
>  
>  static irqreturn_t isr_uh_routine(int irq, void *user_data)
>  {
> -	struct net_device *dev = user_data;
> -	struct wilc_vif *vif = netdev_priv(dev);
> -	struct wilc *wilc = vif->wilc;
> +	struct wilc *wilc = (struct wilc *)user_data;

No need to cast a void pointer.

>  
>  	if (wilc->close) {
> -		netdev_err(dev, "Can't handle UH interrupt\n");
> +		pr_err("Can't handle UH interrupt");
>  		return IRQ_HANDLED;
>  	}
>  	return IRQ_WAKE_THREAD;
> @@ -37,12 +35,10 @@ static irqreturn_t isr_uh_routine(int irq, void *user_data)
>  
>  static irqreturn_t isr_bh_routine(int irq, void *userdata)
>  {
> -	struct net_device *dev = userdata;
> -	struct wilc_vif *vif = netdev_priv(userdata);
> -	struct wilc *wilc = vif->wilc;
> +	struct wilc *wilc = (struct wilc *)userdata;

Same here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
