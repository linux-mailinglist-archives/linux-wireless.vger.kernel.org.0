Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CED24C2F7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgHTQJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729495AbgHTQI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 12:08:56 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F51C061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 09:08:54 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g3so1402603ybc.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtcBO8+jAJdjPjcgPPPetiAvLkqAkiE26u0ODAljGk4=;
        b=sGdCpKx9bBre+CKL3IeWnMjcmFKkAGjvHrm+g9s3WNBfIO6M1bMEMfMYX2q2gE+R0q
         A8B6ABPCB3641v7spsX3LKWQOPv3w4jQcbZB+eGz1ZtwkQrOpCDz/M5KDRm8UCGSN6W7
         cCB84WNp3wm3QhJg35gXTSGEIBNRvogJS4hG0uzT1i/n8mtYTCbg2rd9KH8++4GZHvZg
         8JKPMEy5xii/kk4DbI+m6NmSVaEW/IWUkFNGrRV6qj7FmdU6eCow36M2zCAGh0YHTAuH
         WOzgu8eOv8uM34JO2pW6W8P6tRAThLwVz4aPQqr9zyyjc5NX8fK4zeNjxo0wUclDIn8j
         Tfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtcBO8+jAJdjPjcgPPPetiAvLkqAkiE26u0ODAljGk4=;
        b=YWTP+QL9yobfOo24L3u0SmqAOpsLTMJJJ8FaJMfZwuKIcRwGX6MCzMGquGkcDxuU0E
         ztbx5gb/3EQa9bcLp9e9TUlmGZhj7AmhC/mlPaf6MD8zJpt4UzIJsnEFuLZQyBmI51la
         pvvBitDHy5RL1i0jCxkbwz8pjvYd3ldG6e+csCAC+KLTEd0L/tHMvghOk+aQVlrVNv/A
         kWEvFm7EzgCBXZR8Dz73O8F+FyIZ6GSm/c8sBjI/loSqYgeBVQZaC8lkzJYXS088eJ5Q
         0LWbWSHqWGihte/P9XPhRUNNjeih1gwwohouRshiKmsb7Lpq5GxmBWxSTN9Px178EtBK
         zw6w==
X-Gm-Message-State: AOAM533GpYZIC0ORasJSLaqNs0Jgk4aPD4/JGb1Pa/YpQgsaXzFEtk33
        hXgeMPHKgGdb4aKveaoPKWsNCXmdRmCJLRUvRsJaXVEr
X-Google-Smtp-Source: ABdhPJyvvmLABut7CYnlkKb8qqWwUv090+kmmmA/YFRwKe98AqWLtcYk2rUelQUCrNtifj3LCepNLfxaomtkTXkWAwc=
X-Received: by 2002:a5b:d12:: with SMTP id y18mr5575597ybp.400.1597939734162;
 Thu, 20 Aug 2020 09:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org> <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
In-Reply-To: <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 20 Aug 2020 21:38:41 +0530
Message-ID: <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-08-20 18:52, Krishna Chaitanya wrote:
> > On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> On 2020-08-20 17:19, Krishna Chaitanya wrote:
> ...
> >> >> I'm not really convinced that this is the right fix, but I'm no NAPI
> >> >> expert. Can anyone else help?
> >> > Calling napi_disable() twice can lead to hangs, but moving NAPI from
> >> > start/stop to
> >> > the probe isn't the right approach as the datapath is tied to
> >> > start/stop.
> >> >
> >> > Maybe check the state of NAPI before disable?
> >> >
> >> >  if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
> >> >   napi_disable(&ar->napi)
> >> > or maintain napi_state like this
> >> > https://patchwork.kernel.org/patch/10249365/
> >> it is better to use above link's patch.
> >> napi.state is controlled by napi API, it is better ath10k not know it.
> > Sure, but IMHO just canceling the async rx work should solve the issue.
> Oh no, canceling the async rx work will not solve this issue, rx worker
> ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
> the NAPI_STATE_SCHED will clear.
> The issue of this patch is because 2 thread called to hif_stop and
> NAPI_STATE_SCHED not clear.
That fix is still valid and good to have.

ndev_stop being called twice is typical scenarios (stop vs rmmod), so
 just checking the netdev_flags for IFF_UP and returning from hif_Stop
should suffice, no?
