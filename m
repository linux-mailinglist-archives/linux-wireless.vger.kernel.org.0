Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DE389AE8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 03:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhETBaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 21:30:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D69C061574;
        Wed, 19 May 2021 18:28:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s12so2481986qta.3;
        Wed, 19 May 2021 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KepwKSoYma0dg9U0/mBOP8MmCRfubuuYSK9aM8Nmlh0=;
        b=FWd23Em3TRRJerAxlCpbjkxiSjpxTGbiO/sKBokUK9I4NbtBXCSAi8aDcNndCmYouo
         /NEkcTCH0g3bzKhccq8fFq0zypIXxk0NX9qhJxDe9mSPnzIMU8mHyOyuNLIvQIrF2pYc
         ImMI7ZLyBO6GnLsExVPiblAPPZZIvsYY460UVB6wqiWydFcSLpC4LoHmxKfQYi1JcTOa
         mAq1GjOgd40AXR3C4evz2nc0guZWCanKnKqugo7GyHAZ9By3OUujAi+nb+mntOulO+fD
         R3SMSWNnJ1G6v2y7S1kWHpGSeL40vVL1p0EuuY5zrav0F4Dt1U9D2odExfTas4NpjkDP
         inOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KepwKSoYma0dg9U0/mBOP8MmCRfubuuYSK9aM8Nmlh0=;
        b=K/rsYIMlMPSWZ95VgYyMSyD33drsWyBC4hJkMP5cu7siNHhaGQR+SPswzgRcS1MAvm
         4FftHo8e01bqD/Toqb+J5KmUYX0a94YwIXewSxdVNUhCN+1a0ggwG+KCWhbr/DeS09Af
         wNQYByq32NqA3mbbaqCShmtrWEFdtF3+yT3wFwIiyxpH4cKpE7ahW+NKskWyWgH0oDhs
         Bzabkb9t3d1bBTzsjzN98wUVbyjxNbcu/1P2hMnDdkFgubXdjD0HaBbMNn4zeiNXREQR
         C0R0gvM0ngsFZHM8+dTpScuOfFTUEAMGNQZMDVvVcivdA0aOnfhWLSV+kxHj/4tGf4Yg
         Yuxg==
X-Gm-Message-State: AOAM530+3K4ofF3IL7F9GAh8p6m8PHSzcmcHvsymxzgGDq8b6/7UgWln
        qY93pgjWk8lH0tpLbwvfVEARhfmNGQkaj1mgqBq9BgW8481A8A==
X-Google-Smtp-Source: ABdhPJxRu1lCzqPxh1XA/RSLS/eQz16qc1M2MC1nRj8K/zwf6TzAegxlzm+m0Jl5X4ko1ioF+FRx7jbbRYTwfDVcieQ=
X-Received: by 2002:a05:622a:341:: with SMTP id r1mr2634942qtw.307.1621474137387;
 Wed, 19 May 2021 18:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
 <89da58fc162b46558d60495110fcf75f@realtek.com>
In-Reply-To: <89da58fc162b46558d60495110fcf75f@realtek.com>
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Thu, 20 May 2021 09:28:46 +0800
Message-ID: <CANgQ54cKA5N1h1kMgS52N1acrp+pJzV3e+8vd61miSS0_VVD7Q@mail.gmail.com>
Subject: Re: How does the rate adaptive mask work on Realtek WiFi driver
To:     Pkshih <pkshih@realtek.com>
Cc:     Andy Huang <tehuang@realtek.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8814=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> > -----Original Message-----
> > From: =E9=82=B1=E5=90=8D=E7=A2=A9 [mailto:ccchiu77@gmail.com]
> > Sent: Monday, May 10, 2021 4:36 PM
> > To: Pkshih; Andy Huang; Larry.Finger@lwfinger.net; kuba@kernel.org; kva=
lo@codeaurora.org; Reto
> > Schneider; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: How does the rate adaptive mask work on Realtek WiFi driver
> >
> > Hi guys,
> >     I had a problem while verifying the ampdu tx throughput with the
> > rtl8xxxu driver on RTL8188CUS module. The throughput number is
> > relatively good, 39~42Mbps  TCP on 2.4GHz channel. However, the
> > retransmission rate is high, it's 15% ~ 21% with rtl8xxxu driver and
> > It's almost the same result with the rtl8192cu driver. I can get
> > averagely 7~10% retransmission rate in the same test bed with Realtek
> > vendor driver.
> >
> >     From the air capture, I can see the rtl8xxxu driver keep sending
> > the aggregated frames in MCS7 and doesn't even fall back to lower MCS
> > index in the subsequent retries. I can only see very few retried
> > packets been sent with MCS0 or 6Mbps grate. On the vendor driver, I'll
> > see the retried ampdu packets with MCS4 after 3 retries w/o ack from
> > the receiver.
> >
> >     From the rate mask command issued by the h2c command, I force both
> > the rtl8xxxu driver and vendor driver to use the same ratemask 0xfffff
> > (MCS 0-7 and b/g rate included) and leave the arg0 as-is (mostly 0xa0)
> > and I expect both drivers can do the rate adaptive thing in the same
> > way, but it seems to make no difference. The rtl8xxxu driver still
> > sends the packets with highest MCS.
> >
> >     Can anyone tell me what should I expect the rate adaptive to work
> > with the rate mask 0xfffff and 0xf0000? Does the 0xf0000 means that it
> > will pick up a tx rate only between nrate MCS4 to MCS7? I need a base
> > line so that I can judge it's simply a rate mask problem or maybe the
> > h2c command is not written correctly. Please kindly suggest what I
> > should do next. Thanks
> >
>
> The rate mask indicates which rates will be used by rate adaptive mechani=
sm.
> I'm not sure the exact bit allocation for CCK/OFDM/MCS, maybe
> 0x0000f/0x00ff0/0xff0000 for CCK/OFDM/MCS respectively, but you can trace
> vendor driver to know the detail.
>
> I suggest you can try to send only OFDM rate mask, and expect to see OFDM
> rate only by your sniffer. If it's still keep on MCS7, rate adaptive may
> not work properly.
>
Thanks. That's my expectation and I'll try to verify it on vendor
driver and upstream rtl8192cu driver.

> Also, you can compare the content of rate adaptive H2C with vendor driver=
 to
> see if the format is correct.
>
> Another thing is to try 'fix_rate' in tx_desc. Check the vendor driver to
> know the use_rate/rate/bw fields of tx_desc. Then, try to fix the rate yo=
u
> want.
>
If I set the fix_rate in tx_desc, will the rate mask in H2C command be
ignored? Or the underlying firmware will do the tx rate fallback for
the retry packets?

Chris

> --
> Ping-Ke
>
