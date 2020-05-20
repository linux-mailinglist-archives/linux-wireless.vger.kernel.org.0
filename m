Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1833B1DB32A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETM2I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETM2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:28:00 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF7C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 05:28:00 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id w188so711997vkf.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTSpuOn+eOiS5F2tW+aa6K9KavJrkW2XpL8GASe/3EQ=;
        b=ZJZF0s47BiUZI+F85ZQ/KV58LF7ji2q+KFLvBJ2XZ302vzJCNJ039/dPO3bHj1ZPtB
         pJKW5aCXa6blw8zRD8SIaIxTyryOtTan8+Pl+wAHkJ0Xo6b2oDG5O7v5ekwC24jn2y9d
         nd/b1j13PoD/2ellIblaAg0pBrXGjTZhmT6T6EeuA2yoRwAxcetwnm4SPnngAcdPgf/i
         MZ3uKXhnpc5ImfzZ3Bp25del2ZqvsrFYMn6WvtwHa6fPvJEP/UPFKK8bQ4DdO/ZKeftt
         cCqpvHOL5WEMx54c5VCPYSDcjGaOJzqiMJ1tcYhOrtu/XiNs6ti+vowlOzWD2c+cTFrQ
         D2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTSpuOn+eOiS5F2tW+aa6K9KavJrkW2XpL8GASe/3EQ=;
        b=QT2h9rKYJxcHKqjNnhvxndWquy6/dEgmXyY/p5/FNdHGHKBt8J30u9rUosp+5Y+F7B
         u9Ys3GwhyeVKVENYmfRzgajQDmvffNfcryjPVG6h49IAXgoWal9RT6BbZKUMpa/QXzEw
         O6SygzqXb2KiTQksfSY129WM73p9Mf1U4WuA1h2QPKe6siqVTuEX7R0wjncOf5VsOSAe
         RFGwijOKwthGiy16Dt+2wGSdcxMdcyRNFnXIJzB4hJVK0I8x4V42yJrv4kYkqrLhD8ig
         XXw9wfiteG+fVWE24PMqjP+auY1t9mLfeOW7rpEHdPh1eJcxu4Rk0MXjiyPnAAJyXFSK
         Z9BQ==
X-Gm-Message-State: AOAM5318E2B3S2sTBZA5mWPkFSmjO8OUP0BFz5ZiYCahGlDQy7Loc5S0
        DGk4Y1oMK3bEuWeG5dXGEdnVUNrEj36hqf+A18Q=
X-Google-Smtp-Source: ABdhPJwi6gO3x2zPlKACBRNtmyz9MZkVP44O+i7txJYBnIyawpLq8rhQvBeFmSWczOcWADb1Cg+F6WhAQyq9T6RAsVg=
X-Received: by 2002:ac5:c92c:: with SMTP id u12mr3515908vkl.93.1589977679364;
 Wed, 20 May 2020 05:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <9122588d-683a-936e-1305-c34124e6702c@nextfour.com>
In-Reply-To: <9122588d-683a-936e-1305-c34124e6702c@nextfour.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 20 May 2020 15:27:50 +0300
Message-ID: <CANUX_P1q22J6ONRqTCDwwEMtmbGbCmS=C1WK6Zz0OqG_v2qcSA@mail.gmail.com>
Subject: Re: iwlwifi firmware loading problems, rk3399
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Hi,
>
> We have custom made, Rockchip rk3399 based board with a standard M.2
> socket for wifi/bt card.
>
> We have tried man different cards, like Intel 9260 and Intel AX200, but
> are experiencing problems while loading the firmware.
>
>    Failed to load firmware chunk!
>
> etc. I have a little debugged and the problem seems that the interrupts
> that acknowledges the load to proceed, is not coming, randomly.
> I have tried many firmwares. Do you have any pointers where to look next?

I guess you need to debug your board :)
The interrupt is not coming, then.. there isn't much the driver can do.

>
> Thanks,
> Mika
>
