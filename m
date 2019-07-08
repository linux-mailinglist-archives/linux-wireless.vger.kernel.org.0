Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1983861D27
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2019 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGHKlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jul 2019 06:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHKlV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jul 2019 06:41:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DF12053B;
        Mon,  8 Jul 2019 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562582480;
        bh=eDH3pC2pdqy2o7mwwWeHKRcJ5Id0sidmF+JzgAje81M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkxjZm4/Egog8b/JKQevoIihMFpGRZ08JcU4nzZoN2aj8lqwdsL5Nda2KH2Q92pIy
         afccnXpPvm8d3mSZ6GzTWaTJYAp9/I+AXsFDTILoCxatoBo5U3u+oM2O10A5Kb1a9D
         /BKYQDjReMbFD4NwO1VpUjLpkD6T0D4sj5vZ+PVs=
Date:   Mon, 8 Jul 2019 12:41:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license
 identifier
Message-ID: <20190708104118.GA10261@kroah.com>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com>
 <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
 <20190516200131.GA15814@kroah.com>
 <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
 <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
 <34aa04e4-9ddd-b6aa-721f-a20398f7740d@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34aa04e4-9ddd-b6aa-721f-a20398f7740d@broadcom.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 08, 2019 at 12:07:43PM +0200, Arend Van Spriel wrote:
> + Alan
> 
> On 5/17/2019 8:07 PM, Rafał Miłecki wrote:
> > > > > Another option could be MIT license which is in the preferred folder.
> > > > > Will have to consult our legal department about it though.
> > > > Hey, if your legal department is going to get asked this, why not just
> > > > switch it to GPLv2?  That would make everything much simpler.
> > > Hah. Because I already know the answer to that.;-)
> > It's not that obvious to me, sorry. Does your legal department require
> > something more permissive than GPLv2? Is that worth asking them about
> > dual-licensing? Something like
> > GPL-2.0 OR MIT
> > ? That assures driver is compatible with Linux, no matter what's the
> > current lawyers interpretation of MIT vs. GPL 2.0. I believe Alan Cox
> > once told/suggested that dual-licensing is safer for legal reasons.
> 
> Hi Alan,
> 
> Rafał mentioned your name a while ago when I was struggling with the SPDX
> identifiers. The drivers sources I want to modify for this originally had a
> license text in the header that matches ISC. However,
> one of the files did not have that and it was marked in bulk to GPLv2. So
> now the question is whether I can change it to ISC like the rest or should I
> make it dual like Rafał suggested.
> 
> Can you elaborate the pros and cons of dual license?

You need to talk to your lawyers about that.  Please ask this of them.

thanks,

greg k-h
