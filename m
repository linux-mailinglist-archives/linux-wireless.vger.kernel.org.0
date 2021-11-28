Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D06460902
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhK1Slv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 13:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhK1Sju (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 13:39:50 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17AC06175E
        for <linux-wireless@vger.kernel.org>; Sun, 28 Nov 2021 10:34:37 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4J2HFg5CHxzQjgG;
        Sun, 28 Nov 2021 19:34:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1638124461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oA8D1lCU7CeyPITNQVRngT8Pi1cm3Q47+Grcj4jH22c=;
        b=RhvH+bJWLyR+8EyBZAG+E+zn99aIXtL7iu/rwcPwG/oPRjmNcU4/cAFdSCslSYlpF8XUba
        mfT4Mi1Ehhf7/wAgUMsrNkyzMNYy+/817a4qEKg6smEapqxDM2EUPaTtUShAiREGPqrPAa
        IdONUAhnQ9CprbCg3cHNFgagugAcz8H24JESkAp0Yfji9EoFVSuqupSdh/6SZrke3tJleJ
        pM6UmjTGttQ1uh/bgKwBVuQGF7FD7HtYmzXcN3yI69tCOHYUaQS3CDdox8DHv9/+rudj/K
        RWeH0JwA49wx3VwGNza95umCexobqswJLGSdhwENFKr97hPoyDZQ+W9rEpKYWQ==
Subject: Re: [PATCH v2] mt76: eeprom: tolerate corrected bit-flips
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <YZ/nv74JH/uQwpBt@makrotopia.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c544231a-4939-4924-ab94-f650c93a66a0@hauke-m.de>
Date:   Sun, 28 Nov 2021 19:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <YZ/nv74JH/uQwpBt@makrotopia.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/25/21 8:45 PM, Daniel Golle wrote:
> mtd_read() returns -EUCLEAN in case of corrected bit-flips.
> As data was read, don't error out in this case.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

I tried a similar patch on my device before and it solved the problem too.

> ---
> v2: fix wrong variable name
> 
>   drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index 2d58aa31db934..4a5d14473ddc4 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -65,7 +65,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
>   	offset = be32_to_cpup(list);
>   	ret = mtd_read(mtd, offset, len, &retlen, eep);
>   	put_mtd_device(mtd);
> -	if (ret) {
> +	if (ret && !mtd_is_bitflip(ret)) {
>   		dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\n",
>   			part, ret);
>   		goto out_put_node;
> 

