Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1F473CE9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 07:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhLNGDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 01:03:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59816
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhLNGDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 01:03:52 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E62440192
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 06:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639461831;
        bh=WL9VjCk8gKCYRWvjUSeuXNo5gRaGFyR5coWlvQxj9dA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qZnVIlhvkExRsJxNOmi4AalgKQofSs20yrkPleGuW4/gcM0+WSgo9u4OXrnzxFNP+
         6tDLd71TPJulci6BRXWEbw7lpLTqXn/pXkyqHsgbE7cQLFnRM6bFCjbK1UfpGhW3X0
         Ijo2bqrq4QiEolNJWuG9FzPxiIN3f5KRHhtzUTEDUp2gFpoARhMqVYhXhJsVLkRIVC
         755dkTLv91YaFoWjX90w39nKuE2IiVO3NnYfHe5tabvIU+ETKDrs5U31kkDIPGCrxt
         GA7O1WLC9daYwXAxV49dcfBckEi3qm0Qvzoqk7YSPn3etuzqCwGIwAGOmmz8kXkozS
         73+auCkkFECow==
Received: by mail-oo1-f69.google.com with SMTP id g1-20020a4ab801000000b002c63cddd8f6so12258219oop.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 22:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WL9VjCk8gKCYRWvjUSeuXNo5gRaGFyR5coWlvQxj9dA=;
        b=IMVwOVhRs4fYteEcd4NNYQRc1Oaa3ZaOpna+xtF0FpfuanKO4LUVLquB0kF/ruyIq0
         0WypxWJNp5OW+chxYAwdJASvbi/YpxOldre0bLUmlKLwyZslWjY/IVa/Zf2dN39uHY+C
         emMoS0ZO/pnhOtcWYm0vwEquOLRXQppdF8MyZq9opVU6nGWU23U4hZbXnEYYbesTIBq0
         xtRf1IpcAYwWbxkVilX7Nx10UVESRFKaRa/POKhYKPq0xXYKdDkT1f+zSOCPCOWuAfPq
         VP8QT08iny29lNRNgyzecXQnDcUslNdclEhNMIRvmhVLR/6yQ+OkgGV2sW7Gb63BXvHo
         4o4Q==
X-Gm-Message-State: AOAM532jPjs6dDHgE5t2t2fZuzS/5wfybwH85QNuUeQmEwByI9aFPSpE
        2ywBqdBap6NCMvvPVP8SzJ1W2oCCRIsaq7/i+wc3EqVefFgJGhaM+rEJppanX8T5YLawnfVRoQ2
        h938NHIzXs2+RMdJkVYMnoJQ9Rda1H2qDwN7IaSsOcdA2qMwzzIyeUtcqc9pd
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr32514047oib.98.1639461830404;
        Mon, 13 Dec 2021 22:03:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQiPiixM9RSi+NUpDxh/HasGW+Yuj7rq8GDGN14tmgm1XRQz4dAKdr2QTqTZbeWJcCpX/bCTqbYZQUKb2+2KA=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr32514034oib.98.1639461830205;
 Mon, 13 Dec 2021 22:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20211214053302.242222-1-kai.heng.feng@canonical.com> <874k7bkabi.fsf@codeaurora.org>
In-Reply-To: <874k7bkabi.fsf@codeaurora.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 14 Dec 2021 14:03:39 +0800
Message-ID: <CAAd53p5KRufZLSCX6Z5LwiyD87rPy=+34Lnh1VNQfVT_i6tRvg@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
To:     Kalle Valo <kvalo@kernel.org>
Cc:     tony0620emma@gmail.com, pkshih@realtek.com, jhp@endlessos.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Po-Hao Huang <phhuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 14, 2021 at 1:46 PM Kalle Valo <kvalo@kernel.org> wrote:
>
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>
> > Many Intel based platforms face system random freeze after commit
> > 9e2fd29864c5 ("rtw88: add napi support").
> >
> > The commit itself shouldn't be the culprit. My guess is that the 8821CE
> > only leaves ASPM L1 for a short period when IRQ is raised. Since IRQ is
> > masked during NAPI polling, the PCIe link stays at L1 and makes RX DMA
> > extremely slow. Eventually the RX ring becomes messed up:
> > [ 1133.194697] rtw_8821ce 0000:02:00.0: pci bus timeout, check dma status
> >
> > Since the 8821CE hardware may fail to leave ASPM L1, manually do it in
> > the driver to resolve the issue.
> >
> > Fixes: 9e2fd29864c5 ("rtw88: add napi support")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215131
> > BugLink: https://bugs.launchpad.net/bugs/1927808
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> [...]
>
> >  static bool rtw_disable_msi;
> >  static bool rtw_pci_disable_aspm;
> > +static int rtw_rx_aspm = -1;
> >  module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
> >  module_param_named(disable_aspm, rtw_pci_disable_aspm, bool, 0644);
> > +module_param_named(rx_aspm, rtw_rx_aspm, int, 0444);
> >  MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
> >  MODULE_PARM_DESC(disable_aspm, "Set Y to disable PCI ASPM support");
> > +MODULE_PARM_DESC(rx_aspm, "Use PCIe ASPM for RX (0=disable, 1=enable, -1=default)")
>
> We already have disable_aspm parameter, why do we need yet another one?
> There's a high bar for new module parameters.

It's a good way for (un)affected users to try out different settings.
But yes the parameter isn't necessary. Let me send another version without it.

Kai-Heng

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
