Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7C9377BFF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 07:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEJGAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJGAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 02:00:12 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0AC061573;
        Sun,  9 May 2021 22:59:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g13so11168719qts.4;
        Sun, 09 May 2021 22:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DDUM4uhodbXU4PkgWo8QL4xSQNvJe1bwoVgkMGaWFog=;
        b=dFq5a/A14xy2bGT0ntemK9eVNaeXRYvtmE4FfY7NaglHPOu6EzpqJf2I/vfuqMjsQL
         +2ASzyQBHtM/uCRJ2xGTDUr0S4ObdN57aIWmMJXVMzUCyaT5diuSJ3RKo1ZIdVoHxGsh
         PkNO/MUd1SeHCmZwzlNgO6b13iut6M/Hidy1e+TrobeDceWEco1uvQ+cvmmZAKsG/bfr
         F3SgHgOHdls+ytyrI4A+8GB7YcKH9exI1IuYjkiTqa+iMEQbsNAmMqaxlihasfWujj2y
         YcyXYnVbt1/+KcSsxVM5cxUZfdm4/bG6P/ORRIijQNDP1NktSQzOCZoBihhKqSvIGl5R
         QgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DDUM4uhodbXU4PkgWo8QL4xSQNvJe1bwoVgkMGaWFog=;
        b=NiLpMTkRLO9nOU9Ys75ao6QU72lFYPUZNdiBNevpfuOTuGbRW+yCDDCTSrahS9Oneg
         g+9gms8fY4LCkjYx67FmkklLfMZbQR2j/Jqt6XriaAk5IICNZdgZZEUjk71ffoPDnRaH
         3FVVKdDBMvzHRqeNWNFivao17OMEVBRWckF3ZbHLWzeOyMipxO5R2dO6otuIyTK9jVH7
         /iI+nAz6AlNYIphVQUNCfD9D/WkSOwwDVtgKgiB3CEviMmooGdQK6S6EjFoIGpHq/M29
         p8BLKYujIJf7S74sz5JNeZKjINQyJE9EEsbjzuWI3KaHTia3tzgj4EjK18v1onZ8H1cP
         jGTQ==
X-Gm-Message-State: AOAM532z4IJ/cWxAe8qwwx+ssTN9XDSlJvifjc+vU5ZWMRcJhhsKhyKn
        59qix5H4XAI252fLGDODvJaNdNaYqQ0krQSj6Lg=
X-Google-Smtp-Source: ABdhPJwFRKUs4xTSjfaEXwXUuPNdHMX2XxEQcQHs0V20n1egXs2b7LON4uN3q3Rt0WcYtxNyQN9damVPzUJ9TBxeIFY=
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr21168710qtf.228.1620626347565;
 Sun, 09 May 2021 22:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANgQ54cG8FYTTBtrCc=e6aTsFQzfshM=Mco6J5BdtQ7XyH_Byg@mail.gmail.com>
In-Reply-To: <CANgQ54cG8FYTTBtrCc=e6aTsFQzfshM=Mco6J5BdtQ7XyH_Byg@mail.gmail.com>
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Mon, 10 May 2021 13:58:56 +0800
Message-ID: <CANgQ54f4QAMmGE-swSQoXHoZQNSX166afqTaCoKW-DN=0jdihg@mail.gmail.com>
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
=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=
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
> Chris
