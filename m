Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814611E66E4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404825AbgE1PzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404819AbgE1PzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 11:55:20 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA88C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 08:55:20 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b62so268115ybh.8
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEmAX536cEKY0/3WcgFeUZpRguWTw2eheRjri6Y8rOM=;
        b=heafo/ydFo5dc8vjHOTX8YSQ7sK2rjhJY4tXG8ZH2P2NP/sJIWKzQ5Ptpis835p8LR
         gRZ0/38aFQd7EU2+aTcJG2obAITuLyrttJSQUMNDw/CkIii1j6nyCe4PwSYdU1dA//Su
         lDvPBmd3nKQbPGadZT2nkIExgpWwliIvVwIYk2VfmddAJ0tAfE0mAFNFcMYZRJVY/jiM
         fjZlJgJAF0uounWB7JXzhPll8UB36R2QE/M4AL2vnXCZqzl0l7In9vz4r9HXGEeF1vgn
         gvivH3bxVgf0RruN/4edh2qW4qDZ36uq5zZOtrFytBp7wDK46hQWYefJhKMJ0LgtVPKI
         ikfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEmAX536cEKY0/3WcgFeUZpRguWTw2eheRjri6Y8rOM=;
        b=hW/imiL309ntVih1RPrmAr0DQvVHPCubCURj+EJ1oxrpvr7kD78JAMo5+ZFC7mxW8m
         Tyq1lfMR5LVnZJpOh7dqdDtO1f5J77OtwdWxO7PtHRfCPeB0AqrD6sSYVUWPpYMoUXXP
         0eApNWfO1FFjoSVIDJ1Xqyhl6/JdUM4RCq4zk9VMCfYk9WH6EiXXzu4cocP5bnPC/YUJ
         4HBye4QZK87P5NBFq3WPtnZ8fyqoKv1WwS9L5fGKt8CFpD7Fw1dy/cwrNcZNv6d2CCdr
         Em2HCPzg4T2GcQWACPuLWG4hetk2V0KAwC46HSG6EkFLj+ejCfYnkOO2kDwkcu18fBeo
         ToBA==
X-Gm-Message-State: AOAM533bAn6tdYH8RdbpEXoqkiSGwWNpqkEXix1wFT8utMMdbLK3efsk
        RwjerUvitdtA2HokIl0BHdHGfSC6FfdMPoaGpcdS20SU
X-Google-Smtp-Source: ABdhPJykyD8QYJbGjvkzNRs6tqExsKyGzHcA9VJVZjssyq6iOwDE7sD0hpqZt6gRssWPewjx3pC2PVPNkTA3cEdwwVk=
X-Received: by 2002:a25:4cc4:: with SMTP id z187mr6577880yba.274.1590681319118;
 Thu, 28 May 2020 08:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKWzfAeK96iL_snfJ1jGnaWq0B5odZtC5o1_ccB8ECV9w@mail.gmail.com>
 <20200527184830.GA1164846@mwanda>
In-Reply-To: <20200527184830.GA1164846@mwanda>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 28 May 2020 08:55:07 -0700
Message-ID: <CANn89iJBBvMgGo930cxvhmk_dAt1Jh-AzyiiZQ_reKwzcaO38g@mail.gmail.com>
Subject: Re: [PATCH v3] airo: Fix read overflows sending packets
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>,
        Security Officers <security@kernel.org>,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 27, 2020 at 11:48 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
> skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
> overflow.
>
> The fix is to pad skb->data to at least ETH_ZLEN bytes.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Hu Jiahui <kirin.say@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: remove an unnecessary if statement
>     increment the ->tx_dropped count on failure
>     fix found two more instances of the same bug.
>     fix typo in the "Cc: <stable@vger.kernel.org>" tag
> v3: I had thought that skb_padto() updated skb->len so that it would
>     always be more than ETH_ZLEN meaning that we could delete the checks
>     for smaller values:  "len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;"
>     But I was wrong and those are still required.
>
>  drivers/net/wireless/cisco/airo.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
