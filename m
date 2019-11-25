Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBA108F49
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKYNxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 08:53:18 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:39274
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727462AbfKYNxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 08:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574689997;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=nnmFrluhAsQqe7jVepsaOqJurHLnGk7e8T7iaUfjktg=;
        b=XgvUT+amnG5VRYPcjlZGY8ezX2BM8RhinlUEa6jQQLUA75WSmBs47lpqBO1p8CyR
        Rcmc+ynTxCRj/MH9fgX1bIJbdGade06/OU5Pjx6mfNAu4cbi2RhHVmcIRz1qKBOrbMo
        R6MW1YirTXHWSWEnxSi5SoV35LfnpUS3wEG6PGsA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574689997;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=nnmFrluhAsQqe7jVepsaOqJurHLnGk7e8T7iaUfjktg=;
        b=auaT1ivL00amrkfw6WqOuUvmzl8o4fugRFHlBry81y1tNifbYrUGWImQQKW61pg/
        BG/JNDBZZDNiklLmDHn13hQcYBghD79dvjOy+XvVET2mgXOZoN4ijy0+2sFctuvKpNC
        Ik0gTaPF2Oe5KvVGqSg4xzVbAg3YNQuEZOZQeU5I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65B29C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, kevin.patrick.schmidt@googlemail.com
Subject: Re: [PATCH] mt76: eeprom: add support for big endian eeprom partition
References: <61e89623446ed8914e5969114c7ae8c623f3e3ba.1574502651.git.lorenzo@kernel.org>
Date:   Mon, 25 Nov 2019 13:53:17 +0000
In-Reply-To: <61e89623446ed8914e5969114c7ae8c623f3e3ba.1574502651.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sat, 23 Nov 2019 11:54:01 +0200")
Message-ID: <0101016ea2d681fc-d025a829-1e16-4cf1-b9d0-477469cfb704-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.25-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> mt76x0e users reported some devices (e.g TP-Link Archer VR200v) have
> been flashed with big endian radio partition. Add the possibility to
> specify eeprom endianness using big-endian dts property and in case
> covert eeprom data in little endian
>
> Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index 804224e81103..33d992d5662a 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -64,6 +64,16 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
>  		goto out_put_node;
>  	}
>  
> +	if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
> +		u8 *data = (u8 *)dev->eeprom.data;
> +		int i;
> +
> +		/* convert eeprom data in Little Endian */
> +		for (i = 0; i < round_down(len, 2); i += 2)
> +			put_unaligned_le16(get_unaligned_be16(&data[i]),
> +					   &data[i]);
> +	}

What about the bindings documentation? I don't see this "big-endian"
documented in the mt76 doc, at least.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
