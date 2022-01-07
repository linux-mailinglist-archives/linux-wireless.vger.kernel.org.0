Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D17487560
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbiAGKWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 05:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAGKWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 05:22:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A7C061245;
        Fri,  7 Jan 2022 02:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AYNTNL/S+QFpIYO6a0jZ1apwOzIYkDjKgtgTKBbTuZk=;
        t=1641550931; x=1642760531; b=GuobMlhhmmN4iLh4S1Utru5+nawAeyUaXG0Rt29Cg+mhpf3
        1Av3SxntJiOmjzSZuCO1PlP+8ZcANqDoTxUSa2JI76d7/sUicrl1qYRJH+6OBr46d2WawiK981txs
        0TzpEOrLL08GwUa1a8yZBX6LLc+G3vNdcramkYt1haoKirXv9ByKWeQpRVppJ3BFPi2tD6CmjMaj8
        xvhrzRTHsxgM8LdDpb/xiEhU83YcIfxx+b4FvjkToWX2DjIwaSb29LFsyzuE8jJO75IkvnhiklKyJ
        EiopdpS301B1MJ2o01HbF3R6jZ0paJeexVxUQV/ymveQZVwrHuuWlvRlMSwFP0jA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n5mNh-002rqD-Jk;
        Fri, 07 Jan 2022 11:21:57 +0100
Message-ID: <bbf4b392e557a36f45a8642682512964502a4196.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7915: fix a couple information leaks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 07 Jan 2022 11:21:56 +0100
In-Reply-To: <97dbf02a-e3c7-aa4a-c404-45fc6189dc10@nbd.name>
References: <20220107073609.GH22086@kili>
         <f61c6a25c7ad1ed452b4facf38c7e451d47c5dc0.camel@sipsolutions.net>
         <97dbf02a-e3c7-aa4a-c404-45fc6189dc10@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-01-07 at 11:08 +0100, Felix Fietkau wrote:
> > 
> > Or maybe instead just mark the thing __packed (and/or explicitly add the
> > padding if needed), it seems weird that we'd send something to the
> > *firmware* that has a struct layout subject to compiler/arch padding
> > rules.
> I would also prefer explicitly adding the padding and leaving the rest 
> of the code as-is.
> 

Arguably, if you add padding explicitly, you might want to also mark it
__packed or add some BUILD_BUG_ON() ensuring there's no more padding
added by the compiler because of weird architectures, or whatnot?

johannes
