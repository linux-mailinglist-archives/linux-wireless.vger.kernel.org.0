Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30E9188EBF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQUM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 16:12:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35888 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 16:12:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id 39so7692404otu.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2020 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fPgMyW5Jt+c0+F6TUl02/0AGD5HdboCszQEqvt8UjFk=;
        b=S9kwU1DsLDsqZOlGSBxA9AIA0m4DmkJ2nBWButt1a+o6c5sFhyxj4E1UFunrZA2m40
         nfr7dYbexprjMitRcvjGEh16WprDbQnfYjBUPi4tdDLcywMhZfaALphtpeeRgdYXidXk
         e2Tx/qGE8/jGVE/dnmN3Y6CWCCnBNnxucJZNn4D1aQNf4hpl8bGsrmUheRhE2vXW+NZq
         nNgHGeMOd2mU7J4z94CqF5tFhDeYwFKr+NRCugYadnfOFS3Zs293qBjfGbSTR/TnKBjF
         E71DNtg7hFbncrL/MKi9I03N8TQ8wYkuaK4WjcEU6oSvvG8Kjh49skbNvbuSsUltoJ7U
         GY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fPgMyW5Jt+c0+F6TUl02/0AGD5HdboCszQEqvt8UjFk=;
        b=q14gxvCXwxq/SO1GjOEnmiB5odBz3W9n5K12uOOCCkvaBA3dVXO8WvPX7bpiTyJrwF
         FQftpxaL9XGKZoYH7n5pNSx8GhnacNJF95X7p3lsxZQLTRL/i/BrSZXixdhxBztGsSKK
         u0UKXoL+vuK0ahevphtTmpzs+3WWvc+9+zKVkrnm1f5Tvt+nRnukrRN0kXq5Kog++Jhr
         Zok6bnjPxc+T4z2VHElchM7drHy6aQRa1UiaABAxAvszQEdR5nLfamvYSxlSkrIDuCA0
         5/gyIO5UWtxFtqxg/yBKHgoWVtqmc7CbJLzNOj15WRNgvHb+fcSH7KVUf2key1QA37l2
         Rq7A==
X-Gm-Message-State: ANhLgQ1QrAVY7pzsLggknR97FFb9KpPrK8uWZTCDXACm56lkspwI+dD0
        hJ8gyCnOufiQma3p3yz7dh9zt5cl4cTggXDaC54=
X-Google-Smtp-Source: ADFU+vvjmfO0I0PYpiNAISC9JNMQj0HY8wlW7CWu9sG0OKlWEG5sME83x71mGYz4MSz2ducT+VbGGC8bENyWNJxvUQY=
X-Received: by 2002:a9d:4f0:: with SMTP id 103mr877830otm.336.1584475946921;
 Tue, 17 Mar 2020 13:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200313030545.9184-1-mark.asselstine@windriver.com>
In-Reply-To: <20200313030545.9184-1-mark.asselstine@windriver.com>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Tue, 17 Mar 2020 16:12:15 -0400
Message-ID: <CAPuovEJWzAvCwWQq0E5MACxo=1Dk5pK4YyjH+d0W-bspAMJJQA@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: set 'free_queue' to the loop variable, not a
 meaningless bool
To:     johannes.berg@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        luciano.coelho@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca,

This is my first time sending a fix for iwlwifi and I haven't seen any
feedback or seen the code merged. Should I have sent this somewhere
else?

Thanks,
Mark

On Thu, Mar 12, 2020 at 11:06 PM Mark Asselstine
<mark.asselstine@windriver.com> wrote:
>
> From: Mark Asselstine <asselsm@gmail.com>
>
> The loop variable 'i' is passed to iwl_mvm_remove_inactive_tids() as
> the queue number to operate on. iwl_mvm_remove_inactive_tids()
> operates on that queue number then returns true if the queue can be
> reused, the returned bool is stored in 'ret'. We do not want to set
> 'free_queue' to the returned bool stored in 'ret' but rather the loop
> variable, so we are actually operating on the right queue through the
> rest of iwl_mvm_inactivity_check() and have it return a proper queue
> number.
>
> Signed-off-by: Mark Asselstine <asselsm@gmail.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> index 9db2555518aa..2fcaf779649a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> @@ -1166,7 +1166,7 @@ static int iwl_mvm_inactivity_check(struct iwl_mvm *mvm, u8 alloc_for_sta)
>                                                    &changetid_queues);
>                 if (ret >= 0 && free_queue < 0) {
>                         queue_owner = sta;
> -                       free_queue = ret;
> +                       free_queue = i;
>                 }
>                 /* only unlock sta lock - we still need the queue info lock */
>                 spin_unlock_bh(&mvmsta->lock);
> --
> 2.20.1
>
