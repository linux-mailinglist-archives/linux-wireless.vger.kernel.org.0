Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5343FE331
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbhIATmR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbhIATmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 15:42:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC56C061764
        for <linux-wireless@vger.kernel.org>; Wed,  1 Sep 2021 12:41:14 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c79so757041oib.11
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U/AS3qDXHpFaWx+ZJcvPtCtF+rnLf3zIt76sJF5yEGk=;
        b=NkNxlikZUUM6eXRgFVXiPeq6YkDYPECZQBwyf07ee/u96b9SCgqsgH97bH+bHt18HA
         aO6QTOY7TXnpAhL/AkGdB1ESkCA75/NRsntfNVmdAQVFYrOiMDVqdEXPUqvmabYQ0bu4
         6fwk/eoEvHwqNAicmJQ7QKlfvMHN/EqkPATrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U/AS3qDXHpFaWx+ZJcvPtCtF+rnLf3zIt76sJF5yEGk=;
        b=NSxFU0KtchDOEp7+VfN3LOi9pZ5MHlVWPoWflV7aVJB3RVWn3BFqzEbgFMrGWqHkKT
         lULIkYvN1wSujZnZvY5L2xvan7c38B4XNWix+Acr0j0jR0BQMQOdOEpgMrmR7KbF2Kcw
         BLPhtqwufxYvLeNuknvJy1IVFM+6knnzVuXJmqk282eAzS5zNv3hT8AHII24mKzvXyk0
         ERuyGd6L26Y/uTUhVuahcEPs6+92Rr8qh0QiltlwTuPKfXsFxTzu6nixMZ8Lp/3wFR/F
         PR7ReAyEhkSYTzOrlPiL4Tpb2Np8eNNAbZAZifNSAPyBmIbvrDoX3Z59ExCSkm3qGrrS
         t8Cg==
X-Gm-Message-State: AOAM533QNl0uBGs2rJDO2ajgOxg03cJPE6ht+o6FnEL9wlPnHyG6IEkB
        5yJIhCtRfGuoHXv+PkXslRiseQaxHKpHiQ==
X-Google-Smtp-Source: ABdhPJwuM8p5dP/1TraniPFknfUb9vUjpOzRNIj/BEjsd1N+A+RozGXQcz60CZjPCRuXhklHgFl5Vg==
X-Received: by 2002:aca:c288:: with SMTP id s130mr975217oif.54.1630525273036;
        Wed, 01 Sep 2021 12:41:13 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id m20sm89688oiw.46.2021.09.01.12.41.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 12:41:10 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q39so743674oiw.12
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 12:41:10 -0700 (PDT)
X-Received: by 2002:aca:5344:: with SMTP id h65mr992912oib.117.1630525269918;
 Wed, 01 Sep 2021 12:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210830123704.221494-1-verdre@v0yd.nl> <20210830123704.221494-2-verdre@v0yd.nl>
In-Reply-To: <20210830123704.221494-2-verdre@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 1 Sep 2021 12:40:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com>
Message-ID: <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: Use non-posted PCI register writes
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 30, 2021 at 5:37 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
>
> On the 88W8897 card it's very important the TX ring write pointer is
> updated correctly to its new value before setting the TX ready
> interrupt, otherwise the firmware appears to crash (probably because
> it's trying to DMA-read from the wrong place).
>
> Since PCI uses "posted writes" when writing to a register, it's not
> guaranteed that a write will happen immediately. That means the pointer
> might be outdated when setting the TX ready interrupt, leading to
> firmware crashes especially when ASPM L1 and L1 substates are enabled
> (because of the higher link latency, the write will probably take
> longer).
>
> So fix those firmware crashes by always forcing non-posted writes. We do
> that by simply reading back the register after writing it, just as a lot
> of other drivers do.
>
> There are two reproducers that are fixed with this patch:
>
> 1) During rx/tx traffic and with ASPM L1 substates enabled (the enabled
> substates are platform dependent), the firmware crashes and eventually a
> command timeout appears in the logs. That crash is fixed by using a
> non-posted write in mwifiex_pcie_send_data().
>
> 2) When sending lots of commands to the card, waking it up from sleep in
> very quick intervals, the firmware eventually crashes. That crash
> appears to be fixed by some other non-posted write included here.
>
> Signed-off-by: Jonas Dre=C3=9Fler <verdre@v0yd.nl>

This might be good for many cases, but please read this commit:

https://git.kernel.org/linus/062e008a6e83e7c4da7df0a9c6aefdbc849e2bb3
mwifiex: pcie: use posted write to wake up firmware

It's very much intentional that this is a posted write in some cases.

Without ensuring this doesn't regress, NAK from me.

Brian
