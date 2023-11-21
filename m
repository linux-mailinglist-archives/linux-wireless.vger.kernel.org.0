Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0767F2D8E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 13:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjKUMtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 07:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjKUMs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 07:48:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16CD52
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 04:48:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9146AC433C9;
        Tue, 21 Nov 2023 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700570934;
        bh=FeCtxbqlbC8xnrWkzJX683N7ngIDxVlLlLEvOhQvDdc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BhHj4Otq6Fz0bwX1UDVigzCodM/cZhflcYVltMJkPeFUwbpATfGcrsQjxMGM3hUi8
         44IxcX02y/ItdSdnu3zD1/AsGDGEskcc78um3f3ABni4wrH2H6Qt5KtVQ7ztjE6/d5
         W3+Aqg96TShucaQyIQY5WmJWLl6uC85Cf0xy8D2tER+zvF1qWHBPiDYwiK4X3jthqu
         7KU8j0WMcWMDb2bXz6/OGC7giXRCS8VpLVuEESZzowQ+v1Vb2kOw2BwdTeT/6mbHtE
         3gN2adDQ5G3fdPQAQ1WV/dL761w2h6K5lvGz6uVmqx/VmIctYealFjfiHWXOLzE33k
         FzgmJmqPehp6w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc:     <nbd@nbd.name>, <lorenzo@kernel.org>, <deren.wu@mediatek.com>,
        <Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
        <Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] wifi: mt76: mt7921: fix country count limitation
 for CLC
References: <20231120123940.5788-1-mingyen.hsieh@mediatek.com>
        <20231120123940.5788-2-mingyen.hsieh@mediatek.com>
Date:   Tue, 21 Nov 2023 14:48:49 +0200
In-Reply-To: <20231120123940.5788-2-mingyen.hsieh@mediatek.com> (Mingyen
        Hsieh's message of "Mon, 20 Nov 2023 20:39:38 +0800")
Message-ID: <87v89v6zm6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mingyen Hsieh <mingyen.hsieh@mediatek.com> writes:

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> Due to the increase in the number of power tables on CLC, the variable
> nr_country is no longer sufficient to represent the total quantity.
> Therefore, we have switched to calculating the length of clc buf to
> obtain the correct power table. Additionally, the version number has
> been incremented to 1.
>
> Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location Control support")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> v2:
>   - Convert type of buf_len from "__le16" to "u16".

Like in v2 this should be after "---" line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
