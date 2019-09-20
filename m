Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821D3B966F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfITRT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 13:19:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43440 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbfITRT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 13:19:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so7521141wrx.10
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lqDng+a1V5wthmlIGyTOvwnRwIUwaocc0044UXAv6k=;
        b=s1Ic7nUwmQyDdLG2cUmKuRHpjy2WyahzIJvuOlfDErVaXGlNnMZ9+mlxDAqttCSFkf
         PvMsjOZjM+ca+fUSB0Ad8GyCq/7mStyQgQJOD323/Hh9ZK9eZuqrBCPvTYWkOIv9Ff9Q
         YZUGDDSkiTixskLHbVAbK0MKz0nykVxIsILWlxzRLX+H6LPRt3SqMrtj9cW/8jQkXnQq
         fKiykPAXeljmC+w+97+vEs6AgTBVEz6y81lIqRX16wsmjEX/oqUAFUqhaqpHcgFaiKyc
         vb5is3n/BZPxWrbIvZvPYudWAcqlln+17U1F6ftTMXx3aY7CzHuuqKIIKEg8f3npM79M
         U9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lqDng+a1V5wthmlIGyTOvwnRwIUwaocc0044UXAv6k=;
        b=Hcddc2j2108x+3U7WS5cbXgr5NKivn44Mpq8uH1nOgFxHa0FliGz1hStxl9cochpYa
         KJzLXzgpU4wEuC9rz03TCK+2iXRnpvJ71ssfI5wcvkIeEGJCrJ//60+wVrhKE2Tr/Tia
         RbelLtQtRhsY7ZsiCuzKNXdSvLS2hxSVxMw9+lyoQtGTWNsuarX4mnjTEtnI0lEz67u9
         pRvHH2m/T7M/uYpP3Lp34DRIeWZaLIKOA7prnPAr9xXnbjMoOwoClS1XsgV4FQQ1ppYM
         o9Rs4qomBahFpg9yrX+z0/sv1rk3geAia0W3NluDavdDfv2ex5afwafmgew/1S6N8N73
         sgrQ==
X-Gm-Message-State: APjAAAXaq2ZR7zR2NXM0WW6jo2EUgAhHuQWwscY78qbp2WyvLugRZW+9
        v8/B51rkan1YXWUbyrpv8cQ=
X-Google-Smtp-Source: APXvYqznlml5TsM2oJaPQk+gtt4tIbpBWdLUUfIKh6aUhUKRU7Ws0Sde/3wWVTbyCYPxaPqr/fGQaA==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr11839628wrp.278.1568999964672;
        Fri, 20 Sep 2019 10:19:24 -0700 (PDT)
Received: from debian64.daheim (p4FD09E69.dip0.t-ipconnect.de. [79.208.158.105])
        by smtp.gmail.com with ESMTPSA id g185sm4932711wme.10.2019.09.20.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:19:23 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1iBMYl-00008S-Ph; Fri, 20 Sep 2019 19:19:10 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        =?utf-8?B?TWljaGHFgg==?= Kazior <kazikcz@gmail.com>
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
Date:   Fri, 20 Sep 2019 19:19:06 +0200
Message-ID: <2099574.gZacamft7q@debian64>
In-Reply-To: <20190917064412.C2E0D61572@smtp.codeaurora.org>
References: <20190906215423.23589-1-chunkeey@gmail.com> <20190917064412.C2E0D61572@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday, September 17, 2019 8:44:12 AM CEST Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> wrote:
>=20
> > This patch restores the old behavior that read
> > the chip_id on the QCA988x before resetting the
> > chip. This needs to be done in this order since
> > the unsupported QCA988x AR1A chips fall off the
> > bus when resetted. Otherwise the next MMIO Op
> > after the reset causes a BUS ERROR and panic.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in prob=
e")
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>=20
> I'll drop this as there's no plan to support QCA988X hw1.0.

Kalle,

I'm surprised about this. And your justification
"no plan to support QCA988X hw1.0" seems very odd in this context,
because this patch does not add any support for the QCA988X hw1.0.

But, I could see how the mails/replies from Tom Psyborg derailed the
topic here. Though, I'm not sure if this is the case or not.

So let set the record straight and show you the result of having that
patch applied and load ath10k_pci with a QCA9880 v1 AR1A:

[ 1491.622282] ath10k_pci 0000:00:00.0: device 003c with chip_id 043200ff i=
sn't supported

(System is all good!)

And without the patch:

[  900.320000] Data bus error, epc =3D=3D 86a9a1b0, ra =3D=3D 86a9a4b0
[  900.320000] Oops[#1]:
[  900.320000] CPU: 0 PID: 8127 Comm: insmod Not tainted 5.2.16 #1
[  900.320000] task: 8790dd50 ti: 86a2c000 task.ti: 86a2c000
[  900.320000] $ 0   : 00000000 80350000 deadc0de 1000fc03
[  900.320000] $ 4   : b2080000 8790dd50 1000fc00 ffff00fe
[  900.320000] $ 8   : 86a2dfe0 0000fc00 00000000 00000000
[  900.320000] $12   : 00000005 00000000 00000000 00420000
[  900.320000] $16   : 00000009 8788d400 869f9000 87821800
[  900.320000] $20   : 00000009 b2080008 b2080000 00000001
[  900.320000] $24   : 00000000 8006b784                 =20
[  900.320000] $28   : 86a2c000 86a2dba8 b2080004 86a7a5b0
[  900.320000] Hi    : 000000d1
[  900.320000] Lo    : 9ea86180
[  900.320000] epc   : 86a7a5b0 ath10k_pci_cold_reset+0xf88/0x1bb0 [ath10k_=
pci]
[  900.320000]     Not tainted
[  900.320000] ra    : 86a7a5b0 ath10k_pci_cold_reset+0xf88/0x1bb0 [ath10k_=
pci]
[  900.320000] Status: 1000fc03 KERNEL EXL IE=20
[  900.320000] Cause : 4080801c
[  900.320000] PrId  : 00019750 (MIPS 74Kc)
[  900.320000] Modules linked in: ath10k_pci(+) ath10k_core [...]
[  900.320000] Process insmod (pid: 1127, threadinfo=3D86a2c000, task=3D879=
0dd50, tls=3D775b1440)
[  900.320000] Stack : 80301d90 8790dd50 8790dd50 80301d90 8790c430 80067e7=
8 00000000 87821800
          00080000 00000000 80373900 86a2dc0c 80373900 0000ea80 00000009 b2=
080008
          b2080000 00000001 80373900 80066964 86a2dc0c 80081e80 8790dd50 86=
a63924
          00000001 00000000 00200200 0000ea80 80373900 80081e80 8790dd50 ff=
ffffff
          8788d400 00000009 8788d400 86a2dc58 87821800 80082398 86a2dc5c 86=
a7d140
          ...
[  900.320000] Call Trace:
[  900.320000] [<86a7a5b0>] ath10k_pci_cold_reset+0xf88/0x1bb0 [ath10k_pci]
[  900.320000]=20
[  900.320000]=20
Code: 2410000a  0c0621d3  02c02021 <30420400> 10400006  00002021  24040001 =
 0c0208de  2610ffff=20
[  900.570000] ---[ end trace 1e4e2b7fd4ac9eb8 ]---
Segmentation fault

Notice the DATA BUS Error! The router is unusable at that point and no long=
er "working".


As for why this patch was coded this way. It's because this patch follows M=
icha=C5=82 Kazior
recommendation of how to handle this card in his reply to a previous thread=
=20
"ath10k: reset chip after supported check" regarding the same issue. He did=
 check for a
QCA988X Hardware and only then perform the SOC_CHIP_ID_ADDRESS read.

<https://patchwork.kernel.org/patch/10866417/#22549011>
|That makes sense, but I don't see how blacklisting pci slots would
|help someone putting v2 nic into C7v1 mobo? Won't the slot be the same
|regardless what nic is put?
|
|The best thing I can come up with is something like this:
|
|--- a/drivers/net/wireless/ath/ath10k/pci.c
|+++ b/drivers/net/wireless/ath/ath10k/pci.c
|@@ -3629,6 +3629,19 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
|                goto err_deinit_irq;
|        }
|
|+       if (hw_rev =3D=3D ATH10K_HW_QCA988X) {
|+               /* v1 can crash the system on chip_reset()
|+                * so all we can do is keep our fingers
|+                * crossed v2 never reports 0 without a
|+                * chip_reset()
|+                */
|+               if (ath10k_pci_soc_read32(ar, SOC_CHIP_ID_ADDRESS) =3D=3D =
0) {
|+                       ath10k_err(ar, "qca9880 v1 is chip not supported");
|+                       ret =3D -ENOTSUP;
|+                       goto err_free_irq;
|+               }
|+       }
|+
|        ret =3D ath10k_pci_chip_reset(ar);
|        if (ret) {
|                ath10k_err(ar, "failed to reset chip: %d\n", ret);
|
|I didn't test it. Someone needs to compile and test and make sure v2
|doesn't regress when fw hangs and cold & warm host cpu resets are
|mixed in.

I do hope this helped "to clear things up" since I did not add support
for the QCA9880 v1 AR1A here and don't plan to do so.

Regards,
Christian


