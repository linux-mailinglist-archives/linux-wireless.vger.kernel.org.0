Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8646775C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 13:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352009AbhLCM3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 07:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351984AbhLCM3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 07:29:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37221C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 04:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF71DB826C0
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 12:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B98C53FC7;
        Fri,  3 Dec 2021 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638534384;
        bh=dzNF+pSPJKPlAEiokALdn5a3SFKbXyaxrhbDG+N66J8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oqrWf+kSVQEAH3GzJuO1Ai7DGm5R/d9tnFrHd9bL39g01JO95J+RmVAwgGVv4PRqQ
         ZGXrrwDMRTzY0v5mK9LZaWsSS9zb6TMxF/3H5kS2ufuc5HRetVRWssWZfP0S2Qk4ZC
         dy+y3ZfMgkMm7BM4XoWaoMEQgcpQhdVusq2nQbYpQpkI3qXHzWwX7O3389weKe9xlq
         vrDt7TvjxKgus4VG8RKpJ3BIkkJs5HyDOyBn1O1V2kQFVY6PEp8ST0WwEjoL8G17Mu
         5o59Ylp6M+uoKY/Hw2DVGvVcdsBrFU1ukTfKLs92JyPvCby/y0VbTK+VixUKtzOKgk
         3j688ULtmig7g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.16] iwlwifi: mvm: don't crash on invalid rate w/o STA
References: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
        <26f66cf474aeebc56933faa8ea6fdf81fb439495.camel@coelho.fi>
Date:   Fri, 03 Dec 2021 14:26:18 +0200
In-Reply-To: <26f66cf474aeebc56933faa8ea6fdf81fb439495.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 03 Dec 2021 14:05:31 +0200")
Message-ID: <87k0gllvrp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Fri, 2021-12-03 at 14:04 +0200, Luca Coelho wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>> 
>> If we get to the WARN_ONCE(..., "Got a HT rate (...)", ...)
>> here with a NULL sta, then we crash because mvmsta is bad
>> and we try to dereference it. Fix that by printing -1 as the
>> state if no station was given.
>> 
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Fixes: 6761a718263a ("iwlwifi: mvm: add explicit check for non-data
>> frames in get Tx rate")
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>
> Kalle,
>
> Can you take this one directly to wireless-drivers? This fixes a kernel
> crash in some situations.

Ok, I took the patch in patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
