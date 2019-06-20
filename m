Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE54D093
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTOlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 10:41:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34191 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 10:41:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3335737wrl.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xy5kKhD/htJC9HG/Wek7QbNgYYO8vtcDYitOXxocI5w=;
        b=hleyQN4k6a901eEiyt+/cQ8/bu4hNYDEAwibP/lb0mI9+eF+oYBg7ym0RVc6rhuBrf
         Rlt2iUpzlDotAfc9mLq8NTBNRFpgo3A/84xx01CqGCXx6qlQCrT48O1ELff5tUdeQXUz
         MMMAUB1caWM1/BzzEnwcDmTORJZZ5jShW0Sw1kSFwTZdV+x9WCKfp/hBBRhwk1OGdTf1
         ClaQPCBQZys1NANl8LeBWsx8A2FNrJC3/SFZVVNhdUWqEbwINM15SuiEH0oRx4UT49J5
         2X++VJQoZauAlQBqpIEyZ+y6MxsqfRx6X9TZyrtM1HVU+u9JulPk2Jt/bZ/do4moSQvg
         Yj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xy5kKhD/htJC9HG/Wek7QbNgYYO8vtcDYitOXxocI5w=;
        b=r+kcd1vybn7g1Viz7MJE/lGiG4In0mWIVpHgXmpm/V8Y1gpKcNSVbW6Gn9RwPx73HM
         PfbadELWK0Uk+3ZJBb6ldMMymiNUopNQD9sbGpgbT45tm1CE3f57qFFpRXxPxkxXw5PW
         K+I//eEbk9jrcECLNE3cyybIUI3SZVFZ/sK1yThv6fS/DMUiz9xGTCGZ+uCADLmaK+Ge
         F3OwYxB50yOZ3uP0Hy0GSEziyGOIsb7qOXbLvuZown0LIppJcxLI5O6UPOhDKsuhUwxx
         AIq7ozTIKedBJ6rcoDmbVM03j1nH4O86n31/Gz9XJjFFMNrVUI/VY7zSKjHYAgWhOfC7
         WyfA==
X-Gm-Message-State: APjAAAWPb7LaKXr6/ZFOD4uT0E5cvNpypgZ38imnrAWGnq/ThMZbgrI6
        JEN2ccdn7a/zfruj36DeZHSqJxd5
X-Google-Smtp-Source: APXvYqwLwH2nTg1H1R9IEGPJl1ocUDQMjBFtKKleq3JegrHIDoiYy/oUr3fP9zJ8zD6ua4i8qXAsxQ==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr79569990wrv.118.1561041662361;
        Thu, 20 Jun 2019 07:41:02 -0700 (PDT)
Received: from debian64.daheim (pD9E29A96.dip0.t-ipconnect.de. [217.226.154.150])
        by smtp.gmail.com with ESMTPSA id y44sm23498103wrd.13.2019.06.20.07.41.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 07:41:01 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hdyFJ-000307-2u; Thu, 20 Jun 2019 16:41:01 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: fix enum compare splat
Date:   Thu, 20 Jun 2019 16:41:00 +0200
Message-ID: <4392478.8kWN0Ehzps@debian64>
In-Reply-To: <87a7ef9jp2.fsf@kamboji.qca.qualcomm.com>
References: <20190608144947.744-1-chunkeey@gmail.com> <1601416.I41mb68Wgz@debian64> <87a7ef9jp2.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday, June 18, 2019 2:11:53 PM CEST Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> > On Monday, June 10, 2019 9:06:30 AM CEST Kalle Valo wrote:
> >> Christian Lamparter <chunkeey@gmail.com> writes:
> >>=20
> >> > This patch fixes a noisy warning triggered by -Wenum-compare
> >> >
> >> > |main.c:1390:31: warning: comparison between =E2=80=98enum nl80211_a=
c=E2=80=99
> >> > |	and =E2=80=98enum ar9170_txq=E2=80=99 [-Wenum-compare]
> >> > |  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> >> > |                               ^
> >> > | [...]
> >> >
> >> > This is a little bit unfortunate, since the number of queues
> >> > (hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
> >> > (much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
> >> > less defined by the AR9170 hardware.
> >>=20
> >> Is the warning enabled by default? TBH I'm not seeing how useful this
> >> warning is for kernel development.
> >
> > It is included in the "-Wall" (which is coming from "KBUILD_CFLAGS"=20
> > in the main Makefile).
> >
> > I tried debian's gcc starting from 4.6 to the lastest 8.3. They all
> > complain about it in various degrees.
> >
> > https://gcc.gnu.org/onlinedocs/gcc-4.6.0/gcc/Warning-Options.html#Warni=
ng-Options
>=20
> Ok, odd that I haven't noticed this warning. Maybe I have been just
> blind.

Sorry. No, I messed up there. I made a patch back in the day during the spe=
ctre
mac80211 patches that I kept in my tree for the driver. But I now remember =
that
I never published those because of that exact "warning".
These lines are coming from there.
=20
> >> > --- a/drivers/net/wireless/ath/carl9170/main.c
> >> > +++ b/drivers/net/wireless/ath/carl9170/main.c
> >> > @@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee8021=
1_hw *hw,
> >> >  	int ret;
> >> > =20
> >> >  	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) !=3D __AR9170_NUM_TXQ);
> >> > -	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> >> > +	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);
> >>=20
> >> IMHO this just makes the code worse. Does it make sense to workaround
> >> (stupid) compiler warnings like this?
> >
> > True. What's worse: This isn't really code. The BUILD_BUG_ON Macro is t=
here
> > to guard but it's getting compiled away. I could also just drop it.
>=20
> Either way is fine for me. If the GCC (by default) emits a warning for
> this we need to silence that warning, so in that respect I guess we
> should apply this. Unless better solutions come up, of course :)
Note: I dropped this patch from patchwork. So, there's nothing that
needs to be done now ;)

Well, except OT: Would you mind adding the QCA4019 boardfiles that
have accumulated over the past six-ish months?

<https://www.mail-archive.com/ath10k@lists.infradead.org/msg09966.html>

That list already had:
ath10k-firmware: QCA4019 hw1.0: Add ASUS Lyra specific BDFs
ath10k-firmware: QCA4019 hw1.0: Add Linksys EA6350v3
ath10k-firmware: QCA4019 hw1.0: Add Qxwlan E2600AC specific BDFs
ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A62 specific BDFs
ath10k-firmware: QCA9888 hw2.0: Update OpenMesh A62 specific BDFs
ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A42 specific BDFs
ath10k-firmware: QCA4019 hw1.0: Add ALFA Network AP120C-AC specific BDF
ath10k-firmware: QCA4019 hw1.0: Add AVM FRITZ!Box 7530 specific BDFs
ath10k-firmware: QCA4019 hw1.0: Update Linksys EA6350v3 specific BDFs

and now there's even more:

+ ath10k-firmware: QCA4019 hw1.0: Add Qxwlan E2600AC specific BDFs
 (Watch out, there are multiple versions! The first ones are dodgy
 with a bad crc)=20
 This should be the right "one"
 <https://www.mail-archive.com/ath10k@lists.infradead.org/msg10007.html>

+ ath10k-firmware: QCA4019 hw1.0: Add AVM FRITZ!Repeater 3000 specific BDFs
 <https://www.mail-archive.com/ath10k@lists.infradead.org/msg10101.html>

+ ath10k-firmware: IPQ4018 hw1.0: Add EnGenius ENS620EXT specific BDFs
<http://lists.infradead.org/pipermail/ath10k/2019-March/013034.html>

+ ath10k-firmware: QCA9984 hw1.0: Update Netgear Orbi Pro SRK60 specific BD=
=46s
  ath10k-firmware: QCA4019 hw1.0: Update Netgear Orbi Pro SRK60 specific BD=
=46s

  One for QCA9984 and one for two QCA4019
<https://www.mail-archive.com/ath10k@lists.infradead.org/msg10170.html>
<https://www.mail-archive.com/ath10k@lists.infradead.org/msg10171.html>

+ ath10k-firmware: IPQ4019 hw1.0: Add BDF for Linksys EA8300 [1/2]
  ath10k-firmware: QCA9888 hw1.0: Add BDF for Linksys EA8300 [2/2]

<http://lists.infradead.org/pipermail/ath10k/2019-May/013403.html>
<http://lists.infradead.org/pipermail/ath10k/2019-May/013404.html>

Cheers,
Christian


