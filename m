Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13015010
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEFPYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 11:24:48 -0400
Received: from 0.ictbs.com ([203.137.112.168]:33899 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfEFPYr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 11:24:47 -0400
Received: by hq.local (Postfix, from userid 1000)
        id 6287766429; Mon,  6 May 2019 17:24:41 +0200 (CEST)
Date:   Mon, 6 May 2019 17:24:41 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
Message-ID: <20190506152441.ifjcdi73elxuq5it@localhost>
References: <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <20190506090609.msudhncj7e5vdtzw@localhost>
 <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
 <20190506102032.3ximjecado4mz62j@localhost>
 <fb07ae01-4cca-98e7-1c2d-dfdf44909900@redhat.com>
 <87d0kvvkej.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0kvvkej.fsf@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 03:26:28PM +0300, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
> > If we're going to do some filtering, then I suggest we play it safe and also
> > disallow other chars which may be used as a separator somewhere, specifically
> > ':' and ','.
> >
> > Currently upstream linux-firmware has these files which rely on the DMI
> > matching:
> >
> > brcmfmac4330-sdio.Prowise-PT301.txt
> > brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
> > brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt
> >
> > The others are either part of the DMI override table for devices with unsuitable
> > DMI strings like "Default String"; or are device-tree based.
> >
> > So as long as we don't break those 3 (or break the ONDA one but get a symlink
> > in place) we can sanitize a bit more then just non-printable and '/'.
> >
> > Kalle, Arend, what is your opinion on this?
> >
> > Note I do not expect the ONDA V80 Plus to have a lot of Linux users,
> > but it definitely has some.
> 
> To me having spaces in filenames is a bad idea, but on the other hand we
> do have the "don't break existing setups" rule, so it's not so simple. I
> vote for not allowing spaces, I think that's the best for the long run,
> but don't know what Arend thinks.

I have found a fresh judicate on this:
https://lkml.org/lkml/2018/12/22/221

It seems clear that we have to support at least spaces for some time
(maybe wih separate config option which will be deprecated but on by
defaut until old files are considered gone).

> Maybe we could do some kind of fallback mechanism, like first trying the
> sanitised filename and if that's not found then we try the old filename
> with spaces? And if that old filename works we print a big fat warning
> that the user should update the file and that the old "filename with
> spaces" support is going away soon?

In case of parametric sanitizing function, this might be achievable
by sanitizing using "final" character set first, and falling back
to "compatible" character set on file not found. So this may actually
bring another requirement on the sanitizing function.

Regards,
v.
