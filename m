Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A023557602
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiFWI4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFWI4K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 04:56:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8536B42
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 01:56:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 361F86601792;
        Thu, 23 Jun 2022 09:56:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655974568;
        bh=gaH+QcLCd0GRKyU8drx8USepwlQGvVb6yCGKaphFNNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cuCsRuTLsIDqKPWMRVmQgSzxlM8pDZi4hyxmxcuxRzEKHteOiiMWYqkJ5VQiMitdX
         Be9zJbGH16+7YhjeCKiqFkS/F5gCF8CMdWnDtfp5Shqy7HZetNySJM80eg0ev3/VpR
         2PW4iWlZnEcWZTOQCe4ds4Jpi2kWU/5+BanhWsqeKs9GUMxamgkdGYU/b+I/YvEfjV
         68mUhnzDQqW3o/HOAzjEiDyLfmKvayvWuB4jmDsDNrCWyFUWU+a99qROkWtlLFmWc0
         KNadWwyEIIMs7P6ZoFlf5AK1Gei8TnVDAEjL5WX3uJ6UGGGAxeJXBE+tswTIQMPfAl
         bKeIFnTn52OeA==
Message-ID: <b398e6c6-c120-049a-bfba-aaafa9763c72@collabora.com>
Date:   Thu, 23 Jun 2022 10:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] mt76: mt7921: reduce the mutex lock scope during
 reset
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
 <b10be44b0f968475268895b99864973d18a3b86e.1655944385.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b10be44b0f968475268895b99864973d18a3b86e.1655944385.git.objelf@gmail.com>
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
> Reduce the mutex lock scope for reset to get rid of possible task hung
> e.g wpa_supplicant and to allow the user-space process to keep running
> during we need more retries to complete the reset.
> 

To actually, effectively, reduce the chance to get a hung task, and also
to improve the general responsiveness, I think that the best way would be
to manage the locking inside of the reset callback(s) for each dev/bus.

This is especially because some of these reset functions (like the SDIO one)
may end up waiting for more than *two seconds*.

However, I get that this proposal requires way more effort, and this commit
will anyway improve the situation as it is... so, you get my:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Suggested-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
