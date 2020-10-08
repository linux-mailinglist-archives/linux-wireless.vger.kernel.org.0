Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F7287C18
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 21:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJHTKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 15:10:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54932 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgJHTKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 15:10:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQbJ0-002RIH-Tm; Thu, 08 Oct 2020 22:10:23 +0300
Message-ID: <aef56fa157600b45ae8b4b7d1662fde085bf4c74.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Oct 2020 22:10:20 +0300
In-Reply-To: <87pn5s1zyp.fsf@codeaurora.org>
References: <20201008151250.332346-1-luca@coelho.fi>
         <iwlwifi.20201008181047.d0e2253c282f.Icd2ff00adff52f6c96fb261c34fbf129ce67a00d@changeid>
         <87pn5s1zyp.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 02/13] iwlwifi: pcie: fix the xtal latency value for a
 few qu devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-10-08 at 18:47 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > We were using 5 ms for some qu devices, but their xtal stabilizes
> > much faster than that.  Reduce the value to 500 ms.
> > 
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> > index 60e0640d07dc..8b97c2eb2632 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> > @@ -253,7 +253,7 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
> >  	.device_family = IWL_DEVICE_FAMILY_22000,
> >  	.base_params = &iwl_22000_base_params,
> >  	.integrated = true,
> > -	.xtal_latency = 5000,
> > +	.xtal_latency = 500,
> >  	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
> >  };
> 
> The commit log doesn't make sense, I'll do s/5 ms/5 s/ during commit.

Hmmm, indeed it doesn't make sense like that.  But I actually think the
5 ms is correct, but the other one should be 500 microseconds.

--
Luca.

