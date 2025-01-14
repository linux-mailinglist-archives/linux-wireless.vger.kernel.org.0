Return-Path: <linux-wireless+bounces-17508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41785A11036
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E153A4146
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A02B1FBCA0;
	Tue, 14 Jan 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="QB1HdQbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C591FBE86
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879658; cv=none; b=o4S/SfPT9t7L8K8g/JqNupcqjNSTSdrSM7UAhr6OD9hx/AhkAKIHMr35YOOGv3pZwHGWY+75GHvYE1VWERImMz28DJDeIgnZjfgZMwSHUKpNH/wqJ/lRJm8yn3z51Ux+0nmkXwQF97E+GzSk38J3BAUwKDW/VA9Ia+DEGxBlpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879658; c=relaxed/simple;
	bh=FsV7xhBPU/3qXGoKk/2QLe1qSElMpJLQ+QF6Yk+BVco=;
	h=Content-Type:Date:Message-Id:Cc:Subject:To:From:Mime-Version; b=qzmczHKuX8sZUCENxlrV+1/XmzA8Hpm83a6GvEMhXc8+uMHRk++gdMO9GRyVm+Y9pA/CRnc0O8Ql5s3r2QrAuSJ1uVe+40GDjApkpbsf/CdmM/aYGOQO5OthQjUjwf0BfHMs7FGV+RQ322BSQeKTN49NQ5JsF1XNOZs+5ZVuGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=QB1HdQbC; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1736878750; x=1738178750;
	bh=IYz2igEWKmpvqdIwd5txDTROPM7QuuKLCHbr0Ux6Z24=; h=From;
	b=QB1HdQbCUNgITydwnN387gdUoH/xZZM4jihMn2h7kc8ykaky+Tp8hOALQu2kDibo2
	 BfThUR9EBXzjpxoyeoBKMaWOrRCU2MPYX0jZA1yGnM6CjHlbufK8yNFYQR56fiZOKn
	 AQYkEwpRY3TdfC43nf74/PnJBqNHVcxotovaabz7J4LxaieqM47c1aVnGKBwIhVKN5
	 Xzj4nKdlyB6tbLqt72n+FejrYHg5P6BpGHVbQmaVko3/5FkR3XUzCOFztUD3Yklp08
	 IfO+DCwciVvNXg2iJPYDYkg4/x7XQQ/nZmAxvbNonQ8h4V2dnGGyaf1eM1deG4cGEc
	 wWLHHHs/dZdAw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 50EIJ8Ul021631
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 19:19:10 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 19:19:08 +0100
Message-Id: <D7204PWIGQGI.1FRFQPPIEE2P9@matfyz.cz>
Cc: <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>,
        <linux-wireless@vger.kernel.org>,
        "Francesco
 Dolcini" <francesco@dolcini.it>,
        "Brian Norris" <briannorris@chromium.org>
Subject: issues with sdhci-pxav3 mmc host
To: <linux-mmc@vger.kernel.org>, "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Karel Balej" <balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm working on mainline support for the Samsung Core Primve VE LTE
smartphone based on the Marvell PXA1908 SoC [1] which uses the
sdhci-pxav3 mmc host driver for its internal eMMC storage, microSD card
slot and SDIO WiFi/BT/FM adapter.

Out of the box, the SD card works however eMMC fails probing with the
following error:

	mmc0: SDHCI controller on d4281000.mmc [d4281000.mmc] using ADMA
	mmc0: Card stuck being busy! __mmc_poll_for_busy
	mmc0: error -110 whilst initialising MMC card
	mmc0: Tuning failed, falling back to fixed sampling clock
	mmc0: Card stuck being busy! __mmc_poll_for_busy
	mmc0: error -110 whilst initialising MMC card
	mmc0: Card stuck being busy! __mmc_poll_for_busy
	mmc0: error -110 whilst initialising MMC card
	mmc0: Card stuck being busy! __mmc_poll_for_busy
	mmc0: error -110 whilst initialising MMC card
	mmc0: Failed to initialize a non-removable card
   =20
This error does not occur when the card is forced to DDR_1_8V but if
caching is not force-disabled (by always returning false from
_mmc_cache_enabled), the following errors occur:
   =20
	[    0.210673] mmc0: SDHCI controller on d4281000.mmc [d4281000.mmc] using=
 ADMA
	[    0.301489] mmc0: new DDR MMC card at address 0001
	[    0.302156] mmcblk0: mmc0:0001 QNW00A 7.28 GiB
	[    0.308976] mmcblk0boot0: mmc0:0001 QNW00A 4.00 MiB
	[    0.310318] mmcblk0boot1: mmc0:0001 QNW00A 4.00 MiB
	[    0.311571] mmcblk0rpmb: mmc0:0001 QNW00A 512 KiB, chardev (248:0)
	[  171.353426] mmc0: Card stuck being busy! __mmc_poll_for_busy
	[  171.353443] mmc0: cache flush error -110
	[  201.399007] mmc0: Card stuck being busy! __mmc_poll_for_busy
	[  201.399023] mmc0: cache flush error -110
	[  231.415093] mmc0: Card stuck being busy! __mmc_poll_for_busy
	[  231.415109] mmc0: cache flush error -110
	[  261.464688] mmc0: Card stuck being busy! __mmc_poll_for_busy
	[  261.464703] mmc0: cache flush error -110

In addition, the SDIO is unstable, sometimes it doesn't even get through
firmware loading reporting -EILSEQ before the transfer is complete and
even if it does initialize successfully, putting stronger load on the
WiFi for instance often leads to errors and sometimes card removal,
after which reboot is necessary for it to work again. Note that apart
from this instability both the WiFi and the BT do work normally.

However, as the support for the SDIO was added to the mwifiex driver
rather naively by myself [5] (you can also find the various WiFi errors
I am seeing here), I am not confident that it is fully compatible (the
vendor kernel has a standalone driver for it which however appears very
similar to mwifiex) and thus don't know if these WiFi issues are related
to the eMMC issues or are separate. The former would seem plausible
which is why I am trying to make the eMMC work first to see if it also
fixes the WiFi rather than spending time with the mwifiex code when the
issue might lie elsewhere.

To see what the problem might be mainline, I have experimented with the
v3.14.27-based vendor kernel [2], where the eMMC works out of the box
obviously, trying to strip it of all the additional "features" missing
mainline that seemed like they could affect the functionality of the
card, in particular I have

* removed all the quirks specified in the DT,
* removed the sdhci-pxav3.c code that made it treat the compatibles
  differently (as the compatible used downstream is not available mainline)=
,
* removed or disabled the tuning code (both for the pxav3 driver which
  again contains a lot of things not available mainline and the generic
  sdhci.c tuning),
* removed all the sdhci_ops members not available mainline,
* removed all the clocks that downstream uses for the mmc in addition to
  what mainline has, both from the DT and from the corresponding
  drivers,
* removed several regulators from the DT,

effectively bringing the downstream code to a comparable state as the
mainline is in (at least as far as sdhci-pxav3 is concerned). This has
however not hindered its ability to probe eMMC in the HS200 mode.

At this point thus, I don't know where to look for the problem other
than the mmc core, or possibly still sdhci.c. The SDIO instability would
suggest to me that perhaps the issue really is wrong clocking, however
with the downstream removal mentioned above, the two kernels should be
on-par in this regard with the additional clocks being preset by the
bootloader.

I have also looked through Marvell's fork of the old kernel [3] which
contains the commit history where I found many changes touching
drivers/mmc that seemed like they could be the missing piece, reverting
any of them however also didn't affect downstream's ability to probe the
eMMC.

Apart from the one mentioned in the beginning of this email, there are
several other hacks that enable mainline to probe the eMMC. The first
one is setting card->ext_csd.cache_size =3D 0 right before cache is turned
on in drivers/mmc/core/mmc.c. The other thing I noticed is that what
__mmc_poll_for_busy checks for on mainline via host->ops->card_busy()
(which means sdhci_card_busy):

	!(present_state & SDHCI_DATA_0_LVL_MASK)

differs from what the downstream code checks for:

	R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG

and changing this mainline does indeed make it probe, however changing
in turn the downstream code to use the mainline busy detection mechanism
again does not break its ability to probe eMMC which makes me think that
this is not the real problem.

(Downstream also has SDHCI_DATA_LVL_MASK in sdhci_card_busy instead and
using that mainline does remove the ETIMEDOUT error but causes some
operations concerning the card (such as running mkfs.ext4 on the eMMC)
to run longer (while the read/write speed isn't affected however). Plus,
this function never runs downstream.)

With either of the hacks, the eMMC does probe but dmesg gets spammed
with lots of

	Tuning failed, falling back to fixed sampling clock

originating from sdhci.c's __sdhci_execute_tuning().

However also with neither of the hacks does the SDIO start working
properly, i. e. become stable.

You can find some of my progress notes also here [4].

I will be very grateful for any help, be it a pointer or an idea
regarding what the problem might be or what else I could try with either
the vendor kernel or mainline, as I am very much at a loss at the
moment.

If there is any more information that I should provide, please do let me
know.

[1] https://lore.kernel.org/r/20241104-pxa1908-lkml-v13-0-e050609b8d6c@skol=
e.hr/
[2] https://github.com/CoderCharmander/g361f-kernel/
[3] https://github.com/acorn-marvell/brillo_pxa_kernel
[4] https://gitlab.com/LegoLivesMatter/linux/-/issues/2
[5] https://lore.kernel.org/r/20231029111807.19261-1-balejk@matfyz.cz/

Thank you very much and best regards,
K. B.

