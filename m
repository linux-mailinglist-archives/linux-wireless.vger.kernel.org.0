Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560D72DE946
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLRSt5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgLRSt5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 13:49:57 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96561C0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zRFXMkRycyC0MVrPiA/mwwIXpjM3W0G2IVjoa+Cfnm0=; b=teC4mz03EdIm/6Zt5z6VvfC9jp
        b6OafvRT5ZiiaXaVAjWNbgxVaOtY82YvTiYUcVQ1GqH4wmyZuaWB/SbKcufNVrY0gsXlycjBoOYke
        rXMGwN5dJlX5Z/okcp5oXGW201OhzLgo/maraGt/yaEvvX8rnImrGjsoXA/4BX5RSr34=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kqKoF-0000MY-2a; Fri, 18 Dec 2020 19:48:59 +0100
Subject: Re: [PATCH] mt76: mt7915: increase buffer size to receive large MPDUs
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <00af8edba9bad0e3635ca6024fcf56b3bcd407f8.1608139125.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <9b4df998-b73c-011b-11cc-007785e3fba5@nbd.name>
Date:   Fri, 18 Dec 2020 19:48:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <00af8edba9bad0e3635ca6024fcf56b3bcd407f8.1608139125.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-16 18:24, Ryder Lee wrote:
> This improves 5G/HE Rx performance around 70mbps.
> 
> Tested-by: Chih-Min Chen <chih-min.chen@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> index 8c1f9c77b14f..a8c783be297f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> @@ -203,7 +203,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
>  {
>  	/* Increase buffer size to receive large VHT/HE MPDUs */
>  	struct mt76_bus_ops *bus_ops;
> -	int rx_buf_size = MT_RX_BUF_SIZE * 2;
> +	int rx_buf_size = MT_RX_BUF_SIZE * 4;
This will not be needed after adding rx decapsulation offload.

- Felix
