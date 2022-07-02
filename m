Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710255641F0
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiGBRtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 13:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 13:49:24 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F665F8B
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 10:49:21 -0700 (PDT)
Date:   Sat, 02 Jul 2022 17:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1656784159; x=1657043359;
        bh=vHRz8Pzy9m8vVwMYpWBRXQ2Kgi+Y/eN7Ww+yf7eq8sI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ViX841pvkbSrpsxN8yj4NPlQUqF7AyTOnmzzdeUqyX6xls9onIXcGiteC/FT1YHMd
         wU/jkyWzDA6waxK86O9k9Gj5ySl2SFBA1BskDpDjAOxVW56V1ibDgzLv/fR515geWl
         vrEBPiBzC8/F9U2SXQuIN5LOkBhDKutsA47yawx38C/5P7RN82KYsbKA/AdFyafaIB
         DEmxAxeohQs6HNAGtA6wvFDo1DSmzu6AZfjYi+9b+9DBz+Bl5vTdHgVffIR4AABity
         uo/Lc25pwNLLBm7ZI2zkdzy44VSD4fOurvgXZDgnsvmppx/5MW3ClA/VZOoCqQfID9
         82n7E8Q7gcabw==
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.
Message-ID: <Zi4EB2wpeKLBzLYaWQipAoeQ54MOmavmfpFZ887MjuLaCn-wYory5tCLC9HLBTC7t0SOqLGsGfKFS3M5qFDkdF9HP1LRatW6_MXwNJ4MJPw=@dannyvanheumen.nl>
In-Reply-To: <f14afd46-0bad-9d7b-1361-203bcad92e06@broadcom.com>
References: <ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=@dannyvanheumen.nl> <f14afd46-0bad-9d7b-1361-203bcad92e06@broadcom.com>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I missed the response for a while. Following up in-line.

------- Original Message -------
On Wednesday, June 22nd, 2022 at 14:36, Arend van Spriel <arend.vanspriel@b=
roadcom.com> wrote:

> + Uffe
>
> On 6/17/2022 4:24 PM, Danny van Heumen wrote:
>
> > From f1fcceb65d4a44c078cd684ea25a2f2c7f53deb2 Mon Sep 17 00:00:00 2001
> > From: Danny van Heumen danny@dannyvanheumen.nl
> > Date: Tue, 24 May 2022 18:30:50 +0200
> > Subject: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.
> >
> > In case of buggy firmware, brcmfmac may perform a hardware reset. If du=
ring
> > reset and subsequent probing an early failure occurs, a memory region i=
s
> > accidentally double-freed. With hardened memory allocation enabled, thi=
s error
> > will be detected.
> >
> > - return early where appropriate to skip unnecessary clean-up.
> > - set '.freezer' pointer to NULL to prevent double-freeing under possib=
le
> > other circumstances and to re-align result under various different
> > behaviors of memory allocation freeing.
> >
> > Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It c=
alls
> > 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reini=
tialize
> > the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it ex=
its
> > early, which includes calling 'brcmf_sdiod_remove'. In both cases
> > 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', wh=
ich
> > has not yet been re-allocated the second time.
>
>
> For testing you can also trigger the brcmf_sdio_bus_reset() through debug=
fs:
>
> # cd /sys/kernel/debug/ieee80211/phyX
> # echo 1 > reset

This works. I have done a few resets in a loop to see if the hardware keeps
recovering and no other issues occur. Everything seems to be fine.


>
>
> So I did that without your patch and observed following:
>
> [ 531.481045] brcmfmac: brcmf_sdiod_probe: Failed to set F1 blocksize
>
> [ 531.487314] brcmfmac: brcmf_sdio_bus_reset: Failed to probe after
> sdio device
> reset: ret -123
>
> [ 531.495893] mmc0: card 0001 removed
>
> [ 531.550567] mmc0: new high speed SDIO card at address 0001
>
> [ 531.556561] brcmfmac: F1 signature read @0x18000000=3D0x16044330
>
> So I looked in brcmf_sdio_bus_reset() and noticed that this function
> actually does a call to mmc_hw_reset() which is what I suggested
> earlier. Looking at this log it seems the actual remove and subsequent
> rescan is a deferred work and it will take care of probing the driver ane=
w.

I can confirm that this works. This is helpful.


>
> So I changed debug message level for the sdio ops and then I see:
>
> [ 1327.686828] brcmfmac: brcmf_sdiod_probe: Failed to set F1 blocksize
>
> [ 1327.693091] brcmfmac: brcmf_sdio_bus_reset: Failed to probe after
> sdio device
> reset: ret -123
>
> [ 1327.701626] brcmfmac: brcmf_ops_sdio_remove Enter
>
> [ 1327.706333] brcmfmac: brcmf_ops_sdio_remove Function: 1
>
> [ 1327.711557] brcmfmac: brcmf_ops_sdio_remove Exit
>
> [ 1327.716203] brcmfmac: brcmf_ops_sdio_remove Enter
>
> [ 1327.720911] brcmfmac: brcmf_ops_sdio_remove Function: 2
>
> [ 1327.726135] brcmfmac: brcmf_ops_sdio_remove Exit
>
> [ 1327.730768] mmc0: card 0001 removed
>
> [ 1327.785458] mmc0: new high speed SDIO card at address 0001
>
> [ 1327.791068] brcmfmac: brcmf_ops_sdio_probe Enter
>
> [ 1327.795687] brcmfmac: brcmf_ops_sdio_probe Function#: 1
>
> [ 1327.800988] brcmfmac: brcmf_ops_sdio_probe Enter
>
> [ 1327.805610] brcmfmac: brcmf_ops_sdio_probe Function#: 2
>
> [ 1327.811317] brcmfmac: F1 signature read @0x18000000=3D0x16044330
>
> So to me it seems mmc_hw_reset() is doing everything we need and we can
> make brcmf_sdio_bus_reset() a bit simpler. The only scary part here is
> that brcmf_ops_sdio_remove() is called first for func1 and then for
> func2. Upon rmmod this is different, ie. first func2 and then func1.
> Looking at the implementation in brcmf_ops_sdio_remove() it means we run
> into use-after-free upon mmc_hw_reset().

I have looked into this. The logic itself protects from duplicate behavior
(at least partially) by checking which func is being removed. However,
irq-releases are duplicated because the check only happens after that logic=
.
This is also necessary, because the kernel warns if the irq isn't released
after executing the callback.

In the next patch (prefixed "PATCH v4", already sent), I have slightly
adjusted the control flow such that irq-release happens for each func
-- as per expectation -- while the removal logic remains rooted at func1,
but executed based on the full device (`sdiodev` as function arg). This
should, IIUC, be correct regardless of function order.

This solution isn't a perfect redesign, but should respect both the design
itself and also sdio driver expectations.

Please find the patch at: g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392=
j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=3D%20()%20dannyv=
anheumen%20!%20nl

Regards,
Danny


