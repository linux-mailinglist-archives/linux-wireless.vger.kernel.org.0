Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9405DF84
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGCIPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 04:15:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54856 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727339AbfGCIPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 04:15:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hiaPl-0004wX-Up; Wed, 03 Jul 2019 11:14:54 +0300
Message-ID: <1d7609a45e38725d57c2f78b5e437b83b7e49197.camel@coelho.fi>
Subject: Re: [PATCH for v5.2] iwlwifi: mvm: disable TX-AMSDU on older NICs
From:   Luca Coelho <luca@coelho.fi>
To:     davem@davemloft.net
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        emmanuel.grumbach@intel.com, johannes.hirte@datenkhaos.de,
        steven@uplinklabs.net, Johannes Berg <johannes.berg@intel.com>
Date:   Wed, 03 Jul 2019 11:14:52 +0300
In-Reply-To: <20190703081049.28831-1-luca@coelho.fi>
References: <20190703081049.28831-1-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-03 at 11:10 +0300, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On older NICs, we occasionally see issues with A-MSDU support,
> where the commands in the FIFO get confused and then we see an
> assert EDC because the next command in the FIFO isn't TX.
> 
> We've tried to isolate this issue and understand where it comes
> from, but haven't found any errors in building the A-MSDU in
> software.
> 
> At least for now, disable A-MSDU support on older hardware so
> that users can use it again without fearing the assert.
> 
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=203315.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Hi Dave,

This is an important fix for a bug that has been reported by several
users in bugzilla (and elsewhere).  It fixes FW crashes that disrupt
throughput and connectivity in general in very popular devices (Intel's
WiFi 7000 and 8000 series).

I know it's a bit late for v5.2, but if possible, it would be great to
take this.  Kalle is on vacation, so we agreed that I would send it
directly to you.

Please let me know if this is okay or if we should send this to -next
and get it into v5.2 via stable releases instead.

Thanks!

--
Cheers,
Luca.

