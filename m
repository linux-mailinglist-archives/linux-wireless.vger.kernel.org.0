Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A953B19E800
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgDDXRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 19:17:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43157 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDXRW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 19:17:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so11427634otb.10
        for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2020 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QY6kJu6osv8MjlmxaYnqwbXP+2TZMJZMDfLBsk4FAc=;
        b=XG/u8b5k+1WGaHMPQsDI7v08q8+pKD/Rz5ZkX3n7eEv0U9eepN8N0Jq1d8yx9TZJaC
         F0B2ppluMf9iTqPd7yHrzI7kc1UUHJ6qcHdiD79OjbXpn1mYGmkmqZPFRggss3h4PjWU
         WDuMqm2qUxPYjmOJn2AxWopBfuTz8FVIpeNHbBv4ljVGfSXhJ6UpadBNveSbhnEMnOdD
         USUNtkUIWdVl0qvf0PpgFpyQLbaxY4Rbd7tER1bCYQKl0gvEipb6Vp1NEFxhIXMh8EYA
         bVK8oJn2KFyACY26ejHcVA3esBPXGuMFW3QPyrt7FcSDZcOVVoutLAkdL6noaf4GYria
         ejbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QY6kJu6osv8MjlmxaYnqwbXP+2TZMJZMDfLBsk4FAc=;
        b=JBvTjd3Crwu4a8h89j9MO/VPAQ7mNeMsnq+tyXQz7Kb9A+t2ji845MasATYmlsIQI5
         HUlemSoOGRAx5m3TcWIssIxfT03p6sQZtq1l2xh4aizt3HMIv2frqCq89+B3/Dt/rLht
         CN7b5WTCw5XC/GIfSrN6Kz5hUJi+CGZPlmmMbse2A8p4JL1kUQ3FjmcDiax03cWV0fGJ
         e87lrg+beBYcdcFb91j5jprkC9SZKm10TQoT9LamDPccHLhv+K+f6LVYfjFEpn8jWDli
         Y5MsxJDu0m3s9+j12SIIm2UAyLrtxqRy8C0BxzGprTHTnPdXJguGSb6s2BLufarm1BR/
         wUmw==
X-Gm-Message-State: AGi0PuZBDmUA8Tn4kjjk6Ma9xptDYSyA6bt0uwmsiVp8HpvgCuHZa8bO
        I9qw7No+uSs/C4HRLscyluIBZjbQjORqNTCZhFWjgw==
X-Google-Smtp-Source: APiQypI6C3Cdnpu06vF7kfMtYfrtQq7pG2LHRgqDKaysBB21TxR6fNEP4oh8dAKyVWT/6+cdz8EqqmhKz5D6HbsFaPo=
X-Received: by 2002:a9d:4f0:: with SMTP id 103mr11862681otm.336.1586042241088;
 Sat, 04 Apr 2020 16:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
 <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com> <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com>
In-Reply-To: <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Sat, 4 Apr 2020 19:17:10 -0400
Message-ID: <CAPuovE+VKNvK=3WtFTWmKTGN0xNZWpq6zDM-PG6m4h1MedQWWw@mail.gmail.com>
Subject: Re: [PATCH v5.7 4/8] iwlwifi: mvm: limit maximum queue appropriately
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 3, 2020 at 1:10 PM Mark Asselstine <asselsm@gmail.com> wrote:
>
> On Fri, Apr 3, 2020 at 10:38 AM Mark Asselstine <asselsm@gmail.com> wrote:
> >
> > On Fri, Apr 3, 2020 at 4:32 AM Luca Coelho <luca@coelho.fi> wrote:
> > >
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > Due to some hardware issues, queue 32 isn't usable on devices that have
> > > 32 queues (7000, 8000, 9000 families),
>
> Is this statement really correct? All these devices have 31 queues
> according to (.num_of_queues = 31). Without a HW specification I can't
> be 100% sure but you should have this information within Intel. From
> the details of my patch and my investigation, this should be nack'd
> along with an explanation as to why my fix is not valid.
>
> Mark
>
> > > which is correctly reflected in
> > > the configuration and TX queue initialization.
> >
> > This will not fix the issue on the 1000, 2000, 5000 and 6000 devices.

Just correcting myself here. These use dvm so are OK, but I think we
still have a problem with the 7000, 8000 and 9000 series with the
change as is.

Mark

> > You need further protection on these as their are only 20
> > (IWLAGN_NUM_QUEUES) queues. I sent out a patch on March 19th with a
> > fix.
> >
> > Mark
> >
> > >
> > > However, the firmware API and queue allocation code assumes that there
> > > are 32 queues, and if something actually attempts to use #31 this leads
> > > to a NULL-pointer dereference since it's not allocated.
> > >
> > > Fix this by limiting to 31 in the IWL_MVM_DQA_MAX_DATA_QUEUE, and also
> > > add some code to catch this earlier in the future, if the configuration
> > > changes perhaps.
> > >
> > > Cc: stable@vger.kernel.org # v4.9+
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > > ---
> > >  drivers/net/wireless/intel/iwlwifi/fw/api/txq.h | 6 +++---
> > >  drivers/net/wireless/intel/iwlwifi/mvm/sta.c    | 5 +++++
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > > index 73196cbc7fbe..75d958bab0e3 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > > +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> > > @@ -8,7 +8,7 @@
> > >   * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
> > >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> > >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > > - * Copyright(c) 2019 Intel Corporation
> > > + * Copyright(c) 2019 - 2020 Intel Corporation
> > >   *
> > >   * This program is free software; you can redistribute it and/or modify
> > >   * it under the terms of version 2 of the GNU General Public License as
> > > @@ -31,7 +31,7 @@
> > >   * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
> > >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> > >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > > - * Copyright(c) 2019 Intel Corporation
> > > + * Copyright(c) 2019 - 2020 Intel Corporation
> > >   * All rights reserved.
> > >   *
> > >   * Redistribution and use in source and binary forms, with or without
> > > @@ -99,7 +99,7 @@ enum iwl_mvm_dqa_txq {
> > >         IWL_MVM_DQA_MAX_MGMT_QUEUE = 8,
> > >         IWL_MVM_DQA_AP_PROBE_RESP_QUEUE = 9,
> > >         IWL_MVM_DQA_MIN_DATA_QUEUE = 10,
> > > -       IWL_MVM_DQA_MAX_DATA_QUEUE = 31,
> > > +       IWL_MVM_DQA_MAX_DATA_QUEUE = 30,
> > >  };
> > >
> > >  enum iwl_mvm_tx_fifo {
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > index 64ef3f3ba23b..251d6fbb1da5 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > @@ -722,6 +722,11 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
> > >
> > >         lockdep_assert_held(&mvm->mutex);
> > >
> > > +       if (WARN(maxq >= mvm->trans->trans_cfg->base_params->num_of_queues,
> > > +                "max queue %d >= num_of_queues (%d)", maxq,
> > > +                mvm->trans->trans_cfg->base_params->num_of_queues))
> > > +               maxq = mvm->trans->trans_cfg->base_params->num_of_queues - 1;
> > > +
> > >         /* This should not be hit with new TX path */
> > >         if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
> > >                 return -ENOSPC;
> > > --
> > > 2.25.1
> > >
