Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211484371C9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJVGfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 02:35:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56962 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231912AbhJVGfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 02:35:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdo6r-000beZ-LO; Fri, 22 Oct 2021 09:32:58 +0300
Message-ID: <91fba16c498acc7f5b191078948d766643f2a0ce.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Oct 2021 09:32:56 +0300
In-Reply-To: <8735oywyw8.fsf@codeaurora.org>
References: <20211016084359.246930-1-luca@coelho.fi>
         <8735oywyw8.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH for v5.15 0/5] iwlwifi: fixes intended for v5.15
 2021-10-16
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-10-18 at 10:55 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > Hi,
> > 
> > This is the first patchset with fixes for v5.15.
> > 
> > The changes are:
> > 
> > * Some memory handling fixes;
> > * Fix the device initialization configuration for So devices;
> > * Fix resume flow when iwlwifi resume fails;
> > * Fix device configuration for JnP edvices.
> > 
> > As usual, I'm pushing this to a pending branch, for kbuild bot.  And
> > since these are fixes for the rc series, please take them directly to
> > wireless-drivers.git, as we agreed.  I'll assign them to you.
> 
> We are in -rc6 now and I'm not planning to send anymore fixes to v5.15,
> unless something really critical pops up. Can I take these to
> wireless-drivers-next?

Yes, I guess that's okay.  And I see that you already did, thanks! :)

Sorry for not reacting earlier, I was on vacation till Wednesday.

We should probably have added Cc: stable, though, but of course we can
always just send it to stable later.

--
Cheers,
Luca.
