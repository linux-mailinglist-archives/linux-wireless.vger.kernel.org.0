Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8447B4627BB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 00:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhK2XJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 18:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbhK2XIm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 18:08:42 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95BC21884E
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 12:12:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 131so45767552ybc.7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKc4Hv/xhXc+0564cUYaGcAX3t4u1WnG8QuxUVJeFho=;
        b=Qhn8N5otZ9FxUEylkG/x3yYzzPxhvgTx+v8gsCTyvyeFT5oH8tl2zI9MmCRjeWKk/O
         D3kCw2caQFoROql21XVcCtW+pYdRsG8QhuyD5F9W8knajUmG/vXe1bouNm+fik81d2gE
         9LbQg+sLU3K2yhefiSJqB6z+pxvAMo1X9uXtcUN6rJMocAQ1sZsro76WsREmpl41ftsJ
         DrhB/w06s9g08c82q0gk/oc9Ue7m22Gf1aa5kz9sz+/lJZoGruRP5Xw3fIzloWYOyF1M
         iZvpgrgFNWkLjTa4aus2ZJYmMzH2tQg6znJbbXDAaytaTPTdaZ0TTi1vxxOsxuKeNhMm
         dgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKc4Hv/xhXc+0564cUYaGcAX3t4u1WnG8QuxUVJeFho=;
        b=6cDDbhdBsxK4vOQ+GINcSHSoGxzK0O8FqPEQcPkyg15qkMmzTxuI/c39v13KffQfS/
         DMtoyc0q+YZaXSpCkYLauVTrtWXzBFc2eTI9mzZCYts+T0jXTaT74MPQxV24v2YiRnMq
         tLnQU2CTLS0t55mIc2agZSwXp7QJeQZm0Sp5idhBbThvRivHxetMOiFoSGeqcXCYI4oQ
         O4Ae0ZFb8wE97dfeGgDD9TUymMu0lWDDFnzkYcJs/tct/iYk2sW+e7t0zc/C2z2u/8Qx
         J2TQ1ZU2xDRopUCeGuZO12CM+E7ENsf3qcRxzB3HE0lSv6JwtmrNuxunE/tmSNZwCcVz
         vx+A==
X-Gm-Message-State: AOAM530mL0/VMKvL+EsiwC1S/jDUXGc2SOqhIUePSO6uiL+Mf3tOSWIp
        ku35O4idYbe5s+Dn+TdHQ7AcGuZQYLxpq6RsPTBVLg==
X-Google-Smtp-Source: ABdhPJxbtAOMAGgl2wv5YL8kaq2EGVngwPJMpslrlJayLTK3zQIq5SWoPcBegclT1J7iYRQr4g+70iyQabbrcVT2Ujw=
X-Received: by 2002:a25:99c7:: with SMTP id q7mr8230818ybo.642.1638216740845;
 Mon, 29 Nov 2021 12:12:20 -0800 (PST)
MIME-Version: 1.0
References: <348f1b9c-f1b4-8a01-873f-9749f1070808@redhat.com>
In-Reply-To: <348f1b9c-f1b4-8a01-873f-9749f1070808@redhat.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Nov 2021 15:12:05 -0500
Message-ID: <CAJCQCtStsk8_a+p819g4WJf0hJAokJiMeEeouaMpw8ar5_PH8g@mail.gmail.com>
Subject: Re: iwlwifi suspicous RCU usage warnings with kernel 5.15 and 5.16-rc3
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 29, 2021 at 7:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Since kernel 5.15 (IIRC) I've been getting a suspicous RCU usage warning
> from the iwlwifi driver when running a kernel with checks for this enabled.
>
> Note this is the 2nd or 3th time this happens now, can we please get
> some CI checks for these (assuming there is some iwlwifi CI already) ?

I mentioned it back in October ...
https://lore.kernel.org/linux-wireless/CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com/

And it's still happening with 5.16-rc3 out today.

[    9.305038] iwlwifi 0000:00:14.3: loaded firmware version
46.6b541b68.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
[    9.546976] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x318


--
Chris Murphy
