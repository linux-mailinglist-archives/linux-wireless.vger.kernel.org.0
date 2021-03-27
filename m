Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00BF34B5F7
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 11:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhC0KMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0KMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 06:12:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288DC0613B1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Mar 2021 03:12:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id 19so7180246ilj.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 Mar 2021 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Khb50nVWzVB65AHyk94DSVniLT5CUCxvJJA1TeAX1/U=;
        b=MzeV1axlp+KDRssrIaT/oUOBRP6fd69cDFlS6qIZKO1DGQc+bHPavjaJhyv8gPSLGp
         a5o+b1uHFILx1RKq2K3QNxwn3uDdbC2M8Vdlhxv5rp9RPKw2MjW7xPXTIAh9Gl9ZAwWL
         qwNrtWfRD/jUmlKMKOfUbmpuqpmuk7OWDkAnmfkAqtdYpoO5dS0wcIpUK9dpX9JqktWK
         WAG4pBYygqUtq1h79ptIUoPA1f+RVxttNFrIwTz6S3BLU0qNBgOlMp7NTwh0a80gk157
         cJn3icjv6oKdu1Eh+ireTkPb9ReNnpM+h0fHZXpBXz79rdjjq5Uw/tX3YWTP3hC4R5R/
         VbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Khb50nVWzVB65AHyk94DSVniLT5CUCxvJJA1TeAX1/U=;
        b=mRUrDSuCTP4DhbXW/4MNG4fzRakRrveW9eHV7pxbGScl4AfySfOgVt7xoVXZ4v4g9U
         ohebCUvBksNHV3Pj+dYRd9stfIiGME1e0+0YboNnFcVbW7NpmaHt6ZA21sB0qrgBpM90
         G/DET88uF4kHoHJ3x7m+xASCaRX/79TJZSb0hhb9DiqKa/I5vu4CT/nUTQB/ntsnD1ZL
         DkmgZCRb7SUcqJHzkQEs0D9qY/0yQUG2JHG5/WGqCPH7N9bJbRxkwxya5Ar+Tykawu+G
         U7U9K8CLgCiw1EAJYQOCyPisj40qY0KGDXN4WQkaWc3BrYfWWFqax57OYIeSueYcHEF2
         dZtw==
X-Gm-Message-State: AOAM533AvSPjf9dQVAfW9xz8ER7dNZzuZW9JTdp8CJtcFigGsswBhzua
        7wV9lHOAYVtpFfrXlc6T4N1Ha4Sf6O16lekLAJtMpz01S5zLgQ==
X-Google-Smtp-Source: ABdhPJx/D38m2jbBqPKfPaqGIEaGFdkGtC7iPPzsz91b8+KHMwjNAD+mi35w/cQyULx32E5RecqcdGQou4zKEDJkceM=
X-Received: by 2002:a92:444e:: with SMTP id a14mr13897956ilm.215.1616839971767;
 Sat, 27 Mar 2021 03:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210326105723.211843-1-luca@coelho.fi>
In-Reply-To: <20210326105723.211843-1-luca@coelho.fi>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 27 Mar 2021 11:12:15 +0100
Message-ID: <CA+icZUW51Z4=EfnJ1o0p6RE6y++aMTvON2k_yh1z8sT5KVv_Cw@mail.gmail.com>
Subject: Re: [PATCH v2 for v5.12 0/7] iwlwifi: fixes intended for v5.12
 2021-03-26 v2
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 26, 2021 at 11:58 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Luca Coelho <luciano.coelho@intel.com>
>
> Hi,
>
> This is the v2 of the first patchset with fixes for v5.12.  This new version
> removes the Change-Id tags that mistakenly got out.
>
> The changes are:
>
> * A few locking fixes;
> * Fix a workaround for devices of the 22000 family;
> * Fix the position of a bit in the regulatory capabilities;
> * Add support to some devices that were missing.
>
> As usual, I'm pushing this to a pending branch, for kbuild bot.  And
> since these are fixes for the rc series, please take them directly to
> wireless-drivers.git, as we agreed.  I'll assign them to you.
>

Thanks for the updated patchset v2.

Is it possible to have v2 in <iwlwifi.git#iwlwifi-fixes> without the
by-accident-added "Change-Id:" tags as in [1].
For easy fetching.

Thanks.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git/log/?h=iwlwifi-sent-for-review-2021-03-26

>
>
> Gregory Greenman (1):
>   mvm: rfi: don't lock mvm->mutex when sending config command
>
> Johannes Berg (3):
>   iwlwifi: pcie: properly set LTR workarounds on 22000 devices
>   iwlwifi: fw: fix notification wait locking
>   iwlwifi: mvm: fix beacon protection checks
>
> Luca Coelho (2):
>   iwlwifi: fix 11ax disabled bit in the regulatory capability flags
>   iwlwifi: pcie: add support for So-F devices
>
> Matt Chen (1):
>   iwlwifi: add support for Qu with AX201 device
>
>  .../wireless/intel/iwlwifi/fw/notif-wait.c    | 10 +++---
>  .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
>  .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +-
>  .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |  6 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 17 ++++++---
>  .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 31 +---------------
>  .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  3 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 27 +++++++++++++-
>  .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 35 +++++++++++++++++++
>  10 files changed, 90 insertions(+), 49 deletions(-)
>
> --
> 2.31.0
>
