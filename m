Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC13B427
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfFJLpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 07:45:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbfFJLpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 07:45:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so8171483wmf.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2019 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOthGyXWQqHHqGJn/xuURBaXDymjEAyGi60HM5zS6VA=;
        b=Cx4OAOFBeqQsEE0imVEi1ZhTJHr0+Jm9g/0G7GdNCNDi8TLY8D0uRf/xrp+5EADusX
         8a6iDxB1fys0Uzcg6AWDOPl9Z2FA9SiYXzadVHkokZvjFinKjtKgjCvQvtXny6gmQPmc
         l31CSnTZo4qFe2Z8vzwAPYbGViFSirpLxQpOoqFm3ij2VZ9ktSnrFcliE/s7GZDitd47
         k+yKZFaghmuolvkWYn2saQ0cBbTpnSYfjUrtz+dacCE+UJZVUn5i+TnxlVwaR1VyHWWb
         r8EnT0bFLFuXEYG9gxL5PwytH3Y3xL0MQkDVazb1k3brJ+IMAL7bZ9E/gru417gzoNu9
         Zzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOthGyXWQqHHqGJn/xuURBaXDymjEAyGi60HM5zS6VA=;
        b=bwv1u0wByezboRHwo9JMVfjixYhH0d1bZ8jP/rw/+ShDIn9qW+cajpbVS9KFC/cEpL
         4xn+75L8NDgv2vJE4aPe0kJSmpjPNgYEdA4bOVM8BHDuQuha8b60juWX0FnG4obKOs8n
         mCrYx36Ga2YewtNZTzFYd/TcDmTqWcjK0zCZGocT7H5OEvq4zPf7lmJwzPdwkgmtyXvJ
         WhYDrruEWWwcjTX8DH1exot4SVltk1iy/2gOR5Wzug404ZHPobMbsvN10awj37YE6bPe
         I6OYJOf+viJFDAIAJu7qVLX83wiVkzbg2LEjPFv1zSuTZ6d05ICBK2Kz5MwAmLcK/pen
         G3yw==
X-Gm-Message-State: APjAAAXpLeHFqerQ/20Eub5CdmJlb+a3LwtbmjDCZ6Jo3rDrsmmRk2jm
        hGua+kwtBQ5mNIm9Xvftqx/Zo1MH
X-Google-Smtp-Source: APXvYqwW24QWi+Eze+AttScy2o7FL0QjRgX7xnoPAuRhQSIufwIpVB/QJ+90HZA18dJHEgEafSKfQQ==
X-Received: by 2002:a1c:1b81:: with SMTP id b123mr12777679wmb.144.1560167133997;
        Mon, 10 Jun 2019 04:45:33 -0700 (PDT)
Received: from debian64.daheim (pD9E29896.dip0.t-ipconnect.de. [217.226.152.150])
        by smtp.gmail.com with ESMTPSA id r2sm8981284wma.26.2019.06.10.04.45.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 04:45:32 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1haIjz-0003hl-Kc; Mon, 10 Jun 2019 13:45:31 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: fix enum compare splat
Date:   Mon, 10 Jun 2019 13:45:31 +0200
Message-ID: <1601416.I41mb68Wgz@debian64>
In-Reply-To: <87pnnlncll.fsf@codeaurora.org>
References: <20190608144947.744-1-chunkeey@gmail.com> <87pnnlncll.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday, June 10, 2019 9:06:30 AM CEST Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
>=20
> > This patch fixes a noisy warning triggered by -Wenum-compare
> >
> > |main.c:1390:31: warning: comparison between =E2=80=98enum nl80211_ac=
=E2=80=99
> > |	and =E2=80=98enum ar9170_txq=E2=80=99 [-Wenum-compare]
> > |  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> > |                               ^
> > | [...]
> >
> > This is a little bit unfortunate, since the number of queues
> > (hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
> > (much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
> > less defined by the AR9170 hardware.
>=20
> Is the warning enabled by default? TBH I'm not seeing how useful this
> warning is for kernel development.

It is included in the "-Wall" (which is coming from "KBUILD_CFLAGS"=20
in the main Makefile).

I tried debian's gcc starting from 4.6 to the lastest 8.3. They all
complain about it in various degrees.

https://gcc.gnu.org/onlinedocs/gcc-4.6.0/gcc/Warning-Options.html#Warning-O=
ptions

> > --- a/drivers/net/wireless/ath/carl9170/main.c
> > +++ b/drivers/net/wireless/ath/carl9170/main.c
> > @@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee80211_h=
w *hw,
> >  	int ret;
> > =20
> >  	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) !=3D __AR9170_NUM_TXQ);
> > -	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> > +	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);
>=20
> IMHO this just makes the code worse. Does it make sense to workaround
> (stupid) compiler warnings like this?
True. What's worse: This isn't really code. The BUILD_BUG_ON Macro is there
to guard but it's getting compiled away. I could also just drop it.




