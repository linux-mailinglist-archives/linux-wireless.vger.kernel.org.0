Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302853A5A27
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFMTVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhFMTVh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 15:21:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB32AC061574
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jun 2021 12:19:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lsVds-006LMe-6O; Sun, 13 Jun 2021 21:19:32 +0200
Message-ID: <d04aa1e0550572448f2443c763ddc0260fabcd3c.camel@sipsolutions.net>
Subject: Re: ipw2200 driver no longer sets encrypted WEP in ipw2200 device?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter.T.Breuer@gmail.com, linux-wireless@vger.kernel.org
Date:   Sun, 13 Jun 2021 21:19:30 +0200
In-Reply-To: <20210613103347.0c2148bd@ptb> (sfid-20210613_113416_435859_DECC4D0A)
References: <20210610131139.4fce5404@ptb> <20210613103347.0c2148bd@ptb>
         (sfid-20210613_113416_435859_DECC4D0A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-06-13 at 10:33 +0100, Peter Breuer wrote:
> This list is so offically dead! Still, I have a clue for you:

You sound frustrated. FYI, in case you haven't noticed, the list isn't
even near dead. I'll have a clue down below as to why your question
didn't get any answers.


> On Thu, 10 Jun 2021 13:11:39 +0100
> Peter Breuer <Peter.T.Breuer@gmail.com> wrote:
> 
> > Hello - has somebody disabled encrypted WEP in ipw2200 firmwares, or
> > done something global that would have an equivalent effect, perhaps
> 
> Same issue with WPA1 or 2. Plaintext is OK except the signal keeps
> dropping, and the same is true even from my modern mobile phone.
> 
> The clue is this note from TP-Link:
> 
>   https://www.tp-link.com/en/support/faq/2303/

Which is talking about the 7265 as the oldest product of the bunch, and
~9260 as the newest.

Those had a launch date of Q3'14 and Q4'17 respectively. You might call
them old, but evidently they were fixed. I can't even speculate what the
issue might have been though, but if it wasn't just a Windows driver
(Linux not affected) or firmware issue (new binaries would've been
released for Linux as well), then I certainly never heard about it.


However, your thread here is talking about ipw2200. The devices that
driver is for aren't even listed on ark.intel.com (any more?), but I
recently du out something about them for unrelated reasons. The _latest_
of the bunch (this driver works on) was a mini-PCI (not PCIe) product
called 2915ABG, with a *launch* date of ~2003, and an *EOL* date of EOY
2009.

I think you'll not be surprised that there's hardly anyone who could
help you.

I'll note though that the driver for those ancient devices is just as
ancient, and (obviously) hasn't changed recently. You'll need to look
elsewhere.

I'm also not sure why you're complaining about WEP (might as well run
open network) and AX interoperability together. :)

johannes

