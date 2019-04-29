Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7922CDE44
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfD2Iss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:48:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36195 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfD2Isr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:48:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so7688730oia.3;
        Mon, 29 Apr 2019 01:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DkL30STsaxgYUCGgLF1HNO5dyfcD0gOWg9WjzksmEw=;
        b=kZpVimoCC8ICQe38IjYiMPgBSFHVE5u6uNr7hBanT9YetF4+u0i+RAb5CF+8DkemRO
         5K149R8HMx6nb7z34stxax3PwtStCjagofioV5FVdu0QO1v+7qazBCCFfiNUi0D8O6YH
         sXPUdfNfDM8hRNrxjwou6FecUkIX9imrGF30c2usb/sNoGNxU2WrzCcXO2nrqIRw3trk
         YU+C0zfJzQ9GX9PkmdqdWTBa/llOErvu55MvjNqHiDvVzNuwaqCm54fwsYguPeblauqq
         73ujm42HWr9CPyiYyOu9HA/jMWYiBCWTbfbSHV4Uv7W/B9/pEaHLBohM3HaM3q/GsBsW
         LWhQ==
X-Gm-Message-State: APjAAAWP+9VDEmV7zQgO6dhpFE0fCIjsijbtR2gbxbuDwK340JJ8m4iF
        KBD8B08Tx1EC3ttPeLoTQQqzmWV7g/kjjXW6ZBA=
X-Google-Smtp-Source: APXvYqyLJGa7+HnvOpfZY8x6Fch1od+pFueZwowvEwEsz9duuDJOvZrKhA1V/swPDl6mm+4EGDvD+SUxVsA5B/E186I=
X-Received: by 2002:aca:5304:: with SMTP id h4mr4059265oib.115.1556527726758;
 Mon, 29 Apr 2019 01:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
 <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 10:48:35 +0200
Message-ID: <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Claire Chang <tientzu@google.com>,
        Sriram R <srirrama@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 26, 2019 at 9:18 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Brian Norris <briannorris@chromium.org> writes:
>
> > + Sriram, Pradeep, Claire
> >
> > On Sun, Mar 03, 2019 at 06:24:33PM +0100, Rafael J. Wysocki wrote:
> >
> > Ooh, exactly 1 month ago!
> >
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> ath10k_mac_vif_chan() always returns an error for the given vif
> >> during system-wide resume which reliably triggers two WARN_ON()s
> >> in ath10k_bss_info_changed() and they are not particularly
> >> useful in that code path, so drop them.
> >>
> >
> > Particularly, when WOWLAN isn't enabled, we get called during resume via
> > ieee80211_reconfig(), where we're not associated and don't have any
> > channel contexts. AFAICT, we shouldn't need to communicate anything in
> > particular to the firmware here, and so failing the 'if' is definitely
> > not worth WARN-ing about.
> >
> > I'd love to see this get applied with:
> >
> > Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> > Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> >
> > and sent to stable. This has been bugging people since 4.19. Spurious
> > WARN_ON()s can trigger reports to various crash trackers, and on some
> > systems appear as user-visible warnings ("System problem detected").
> >
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > Tested-by: Brian Norris <briannorris@chromium.org>
>
> I added these now to the commit log, thanks Brian.
>
> Rafael, could you please provide the hardware and firmware versions you
> tested this on? We have so many different firmware branches to support
> that I prefer to have that documented in the commit log. Providing
> ath10k startup messages in dmesg are enough,

There you go:

[    4.695349] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[    4.698165] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[    4.912240] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target
0x05030000 chip_id 0x00340aff sub 1a56:1535
[    4.912255] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
tracing 0 dfs 0 testmode 0
[    4.912716] ath10k_pci 0000:3a:00.0: firmware ver
WLAN.RM.2.0-00180-QCARMSWPZ-1 api 4 features
wowlan,ignore-otp,no-4addr-pad crc32 75dee6c5
[    4.982563] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A
crc32 19644295

> I can then add it to the commit log.

Still, I'm quite sure that the WARN_ON()s trigger during system resume
regardless of the hw/fw combination.
