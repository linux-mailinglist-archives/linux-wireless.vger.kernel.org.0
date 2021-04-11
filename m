Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59935B31E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhDKKZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKKZ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:25:28 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E14C061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86SrSJu2os65YuE3x+cEFb3Q4jyL9NFA7EnI5LWHG+I=; b=O2VsAUQauzRYqYsrKlhtlImwMn
        3P97s/jQ9VFHSx2Nxi/IY9hLLEN87VkqR9lsbmP2k3DNyL6tUh+6VCwdpyDvywTF/r8awWx0gefvz
        4EHVLb0+O9m21l5q12ibxcydePJ4VpcI9oi+paCNzaFZyqfzcEGs2Nyj/pStKxx6xJIE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lVXHC-0000q2-7V; Sun, 11 Apr 2021 12:25:10 +0200
Subject: Re: [PATCH 5.12] mt76: fix potential DMA mapping leak
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, greearb@candelatech.com
References: <20210323214737.53254-1-nbd@nbd.name>
 <20210411084750.380F5C43461@smtp.codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <3766ead5-944d-6feb-e897-f7b59b9c5f11@nbd.name>
Date:   Sun, 11 Apr 2021 12:25:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210411084750.380F5C43461@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-11 10:47, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> wrote:
> 
>> With buf uninitialized in mt76_dma_tx_queue_skb_raw, its field skip_unmap
>> could potentially inherit a non-zero value from stack garbage.
>> If this happens, it will cause DMA mappings for MCU command frames to not be
>> unmapped after completion
>> 
>> Fixes: 27d5c528a7ca ("mt76: fix double DMA unmap of the first buffer on 7615/7915")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> Sorry, I missed this and I suspect it's now too late for v5.12. Felix, can you
> instead take this to your tree so that we can get this to v5.13? I assigned
> this to you on patchwork.
Will do. I plan on sending an updated pull request today.

- Felix
