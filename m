Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4D3F9D31
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhH0REv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhH0REu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 13:04:50 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E53C061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zp2Jx2p4tyFPvaHoFkrRw0ec88lvZ1SKolJlkPGdft8=; b=i2J5Q3kjc5aXG+VEbm2JnxnDAb
        mzEeEu22XhGhP6CAKVaZW3tuWWjdJIQpJFx4VzPnb8e286EdnvwLxUclpRCyXxzPTcB0oiQljiYzl
        5GqJ7byPurzj4ZSpE6Fo2kCgjLd6/kApXMe2l4h/eJh7aZzm880fnWQlS/41nn9AvQRE=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mJfGn-0007hd-89; Fri, 27 Aug 2021 19:03:57 +0200
Subject: Re: [PATCH] mt76: mt7915: add LED support
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <money.wang@mediatek.com>
References: <20210621141430.17577-1-MeiChia.Chiu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <046a19be-b804-94a1-7c8c-5c4f3bfa8eac@nbd.name>
Date:   Fri, 27 Aug 2021 19:03:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210621141430.17577-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-21 16:14, MeiChia Chiu wrote:
> From: MeiChia Chiu <meichia.chiu@mediatek.com>
> 
> Initialize brightness_set and blink_set callbacks to enable LED support.
> 
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Money Wang <money.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c |  6 +++--
>  .../net/wireless/mediatek/mt76/mt7915/regs.h | 19 ++++++++++++++
>  3 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> index af712a9..43f9245 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -92,10 +92,12 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
>  	}
>  
>  	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
> -	    (addr >= 0x70000000 && addr < 0x78000000) ||
> -	    (addr >= 0x7c000000 && addr < 0x7c400000))
> +	    (addr >= 0x70000000 && addr < 0x78000000))
>  		return mt7915_reg_map_l1(dev, addr);
>  
> +	if (addr >= 0x7c000000 && addr < 0x7c400000)
> +		return mt7915_reg_map_l1(dev, addr - 0x64000000);

This part doesn't make any sense to me. So you're defining registers in
the 0x7c000000 range, but subtracting 0x64000000 from the address, which
means we land at 0x18000000, which is already covered by the l1-mapped
ranges.
Why not just skip this weird magic trick and define the registers as
being in the 0x18000000 range?

- Felix
