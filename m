Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43262254CC0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgH0SRQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0SRP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 14:17:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58AC061232
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 11:17:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so4136000pfb.6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soeX4jUjZZZTlITUKQ5pcDSGwYI4DnugTTOq/SNIIW8=;
        b=bwQqo9mUQZ78SYazcavWuleirnFV8qiGz4YuuoqdE7eRmQ2tSTM68j++Et8BP9GqJr
         syUBg3Kcg7Q9OgEbN+FAt7t4lGugKe8nLewk7Ughsm9qm/jfjiWsNzpi5+yadtKvRkgD
         9dkaxNNv0wKsa2fEmJKGhE8yW74+BwsjHwwBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soeX4jUjZZZTlITUKQ5pcDSGwYI4DnugTTOq/SNIIW8=;
        b=nA4/QPpB6UMPYDMVbdmFM1Hm66DGZMM4iwYepIXdI9BGWK53nzNMQqPTEjRWp2uRIm
         N5WNw5zExKNYeIcxkxsyP4GIqqd28HUdO9Av2b86Rbp6+Vv+ZIdkznetxK5TQ6C9C4Rl
         2eC/FxH39myS0Kjb1D/tfZ7QIfln9e9utttaXB4qvMi/6f7UMEieNv3DjHW49JngQGBk
         tdXxwnNnBJev2lohJ7JOI0Mc0oSTs8eEwryVPblS8a0LHAf8VHfPTVxXs1cCoGwTyYM6
         Z02YJu91fuprkawBjh3v17yRNP9tOIq3E7xTNvLfRO4qnGRPHVqMEC+FXd9UPryYk2V9
         ig4g==
X-Gm-Message-State: AOAM533fBGbnUmqLdCobwkZ18TZCzFzu+U6nSYGeOGQWZrYcXCXcf5kK
        58BHLmkcuDPcGZeJAX7ydqTLHA==
X-Google-Smtp-Source: ABdhPJxQHJQlJtOpVK3cF7+baxJUjdkujQ9/OnK25Ibx+RalSDrSK6OVeL6QkvgSiagIIwSSDUbj5Q==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr11532811plr.47.1598552234468;
        Thu, 27 Aug 2020 11:17:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e29sm3441674pfj.92.2020.08.27.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:17:13 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:17:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Allen Pais <allen.cryptic@gmail.com>, kuba@kernel.org,
        jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        chunkeey@googlemail.com, Larry.Finger@lwfinger.net,
        stas.yakovlev@gmail.com, helmut.schaa@googlemail.com,
        pkshih@realtek.com, yhchuang@realtek.com, dsd@gentoo.org,
        kune@deine-taler.de, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [05/16] atmel: convert tasklets to use new tasklet_setup() API
Message-ID: <202008271115.A54F087@keescook>
References: <20200817090637.26887-6-allen.cryptic@gmail.com>
 <20200827132320.B70A9C433AD@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827132320.B70A9C433AD@smtp.codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 27, 2020 at 01:23:20PM +0000, Kalle Valo wrote:
> Allen Pais <allen.cryptic@gmail.com> wrote:
> 
> > From: Allen Pais <allen.lkml@gmail.com>
> > 
> > In preparation for unconditionally passing the
> > struct tasklet_struct pointer to all tasklet
> > callbacks, switch to using the new tasklet_setup()
> > and from_tasklet() to pass the tasklet pointer explicitly
> > and remove .data field.
> > 
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> 
> 11 patches applied to wireless-drivers-next.git, thanks.
> 
> a36f50e5b937 atmel: convert tasklets to use new tasklet_setup() API
> fc6722301428 b43legacy: convert tasklets to use new tasklet_setup() API
> 427a06beb072 brcmsmac: convert tasklets to use new tasklet_setup() API
> ae6cf59f80f7 ipw2x00: convert tasklets to use new tasklet_setup() API
> b81b9d372ac8 iwlegacy: convert tasklets to use new tasklet_setup() API
> 7433c9690318 intersil: convert tasklets to use new tasklet_setup() API
> 51c41aa93ef5 mwl8k: convert tasklets to use new tasklet_setup() API
> aff8e8d02ec2 qtnfmac: convert tasklets to use new tasklet_setup() API
> a0d6ea9b6e1c rt2x00: convert tasklets to use new tasklet_setup() API
> d3ccc14dfe95 rtlwifi/rtw88: convert tasklets to use new tasklet_setup() API
> 26721b02466e zd1211rw: convert tasklets to use new tasklet_setup() API
> 
> -- 
> https://patchwork.kernel.org/patch/11717451/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

FWIW, I don't think a revert is needed here to wait for the from_tasket()
-> container_from() API to land since from_tasklet() is already being
used by other trees. Let's just get this done so we can get closer to
ripping out the old tasklet API. We'll have to do a treewide
from_timer(), from_tasklet() -> container_from() anyway...

-- 
Kees Cook
