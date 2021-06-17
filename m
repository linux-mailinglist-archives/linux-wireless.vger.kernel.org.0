Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2C3ABA94
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhFQRZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhFQRZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 13:25:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD84C061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:23:41 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ltvjs-0089S5-E6; Thu, 17 Jun 2021 19:23:36 +0200
Message-ID: <4526c9fb8269675a98845160d15d4b746ae3b62e.camel@sipsolutions.net>
Subject: Re: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax
 devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 17 Jun 2021 19:23:35 +0200
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com> (sfid-20210617_180250_327693_0073AC4A)
References: <20210617160223.160998-1-viktor.barna@celeno.com>
         (sfid-20210617_180250_327693_0073AC4A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Viktor,

> The RFC is divided into separate patches on a per-file basis to simplify
> the review process.

Wow, umm, seems big! LOC maybe not, but # of files ... not that easy to
review.

I've only looked a little while now, but for making this easier to
review it would be nice to split it into a "minimum viable product"
first, i.e. have a much smaller driver, and this is probably not an
exhaustive list:

 * without command line interfaces with string parsing built into the
   kernel
   (OK, that's probably something that will never go upstream anyway)
 * Kconfig vs. code inconsistencies cleaned up, you have a TON of
   CONFIG_* ifdefs that don't even exist and can never be set, so remove
   the code, at least for now?
 * remove wrappers like cl_snprintf(), though that seems part of all
   those command line interfaces built into the driver
 * consider joining some of the many header files into bigger chunks,
   header files that are 50% boilerplate aren't really all that useful
 * namespace your things better - e.g. "is_ipv4_packet" and friends?
   (why do you even care?)
 * remove all vendor commands for now, and read the vendor commands
   upstreaming documentation before re-introducing them
   https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
 * remove utils/string.c, obviously, use kernel stuff directly or
   improve where needed I guess - but likely all part of the weird CLI-
   in-kernel stuff?
 * remove abstraction layers like cl_timer
 * what's this VNS stuff? doesn't look like it belongs into a driver
   (a mac80211 one at that!)
 * bitfields in endian-safe code are generally frowned upon, so you
   shouldn't need cl_are_host_bits_le(). And also cl_are_host_bits_be()?
   What?
 * Use ERR_PTR() and friends, instead of out pointer parameters.


You'll probably also notice a lot of issues yourself if you take a step
back and actually read your patches, rather than just the code they were
generated from, e.g. the Kconfig confusion I mentioned below.

Thanks,
johannes

