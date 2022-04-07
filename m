Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA94F7F51
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiDGMnR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiDGMnQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 08:43:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB57B11E
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 05:41:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C98431F46263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649335276;
        bh=UZfegCPd2RthtHEiBUdmuemUwEzaqmYb4F7AmIXnuDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cVg/1i2fxKSdBqwnIbNfbxidpi4upKD/fUKbTwnjgIVV18vZm8mBARhAdjCmjvP/a
         jtBvntd1wO2QPDtb7zXvqJJaiKEzWKJHxvFTf1+Yi/ZSwEg9GMgujoqonJf8QEO9HW
         568nuONe5+esT8KrX/SJofzTFupOOAw9Xh5A/e9XbAOAAEKdMn5sLRbOxz30CaFz80
         Wv8qtnFwB/aGxK8jU6pEY1NkVPZZ/X2/LG1cxnbkvPLJmE2TwiyPxAXo3E54qpV1Q6
         Y4J7IvQ/+Tiu2lCb5LGNN6ttX3kae+YMyzDF+xE0hu1VnligdHEeyQi1T1CPuSUXZD
         9qQXygc0CLtIQ==
Message-ID: <511692d7-bc9c-bcf0-3a1f-9825eb6790e9@collabora.com>
Date:   Thu, 7 Apr 2022 14:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] mt76: mt7921: Add AP mode support
Content-Language: en-US
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <8868a55bcaec80822e5b671c7a6023583d1b16b0.1649269260.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8868a55bcaec80822e5b671c7a6023583d1b16b0.1649269260.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 06/04/22 20:29, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add AP mode support to mt7921 that can work for mt7921[e,s,u]
> with the common code.
> 
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


