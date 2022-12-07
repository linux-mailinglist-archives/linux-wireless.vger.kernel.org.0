Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6413F645B24
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLGNkb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 08:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLGNka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 08:40:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E329834
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 05:40:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00D1167373; Wed,  7 Dec 2022 14:40:25 +0100 (CET)
Date:   Wed, 7 Dec 2022 14:40:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        debian-kernel@lists.debian.org, debian-boot@lists.debian.org
Subject: Re: failed to insert STA entry for the AP (error -2)
Message-ID: <20221207134025.GA21691@lst.de>
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org> <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org> <20221130133016.GC3055@lst.de> <87sfhx3ap6.fsf@kernel.org> <20221203155227.GA13254@lst.de> <87cz8v2xb2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz8v2xb2.fsf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

adding the debian-kernel list due to issues with using debian-installer
daily snapshot to install on my brand new laptop with an ath11k_pci
supported wifi chip.

It turns out that while d-i comes with the ath11k and ath11k_pci
drivers, but misses the qrtr, qrtr-mki and michael_mic modules that
are needed for the driver to actually work and not just load.

On Wed, Dec 07, 2022 at 02:49:37PM +0200, Kalle Valo wrote:
> Thanks. But this makes me wonder is it sensible to randomly install a
> set of .ko files and drop the rest, like Debian's installer apparently
> does? The dependency for drivers is pretty well documented in Kconfig
> files, thanks to build testers testing with random configurations, but
> if the installer omits all that there will be problems just like you are
> experiencing. So for me MODULE_SOFTDEP() feels just like a band aid and
> not a robust solution.

I think a driver that a driver that has a runtime depedency on a
certain module, but doesn't import symbols is always going to be
somewhat problematic.  But I also agree that the arbitrary splitting
of kernel modules into separate packages for the installer, or
in fact not packaging them at all for the installer is rather
problematic.  I'm not sure what the rationale is behind that, but
I've added the debian-kernel and debian-boot lists.


> Though I am happy to take your MODULE_SOFTDEP() patch, just wondering if
> there is a better way to solve this. For example net/mac80211 (the
> 802.11 stack) has a lot of crypto dependencies:
> 
> 	select CRYPTO
> 	select CRYPTO_LIB_ARC4
> 	select CRYPTO_AES
> 	select CRYPTO_CCM
> 	select CRYPTO_GCM
> 	select CRYPTO_CMAC
> 	select CRC32
> 
> And it's not using MODULE_SOFTDEP() at all.

Yes.  I'm not quite sure how the packages for d-i select which
modules to include where, but given that other wifi hardware
seems to work in the installer they must have figured this out
somehow.
