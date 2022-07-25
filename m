Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FD57FDCE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiGYKpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiGYKpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 06:45:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3AFA470
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 03:45:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 491EF6601AD9;
        Mon, 25 Jul 2022 11:45:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658745911;
        bh=8jqDRz7pmMCFgF9l2ImU8VeeQTeNrBDh76+ym1NgW+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LaKHIvkhyLjcACgIe2Q1iGCENgeoUGrDw6wFlzCkYsfFv+tNPmm/hRdyFqfalSWko
         h39EGl8V97qYdNIJXfzhl+e20USyc/GK9zR6ofa3MDxfBBSj2+V+VuUkF6ocOdaR6G
         M16IdHYSVuWnT2ydUV6J7mZVKxSThvWIdLaa8pTkgumtZyMWrgXGha/EfcQpTjA/Oh
         X9a+6IwZfy46ShwOqtVgN2fLTm7Q1/7gT1TlcXNfxSDDubHq+FxmWvbOFm4Qq2CoXj
         uhCMPQo/SP3wf06gLpkY6cLH66MbM+OGCA2CSY0DL6b0nkhEbyrzCkBDYaFmxTV/Tq
         paCMnsYCKHGdg==
Message-ID: <42747f5b-cd51-6a42-c793-db5f410b3bcc@collabora.com>
Date:   Mon, 25 Jul 2022 12:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] mt76: mt7921: add mt7921_mutex_acquire at
 mt7921_sta_set_decap_offload
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
References: <acb86f6ecd2f446e4102a2ef2e7a9c0003ae8b46.1658641200.git.objelf@gmail.com>
 <02ef9b9464024d2375caf598ae7c6b1e8e8e20de.1658641200.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <02ef9b9464024d2375caf598ae7c6b1e8e8e20de.1658641200.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 24/07/22 10:58, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add mt7921_mutex_acquire at mt7921_[start, stop]_ap to fix the race
> with the context holding dev->muxtex and the driver might access the
> device in low power state.
> 
> Fixes: 24299fc869f7 ("mt76: mt7921: enable rx header traslation offload")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

