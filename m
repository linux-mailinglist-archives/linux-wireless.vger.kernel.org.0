Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF47C2064
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfI3MMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 08:12:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45704 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfI3MMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 08:12:23 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iEuXI-00006G-V5; Mon, 30 Sep 2019 15:12:17 +0300
Message-ID: <0a4d46d6cb811c82fc1221bc6c6c9a5ee89fac5b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Matteo Croce <mcroce@redhat.com>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Mon, 30 Sep 2019 15:12:15 +0300
In-Reply-To: <CAGnkfhyMJo11otYVeJmCaMivkbGfrh76i4MgpCN5CmGwQ_+qLA@mail.gmail.com>
References: <20190628092008.11049-1-luca@coelho.fi>
         <20190628092008.11049-9-luca@coelho.fi>
         <CAGnkfhyMJo11otYVeJmCaMivkbGfrh76i4MgpCN5CmGwQ_+qLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 08/20] iwlwifi: mvm: Add log information about SAR status
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-30 at 14:06 +0200, Matteo Croce wrote:
> On Fri, Jun 28, 2019 at 11:20 AM Luca Coelho <luca@coelho.fi> wrote:
> > From: Haim Dreyfuss <haim.dreyfuss@intel.com>
> > 
> > Inform users when SAR status is changing.
> > 
> > Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 3 +++
> >  drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 9 +++++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > index b27be2e3eca2..41a98cf01d0e 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > @@ -850,6 +850,9 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
> >                         return -ENOENT;
> >                 }
> > 
> > +               IWL_DEBUG_INFO(mvm,
> > +                              "SAR EWRD: chain %d profile index %d\n",
> > +                              i, profs[i]);
> >                 IWL_DEBUG_RADIO(mvm, "  Chain[%d]:\n", i);
> >                 for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
> >                         idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> > index 7bdbd010ae6b..719f793b3487 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> > @@ -620,6 +620,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
> >         enum iwl_mcc_source src;
> >         char mcc[3];
> >         struct ieee80211_regdomain *regd;
> > +       u32 wgds_tbl_idx;
> > 
> >         lockdep_assert_held(&mvm->mutex);
> > 
> > @@ -643,6 +644,14 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
> >         if (IS_ERR_OR_NULL(regd))
> >                 return;
> > 
> > +       wgds_tbl_idx = iwl_mvm_get_sar_geo_profile(mvm);
> > +       if (wgds_tbl_idx < 0)
> > +               IWL_DEBUG_INFO(mvm, "SAR WGDS is disabled (%d)\n",
> > +                              wgds_tbl_idx);
> > +       else
> > +               IWL_DEBUG_INFO(mvm, "SAR WGDS: geo profile %d is configured\n",
> > +                              wgds_tbl_idx);
> > +
> >         regulatory_set_wiphy_regd(mvm->hw->wiphy, regd);
> >         kfree(regd);
> >  }
> > --
> > 2.20.1
> > 
> 
> Hi all,
> 
> this patch seems to cause a long microcode dump:
> 
> [   16.792357] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
> [   16.939172] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
> [   17.019127] iwlwifi 0000:04:00.0: FW already configured (0) - re-configuring
> [   17.053395] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
> [   17.200436] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
> [   17.280572] iwlwifi 0000:04:00.0: FW already configured (0) - re-configuring
> [   20.822983] iwlwifi 0000:04:00.0: Microcode SW error detected.
> Restarting 0x82000000.
> [   20.823153] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
> [   20.823155] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
> [   20.823157] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
> [   20.823158] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND

[...]


> Reverting the patch fixes it, this is my card:
> $ lspci -d ::280
> 04:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)

Thanks for reporting!

But this bug was already reported and fixed.  Please check this:

https://bugzilla.kernel.org/show_bug.cgi?id=204151#c15

(specifically comment 15)

HTH.

--
Cheers,
Luca.

