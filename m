Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAFF58990
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF0SNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 14:13:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0SNx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 14:13:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B0D86021C; Thu, 27 Jun 2019 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561659232;
        bh=AX6/4cg+Uhieo2kt5IMhar5XqBibFCkFUcVTo5EjEcY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UWXwH0FPu1UVBop52rFyJmBWPoDX9MjiGS5dE8Yha9fR2+3tZrTcElci6leGUJHkW
         9Bq3l8e603vm0JC2oZCQ91p9qwNz3I1iBHYGDla8ivK+j+1a3dktlvfIXvKPEIWd5q
         F0JNHQnPyNL8XHiK+kim+POFooOonfGGiFqwBUvA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9612A607DE;
        Thu, 27 Jun 2019 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561659231;
        bh=AX6/4cg+Uhieo2kt5IMhar5XqBibFCkFUcVTo5EjEcY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wm6zXlWdXgvCIPCQAaeg+JKJkJ1ZyT3zTfEDPKoNRVhpIEiWilAtuKhlX7ttN00tk
         KdAyu0fwLz+YA+IJkCYsyvy1Y02OCz3tl4sbg+AUAgFb8wIuf1mc+SCdxiEiLQpVSD
         MN94Em4DSrJWpByYRdIvcqtCAzGwMyalrq38YgaA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9612A607DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v3] ath9k: add loader for AR92XX (and older) pci(e)
References: <20190609203621.13015-1-chunkeey@gmail.com>
Date:   Thu, 27 Jun 2019 21:13:47 +0300
In-Reply-To: <20190609203621.13015-1-chunkeey@gmail.com> (Christian
        Lamparter's message of "Sun, 9 Jun 2019 22:36:21 +0200")
Message-ID: <87tvcasxpg.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> Atheros cards with a AR92XX generation (and older) chip usually
> store their pci(e) initialization vectors on an external eeprom chip.
> However these chips technically don't need the eeprom chip attached,
> the AR9280 Datasheet in section "6.1.2 DEVICE_ID" describes that
> "... if the EEPROM content is not valid, a value of 0xFF1C returns
> when read from the register". So, they will show up on the system's
> pci bus. However in that state, ath9k can't load, since it relies
> on having the correct pci-id, otherwise it doesn't know what chip it
> actually is. This happens on many embedded devices like routers
> and accesspoint since they want to keep the BOM low and store the
> pci(e) initialization vectors together with the calibration data
> on the system's FLASH, which is out of reach of the ath9k chip.
>
> Furthermore, Some devices (like the Cisco Meraki Z1 Cloud Managed
> Teleworker Gateway) need to be able to initialize the PCIe wifi device.
> Normally, this should be done as a pci quirk during the early stages of
> booting linux. However, this isn't possible for devices which have the
> init code for the Atheros chip stored on NAND in an UBI volume.
> Hence, this module can be used to initialize the chip when the
> user-space is ready to extract the init code.
>
> Martin Blumenstingl prodived the following fixes:
> owl-loader: add support for OWL emulation PCI devices
> owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> owl-loader: use dev_* instead of pr_* logging functions
> owl-loader: auto-generate the eeprom filename as fallback
> owl-loader: add a debug message when swapping the eeprom data
> owl-loader: add missing newlines in log messages
>
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0

[...]

> +MODULE_LICENSE("GPL v2");

ath9k has ISC license, is there a specific reason why you chose GPLv2
here instead of ISC? I don't like mixing licenses within a driver,
that's why I'm asking.

-- 
Kalle Valo
