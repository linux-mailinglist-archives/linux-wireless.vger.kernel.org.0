Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C66649D61
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 12:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiLLLRv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 06:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiLLLRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 06:17:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5954255B5
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 03:15:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33CAD6600363;
        Mon, 12 Dec 2022 11:15:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670843738;
        bh=ChOKXmAMcKCTWwH41gASrLbQANZal4s0KXhEMEBDovI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cqW3WJq+SfyziEYqn5tNeHwMhbNc1nnJJ5fydymWwK527QiMIzeQtPLkweOUijE+3
         pNLFwmJ5/yQF0NSpc8ENsmpP/co6C5UdL93SQxPLY4ojTEZg8B/rXpUC6liDzknCzT
         TxNwXKxW3zNNq98Alo3MtDBBsYFYsfLSU87UfWZ4AsQp7C7YG2QCB6UHeJ8Ib9oM7E
         gptJLhfj7j9GJsQKBR70AEvJl5GdKqG+D/U7LWK01gNQ2tzVKuMtCnavOQpv7scFsv
         HjYvmXtZnAV4ZZrzo8UysjXwKvJwmNEmS8e/2Z7drb6WhTv4wNqaM9lOKuGHHv6KQ4
         8BvyKXIWxqj6A==
Message-ID: <c2c71a7c-065a-2720-ac1d-8f27af2a723f@collabora.com>
Date:   Mon, 12 Dec 2022 12:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] wifi: mt76: mt7921: resource leaks at
 mt7921_check_offload_capability()
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
References: <1670540517-21517-1-git-send-email-sean.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1670540517-21517-1-git-send-email-sean.wang@mediatek.com>
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

Il 09/12/22 00:01, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fixed coverity issue with resource leaks at variable "fw" going out of
> scope leaks the storage it points to mt7921_check_offload_capability().
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527806 ("Resource leaks")
> Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


