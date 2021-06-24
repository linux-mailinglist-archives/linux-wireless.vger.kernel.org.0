Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B73B2B79
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhFXJe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 05:34:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61723 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFXJe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 05:34:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624527160; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=K/Gl+vrtz8Ce8ioTXxwLnLrxUrfk2l9JlS7AIFYI1qQ=; b=WrWd047Twy5Pnou+l3MlrUE9Q/F8WOTQ9RopdAY3zD7VMqPirrssGu9Ahsf/lxLQ/HVYEssP
 3UrMH6mJ2VO+QTfZ9Mf4lIn20QWuIKUpdIqKimNOZ1XjTwq0mOk2z7s4dGg9j6oFE5ZpN1aW
 mixf9J1m7aZeaq7Tw2glPn5F2h8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60d451372a2a9a9761faf30d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 09:32:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC379C4338A; Thu, 24 Jun 2021 09:32:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6665FC433F1;
        Thu, 24 Jun 2021 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6665FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 08/12] wilc1000: invoke chip reset register while FW download
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
        <20210423182925.5865-9-ajay.kathat@microchip.com>
Date:   Thu, 24 Jun 2021 12:32:34 +0300
In-Reply-To: <20210423182925.5865-9-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Fri, 23 Apr 2021 18:29:47 +0000")
Message-ID: <87a6nfip59.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Added chip-reset command before firmware download to initialize the
> chip. Also configure chip in wake state, ready to accept the FW
> binary.

"Added" -> "Add"

This repeats many times, so I don't comment on that anymore.

> @@ -1088,10 +1089,22 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
>  		return -EIO;
>  
>  	offset = 0;
> +	pr_info("%s: Downloading firmware size = %d\n", __func__, buffer_size);
> +
> +	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
> +
> +	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
> +	reg &= ~BIT(10);
> +	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
> +	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
> +	if (reg & BIT(10))
> +		pr_err("%s: Failed to reset\n", __func__);
> +
> +	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
>  	do {
>  		addr = get_unaligned_le32(&buffer[offset]);
>  		size = get_unaligned_le32(&buffer[offset + 4]);
> -		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
> +		acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
>  		offset += 8;
>  		while (((int)size) && (offset < buffer_size)) {
>  			if (size <= blksz)
> @@ -1109,10 +1122,13 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
>  			offset += size2;
>  			size -= size2;
>  		}
> -		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
> +		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
>  
> -		if (ret)
> +		if (ret) {
> +			pr_err("%s Bus error\n", __func__);
>  			goto fail;
> +		}
> +		pr_info("%s Offset = %d\n", __func__, offset);

Please use pr_info() sparingly, it's only for important messages like
hardware info, firmware version/features and so on. I think pr_info()
calls in this function should be debug messages instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
