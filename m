Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15E3A387E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFKAUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFKAUm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 20:20:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEEC061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 17:18:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so1559963otl.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fVbGkzDMbWH/xzjd9fVHiPChuwdtXQFDYbGkUbQ+LM=;
        b=NAcNxoZoGKx25E1SGTp14Ho7XpwdCNkwzT1GSk14egrMTvsNx/jUPKkUBmBJawp24D
         7VQiJylG3YqtKPydCOA42iU7b1pipt1zXZi8k2TGwaTK3rl90JR0Uq2NZLrLLRx8nVGR
         Xrtno2MSBL6+95zqvtXHNipz+4HmVNbF6xw8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fVbGkzDMbWH/xzjd9fVHiPChuwdtXQFDYbGkUbQ+LM=;
        b=O/MW8/MhYFfCi4xR4gGySPeleJoiO/ZEYvFIZ+njxd25P513D3vOLGbaK2ZEG48M4Z
         KGXRahOfnDKU5rMKI2xvQAPOeIEQ7ubf0dZspRorsow3e3uVtU077YcAP4bimr7iQH7l
         x0Ny4cEbwdGnljlZhyFidLx+4/RoYI8QwdSmmGqul7+7edVfplUj9jtXASXRLIM9ydUA
         xFdIrWueNgWs2ozAui4Gv0o7e3moA67EAw8Wf1QnnzGZoK22vPVtaWoIdgHZfCDu4vuC
         Z9F0fNi0E45pUxqbecPQX7kV7o6FxQhGOjf8XNqgU1QEr/lpTl+PWzqxoT0nNL5L+ayC
         S85A==
X-Gm-Message-State: AOAM532gcHxZeQDqmJ7uQPCz+NqgmreGW/vNE7VVunk3DfGO5KGNx63F
        kb0t+0Vd54Qhfec6SmSkHR1FpmGyU5Y9Aw==
X-Google-Smtp-Source: ABdhPJwjvx49XCxvpTTha7+bYzkB2gRabxqsLrzMbXTQLJJAaA/qB1fNIDPK00sHrhRLlh3m4TU+yA==
X-Received: by 2002:a05:6830:2370:: with SMTP id r16mr748789oth.188.1623370724907;
        Thu, 10 Jun 2021 17:18:44 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id v82sm885789oia.27.2021.06.10.17.18.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 17:18:44 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so1505255otk.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 17:18:43 -0700 (PDT)
X-Received: by 2002:a05:6830:168a:: with SMTP id k10mr734314otr.203.1623370723322;
 Thu, 10 Jun 2021 17:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210515024227.2159311-1-briannorris@chromium.org>
In-Reply-To: <20210515024227.2159311-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Jun 2021 17:18:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMDtWpZ-xrymmq51j4TjPT-NXs61-7q=sn090BoJu9qDg@mail.gmail.com>
Message-ID: <CA+ASDXMDtWpZ-xrymmq51j4TjPT-NXs61-7q=sn090BoJu9qDg@mail.gmail.com>
Subject: Re: [PATCH 5.13] mwifiex: bring down link before deleting interface
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        stable <stable@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>, dave@bewaar.me,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 14, 2021 at 7:45 PM Brian Norris <briannorris@chromium.org> wrote:
>
> We can deadlock when rmmod'ing the driver or going through firmware
> reset, because the cfg80211_unregister_wdev() has to bring down the link
> for us, ... which then grab the same wiphy lock.
...
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-wireless/98392296-40ee-6300-369c-32e16cff3725@gmail.com/
> Link: https://lore.kernel.org/linux-wireless/ab4d00ce52f32bd8e45ad0448a44737e@bewaar.me/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reported-by: dave@bewaar.me
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Ping - is this going to get merged? It's a 5.12 regression, and we
have multiple people complaining about it (and they tested the fix
too!).

Thanks,
Brian
