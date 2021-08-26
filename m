Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4483F868B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbhHZLbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:31:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33154 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234382AbhHZLbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:31:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJDao-002VRV-GQ; Thu, 26 Aug 2021 14:30:48 +0300
Message-ID: <ce687133d7edf29abb421a9f1a105bb9eedd9761.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 14:30:46 +0300
In-Reply-To: <87tujisxfq.fsf@codeaurora.org>
References: <20210820110318.260751-1-luca@coelho.fi>
         <iwlwifi.20210820140104.8f8ce6f25ecd.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
         <87tujisxfq.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank
 otp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-08-21 at 17:07 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Matti Gottlieb <matti.gottlieb@intel.com>
> > 
> > When having a blank OTP the only way to get the rf id
> > and the cdb info is from prph registers.
> > 
> > Currently there is some implementation for this, but it
> > is located in the wrong place in the code (should be before
> > trying to understand what HW is connected and not after),
> > and it has a partial implementation.
> > 
> > Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +/*
> > + * struct iwl_crf_chip_id_reg
> > + *
> > + * type: bits 0-11
> > + * reserved: bits 12-18
> > + * slave_exist: bit 19
> > + * dash: bits 20-23
> > + * step: bits 24-26
> > + * flavor: bits 27-31
> > + */
> > +struct iwl_crf_chip_id_reg {
> > +	u32 type : 12;
> > +	u32 reserved : 7;
> > +	u32 slave_exist : 1;
> > +	u32 dash : 4;
> > +	u32 step : 4;
> > +	u32 flavor : 4;
> > +};
> 
> This doesn't look endian safe.

It's not exactly that this is not endian safe, but we had two issues:

1. AFAIK these bitfields are not guaranteed to be kept in order, so we
shouldn't use them.  I'll change it to decode this in some other way.

2. We are actually reading the register without caring for endianess. 
I will fix it.

Expect v2 soon.

--
Cheers,
Luca.


> > +	/* Set CDB capabilities */
> > +	if (cdb & BIT(4)) {
> > +		iwl_trans->hw_rf_id += BIT(28);
> > +		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
> > +	}
> 
> Magic numbers.
> 


