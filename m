Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6910A19DC6D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDCRKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 13:10:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42047 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCRKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 13:10:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id z5so7985782oth.9
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NQsNcZoNvhxa8sxCKT+EqRaHA5MlC6Htv2OcwjWylA=;
        b=VITZPPjH941cELSyVbSFPnH4Z/7SewourxTaSRMglXb5VfAKoUI/GQwk6w5jAkD9bc
         verQXEmgVceczX55j3+h7bdbVtvVxmpo7LQkd5c/954tRwkg8m5UDN6s90Ja6Yrq7R1s
         baH0c9S8ZJGrmGXxr56YyX3rlD3buvPvjTISgTMsgNYjVrEGON1p1oj/SRwXDh3YR0Ql
         +l3I1KZb/Jw5kePkOEtcEzXjaG4E9O9q/MMyue7sTxGZqKSpkv02qaujnLQVsK1gf9N9
         GY+x9+6eOOftsuMIuF2sBA924ylSJ/T3Wg+xJRsHZKZ4/uV13tbeMelmTQ7j0/wHByX9
         Fxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NQsNcZoNvhxa8sxCKT+EqRaHA5MlC6Htv2OcwjWylA=;
        b=hHqOFLi0bayBJ2SEaxxRl3ZSC066927FHUv4trUzcm4t6q4cqPEJQPA0ZUzUygR9s/
         f7eT8UamTA2eR0HaKXNBTNirDa6rYq1iJIZAsVhG/f0zJCzRvipzHy8pl5zcmSrbcNsb
         64zzcSwoli9nGPhE7a9su02d1CKbNyA9xPUNV9CxS5o86o/ScdgHo5uk+ZR8AvqeHPC0
         /NdCdlI1vQinWiCLTnhCinBuZEAP43oEbz9vaXrDATDg/Iu46VdVbzqEEmYonHRXIejf
         u85j9JpJ83Nh3Seiin440gnBz9PGjZ7FwETA73/oG5GtOEvOCJhTJRePWJGIQLrUGjRJ
         I79Q==
X-Gm-Message-State: AGi0PuZvq2LslWnjyLfYPql8i6mWoQ6q7Yc55Cn87rmK10nSWAaD6J76
        62OSWJSchMRsSlbMRXFxl3pNU3/oevmuXODIrIk=
X-Google-Smtp-Source: APiQypJJRBYF8Oqto+dL+yaVR1yEDbQYG7yFFqqRSoXW08pNLEDr4u7RzX8DhlF9KC5eXWDFFnBJd+moAesGHkg6dHM=
X-Received: by 2002:a9d:264a:: with SMTP id a68mr7088533otb.176.1585933842431;
 Fri, 03 Apr 2020 10:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
 <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com>
In-Reply-To: <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Fri, 3 Apr 2020 13:10:31 -0400
Message-ID: <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com>
Subject: Re: [PATCH v5.7 4/8] iwlwifi: mvm: limit maximum queue appropriately
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 3, 2020 at 10:38 AM Mark Asselstine <asselsm@gmail.com> wrote:
>
> On Fri, Apr 3, 2020 at 4:32 AM Luca Coelho <luca@coelho.fi> wrote:
> >
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > Due to some hardware issues, queue 32 isn't usable on devices that have
> > 32 queues (7000, 8000, 9000 families),

Is this statement really correct? All these devices have 31 queues
according to (.num_of_queues = 31). Without a HW specification I can't
be 100% sure but you should have this information within Intel. From
the details of my patch and my investigation, this should be nack'd
along with an explanation as to why my fix is not valid.

Mark

> > which is correctly reflected in
> > the configuration and TX queue initialization.
>
> This will not fix the issue on the 1000, 2000, 5000 and 6000 devices.
> You need further protection on these as their are only 20
> (IWLAGN_NUM_QUEUES) queues. I sent out a patch on March 19th with a
> fix.
>
> Mark
>
> >
> > However, the firmware API and queue allocation code assumes that there
> > are 32 queues, and if something actually attempts to use #31 this leads
> > to a NULL-pointer dereference since it's not allocated.
> >
> > Fix this by limiting to 31 in the IWL_MVM_DQA_MAX_DATA_QUEUE, and also
> > add some code to catch this earlier in the future, if the configuration
> > changes perhaps.
> >
> > Cc: stable@vger.kernel.org # v4.9+
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/fw/api/txq.h | 6 +++---
> >  drivers/net/wireless/intel/iwlwifi/mvm/sta.c    | 5 +++++
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > index 73196cbc7fbe..75d958bab0e3 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > @@ -8,7 +8,7 @@
> >   * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > - * Copyright(c) 2019 Intel Corporation
> > + * Copyright(c) 2019 - 2020 Intel Corporation
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of version 2 of the GNU General Public License as
> > @@ -31,7 +31,7 @@
> >   * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > - * Copyright(c) 2019 Intel Corporation
> > + * Copyright(c) 2019 - 2020 Intel Corporation
> >   * All rights reserved.
> >   *
> >   * Redistribution and use in source and binary forms, with or without
> > @@ -99,7 +99,7 @@ enum iwl_mvm_dqa_txq {
> >         IWL_MVM_DQA_MAX_MGMT_QUEUE = 8,
> >         IWL_MVM_DQA_AP_PROBE_RESP_QUEUE = 9,
> >         IWL_MVM_DQA_MIN_DATA_QUEUE = 10,
> > -       IWL_MVM_DQA_MAX_DATA_QUEUE = 31,
> > +       IWL_MVM_DQA_MAX_DATA_QUEUE = 30,
> >  };
> >
> >  enum iwl_mvm_tx_fifo {
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > index 64ef3f3ba23b..251d6fbb1da5 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > @@ -722,6 +722,11 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
> >
> >         lockdep_assert_held(&mvm->mutex);
> >
> > +       if (WARN(maxq >= mvm->trans->trans_cfg->base_params->num_of_queues,
> > +                "max queue %d >= num_of_queues (%d)", maxq,
> > +                mvm->trans->trans_cfg->base_params->num_of_queues))
> > +               maxq = mvm->trans->trans_cfg->base_params->num_of_queues - 1;
> > +
> >         /* This should not be hit with new TX path */
> >         if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
> >                 return -ENOSPC;
> > --
> > 2.25.1
> >
