Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9EC3B1865
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWLG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 07:06:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48664 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhFWLG1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 07:06:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lw0ft-001bj2-8p; Wed, 23 Jun 2021 14:04:07 +0300
Message-ID: <37ccff43592353f2dabcf1fa6d050fa5d23b18d9.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Florian Fainelli <f.fainelli@gmail.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 23 Jun 2021 14:04:03 +0300
In-Reply-To: <f0b8bcb1e90c4e805db974674e07f55e2ee38c14.camel@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
         <iwlwifi.20210618133832.5b2063dea3b3.I56248f2ce2e22a5c0cf797378726f6904b5de5e2@changeid>
         <db8585de-f1a2-b40c-0e4d-30dc5ad1d6ae@gmail.com>
         <f0b8bcb1e90c4e805db974674e07f55e2ee38c14.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 02/31] mac80211: do not add twice the HE 6GHz cap IE
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-06-18 at 23:17 +0300, Luca Coelho wrote:
> On Fri, 2021-06-18 at 10:14 -0700, Florian Fainelli wrote:
> > 
> > On 6/18/2021 3:41 AM, Luca Coelho wrote:
> > > From: Shaul Triebitz <shaul.triebitz@intel.com>
> > > 
> > > The HE 6GHz capability IE is already added before:
> > > ieee80211_add_he_ie -> ieee80211_ie_build_he_6ghz_cap
> > > 
> > > Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > > ---
> > >  net/mac80211/mlme.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> > > index 2480bd0577bb..310cfd02fda4 100644
> > > --- a/net/mac80211/mlme.c
> > > +++ b/net/mac80211/mlme.c
> > > @@ -8,7 +8,7 @@
> > >   * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
> > >   * Copyright 2013-2014  Intel Mobile Communications GmbH
> > >   * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> > > - * Copyright (C) 2018 - 2020 Intel Corporation
> > > + * Copyright (C) 2018 - 2021 Intel Corporation
> > 
> > This change only bumps the copyright year...
> 
> Oops, something went wrong when I applied it.  I'll check and either
> resend or drop it.

Please drop this patch.  It was an internal fixed to a merge damage and
should not have been sent out (obviously because it resulted in no
code).

--
Cheers,
Luca.

