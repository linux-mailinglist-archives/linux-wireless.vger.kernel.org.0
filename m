Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775721EF34
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGNLYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 07:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNLYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 07:24:21 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22258C061755
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2020 04:24:21 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t187so3577521vke.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2020 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfFiSsJtAfTP+kMjmRxEbX332rW3E4gmbsUJfmyX7h4=;
        b=VtYIfyJTejPdYREikuawnxvA5j5ayvVz5SnUINKsjzorRn7W6qT1NypKMV0E1oUyXA
         B/jEDiFpIpwK/1+wf+4Fjp6AIwbCGIxE8rydMvATNll3P34pF2zeuXAEwrq58/M4pL/q
         wGvASyhgPeaJBGi7K4y70jbSn/Jccc3V/P6E6Pu6Gfm8lw8ytjmAz6AP3C91YCakeigv
         FDtL8ta0i7x4COB4neXeZiHj+DTkfwb76NAwhKLw8ytpIniU0yICFihmlUzFL/SiFmqA
         PiDPKBP8TYAWP3mnM5YZJ7XJ8yyMdbcIebSR7mRqorLSf2G9CI42Zjg3DIzgI63gq5UK
         PUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfFiSsJtAfTP+kMjmRxEbX332rW3E4gmbsUJfmyX7h4=;
        b=R8aoPONYRAIIZzvamGs02V3uyFxXVOeNbagT4EUz+uZpK7KzGa15OmuF3UmJmyqoHz
         VtCFBb+XSdyzAq0kIb0DjilVP5zWfukVwCiY+ONWB+Jf5rt3PXpXwkEPKkHReUBE6jeE
         NSIAkn6jtFsMdpULefUyC05X6TS7Eu0+WfR8oBeRgPfgjmXGMTb/tcj3epTek77jord1
         J2QBD7F1a/Dt2d6o66IP+Gq1CCldUWVQDQkv8Ezded0nQymljSUqGpA/Hn1JZI1ozjoc
         R7LeTF6TAH55x2yrfR9PxQfHH5XTJvXbOQJAIvzyuuw3D2kao9zpnzqamNFjqoJ7xMjR
         zxCg==
X-Gm-Message-State: AOAM531nnM/lZZPWzBCC4olH/6TGYQPZoF7wTAsaxTuYSyIgwRqtjaL6
        kvAnczZhWBNfnC6N6aiWnOsp8WWXPI3MQUTktjVQTw==
X-Google-Smtp-Source: ABdhPJxwseHtfoTYpsVbBoyHUHwjpr1DmLApji1oWJ5No5j5zfB+jK3UzXZuHu1TdoF9GBHvCvIK1vDnDv/NsIWr4bM=
X-Received: by 2002:a1f:dc06:: with SMTP id t6mr3337279vkg.10.1594725860317;
 Tue, 14 Jul 2020 04:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <87imeqcwbt.fsf@tynnyri.adurom.net> <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it>
 <877dv6cthg.fsf@tynnyri.adurom.net>
In-Reply-To: <877dv6cthg.fsf@tynnyri.adurom.net>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Tue, 14 Jul 2020 14:24:08 +0300
Message-ID: <CANUX_P3jbE__37Osw2PEZzrwjkxdZXUn-Kb+AmMRUyAAjp+8cQ@mail.gmail.com>
Subject: Re: [PATCH v2] iwlwifi: Make some Killer Wireless-AC 1550 cards work again
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it> writes:
>
> > Fix the regression introduced by commit c8685937d07f ("iwlwifi: move
> > pu devices to new table") by adding the ids and the configurations of
> > two missing Killer 1550 cards in order to configure and let them work
> > correctly again (following the new table convention).
> > Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2",
> > https://bugzilla.kernel.org/show_bug.cgi?id=208141).
> >
> > Fixes: c8685937d07f ("iwlwifi: move pu devices to new table")
> > Signed-off-by: Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
>
> Luca, should I take this to v5.8?

Luca is OOO, but I guess you should, yes.

Thanks.
