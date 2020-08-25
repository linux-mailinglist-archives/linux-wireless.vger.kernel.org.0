Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF137251FFF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 21:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYTat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYTap (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 15:30:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAACC061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 12:30:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so15182795ljk.6
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91WGW73GFVXZx1UKeprndgfgbUo/dF8OQ0jSHfku+Fs=;
        b=oMyRKWufRNneJLathiUhhHb8GFwnpMOFPdZUhrb+Lp5nOIEH2I70wf70XzWPL2p86h
         tV6zGVWvQ5UqlBWAD/mIdJIH3c6cdzff4Zwg3yszC7MGUw0wSw6mKfhIBUoaoSPDVtdf
         62c56twYXvz6zL2YlbNYGyGie1UQatqVYornI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91WGW73GFVXZx1UKeprndgfgbUo/dF8OQ0jSHfku+Fs=;
        b=EprISlcXRgaYB20SBLNOFskM7CS1FCyoc1FblbcknvDhonsLE9jgEPvJbREA5dXTtf
         ItV0Ul2v0Kuua5E9DGkkI3WuihUJzd10OzBXjkArHzjn+KkNks/GyVePFWghCAuc1NdI
         YjqLDw292nJBuLsK0Xz/wIVirAfpHPKta6vZEE7qeRhkSdid7vZ/Ud+7BqaeNITol0+i
         KfmEBfB2TEbT10CykQxWHFTqvzrfIorw/GKXFcaWi7j70am7uBPsvDDoOeKNZ6jvPYRW
         fZ1kozq0NiaACK2ZOoR6AUjLxP+aizgBXFFvdAbSnLZEgR3MyHZPmhaDV3eqPM7paMss
         xICQ==
X-Gm-Message-State: AOAM533ukUGiVvhoXuADpu5so4ovpxh4jEWVuy0fKaV0dXL0QgdMq7pr
        FnANcbt6sYCYfuPj419e/qzM/vbaRbECGA==
X-Google-Smtp-Source: ABdhPJzkpMGedHOvXOGW661Mx/LHbrroQL5pykgU/JSTlm0g2wp6rfEqjWfqdX8WT0J287awgEd3aw==
X-Received: by 2002:a2e:9196:: with SMTP id f22mr5584864ljg.435.1598383843085;
        Tue, 25 Aug 2020 12:30:43 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id l13sm3256568lfk.18.2020.08.25.12.30.41
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 12:30:41 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id c15so7068510lfi.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 12:30:41 -0700 (PDT)
X-Received: by 2002:a19:8c3:: with SMTP id 186mr5686629lfi.61.1598383840878;
 Tue, 25 Aug 2020 12:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200825153829.38043-1-luzmaximilian@gmail.com>
In-Reply-To: <20200825153829.38043-1-luzmaximilian@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Aug 2020 12:30:28 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPoxdMb4b5d0Ayv=JFACHcq7EXub14pJtJfcCV2di95Rg@mail.gmail.com>
Message-ID: <CA+ASDXPoxdMb4b5d0Ayv=JFACHcq7EXub14pJtJfcCV2di95Rg@mail.gmail.com>
Subject: Re: [PATCH net] mwifiex: Increase AES key storage size to 256 bits
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kaloyan Nikolov <konik98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Aug 25, 2020 at 8:38 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Following commit e18696786548 ("mwifiex: Prevent memory corruption
> handling keys") the mwifiex driver fails to authenticate with certain
> networks, specifically networks with 256 bit keys, and repeatedly asks
> for the password. The kernel log repeats the following lines (id and
> bssid redacted):
>
>     mwifiex_pcie 0000:01:00.0: info: trying to associate to '<id>' bssid <bssid>
>     mwifiex_pcie 0000:01:00.0: info: associated to bssid <bssid> successfully
>     mwifiex_pcie 0000:01:00.0: crypto keys added
>     mwifiex_pcie 0000:01:00.0: info: successfully disconnected from <bssid>: reason code 3
>
> Tracking down this problem lead to the overflow check introduced by the
> aforementioned commit into mwifiex_ret_802_11_key_material_v2(). This
> check fails on networks with 256 bit keys due to the current storage
> size for AES keys in struct mwifiex_aes_param being only 128 bit.
>
> To fix this issue, increase the storage size for AES keys to 256 bit.
>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reported-by: Kaloyan Nikolov <konik98@gmail.com>
> Tested-by: Kaloyan Nikolov <konik98@gmail.com>

Thanks for this! I just happened to notice this breakage here, as we
just merged the relevant -stable updates. I think it would be wise to
get the Fixes tag Dan noted, when Kalle lands this.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Also, while technically the regressing commit (e18696786548 ("mwifiex:
Prevent memory corruption handling keys")) was fixing a potential
overflow, the encasing command structure (struct host_cmd_ds_command)
is a union of a ton of other command layouts, and likely had plenty of
padding at the end, which would at least explain why non-malicious
scenarios weren't problematic pre-commit-e18696786548. It's also not
clear to me how much the network can directly determine this length,
but I suppose that's beside the point now -- it's good to fix both of
these bugs.

Regards,
Brian
