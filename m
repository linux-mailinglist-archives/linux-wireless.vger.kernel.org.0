Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165A5191427
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCXPVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 11:21:51 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57569 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCXPVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 11:21:51 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1D8B2C0011;
        Tue, 24 Mar 2020 15:21:47 +0000 (UTC)
Message-ID: <73723ab7d2c64c7d5ce7e2ae05b857c965824168.camel@hadess.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Tue, 24 Mar 2020 16:21:47 +0100
In-Reply-To: <20200324152040.GA2511658@kroah.com>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
         <20200324152040.GA2511658@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 (3.36.0-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 16:20 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2020 at 11:36:00AM +0100, Bastien Nocera wrote:
> > Make it possible to disable the LED, as it can be pretty annoying
> > depending on where it's located.
> > 
> > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > out-of-tree version.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
> >  drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
> >  drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
> >  3 files changed, 13 insertions(+)
> 
> Why was this resent?  Didn't I just reject this?

It wasn't resent, it's the same mail you already answered.

