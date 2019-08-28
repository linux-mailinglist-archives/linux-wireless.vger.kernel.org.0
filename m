Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71FA0B79
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfH1U2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 16:28:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42268 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1U2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 16:28:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i34Yf-0000AZ-9X; Wed, 28 Aug 2019 22:28:45 +0200
Message-ID: <8fc1716ca0dd522b7149160be02aed5f8cd1c882.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: add local BSS receive time to survey
 information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 28 Aug 2019 22:28:43 +0200
In-Reply-To: <F130F474-2D74-4952-B94B-82200B1D6CB6@holtmann.org>
References: <20190828102042.58016-1-nbd@nbd.name>
         <9189B2C1-6E5B-4457-9354-A010F946EE33@holtmann.org>
         <18c4232675c7b4f13fbfe9e5d8e9364a0908f316.camel@sipsolutions.net>
         <F29BC537-AED5-4BFA-915F-ED8E749124FC@holtmann.org>
         <a15716609a2c88e1591581539fd637f7385571e4.camel@sipsolutions.net>
         <F130F474-2D74-4952-B94B-82200B1D6CB6@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-08-28 at 22:24 +0200, Marcel Holtmann wrote:
> Hi Johannes,
> 
> > > > No, as usual, that would break ABI. PAD is a regular attribute, just
> > > > empty and ignored for aligning 64-bit values.
> > > 
> > > then I do not grok on how the nla_put_u64_64bit works, but that is
> > > fine.
> > > 
> > > I assumed these are similar to the NL80211_SURVEY_INFO_MAX which we
> > > also always move, but also not expected to be part of the API as a
> > > fixed value.
> > 
> > No no, the _MAX is just the token we use for knowing what we want as the
> > maximum when parsing etc.
> > 
> > The _PAD is actually a real attribute, basically nla_put_u64_64bit()
> > will do "nla_put_flag(_PAD)" if and only if "offset % 8 == 0", in order
> > to actually 64-bit align the 64-bit value in the following attribute.
> > 
> > (Note that offset % 8 can only be 0 or 4, due to the way netlink
> > attributes work.)
> 
> I get that part now. So the kernel is inserting a _PAD, but userspace
> is still not doing that. 

Yeah, and I forgot to say - if we renumbered _PAD, then newer userspace
would think old kernel's _PAD is really _BSS_RX, so things would break.

> So for NL80211_ATTR_WDEV we should be doing the same actually?

Not really. The kernel doesn't rely on it, nla_get_u64() uses
nla_memcpy() so doesn't care about alignment.

Even userspace doesn't (usually) rely on the alignment, it also
typically uses nla_get_u64() from libnl which also uses nla_memcpy() or
memcpy() (depending on the version), so it's all not really necessary.

I think some libraries or tools like maybe iproute2 didn't do it
correctly and just dereferenced a pointer there, causing alignment
violations, and so basically the decision was to get rid of unaligned
64-bit attributes to prevent that once and for all.

johannes

