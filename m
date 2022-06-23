Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7D5575DC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiFWIsN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFWIsM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 04:48:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F824BCC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 01:48:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A635C6601792;
        Thu, 23 Jun 2022 09:48:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655974090;
        bh=ylgwSvzf7Fqq4ao2tBir/3+VLMJz9T1sIuh0IuI0M2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nRkCTHiYs4l1ldAealljY6GiGIFZ/IpFvUCarTw2/Qv9TKXiGRNu9GsSVacT46H7f
         4oMSzMvTcwPqZaF3+tXV4CpBvndP3015KC1v77eipcxoJXz6rMfdJLnaSNHN19b13d
         n3LfzvTwxkq1nXrw017eyNJ6nPdHxRWF10qjz2yzhCCvEX5+RTT8Y7zaF94f18swkz
         N0TRldcLs5tve6ZJh7OETzpfsLlP9SwNh2nOujoi16xMbTu/uwAZfVvx+t+40rkWsd
         F2PvOiYuzMP6PSHRl2wi8X30Lj/tE0Hi9Anopazfxmdjk+2FzIWRd9oUQ6fvOSK3Pn
         vuFwb27qSWP+g==
Message-ID: <b2769038-798c-fe93-478b-8d5bbd97b29f@collabora.com>
Date:   Thu, 23 Jun 2022 10:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] mt76: mt7921: reduce log severity levels for
 informative messages
Content-Language: en-US
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <753f19393f169ad4a5fc127f68e16074f1617306.1655944385.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <753f19393f169ad4a5fc127f68e16074f1617306.1655944385.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 23/06/22 02:35, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Use dev_info instead for the informative messages.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> index eb1bfb682e02..2ce3a833176e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -740,7 +740,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>   	struct mt76_connac_pm *pm = &dev->pm;
>   	int i;
>   
> -	dev_err(dev->mt76.dev, "chip reset\n");
> +	dev_info(dev->mt76.dev, "chip reset\n");

Since this function is normally expected to be called and this message is
describing the wanted flow and/or this worker function starting, I'd say
that this is not a really important information anyway...

What about changing that one to a dev_dbg() instead?

Regards,
Angelo

>   	dev->hw_full_reset = true;
>   	ieee80211_stop_queues(hw);
>   

