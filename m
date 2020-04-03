Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93619D947
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgDCOjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 10:39:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41413 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOjH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 10:39:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so6251188oia.8
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tjj6eE/ucgSL74NIFz+7heO8Ditwaaktx0ch8GqLlBo=;
        b=KOIWjKQbVQIWTXiS/9XWZXnFniQGkQ68frwANVlEn809Fmq8d14rY6QS56q11Tu5aN
         8ftOklEV3YRgg3jAXAomOhjKlwznoy/sgbssforjLu0mdAmomglakVxvrlXldUTxT6VO
         5xwEM7b8sUAxLQxkIHYuP+bNxbA5Ul7vS+piw9o1+EeHNM1Q7zYYBKwV3fUN6H+gW+5t
         GEDVPwORBMGxdKKAV3qZ2kWKKxEevrjv4sVLskToUe0O6sGfmByBfJKvXY/ji7J3Izlh
         ROxquowFU8vL48ilV7bs49UeeJEMVp5aVVCa/QIHJtYQVNP31TietQCewutZF8mV1P8i
         oDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tjj6eE/ucgSL74NIFz+7heO8Ditwaaktx0ch8GqLlBo=;
        b=duU2iTfu53NVY0T4uZK3/b31kl1Gv2XotW+gNlLc7iQ3M7cmPmKS2tgq9DPxVZfgOH
         D+XSGEkBYpMCDr+Yl+Q2BYFUfPJpXK2SozMspqcFz6zCYzx4/jpQSnXCAC2X9fs7NCRI
         KHTfM+Hnjq9kMLITae5+Y7Kaoc7z6Ed7GVPSkxemKViuK1DL07w7zvBF/+DKak5lqF5P
         pHCmejJqS8aVfvEOwxyTo7SokyWr6M9yuvPoGoDSl62kMU9mVaiiK/BIIevQokgjX43w
         +/LcC6LWjeGfgvf3EobUYjwEfrFkEH6rQm2LTVWpnybZjDMErt19SbQoDlW/fm05d8ch
         +G7g==
X-Gm-Message-State: AGi0PuYDy4MEVeGZER5QeOwwPLFvpvONAh7njRFP/cVD5IjpGOzjPcdE
        0YQNiuOEzNvURTtiww81LoWC40pxbONtai7IwRfMacnV
X-Google-Smtp-Source: APiQypLHqZafSCp3GRdCK+7jVWjSfXr/rs7w6xhbjttxER8c501BXQT8CyzMKk0lrK4lkYtDIolxonrSEgc2tnTFWMk=
X-Received: by 2002:aca:b756:: with SMTP id h83mr3320859oif.4.1585924746613;
 Fri, 03 Apr 2020 07:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
In-Reply-To: <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Fri, 3 Apr 2020 10:38:55 -0400
Message-ID: <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com>
Subject: Re: [PATCH v5.7 4/8] iwlwifi: mvm: limit maximum queue appropriately
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 3, 2020 at 4:32 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Due to some hardware issues, queue 32 isn't usable on devices that have
> 32 queues (7000, 8000, 9000 families), which is correctly reflected in
> the configuration and TX queue initialization.

This will not fix the issue on the 1000, 2000, 5000 and 6000 devices.
You need further protection on these as their are only 20
(IWLAGN_NUM_QUEUES) queues. I sent out a patch on March 19th with a
fix.

Mark

>
> However, the firmware API and queue allocation code assumes that there
> are 32 queues, and if something actually attempts to use #31 this leads
> to a NULL-pointer dereference since it's not allocated.
>
> Fix this by limiting to 31 in the IWL_MVM_DQA_MAX_DATA_QUEUE, and also
> add some code to catch this earlier in the future, if the configuration
> changes perhaps.
>
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/api/txq.h | 6 +++---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c    | 5 +++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> index 73196cbc7fbe..75d958bab0e3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
> @@ -8,7 +8,7 @@
>   * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> - * Copyright(c) 2019 Intel Corporation
> + * Copyright(c) 2019 - 2020 Intel Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of version 2 of the GNU General Public License as
> @@ -31,7 +31,7 @@
>   * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> - * Copyright(c) 2019 Intel Corporation
> + * Copyright(c) 2019 - 2020 Intel Corporation
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -99,7 +99,7 @@ enum iwl_mvm_dqa_txq {
>         IWL_MVM_DQA_MAX_MGMT_QUEUE = 8,
>         IWL_MVM_DQA_AP_PROBE_RESP_QUEUE = 9,
>         IWL_MVM_DQA_MIN_DATA_QUEUE = 10,
> -       IWL_MVM_DQA_MAX_DATA_QUEUE = 31,
> +       IWL_MVM_DQA_MAX_DATA_QUEUE = 30,
>  };
>
>  enum iwl_mvm_tx_fifo {
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> index 64ef3f3ba23b..251d6fbb1da5 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> @@ -722,6 +722,11 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
>
>         lockdep_assert_held(&mvm->mutex);
>
> +       if (WARN(maxq >= mvm->trans->trans_cfg->base_params->num_of_queues,
> +                "max queue %d >= num_of_queues (%d)", maxq,
> +                mvm->trans->trans_cfg->base_params->num_of_queues))
> +               maxq = mvm->trans->trans_cfg->base_params->num_of_queues - 1;
> +
>         /* This should not be hit with new TX path */
>         if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
>                 return -ENOSPC;
> --
> 2.25.1
>
