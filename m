Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAD2D36D3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 00:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgLHXSk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 18:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgLHXSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 18:18:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8AC0613CF;
        Tue,  8 Dec 2020 15:18:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p4so170350pfg.0;
        Tue, 08 Dec 2020 15:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1jflPVyzlck8ZSQb6zrxXfrXtKIO2jE239ZdUGpFuY=;
        b=PeO+Qc5G+BURgWlA3N9QwG6YJnV/WGe6/TbioDQM1XX6cWHGETFjuhXOqaSsIjop8d
         DlhTkb4ymEsLvPQ6E46ooUnkO1CoyjVQ6DL3HLSTKE+9ScETfnZyPETk//zQsR/J03os
         +v78yPKMoi8MFTkhfzsNqQ1P2yQLOJdIpK/uEV9/L4lOdONf6jTAa88718YJZi5WkDGh
         FUnRWUnEHGvdEk/I/Q6w+DA+kryPqEunifOd2BYmOj7vOaxgVZowj/4oaYLu8jvhN6Qk
         oLiT44Yx8m94IWsgJJKlrXttCOArT3Jtq3uUb1Pfqu+lqrsYnLHF/YGucKAzImH7TJa0
         JfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1jflPVyzlck8ZSQb6zrxXfrXtKIO2jE239ZdUGpFuY=;
        b=r4uwKxFQBC/qjzMwsOs1MC4/G3uXs699F8maNMvob9Fv0Gpqf6NnyGoUGymEb/2OD0
         KmgMlcVxQ0fgkc5s5N2Jw/tt0O3bNgkJcddBqk/hGSkJRjCF9Zk/+Q8IxVtWudt85KK2
         K+O6Chm3PogMKBaUbBJMq6j6KHaK4etzRtXdnkjF51wvR6AjMawB69Ge4B4sK2laPdyC
         rmpNmBuzU2188IKHI1esCT9ORvqxRG+L4N5rUVfAxblx3uFW79iXbRZO6YLrv8nd/Xfh
         1XMuqucFjIgVaGOrF6jOMjthQ+/lBZHjSFV7xl8u9u0A7eurtixl9WOXy/VPDxjJ6cdX
         YwgQ==
X-Gm-Message-State: AOAM532fKRiDuv3JJfrqGha7cmJ2t5vwbmxa+EJO3Gr2fKMy1vVNMMkQ
        8VW/F4qCDGDWgo9QVq4jBOJwiF7HUMoWZxM0VA==
X-Google-Smtp-Source: ABdhPJyUnZlcKi+r5TcN3aOqBJ2J1dSVwg3RWVH6rpQSBvt/3+m5O2vSguBkDshqlX+2dPR0+cSwyLTaS9teLzQMuYE=
X-Received: by 2002:a63:7e53:: with SMTP id o19mr372970pgn.92.1607469479629;
 Tue, 08 Dec 2020 15:17:59 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
In-Reply-To: <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 8 Dec 2020 23:17:48 +0000
Message-ID: <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Luca,

On Tue, 8 Dec 2020 at 16:27, Coelho, Luciano <luciano.coelho@intel.com> wrote:
>
> On Tue, 2020-12-08 at 11:27 +0000, Rui Salvaterra wrote:
> >
> > [ 3174.003910] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
> > [ 3174.003913] iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)
>
> It looks like your machine is reporting RF-Kill to the WiFi device.

Yes, that's an artifact of how I tested: I rebooted the router, the
Wi-Fi interface disassociated and the dmesg was clean. However, after
the router came up, the laptop didn't reconnect (and the connection
had completely disappeared from nmtui). Afterwards, I did the rfkill
cycle you see, and only then I got the register dump.

> There seems to be some sort of race there that is causing us to still
> try to communicate with the device (and thus you see the transaction
> failed dump), but that will obviously fail when RF-Kill is enabled.

I'm not sure about that, the card was already dead before the rfkill cycle.

Thanks,
Rui
