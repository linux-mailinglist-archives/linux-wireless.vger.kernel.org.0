Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16FA3C3D5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbfFKGIq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:08:46 -0400
Received: from verein.lst.de ([213.95.11.211]:48379 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbfFKGIq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:08:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 29D2768B02; Tue, 11 Jun 2019 08:08:17 +0200 (CEST)
Date:   Tue, 11 Jun 2019 08:08:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190611060816.GA20158@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net> <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org> <3ed1ccfe-d7ca-11b9-17b3-303d1ae1bb0f@lwfinger.net> <c91ccbddd6a58dbee5705f10ed1d98fb44bd8f8d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91ccbddd6a58dbee5705f10ed1d98fb44bd8f8d.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 11, 2019 at 03:56:33PM +1000, Benjamin Herrenschmidt wrote:
> The reason I think it sort-of-mostly-worked is that to get more than
> 1GB of RAM, those machines use CONFIG_HIGHMEM. And *most* network
> buffers aren't allocated in Highmem.... so you got lucky.
> 
> That said, there is such as thing as no-copy send on network, so I
> wouldn't be surprised if some things would still have failed, just not
> frequent enough for you to notice.

Unless NETIF_F_HIGHDMA is set on a netdev, the core networkign code
will bounce buffer highmem pages for the driver under all circumstances.
