Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685A82FBFFA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392077AbhASTYc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 14:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390516AbhASTMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 14:12:23 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15FC061573
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:11:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 36so9352132otp.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjMT7wy0I3au65qf7KQzj6Sfm9enWQl80vCDCkue1vM=;
        b=CkzEjvUreKeWVVae5rT3JvRCspan9QX3/eg9rdt2OiUoCCDs7bz0HuW5RMeks5o7Bv
         eRrznhzjXOO29PXC8V8/LLSMRVUIfyUDYXGLZkciPj1qvlWw+XfkBQ5ji4bLwR+hgRd2
         D0KP8bBemEWuajX/igR1eIdySrhTYsjkgHm/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjMT7wy0I3au65qf7KQzj6Sfm9enWQl80vCDCkue1vM=;
        b=HGka1tCXb9ZnYxWEXN+apH5n0EyrbfJxPNhe76qrZQA7rs3vt7P/a21MiUTYl6Gftz
         v/UDRhSBLx+FZTgvNdr8xmubWU1C30GjRFNQeQj8apUXZgqSmLEA8+LZCAylCbg5f6kP
         KCjh6eI27PNyF7hrL32ws9njX6N7IViBlXFpJtZDtL07gbWT1ZVMa0UHPCE2RozebjeA
         IyK7JhYgmf8T9AuUsu8HaPyDbjfA22dnuHHSEvBTJqb92Gc3PUekUFCSFAIHf9XiIBnk
         fSRPNg4X5mB1CtkEBluVbRvg8/W7BImmKNkREsnITXJ626z5Dzivt3m/RY56UfVxW3VU
         kuhA==
X-Gm-Message-State: AOAM5325xXFC5P1mEb9bNzx9orMP0MCUbNhlUvQD7pDSUYz1EEO+L/UM
        YajJwH5GWHXWYZBCwlgshxQYRiG9hr8WyA==
X-Google-Smtp-Source: ABdhPJxzfrA+SraGK4UQFT1fVCfrMSmKtK1RbTnP6d4dhKpTyRfCkkMXPbaA5zxTemve01kBrdAzNw==
X-Received: by 2002:a05:6830:1e7b:: with SMTP id m27mr2168142otr.317.1611083500990;
        Tue, 19 Jan 2021 11:11:40 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id p22sm1226949oth.38.2021.01.19.11.11.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:11:39 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id x13so20860920oto.8
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:11:39 -0800 (PST)
X-Received: by 2002:a9d:744a:: with SMTP id p10mr4554986otk.203.1611083499205;
 Tue, 19 Jan 2021 11:11:39 -0800 (PST)
MIME-Version: 1.0
References: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Jan 2021 11:11:27 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
Message-ID: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
Subject: Re: [PATCH] marvell/mwifiex: replace one-element array with
 flexible-array member.
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jan 15, 2021 at 1:39 AM Jiapeng Zhong
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the follow coccicheck warnings:
>
> ./drivers/net/wireless/marvell/mwifiex/fw.h: WARNING use flexible-array
> member instead(https://www.kernel.org/doc/html/latest/process/
> deprecated.html#zero-length-and-one-element-arrays)
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Past experience unfortunately requires me to ask: did you test your
changes? I understand that's a mostly legit warning, and a good
deprecation notice, but that doesn't mean this is the right fix. One
probably should instead audit the usage sites to see if they *are*
already making proper sizeof (or other) comparisons, and if not, fix
those first. And if any sites *are* doing correct sizeof computations
using the existing struct layouts, then you are probably breaking
them.

Or if you have audited the usage of these structs, it's nice to make a
small explanation of why this is correct, so I (and other readers)
don't have to ask these questions :)

Regards,
Brian
