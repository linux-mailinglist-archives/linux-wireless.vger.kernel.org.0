Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC3436E67
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhJUXmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 19:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 19:42:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CC7C061764;
        Thu, 21 Oct 2021 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OEUJmZNnx6E69Y9a/rMQD8aPaxuy5E3qagoQ7/1dgv8=; b=LeAL3jxJzHoChU3dqDXfik7tW8
        jLoixIxsIvwW7KwwtQwc94gxDhK9X3ZMU24/u5k95/rYGlirlRdI6ByV/OHN+At6d5155OBddVgdn
        RzBuAfjPG5zSz+IHKIwKPigl8mpFEgmZNiN14HTlrXi505YbZ43/dsfwA/ACN83toh67amsUsojnX
        UsEuD6KT1o1lK9JXhu8G1fIwT6mDyzTmPu+fHHdOhNvgpnYw513CSQ2lzwR/JSy2y0IKSvAY/yXQ6
        6TQYC1y+oESTeOT/mLC+Ektx8+GE7F/SgTlOY/m8tHI8MPBj9FRap0sl8rSNLW0BbsmZGyLT5Pfs0
        DWfJ7g+A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdhfV-009Iqz-QT; Thu, 21 Oct 2021 23:40:17 +0000
Subject: Re: linux-next: Tree for Oct 21
 (drivers/net/wireless/mediatek/mt76/sdio.o)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <20211021184300.30c77f51@canb.auug.org.au>
 <88795dab-d8a9-856e-a938-8da6acc944ea@infradead.org>
 <YXHtdI61S54Cm0S2@lore-desk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <831cb7e7-dd85-0883-dfcb-52aad52f8322@infradead.org>
Date:   Thu, 21 Oct 2021 16:40:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXHtdI61S54Cm0S2@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/21/21 3:45 PM, Lorenzo Bianconi wrote:
>> On 10/21/21 12:43 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20211020:
> 
> Hi Randy,
> 
> can you please the patch below?
> 
> Regards,
> Lorenzo
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
> index ce3a06227901..71154fc2a87c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
> @@ -19,6 +19,7 @@ config MT7921S
>   	select MT76_SDIO
>   	select MT7921_COMMON>   	depends on MAC80211
> +	depends on MMC
>   	help
>   	  This adds support for MT7921S 802.11ax 2x2:2SS wireless devices.

Hi,
Yes, that works. Thanks.

-- 
~Randy
