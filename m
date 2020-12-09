Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65ED2D47A0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbgLIROE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 12:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732621AbgLIRN5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 12:13:57 -0500
Date:   Wed, 9 Dec 2020 09:13:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607533996;
        bh=yx06fepjWrRwJsnGMb//hVPuQcpepHhze51LMVwFV1I=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixcNaOLzH2DMiDXDGCa4CtxnjvQ8O82WY5+6MFhPSqIJ07648uXKpmh1hsdVQXUQw
         MyBgcRHnh70t1PzLYoxFcMrwYI5sYIaMtzje1sT8Uxvd4xz2Xd8gQn62aMz7ijVBCl
         vwp1J6Sz4+03vESaLFOXONZKEdATeNCM3vQYHfZTDO6eZBCI4qmUsCGRIspVKkCQ95
         MLEym5YWMnQhJri8OC4WQyITjhD7cc00WXkmwsY7JTuwtJjiz1PQheb5Z6tGQv2GHy
         6bor31wFJ3AEOxM2sETqjC4owE8uNWl8yVa6mokkfXaxJ7m2uOEG3mQ5jvETB9QBsd
         pXRgPU05fsXsA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
Message-ID: <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
        <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
        <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Dec 2020 23:17:48 +0000 Rui Salvaterra wrote:
> Hi, Luca,
> 
> On Tue, 8 Dec 2020 at 16:27, Coelho, Luciano <luciano.coelho@intel.com> wrote:
> > On Tue, 2020-12-08 at 11:27 +0000, Rui Salvaterra wrote:  
> > >
> > > [ 3174.003910] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
> > > [ 3174.003913] iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)  
> >
> > It looks like your machine is reporting RF-Kill to the WiFi device.  
> 
> Yes, that's an artifact of how I tested: I rebooted the router, the
> Wi-Fi interface disassociated and the dmesg was clean. However, after
> the router came up, the laptop didn't reconnect (and the connection
> had completely disappeared from nmtui). Afterwards, I did the rfkill
> cycle you see, and only then I got the register dump.
> 
> > There seems to be some sort of race there that is causing us to still
> > try to communicate with the device (and thus you see the transaction
> > failed dump), but that will obviously fail when RF-Kill is enabled.  
> 
> I'm not sure about that, the card was already dead before the rfkill cycle.

Any luck figuring this out, Luca? If this is a 5.10 regression we need
to let Linus know tomorrow, so the time is ticking :(
