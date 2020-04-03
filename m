Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F77419D969
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbgDCOqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 10:46:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36207 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 10:46:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so6315940oib.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+9t8TVhcuRAxEqo0k+4IL+Ja/sDsNAxc03/O1ePTr8=;
        b=OXv7AzKtQINMHqZzyeIcbAQxl9kSIhA/MC5c4NTf5TirJXYuX8zQtzBf4bGJMbMMWO
         Oo5MafNJhGJd+heLaSGFw1h0+jwBODEJ0oz4RzMJWEma6+Y9Wi3Y0lDZxEF4RYiRPeG2
         glOMO4P2Jw5U4AZKmMszdIMXSdKSnG5oLY7BZBHxrSA3VDkwwZcGLzYBYbotYdTdyr2l
         feUDxEubZNwjUKzPxI9UqRYOyoC4iD/LXjuU87cS918AB8ay0+vu7c3/onrs+7VUjwFI
         tjrXXiww/iuhpM7HcVgyQvonQLtvEeq1hKYmyJT9t4+xxVG4DSUdZPvy/j0YdyrlSKFd
         eJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+9t8TVhcuRAxEqo0k+4IL+Ja/sDsNAxc03/O1ePTr8=;
        b=ssL+38xy0NwPYwvj/Mel12wK9yutyjp7QFEJ8RIDmF+7UeEuB4oCziAjW525Y5UcFJ
         C7pJOpzY1FBVKvOZqxscQS1kE+NuZCEg57nT1EoSkL2WvE/LLm/c4IQWiYChH0D/eNFO
         SBTqzcJuwkehgUTll1RmI/h+fCJEdQzwhj/NF9syuijYz9i/rBVi9H+8PY6YfTm9Ax1e
         T5hUpP5licPqZ1kaJuEUx6Mc0MN/gr+5BHmA09rjk0f0lRRejKlrusXdPsPza2M7RD5Y
         OzW+tp0QwzeSq3HlOgFSercruyH6dBUpgBNUZXOmVwgEjgnUH4rS4Vys9rYdf1WamUgh
         UPdw==
X-Gm-Message-State: AGi0PuaHVXTvgI5UPPcxVNsieGUfJtoRXNzCNleGjHab9fxYpTkxCuJe
        9ICzh51pF/LRKFZx69GZZEMBvAjW/I+hFBV+cm8=
X-Google-Smtp-Source: APiQypJPDq8wpjjBKIt6x/ylbAMpbrgi1SSwdbSFWiJOq5dUzGXq3gnkuq27QrMa8zcYtcz1kZlXD2EkaDI40Btpuv4=
X-Received: by 2002:a54:4e0e:: with SMTP id a14mr3350237oiy.88.1585925192212;
 Fri, 03 Apr 2020 07:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.75faaf2137f4.I9e27ccc3ee3c8855fc13682592b571581925dfbd@changeid>
In-Reply-To: <iwlwifi.20200403112332.75faaf2137f4.I9e27ccc3ee3c8855fc13682592b571581925dfbd@changeid>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Fri, 3 Apr 2020 10:46:21 -0400
Message-ID: <CAPuovEJ7b36wEh7=8GQUx8dp_fx2AuQS4ivKb3tuHeP31HwyUQ@mail.gmail.com>
Subject: Re: [PATCH v5.7 7/8] iwlwifi: mvm: fix inactive TID removal return
 value usage
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 3, 2020 at 4:31 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>

I sent Johannes part of this fix weeks ago and heard nothing back. I
am far from a glory hound but something is wrong with this list if
fixes are sat on for weeks and then the fix shows up with any
acknowledgment lost. At minimum a note saying that a fix existed and
would be merged shortly would have been nice.

Mark

>
> The function iwl_mvm_remove_inactive_tids() returns bool, so we
> should just check "if (ret)", not "if (ret >= 0)" (which would
> do nothing useful here). We obviously therefore cannot use the
> return value of the function for the free_queue, we need to use
> the queue (i) we're currently dealing with instead.
>
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> index 251d6fbb1da5..56ae72debb96 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> @@ -1169,9 +1169,9 @@ static int iwl_mvm_inactivity_check(struct iwl_mvm *mvm, u8 alloc_for_sta)
>                                                    inactive_tid_bitmap,
>                                                    &unshare_queues,
>                                                    &changetid_queues);
> -               if (ret >= 0 && free_queue < 0) {
> +               if (ret && free_queue < 0) {
>                         queue_owner = sta;
> -                       free_queue = ret;
> +                       free_queue = i;
>                 }
>                 /* only unlock sta lock - we still need the queue info lock */
>                 spin_unlock_bh(&mvmsta->lock);
> --
> 2.25.1
>
