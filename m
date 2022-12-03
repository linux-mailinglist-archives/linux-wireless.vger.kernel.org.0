Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABC641795
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 16:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLCPwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 10:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLCPwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 10:52:39 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2527CB1C6
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 07:52:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E1E468AFE; Sat,  3 Dec 2022 16:52:28 +0100 (CET)
Date:   Sat, 3 Dec 2022 16:52:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: failed to insert STA entry for the AP (error -2)
Message-ID: <20221203155227.GA13254@lst.de>
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org> <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org> <20221130133016.GC3055@lst.de> <87sfhx3ap6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfhx3ap6.fsf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 02, 2022 at 08:46:45PM +0200, Kalle Valo wrote:
> Haven't seen this before either. Really unfortunate that the warning
> message message is not printing the error value (missed that during
> review), but I suspect the error is coming from crypto_alloc_shash()
> call:

> Any chance you could check that? Also please check that
> CONFIG_CRYPTO_MICHAEL_MIC is enabled (it should be as CONFIG_ATH11K
> depends on it).

So, this is the debian-installer case onc again.  CONFIG_CRYPTO_MICHAEL_MIC
is enabled in the kernel config, but michael_mic.ko is not present on
the installation media. Once I side-load it, the problem goes away.

I guess I'll respind the MODULE_SOFTDEP patch to include michael_mic,
but if you have a good idea to make the error reporting more useful that
would be appreciated as well.
