Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA5383A65
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhEQQtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbhEQQt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 12:49:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C6C0560D7;
        Mon, 17 May 2021 09:29:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e14so6574278ils.12;
        Mon, 17 May 2021 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f8prtgombTmd78g0v9dgtzdTUlZdr2SiZd0lMWRSNk=;
        b=ukBthsuaQauYuLXuTbaKTuOd3/K0xb/RF2whWm03lx9qUFwgjF69EcWdgKcJH0ypyY
         dYfY5lfsJMHh7kHwXyUSduta5aWMKhHc3XCdHWcTt17x8tIEcH+DfN4RJ2DU6YNql8FZ
         n5SvtCqXGSQCf3FB9AIY9DVOAWYMRLyVmtOS9CkegUC0NsmX+sFDm6uzPgvpl5xA0NnI
         2iYnq+f56ZFU0IodwxKUIxrjM1QFh61KUjsq5pk+chzSXxqv4IGtTIe0eQsrrfrnppIC
         k15xJyrCs/4dNGqxauP0RiFuhE9/+xoiGtXhFsUrDWYI+pT/SZE94z3R5l3mwv0JV0cU
         x5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f8prtgombTmd78g0v9dgtzdTUlZdr2SiZd0lMWRSNk=;
        b=Vm1GDySHwA3C6ANT1D8sRX5sI+3v6+yLDqWFSwqwSdXeE35lMNYUT8fnzflfVOALAt
         ca6IdB6T+3iDVar0qU3+vJLeh5CNgCBUpkssWFsB2ZWb2+0Nd6tgmScfZAgDoPpDE/2x
         mezLwAruXUPf/OdoP3tp8qVMDF7G7LAmDkfK4sDYikTZNklJ6fDxBBXR/BaqoYdYLnpC
         YV5jPvbI9WGy84e+4jYeGPkfvYN/V9gGVr/u4hkiXhlBiLbZxWvGt+Hit+Y2/OtZnv1R
         +1iIXLV7su31R+9aeZFcnGcN3Jj0x9+pUy1jPUJ8CVNPpWXc2j/CgWFhYk4n0txU1/0x
         aoRA==
X-Gm-Message-State: AOAM533uSr8AIpQ+rBAqydxFy9YiZ6890Qxg8JTsq2rb6x2uQnGWod0k
        GQ5HbtFNJS7kvIecViV7ckRYn6k7ygDPexikTwI=
X-Google-Smtp-Source: ABdhPJwJQDl+CfRLFQy5xJz/dMwfNIgt4CM+w5JCvOUJiH2Giug8UZIZ179NbBcdHpPOEXBgIuiW/MTdOzM6SzjnN8E=
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr449775ilt.127.1621268975011;
 Mon, 17 May 2021 09:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210517050141.61488-1-shenyang39@huawei.com> <20210517050141.61488-6-shenyang39@huawei.com>
In-Reply-To: <20210517050141.61488-6-shenyang39@huawei.com>
From:   Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Mon, 17 May 2021 20:30:49 +0400
Message-ID: <CA++WF2PDC9cXoZ3-C=Y+aeDK-qPTk4rc6VKwH3iQBr7Hu8cDTQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] net: intel: ipw2x00: Fix wrong function name in comments
To:     Yang Shen <shenyang39@huawei.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        wireless <linux-wireless@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 17 May 2021 at 12:14, Yang Shen <shenyang39@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:5359: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6533: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6565: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Looks fine, thanks!

Stanislav.
