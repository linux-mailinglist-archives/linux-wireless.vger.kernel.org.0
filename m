Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98851347DA6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCXQ0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhCXQ0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 12:26:06 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C31CC061763
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 09:26:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k25so10018837iob.6
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGUjjIjmYb3FmUAZJY1VJospXDwUV1Szs6e0OnH6qcA=;
        b=TI1Fs/mX3cVATj8jB2Bm/t2nLrMSK/m1M38qCasvK4ugnCHLq5XHo5flJGL+0Mw0pr
         nTTlbVZXRyHxCKq5pGCX52zMzn0TKpOQe13whcWLLIe9/8xm9x+8c31rCLj+L90C/cCc
         0IFPIFaz7R3l4IIxUdjwOcMmqAv0wrN4J5OxdgZB5A3xWwwbAookdWg+k5Osm6q7U+hG
         aM1+xZYn3cciDn0y510k/FFKtLHIF/zBHcAzuTKBXa/o/X/b8QyBgQDAXTFHu0kELuVM
         T93GcQM5hP8gcDl40SxsDAA9PRwKFWvPYcz1UDe01j2M54L6WE94S7gQbyVasJ6TCe4k
         1MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGUjjIjmYb3FmUAZJY1VJospXDwUV1Szs6e0OnH6qcA=;
        b=I9J/a/6qGrSqKhwhqposxIEoU6TQQadUVjFxMkxZ1AE1EXD04Ge6uG277PHEkcFyOc
         s8nop+sEcOlpm/75dx5eLDvEpbByE5i3CUlfxOc5QHKnbd7yeABDj8ngriVJ1/u52kIh
         rmOV73vo67e7//BsgUwQaaoPM5EcgD6zCDZfx7Z7zvkNA3mbyXXgwivb6pYryJbmO0Fa
         c84rHTsdCdPQeGtGfCREyUroUuVlzgEZ8i4QitUwt8hdlTpEhV5CpqRm9wXtNdJC7gy9
         +UETsDkPOzdqCM3xpi2tE+qUGVXFi5U3J+zTzXFWwflqYP+P8RilTJzBT1sNUa/fzVxa
         70Eg==
X-Gm-Message-State: AOAM532qEu6Y5EJtfvAWyHQoZAYFQPfssnzOhpQkuCIYSGMB4cVXubqG
        Wt8dRyaCbeGgAJp7HkfrCMGmCock8lv+YoZzIBM=
X-Google-Smtp-Source: ABdhPJxsBDJKdTydI1d3n0apcNU90XPuIGZFLoJy9sZfUvIcY7YwzDLCAldTklBbZIc1ECIeoQeGUhhI/BszLRAeQt8=
X-Received: by 2002:a02:7f8c:: with SMTP id r134mr3618722jac.95.1616603164462;
 Wed, 24 Mar 2021 09:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
 <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com> <CAPiS6wB4Ls53ykD6iSUpBGN+sHauya1Mhu-7Q+Z_gzh=bAShAw@mail.gmail.com>
 <CAPiS6wD=NZe6+aT6wc_s94KVfFRVK_3b+zM_RUR7q6uWe-Wgpw@mail.gmail.com>
In-Reply-To: <CAPiS6wD=NZe6+aT6wc_s94KVfFRVK_3b+zM_RUR7q6uWe-Wgpw@mail.gmail.com>
From:   Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date:   Wed, 24 Mar 2021 18:25:53 +0200
Message-ID: <CAPiS6wCi2-cUaDkgkOFietb5Ko7oCLMjkoNcOfygNsSfYxAAeg@mail.gmail.com>
Subject: Re: Intel AX210 does not work on 5.11
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 24, 2021 at 6:16 PM Paulius Zaleckas
<paulius.zaleckas@gmail.com> wrote:
>
> On Wed, Mar 24, 2021 at 3:46 PM Paulius Zaleckas
> <paulius.zaleckas@gmail.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 2:24 PM Ben Greear <greearb@candelatech.com> wrote:
> > >
> > > On 3/24/21 5:21 AM, Paulius Zaleckas wrote:
> > > > It was working on 5.10.16:
> > > > [    4.274856] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > > > [    4.279014] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > > > supported by driver
> > > > [    4.279031] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > > > Version: 93.8.63.28
> > > > [    4.279401] iwlwifi 0000:3c:00.0: loaded firmware version
> > > > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > > > [    4.456228] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > > > 160MHz, REV=0x420
> > > > [    4.607524] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > > [    4.673134] iwlwifi 0000:3c:00.0: base HW address: d8:f8:83:d9:35:87
> > > > [    6.055731] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > > [    6.288461] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > > [   72.546602] iwlwifi 0000:3c:00.0 wlan0: disabling HT/VHT/HE as
> > > > WMM/QoS is not supported by the AP
> > > >
> > > > And fails to start on 5.11.8:
> > > > [    3.882744] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > > > [    3.937708] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > > > supported by driver
> > > > [    3.937720] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > > > Version: 93.8.63.28
> > > > [    3.937891] iwlwifi 0000:3c:00.0: loaded firmware version
> > > > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > > > [    4.341262] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > > > 160MHz, REV=0x420
> > > > [    4.486405] iwlwifi 0000:3c:00.0: loaded PNVM version 0x324cd670
> > > > [    4.588212] iwlwifi 0000:3c:00.0: Timeout waiting for PNVM load!
> > > > [    4.588213] iwlwifi 0000:3c:00.0: Failed to start RT ucode: -110
> > > > [    4.588215] iwlwifi 0000:3c:00.0: iwl_trans_send_cmd bad state = 1
> > > > [    4.796206] iwlwifi 0000:3c:00.0: firmware didn't ACK the reset -
> > > > continue anyway
> > > > [    4.808321] iwlwifi 0000:3c:00.0: Failed to run INIT ucode: -110
> > > >
> > > > Please add me to Cc as I am not on the list.
> > > >
> > >
> > > You probably need to get latest firmware from https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git
> > > and splat the intel related firmware into /lib/firmware/
> >
> > Did that, but still the same issue...
>
> Removing /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm fixed this issue.

Found more info on Gentoo bugs: https://bugs.gentoo.org/777324#c6
So either commit 000735e5dbbb739ca3742413858c1d9cac899e10 should be
ported to 5.11-stable or PNVM loading disabled.
