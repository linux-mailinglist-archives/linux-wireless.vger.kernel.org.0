Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0872B8CE5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgKSIL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 03:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgKSILZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 03:11:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826CC0613CF;
        Thu, 19 Nov 2020 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A8ZpF4d5bM/Bn7Uny5g9ie3oCYKMVaj7Hp1UThvfNmU=; b=rnWZuTFnqtxXLtubdtoPaN5KTU
        s65+X2NkbURKUzUk9wjsooeN8isTyvd/c06IfTwnKrhj1jyYpa1CeHLVOWF2ETyGTNu4KL2r6UJiM
        TwG81gaA8GwlyzrunPWiCvSbl9b6eE+bkKq4cvb5OG9Bu6mKdQH/ciLBNeJrtK+Awl7iEHAtIh9fD
        cxMeIrOPeLnp5Ln29gEzBnBFZ/8KuQfvVf4AucTmqjkxIHW/lXHWGwz3H3uqcISzCjd5ICFih/0Wg
        ca54KUUD2+L+YdDqda1mnp52W4K/TtYlvF98pEI2HE+r4eWit23rPU6QgffBKX/L8Nq/8x9xyveRu
        qWF1/HIQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kff2G-0002Dx-I8; Thu, 19 Nov 2020 08:11:20 +0000
Date:   Thu, 19 Nov 2020 08:11:20 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: Re: [PATCH 1/6] relay: allow the use of const callback structs
Message-ID: <20201119081120.GA6149@infradead.org>
References: <20201118165320.26829-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118165320.26829-1-jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +/*
> + * rchan_callback wrappers. Call the callbacks if available, otherwise fall back
> + * to default behaviour.
> + */

This adds an overly long line.  That being said this behavior is pretty
normal for kernel APIs, so I'm not even sure we need it at all.

> +
> +/*
> + * subbuf_start() callback.
> + */

and this one is for sure completley useless.  Same for all the other
similar ones.


But taking one step back:  All instances implement create_buf_file
and remove_buf_file, which makes sense as that is the prime aim
of these methods.  So there is no point in making those optional.
subbuf_start_callback is overriden by two instances, so making that
optional totally makes sense.  buf_mapped and buf_unmapped are
never overriden, so they should be removed entirely.

More importantly there is no case that passes a NULL rchan_callbacks,
which makes complete sense as it wouldn't even create a file.  So
remove that case as well and just replace it with a sanity check in
relay_open().

Please also add a patch to mark all rchan_callbacks instances const
while you're at it.
