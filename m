Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D082324C0F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhBYI2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 03:28:52 -0500
Received: from z11.mailgun.us ([104.130.96.11]:17424 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235876AbhBYI2q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 03:28:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614241706; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4A2cOifs25KZ712bMUlS+qU+4oMKzXS4Saplfx6AI54=; b=g+TLkKDkQDdV3qmfny4w2cDXZhlaCOzu0pVtegZfVkBq2n+yhh2e1vr3+9lOU5wgTlXGgABO
 Q9AsU3+8d9LlwI+4WIwVzMGYgvgOSPGaUc7r528Sp2NO9kLvv1pj4dQNgsORh40Ixx+UyKyW
 usmMhYSM1rTvseq4QwLpT+rQVqA=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60375f8e2658fcb8734ac819 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 08:27:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C7EBC43462; Thu, 25 Feb 2021 08:27:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFBEFC433ED;
        Thu, 25 Feb 2021 08:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFBEFC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 3/4] wilc1000: Check for errors at end of DMA write
References: <20210224055135.1509200-1-davidm@egauge.net>
        <20210224055135.1509200-3-davidm@egauge.net>
Date:   Thu, 25 Feb 2021 10:27:52 +0200
In-Reply-To: <20210224055135.1509200-3-davidm@egauge.net> (David
        Mosberger-Tang's message of "Wed, 24 Feb 2021 05:51:57 +0000 (UTC)")
Message-ID: <87eeh4eelz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> writes:

> After a DMA write to the WILC chip, check for and report any errors.
>
> This is based on code from the wilc driver in the linux-at91
> repository.
>
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>  drivers/net/wireless/microchip/wilc1000/spi.c | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
> index fca34d1999ec..b0e096a03a28 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -750,6 +750,51 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 addr, u32 data)
>  	return 0;
>  }
>  
> +static int spi_data_rsp(struct wilc *wilc, u8 cmd)
> +{
> +	struct spi_device *spi = to_spi_device(wilc->dev);
> +	int result, i;
> +	u8 rsp[4];
> +
> +	/*
> +	 * The response to data packets is two bytes long.  For
> +	 * efficiency's sake, wilc_spi_write() wisely ignores the
> +	 * responses for all packets but the final one.  The downside
> +	 * of that optimization is that when the final data packet is
> +	 * short, we may receive (part of) the response to the
> +	 * second-to-last packet before the one for the final packet.
> +	 * To handle this, we always read 4 bytes and then search for
> +	 * the last byte that contains the "Response Start" code (0xc
> +	 * in the top 4 bits).  We then know that this byte is the
> +	 * first response byte of the final data packet.
> +	 */
> +	result = wilc_spi_rx(wilc, rsp, sizeof(rsp));
> +	if (result) {
> +		dev_err(&spi->dev, "Failed bus error...\n");
> +		return result;
> +	}
> +
> +	for (i = sizeof(rsp) - 2; i >= 0; --i)
> +		if ((rsp[i] & 0xf0) == 0xc0)
> +			break;

No magic numbers. Please create proper defines for these.

> +	if (i < 0) {
> +		dev_err(&spi->dev,
> +			"Data packet response missing (%02x %02x %02x %02x)\n",
> +			rsp[0], rsp[1], rsp[2], rsp[3]);
> +		return -1;
> +	}
> +
> +	/* rsp[i] is the last response start byte */
> +
> +	if (rsp[i] != 0xc3 || rsp[i + 1] != 0x00) {

Same here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
