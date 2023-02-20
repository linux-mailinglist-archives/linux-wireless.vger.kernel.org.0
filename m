Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5119969C7FA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBTJwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 04:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTJwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 04:52:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B40EF9A
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 01:52:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33089B80B9C
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 09:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD77C433D2;
        Mon, 20 Feb 2023 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676886726;
        bh=kRufBzngI+V7eIAi9Js4QnJARPazNYOkzWxa19IWQAw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LyNLpxVEbbFOKQgJ3s0+BNGmUDG7cIJe+6xnhPZp0NPdCuzKGz9AjTvdN2m0MYT5Q
         1PRv0H5Xtqn/xhFh9B5gvQNVFoZAG6t/wfUEjf9Hc8RfRYqZDZ2FR/JOf++ULa4sDc
         q/PDVY53K5R/yVpBVzL+cVw7ybRnBXyZKO1BIpNWVihlKi1Brj/iqkw3vOQjFnRvHd
         MB9tit65TnOcYzwu7eZnBFfaA0PmmvfVBEpB9Ocmcq0hVsfJYNudHJa6151eLfteUq
         HiJaVBv5k123goh6y0IFB2lY9gnmhIj+r1XQ7Cwg8Uo5KUXm2N0kF9VbKgFsZDgSHi
         oDqDKx6suCS5w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix radiotap bitfield
References: <c5289bc85b268fca577420fae74cc4f06b544798.1676623066.git.ryder.lee@mediatek.com>
Date:   Mon, 20 Feb 2023 11:51:58 +0200
In-Reply-To: <c5289bc85b268fca577420fae74cc4f06b544798.1676623066.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Sat, 18 Feb 2023 01:46:54 +0800")
Message-ID: <871qmk4qbl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> The 11be generation's radiotap bitfields were wrongly copy-and-pasted
> from 11ax driver, so fix them accordingly.
>
> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> change since v2 - revise commit message.

Thanks, much better now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
