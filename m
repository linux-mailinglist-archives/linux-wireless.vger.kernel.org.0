Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4529A19D91C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390796AbgDCO2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 10:28:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33467 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCO2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 10:28:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 22so7479300otf.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7nS7Oiy8X1JKqiU2L0rkxt9WpTyOOxLbBYQb6uDNXE=;
        b=p1FwhAAz/UBgUXlsum6hh55lYRF7pOEqINw01NVJhb5a+d3V5RjJJCSuulfDuKEDdF
         kLybNt39wVEhW3LaBXxUoIq6+ZsmQlw53XPzxqLl1Ako+nd5f5+2UuaacJcdgKJ11NG+
         ACO8crdDy+7FCTiUHUDmI9Ojimq6JS5rXV6F6nfg8ioDy/CGaXoS0J3gCkUGAYtx0arD
         I/OatDpkl/QcjVirC2CEvSpmPn8hSaJAvA5SqaTZCegmx6zlp8WwwFI8RH21kWjCt9p1
         8vf6qjZPYpMzpTo6S9gc4aCRs0bvlmAecXdTOxZnv9eByOxsTBZKFB/QDBYCNdDTGhWf
         cCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7nS7Oiy8X1JKqiU2L0rkxt9WpTyOOxLbBYQb6uDNXE=;
        b=BMxSvSHA/drCONhnUmWKjt8rZnTo0U6N/ZTIDsw9PX+mbdWUV83d+AJ2UmxYNkX2Gs
         I1bCs4ZTW5eCW01TgGEbzFcqVlkwaJlyNp3rbpHuv5P00yUnnOPzB8WZ0soYoL5RUvps
         YbdyrkDQErPt46TK63aJSJbPKFI7h2q6NatGGuNF5482RxPX+eDXddxXI3ZH8Dkbxp4J
         tS2S6you41n64i14ds0Y7l0Y6Ri8QFdNaC+7Pcwlersz5FmnEPC9Do3amwkr2q1UjUCp
         qpDGQgRhGsJJkn0o5f7njmXTo/VH+3R6e+DcmeW8yqJQKvK+71zX7/PiWpnYqV0s3yfx
         8isg==
X-Gm-Message-State: AGi0PuZZxij0Wen+LmuGUMgnog9xwN8Uh6H6u1qM/yeUsDJOE3l5p6NF
        o12FgzqGJSrtq8hcIr5Bn3Wr1hVtLMVbJmYWARFiwSZY
X-Google-Smtp-Source: APiQypIdJUyiFu/Galg34LXGHflXQk8n6/yTk5q+mzraxs0VnhrQPjLCcWaXMDrtqEMH/VT4mGQB0BUrUTfiTXcPd+A=
X-Received: by 2002:a9d:264a:: with SMTP id a68mr6434128otb.176.1585924129151;
 Fri, 03 Apr 2020 07:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
In-Reply-To: <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Fri, 3 Apr 2020 10:28:37 -0400
Message-ID: <CAPuovE+_jWPjesRZ0GFk0zjf-jLmyyqOGxwyZGcawg5DL9CbXg@mail.gmail.com>
Subject: Re: [PATCH v5.7 8/8] iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue()
 under RCU
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I was looking into this as part of
https://bugzilla.kernel.org/show_bug.cgi?id=206971 and had a similar
fix in flight. My concern was that queue_owner being used outside of
the RCU might be an issue as now you have no guaranty that the
eventual use of sta->txq[tid] in iwl_mvm_free_inactive_queue() is
going to be valid. The only way to work around this is instead of
storing queue_owner, store mvmtxq = iwl_mvm_txq_from_tid(sta, i), then
adjust iwl_mvm_free_inactive_queue(), iwl_mvm_disable_txq() and
whatnot to take struct iwl_mvm_txq * instead of struct ieee80211_sta
*. If you open the bug you will see the latest version of my work as
the attached patch. I am not an RCU expert so I am curious to hear
your thoughts.


On Fri, Apr 3, 2020 at 4:31 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> iwl_mvm_free_inactive_queue() will sleep in synchronize_net() under
> some circumstances, so don't call it under RCU. There doesn't appear
> to be a need for RCU protection around this particular call.
>
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> index 56ae72debb96..9ca433fdf634 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> @@ -1184,17 +1184,15 @@ static int iwl_mvm_inactivity_check(struct iwl_mvm *mvm, u8 alloc_for_sta)
>         for_each_set_bit(i, &changetid_queues, IWL_MAX_HW_QUEUES)
>                 iwl_mvm_change_queue_tid(mvm, i);
>
> +       rcu_read_unlock();
> +
>         if (free_queue >= 0 && alloc_for_sta != IWL_MVM_INVALID_STA) {
>                 ret = iwl_mvm_free_inactive_queue(mvm, free_queue, queue_owner,
>                                                   alloc_for_sta);
> -               if (ret) {
> -                       rcu_read_unlock();
> +               if (ret)
>                         return ret;
> -               }
>         }
>
> -       rcu_read_unlock();
> -
>         return free_queue;
>  }
>
> --
> 2.25.1
>
