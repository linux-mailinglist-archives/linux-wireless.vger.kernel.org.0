Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6D75F53
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfGZGwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 02:52:34 -0400
Received: from mail.sig21.net ([80.244.240.74]:54646 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZGwe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 02:52:34 -0400
Received: from p5b206fb8.dip0.t-ipconnect.de ([91.32.111.184] helo=abc.local)
        by mail.sig21.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <js@sig21.net>)
        id 1hqu5R-0003WC-BN; Fri, 26 Jul 2019 08:52:22 +0200
Received: from js by abc.local with local (Exim 4.92)
        (envelope-from <js@sig21.net>)
        id 1hqu5N-0001hu-KI; Fri, 26 Jul 2019 08:52:13 +0200
Date:   Fri, 26 Jul 2019 08:52:13 +0200
From:   Johannes Stezenbach <js@sig21.net>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: mt76x0u blocks resume from suspend
Message-ID: <20190726065213.GA6539@sig21.net>
References: <20190722164020.GA5850@sig21.net>
 <20190723071806.GA2892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723071806.GA2892@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-21-Score: -2.9 (--)
X-Spam-21-Report: No, score=-2.9 required=8.0 tests=ALL_TRUSTED=-1,BAYES_00=-1.9 autolearn=ham autolearn_force=no
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanislaw,

On Tue, Jul 23, 2019 at 09:18:07AM +0200, Stanislaw Gruszka wrote:
> On Mon, Jul 22, 2019 at 06:40:20PM +0200, Johannes Stezenbach wrote:
> > I met failure to resume from suspend to RAM with v5.1.19
> > and TP-Link Archer T2UH connected to my PC (Asus P8H77-V).
> > I tried about a dozen times while trying to figure out the reason,
> > the issue happened every time.
> > Eventually I connected a serial console and captured this:
> > 
> > [   87.803576][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:ac80 failed:-110
> > [   91.030328][ T4640] mt76x0u 2-1.6:1.0: vendor request req:07 off:b000 failed:-110
> > [   94.256950][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:b000 failed:-110
> > [   97.483579][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:aca0 failed:-110
> > (repeats)
> > [  107.492106][    C0] Call Trace:
> > [  107.495293][    C0]  ? __schedule+0x381/0xa30
> > [  107.499706][    C0]  schedule+0x36/0x90
> > [  107.503575][    C0]  schedule_timeout+0x1e8/0x4c0
> > [  107.508310][    C0]  ? collect_expired_timers+0xb0/0xb0
> > [  107.513593][    C0]  wait_for_common+0x15f/0x190
> > [  107.518249][    C0]  ? wake_up_q+0x80/0x80
> > [  107.522412][    C0]  usb_start_wait_urb+0x82/0x160
> > [  107.527222][    C0]  ? wait_for_common+0x38/0x190
> > [  107.531961][    C0]  usb_control_msg+0xdc/0x140
> > [  107.536542][    C0]  __mt76u_vendor_request+0xc4/0x100 [mt76_usb]
> > [  107.542687][    C0]  mt76u_copy+0x8b/0xb0 [mt76_usb]
> > [  107.547721][    C0]  mt76x02_mac_shared_key_setup+0xdf/0x130 [mt76x02_lib]
> <snip>
> > The whole machine is hanging at this point. without serial console
> > my only choice was to press the reset button.  At least mt76x0u should
> > bail out with an error and not block the resume completely.
> > Unplugging the hardware also didn't cause it to bail.
> 
> I recently sent fix for that
> https://lore.kernel.org/linux-wireless/1563446290-2813-1-git-send-email-sgruszka@redhat.com/raw

Although the error message you quote in your patch is
different than what I got, your patch works for me, too.


Thanks,
Johannes
