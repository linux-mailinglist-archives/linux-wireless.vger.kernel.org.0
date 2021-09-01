Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF033FE2B4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 21:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbhIATCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbhIATCO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 15:02:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B9C061760
        for <linux-wireless@vger.kernel.org>; Wed,  1 Sep 2021 12:01:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq28so1095227lfb.7
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npd1RU7mbNsF3k0GeBkr9d4yP6Ob5CEAADTVG3CYCjw=;
        b=ErHaIpxZiEMxxjypsttdmUORwYq4vP1VZ+xYSjVl8afEmUE0mZp3Aj9x4LVzPgegFp
         QxCWY5+Gxwtt2L2qth2RgEkh1nozrNfG4UGJESfbueNOy10Bzrii0P8RVC60ibu3uR99
         Ri6W/fH6hsL0OtQOBkjpL0U0EcWE6CxP3PMa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npd1RU7mbNsF3k0GeBkr9d4yP6Ob5CEAADTVG3CYCjw=;
        b=L/1eM1xhC87EsBpEyzxIJjBFsxZT+7wCkaND3eB13wtZDZKPw/MkP2AP3kI9ara5L+
         oRQ/q2waL7jKzIFOFgPGgYNso/Muwjys33lfqKbPr+6KgTPgpby8KN7oeEEDJ9hqSm4C
         bbpycWZsDtd/OUpjZZ4kTJQU9eUxPnFGONe4qzJGzcChfHYSS0gvWcU+bM+MNpd7UQf0
         wLgjjtJ52ViYwzEZ3BM+Y3WojF+tvOv12kZr/JnjyUu28tvr5nqsrf6Q82Ncbrwr4ol+
         suEhMGXiV0rRRXADc5Y8T06Ax/4BI07nnEqyyvAMEvXYmuIrGPR9ZDz5g9VyFCtM9PfN
         QjdA==
X-Gm-Message-State: AOAM532gPcziELwzdxhJLlb6N2F0Ke49mA88lcGRvzJMTtyQyWGGme1j
        TYmDQPHuhs/5Re4kRtPEd56rueqFaHOIX+Ut
X-Google-Smtp-Source: ABdhPJyQf5yx6NAwHaYLImtHRjVsfd67Ehgqij+wLHV/QWTAAcsZ2VmadbeRf/MvbFyTGQCtQjecqg==
X-Received: by 2002:ac2:5689:: with SMTP id 9mr621374lfr.397.1630522874317;
        Wed, 01 Sep 2021 12:01:14 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w5sm36275lfq.80.2021.09.01.12.01.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 12:01:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y6so801341lje.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 12:01:13 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr888035ljw.465.1630522873162;
 Wed, 01 Sep 2021 12:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210831203727.3852294-1-kuba@kernel.org>
In-Reply-To: <20210831203727.3852294-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 12:00:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjB_zBwZ+WR9LOpvgjvaQn=cqryoKigod8QnZs=iYGEhA@mail.gmail.com>
Message-ID: <CAHk-=wjB_zBwZ+WR9LOpvgjvaQn=cqryoKigod8QnZs=iYGEhA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v5.15
To:     Jakub Kicinski <kuba@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 31, 2021 at 1:37 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> No conflicts at the time of writing. There were conflicts with
> char-misc but I believe Greg dropped the commits in question.

Hmm. I already merged this earlier, but didn't notice a new warning on
my desktop:

  RTNL: assertion failed at net/wireless/reg.c (4025)
  WARNING: CPU: 60 PID: 1720 at net/wireless/reg.c:4025
regulatory_set_wiphy_regd_sync+0x7f/0x90 [cfg80211]
  Call Trace:
   iwl_mvm_init_mcc+0x170/0x190 [iwlmvm]
   iwl_op_mode_mvm_start+0x824/0xa60 [iwlmvm]
   iwl_opmode_register+0xd0/0x130 [iwlwifi]
   init_module+0x23/0x1000 [iwlmvm]

and

  RTNL: assertion failed at net/wireless/reg.c (3106)
  WARNING: CPU: 60 PID: 1720 at net/wireless/reg.c:3106
reg_process_self_managed_hint+0x26c/0x280 [cfg80211]
  Call Trace:
   regulatory_set_wiphy_regd_sync+0x3a/0x90 [cfg80211]
   iwl_mvm_init_mcc+0x170/0x190 [iwlmvm]
   iwl_op_mode_mvm_start+0x824/0xa60 [iwlmvm]
   iwl_opmode_register+0xd0/0x130 [iwlwifi]
   init_module+0x23/0x1000 [iwlmvm]

and

  RTNL: assertion failed at net/wireless/core.c (84)
  WARNING: CPU: 60 PID: 1720 at net/wireless/core.c:84
wiphy_idx_to_wiphy+0x97/0xd0 [cfg80211]
  Call Trace:
   nl80211_common_reg_change_event+0xf9/0x1e0 [cfg80211]
   reg_process_self_managed_hint+0x23d/0x280 [cfg80211]
   regulatory_set_wiphy_regd_sync+0x3a/0x90 [cfg80211]
   iwl_mvm_init_mcc+0x170/0x190 [iwlmvm]
   iwl_op_mode_mvm_start+0x824/0xa60 [iwlmvm]
   iwl_opmode_register+0xd0/0x130 [iwlwifi]
   init_module+0x23/0x1000 [iwlmvm]

and

  RTNL: assertion failed at net/wireless/core.c (61)
  WARNING: CPU: 60 PID: 1720 at net/wireless/core.c:61
wiphy_idx_to_wiphy+0xbf/0xd0 [cfg80211]
  Call Trace:
   nl80211_common_reg_change_event+0xf9/0x1e0 [cfg80211]
   reg_process_self_managed_hint+0x23d/0x280 [cfg80211]
   regulatory_set_wiphy_regd_sync+0x3a/0x90 [cfg80211]
   iwl_mvm_init_mcc+0x170/0x190 [iwlmvm]
   iwl_op_mode_mvm_start+0x824/0xa60 [iwlmvm]
   iwl_opmode_register+0xd0/0x130 [iwlwifi]
   init_module+0x23/0x1000 [iwlmvm]

They all seem to have that same issue, and it looks like the fix would
be to get the RTN lock in iwl_mvm_init_mcc(), but I didn't really look
into it very much.

This is on my desktop, and I actually don't _use_ the wireless on this
machine. I assume it still works despite the warnings, but they should
get fixed.

I *don't* see these warnings on my laptop where I actually use
wireless, but that one uses ath10k_pci, so it seems this is purely a
iwlwifi issue.

I can't be the only one that sees this. Hmm?

                 Linus
