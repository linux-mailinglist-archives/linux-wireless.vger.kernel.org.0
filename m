Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE93A191529
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgCXPmX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 11:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgCXPmW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 11:42:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5A820714;
        Tue, 24 Mar 2020 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064542;
        bh=iY0iQy8M8M9PlPZnJFM5YPoDv72kOb7VIAOeqRPiEr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlLuGC74jPz7CHp6TqNiqQThNKA/sJDDbmlEjIAvKxA6pA5tOSsRUyZ+zAOsV06HO
         TRVl1xNKlH6/YSc6lMm7YGYmF+IR4zkyXm3zSS4QLK8YAR9aKJ4O+fMbYQQIUglCtk
         HymrUB7OUvyj7O9y/47EZr41SeYXXRGs3mYuK1+0=
Date:   Tue, 24 Mar 2020 16:42:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
Message-ID: <20200324154219.GB2513347@kroah.com>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
 <20200324152040.GA2511658@kroah.com>
 <73723ab7d2c64c7d5ce7e2ae05b857c965824168.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73723ab7d2c64c7d5ce7e2ae05b857c965824168.camel@hadess.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 24, 2020 at 04:21:47PM +0100, Bastien Nocera wrote:
> On Tue, 2020-03-24 at 16:20 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 11:36:00AM +0100, Bastien Nocera wrote:
> > > Make it possible to disable the LED, as it can be pretty annoying
> > > depending on where it's located.
> > > 
> > > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > > out-of-tree version.
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
> > >  drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
> > >  drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
> > >  3 files changed, 13 insertions(+)
> > 
> > Why was this resent?  Didn't I just reject this?
> 
> It wasn't resent, it's the same mail you already answered.

Ah, slow mailing lists, sorry :)

greg k-h
