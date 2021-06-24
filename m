Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262703B377F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhFXUCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhFXUCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 16:02:04 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF3C061574
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 12:59:43 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id k9so2666418uaq.6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgYUf2UwozZW1M1F4AiO1MTGhl6u3fFGhBU4S5iL+m8=;
        b=eRLfY5gFUkzk5YtmMD8YX7u2vVMYdAuLTQkrUc3NFS04g4EkTRigpAVEU4FSjnxmaI
         hoagqiFz28ZcuD7RGwYqKk3V0hmGiZRHbRH64/OcgrPsYgdKuxzBVg4wGg1HyTCZc/Sd
         R7aYcG24QxcYHYmzqpVtE014ziDUygzMKNSGxqr3vodiqPNmcmGBX5LYbbNBIfzN9jSG
         tC+pD+Ho6nhyUqHnwQpLFCOCnzM41Qf8Njl76ZSczaCmw6EyNgJJ2TktLOzHVJvnhHsj
         tILOGc776UEn4261OU7FQvZ5DnnxhUenPxW6sXVIOxMBiq8quRNKbyUAGOkDDx4AFTQr
         HRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgYUf2UwozZW1M1F4AiO1MTGhl6u3fFGhBU4S5iL+m8=;
        b=gi3QkcE1leZF5gi3M1oKbCrngFNpYNmK6uh8lDregq8obf4dBRCkjdVcSRyMg+ZHXl
         be1ZrRvhHSZ4GKhOlPLHVe8WIG+yfMD+Pc7PQSx5IaesKbZB2f8whUo9vWBPc/37sVag
         oTU4EnbSrkegdSVLyAm2PC5S2PqLD21T3nhPT9OzYEvhFmPE6KI8ocq9zC72cadTFPa3
         AbiQrLWzIpOOzv99UPpCtakbA1h7lyr62oNOscrxZoBgWaLDsBQuRa29uY0MOxTW51W/
         i8PZ9yF2BhcHt04501ebLSfWV5iF6gCQJ2peZqMjUQk8Cu7NUWRDRnj111j/Qechrjpd
         h84w==
X-Gm-Message-State: AOAM532KGjB7PGHwZyE6IAR5VwOSnoUmxUsHSHGBVqmLuwnyDsqmyeeh
        b/uf63nMiiTtzywOmy+Nlj8qR3F+XjESbl+QN+U=
X-Google-Smtp-Source: ABdhPJxYi04gjNK3LvndpwS7jEimg/Cr8CWXk9omD2gF1tgZgznEWA6kL9VaZnpnz9U+BofUFBtCy2/cHIkoiEhFeyc=
X-Received: by 2002:ab0:6009:: with SMTP id j9mr7796950ual.87.1624564782956;
 Thu, 24 Jun 2021 12:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
 <20210623141033.27475-4-emmanuel.grumbach@intel.com> <87fsx7i416.fsf@codeaurora.org>
In-Reply-To: <87fsx7i416.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 24 Jun 2021 22:59:32 +0300
Message-ID: <CANUX_P3HWWBkeHHSw+-wdQEBFNF1V+GWRDFiEerH7NhksRvOzA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iwlwifi: mvm: add vendor commands needed for iwlmei
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 24, 2021 at 8:13 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>
> > Add the vendor commands that must be used by the network manager
> > to allow proper operation of iwlmei.
> >
> > * Send information on the AP CSME is connected to
> > * Notify the userspace when roaming is forbidden
> > * Allow the userspace to require ownership
> >
> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/Kconfig    |  11 ++
> >  .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
> >  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
> >  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
> >  .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 186 ++++++++++++++++++
> >  5 files changed, 203 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > index 629aaa26a230..f91516d08b28 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > @@ -92,11 +92,22 @@ config IWLWIFI_BCAST_FILTERING
> >         If unsure, don't enable this option, as some programs might
> >         expect incoming broadcasts for their normal operations.
> >
> > +config IWLMVM_VENDOR_CMDS
> > +     bool "Enable vendor commands"
> > +     depends on IWLMVM
> > +     help
> > +       This option enables support for vendor commands, including some
> > +       that don't have their own Kconfig option. Other Kconfig options
> > +       depend on this one as well.
> > +
> > +       This is not enabled by default, if unsure, say N.
>
> Why do we need a new Kconfig option? Why not always include it in the
> compilation?

I expect 99.9% of the users to want to disable this.VENDOR_CMDS adds a
user space API and in a sense, it increases the attack surface. You
can claim that I can reuse the IWLMEI Kconfig option, which is true,
but we have other features that need VENDOR_CMDS that are not (yet)
upstream. So the idea here is that any feature that needs the
VENDOR_CMDS will select it and if none of them are enabled (for 99.9%
of the use cases), then, we would disable VENDOR_CMDS and decrease the
attack surface.

Makes sense?
