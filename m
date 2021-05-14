Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF33802F9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 06:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhENE2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhENE2U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 00:28:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2813C061574;
        Thu, 13 May 2021 21:27:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 5so10946046qvk.0;
        Thu, 13 May 2021 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OnfsK4OFFR2kcyeH9bcZaFEi8Zf/r8bR1RTogsvth8g=;
        b=YuoFQn8ddV0UAnWcvbvcPBqjJsS48V5KpdJuia81sZPx4kUXe/moBXrLwJnbglsAKx
         sVvKVzNhD90LQ0L5nTY4y2DMdvWlJjiU5HXywF+WhYzU7lLITYRvPDygW/drJG9v52+x
         UViVMLoHvI0hXtsux/OdQPWlk85ieDFXcojheE8i53OFvTQzFBcj4wAzQcjS9gTd4hG/
         VeYqbLTp1qjZezQGufRL23dtRjLfLU65acWOmFyukCMuDac/RHmfJ5TM3vP105Th/TkS
         ol7wQyqFL5TAmaKBQVxxviGPjCPteU0OTUPvHnnokO3fEQmJ8GWID3veloRX1Zq3SHN0
         aCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OnfsK4OFFR2kcyeH9bcZaFEi8Zf/r8bR1RTogsvth8g=;
        b=Eo5OKUgMJWqEiBYDz83x5Xx0XT2xngZlXkKfgjE8Q7zrUhHtgmymZzTvzfrH+SKI7m
         R0hIBpwHv5zKPtQ2DyEdGjGmt1NXjD4Y2ZazGfY7P4oKoXeE9RoySDPhZcQd04RKazIU
         rsb0WNyDtbR2rG/emzMfbA642q1eZTepZUGBDghSObtj7NbJ8zDXb/Ao4+2myy/wgN6a
         iMJ/NjSCeXr1disaybWdOcAFcqFRK/CUl/MTXvergHJTFyFigeemBRwrXQ4zkMD6Gvui
         NfE40Mz4lPjBmWmXPSBhxDVwx4Mzh9x13xDGpjPwyyM0e+5ysFVl+woqCTSYcnK5qts9
         FD/g==
X-Gm-Message-State: AOAM530+a8CBFtAIOccen3KYWrBLdhx+XFl60/WlEiYWEfLxReBsd9/e
        768g2nvHUlbV6S/40SzjKMGpGe3LKuTHG2pCerTcmoaFh4CqA8ov
X-Google-Smtp-Source: ABdhPJyr//8durvIDvg7C3pReJJJR8TsvsXkIO62ISIGTXFoTybjDgEW5rREiQRGXRA8xt1RuGdC8c3yaNv5hY4ovGo=
X-Received: by 2002:a0c:ef42:: with SMTP id t2mr40941870qvs.48.1620966428989;
 Thu, 13 May 2021 21:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
In-Reply-To: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Fri, 14 May 2021 12:26:58 +0800
Message-ID: <CANgQ54e_AkZQNYBBf4yrGGCQ-h+AE-ynM=RVD7Nxt9tY_mFKOQ@mail.gmail.com>
Subject: Re: How does the rate adaptive mask work on Realtek WiFi driver
To:     Pkshih <pkshih@realtek.com>, Andy Huang <tehuang@realtek.com>,
        Larry.Finger@lwfinger.net, kuba@kernel.org, kvalo@codeaurora.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=E9=82=B1=E5=90=8D=E7=A2=A9 <ccchiu77@gmail.com> =E6=96=BC 2021=E5=B9=B45=
=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:35=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi guys,
>     I had a problem while verifying the ampdu tx throughput with the
> rtl8xxxu driver on RTL8188CUS module. The throughput number is
> relatively good, 39~42Mbps  TCP on 2.4GHz channel. However, the
> retransmission rate is high, it's 15% ~ 21% with rtl8xxxu driver and
> It's almost the same result with the rtl8192cu driver. I can get
> averagely 7~10% retransmission rate in the same test bed with Realtek
> vendor driver.
>
>     From the air capture, I can see the rtl8xxxu driver keep sending
> the aggregated frames in MCS7 and doesn't even fall back to lower MCS
> index in the subsequent retries. I can only see very few retried
> packets been sent with MCS0 or 6Mbps grate. On the vendor driver, I'll
> see the retried ampdu packets with MCS4 after 3 retries w/o ack from
> the receiver.
>
>     From the rate mask command issued by the h2c command, I force both
> the rtl8xxxu driver and vendor driver to use the same ratemask 0xfffff
> (MCS 0-7 and b/g rate included) and leave the arg0 as-is (mostly 0xa0)
> and I expect both drivers can do the rate adaptive thing in the same
> way, but it seems to make no difference. The rtl8xxxu driver still
> sends the packets with highest MCS.
>
>     Can anyone tell me what should I expect the rate adaptive to work
> with the rate mask 0xfffff and 0xf0000? Does the 0xf0000 means that it
> will pick up a tx rate only between nrate MCS4 to MCS7? I need a base
> line so that I can judge it's simply a rate mask problem or maybe the
> h2c command is not written correctly. Please kindly suggest what I
> should do next. Thanks
>
> The rtl8188cus vendor driver I tested is here (It can be compiled with
> kernel 5.12+)
> https://github.com/mschiu77/rtl8188cus_vendor/
>
> Chris

Gentle ping. Any suggestions would be appreciated.

Chris
