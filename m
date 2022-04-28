Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C22513AAF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiD1RP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiD1RP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 13:15:57 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 10:12:42 PDT
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C45B3D2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 10:12:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 4BBAB10FB4;
        Thu, 28 Apr 2022 17:07:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZJu7z1ZY66Kh; Thu, 28 Apr 2022 17:07:31 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 28 Apr 2022 20:07:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1651165651; bh=s8hGBbNQh46sSlQ5sGSKs6winwiPDz3gAwqF12YVCVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xa8a4J5CaXAO8ZRTDF8WIlZsaqX/MJSbeZIPd8WP1vWnDmJegR2YtZKO4kXJQxrvD
         psRZJ8nQMl+2M8Cci1LOX43toPmVSpVzNZsSs9DQyh865sez0szE0XoWbJdelKhPI0
         KpWVe0ED5ny21mi8oPcJTj9B+Dqex9w6lCh4Tb7VNuvk4ZtIxNIVtfXk5WFiXBvk5C
         jXoh67i0aq20k0KbQGCjgePEVf8eCsitRkaghbs2cAYaaHHYk+CiWhpicY/nIbHiqL
         L7CYvtvAgUkjDb2LWS9ogXbL7/OuPeN5T5laqKWts8unl5oET3VisHNj8kzjqxAoNo
         pActnjHvIGHjw==
Date:   Thu, 28 Apr 2022 20:07:29 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
Message-ID: <20220428170729.GA13599@w1.fi>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
 <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
 <6b40798e349d11e495a6df20ecba479a8357dad2.camel@sipsolutions.net>
 <ff39ff9b6b1a6619ab30118e8a76b43ad2b9a715.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff39ff9b6b1a6619ab30118e8a76b43ad2b9a715.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 28, 2022 at 02:36:26PM +0200, Johannes Berg wrote:
> However, I'm starting to have second thoughts on this.
> 
> I do understand the concern that Jouni mentioned, that the device might
> roam by itself, and change the underlying links, and you'd have races if
> you identify only by the link ID, and that just changed, and so now
> you're referring to something else. His suggestion was that we might
> need to include the BSSID or the address of the AP MLD, or such, in some
> cases. [1]
> 
> However, if e.g. roaming is offloaded but the supplicant isn't, then we
> really do need the ability to refer to the link ID, e.g. to set the per
> link GTK/IGTK/BIGTK after the 4-way-HS (or later 2-way-HS).
> 
> So now I'm wondering what we're achieving by having a mapping, if every
> component in the system needs to be aware of the mapping?

There are use cases where over-the-air Link ID is used and other cases
where it is more appropriate to identify the local link based on the
band (or subband, etc.) in a manner that is valid over one or multiple
associations. It might actually make more sense to come up with two
nl80211 attributes for identifying a link based on either the
over-the-air Link ID (which is valid only during an association and can
change whenever roaming occurs) or the internal identifier for a link.

This would allow nl80211 commands to use only one of the possible ways
of identifying link so that user space components would not need to know
or care about the mapping and would just use the variant that is easier
for the particular case. For nl80211 event messages, both attributes
could be included since the driver and/or cfg80211 would know the
mapping and could fill in both options so that the user space components
would not need to be aware of the full mapping.

In addition, there seems to still be some open discussion on how various
Management frames are targeting specific links and that might even
result in there being a protocol mechanism for targeting a subset of the
available links, i.e., not all of MLD but one or more links. I'm not
sure whether this would need anything particular in nl80211 since we
could always send multiple copies of the command/event (one per link),
but it might also be convenient to be able to use an array of the
over-the-air and/or internal identifiers for the links.

-- 
Jouni Malinen                                            PGP id EFC895FA
