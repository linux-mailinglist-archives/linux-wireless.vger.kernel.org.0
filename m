Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983365B36B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjABOjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjABOi5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 09:38:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13634321
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 06:38:55 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAA666602CC0;
        Mon,  2 Jan 2023 14:38:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672670333;
        bh=pMikB19yU/UkbJaEJvuwA2/p/HZ5W0dUSLFKBbmG/KQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GA6FK+qq3fPjz49b+fv5tPL850lBxjApPmX60wxhXnTH+cdFc/UqYV+GoJM4bcUwT
         wbC5zpPXs2+QolnGWHWy6cwEjXzJOPM30YXdjC5/lIgsd9qs5MSsVVdmKwAL+GP20B
         WmibGu50UsqKuby5qjHIW5qcQlPeNvIaHKRg+Fps/4xoxhc8XrnYxYH5Gl8afbfbmx
         zl/bQuH+vV2N2H1dbdqlQ7LZmIbtloe5t6lh66mY/DHbLWghM4xRjJarkLix6EAez8
         QY5HL3dpTDZd0KLPZTFvZXMyhHAyyfUsVTvadPhwDF7UP90SSAxl7h3wAzE2AsXSzP
         rTT54lTsZqt8Q==
Message-ID: <0c47a386-49b6-2fa3-3169-33b04e0b2cda@collabora.com>
Date:   Mon, 2 Jan 2023 15:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mt76: mt7915: remove BW80+80 support
Content-Language: en-US
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Money Wang <Money.Wang@mediatek.com>
References: <20221229021131.9361-1-MeiChia.Chiu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221229021131.9361-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 29/12/22 03:11, MeiChia Chiu ha scritto:
> mt7915 doesn't support bw80+80.
> 
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Money Wang<Money.Wang@mediatek.com>
> Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>

On AW7915-NP1 mPCIe:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


