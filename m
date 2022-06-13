Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE682548335
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiFMJTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiFMJT0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279B14D12
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so9890192ejj.10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z5NXyVBSgxHbJM8RcYQpj5keK992nWNa+tNe8nn1Tic=;
        b=Qr+va9KLzgrEzY1TDQ1kMN1CqZdNDzxwMic+iYH5k8TyCulEbFomu/vM/ZVPIp/dQJ
         T/TtfruJUdIUjMb9z2U+IcBqj4PZ3iTaWjxaR4uvHdK3nPQrlhYMnxDEYfqMqgAbFJjr
         qwhA7TO0T9OCKIHGrpbNgUvPJFLgCDnwwR8JrtATE2Gc9jsoPNVI3QMcQsxskXvPxvOM
         iw56EvDI7pbqSpi86pCIrJ9L6Sq8haEa5EHzgK6iDWUBPCkq+w2ksmkytB9sy0VusPfY
         qCUJ1FPZaKqB6pgjCjfvod/h0xAVRWpPVBx+UPSqfwISw9zW9uG7/PMGHjzOaiqVZ3Ew
         KIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z5NXyVBSgxHbJM8RcYQpj5keK992nWNa+tNe8nn1Tic=;
        b=UXfxaPGUntB8qbST2Kh57+hhy4n0Lg0xflSHOjecHvEzq/JUi4VgkuWTdYb4I4X8JB
         W/EiTRfyqH14M7JtgPUWzzDUA2L1BgrIpdyYMpSurGIONJWfcdlSQoF0UeW6m+4xI8RW
         PosmVA5k2l1l8ZGUWzMy302EDuDV1UWZvoIDsF8aLu+HvQzBRlDDcJqAs2w46gslO2wo
         jWtCJiWzCQHceqTnoJLXg59V+BrA5PCXcDfuQFFiXxw1D6v+0itXq9TWRqxZtDtOZiI7
         SWUASMwU1GbL5lj7qt648Xi0Nazsap7YLVYwb8Eai8JLWehw6PuxWmgSzR4UWLCjKxaF
         +wYQ==
X-Gm-Message-State: AOAM531lx/o31b3IXrO3LleeCZYWsBhH+zbiMtNIjERJYrrcQA9TF/vC
        ZhtDCDDT11AwlcR44+IUZtWC+poUJqUUkbGCDsw=
X-Google-Smtp-Source: ABdhPJzrvN1MjcJ58Q/DgbICzCTLot7k3Y5OdvHj2df6J33N7j+EFhuJGzM1Qq7zeUvKKOxqMLuTCOQSYx4cyfwBJPA=
MIME-Version: 1.0
X-Received: by 2002:a17:906:519c:b0:712:1c90:1c39 with SMTP id
 y28-20020a170906519c00b007121c901c39mr15693088ejk.620.1655111963523; Mon, 13
 Jun 2022 02:19:23 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:23 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
Date:   Mon, 13 Jun 2022 05:19:23 -0400
Message-ID: <CAJ65rDxwRshw4Qwte9bU4K+xifcS0Yo7TjCKJ2aNPg4wBLeg5w@mail.gmail.com>
Subject: [PATCH 0/7] brcmfmac: support devices from multiple vendors
To:     Kalle Valo <kvalo@kernel.org>, arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bcm43xx family of wifi chipsets found its way to different
groups inside and outside Broadcom. For the fullmac devices this
means that in those difference groups firmware is being developed
and the firmware api is bound to diverge. This series introduces
a design change to accomodate supporting multiple firmware api's.
The vender-specific support can be compiled in brcmfmac or
built as a separate module. Currently the vendor-specific support
does not have any real effect. At the momemt looking into SAE support
which appear to be different for Cypress devices so that might be a
first use-case. Meanwhile wanted to put this series out there and
get feedback on it. Some ideas were taken from iwlwifi which does
similar things for iwlmvm, iwldvm, etc.

The patches apply to the main branch of the wireless-next repository.

Arend van Spriel (7):
  brcmfmac: add function to unbind device to bus layer api
  brcmfmac: add firmware vendor info in driver data
  brcmfmac: add support for vendor-specific firmware api
  brcmfmac: add support for Cypress firmware api
  brcmfmac: add support Broadcom BCA firmware api
  brcmfmac: add vendor name in revinfo debugfs file
  brcmfmac: introduce BRCMFMAC exported symbols namespace

 .../broadcom/brcm80211/brcmfmac/Kconfig       |  30 +++
 .../broadcom/brcm80211/brcmfmac/Makefile      |  11 +
 .../broadcom/brcm80211/brcmfmac/bca/Makefile  |  12 +
 .../broadcom/brcm80211/brcmfmac/bca/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/bca/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/bca/vops.h    |  15 ++
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  50 +++--
 .../broadcom/brcm80211/brcmfmac/bus.h         |  30 ++-
 .../broadcom/brcm80211/brcmfmac/core.c        |  12 +-
 .../broadcom/brcm80211/brcmfmac/core.h        |   8 +
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile  |  12 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/cyw/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/cyw/vops.h    |  15 ++
 .../broadcom/brcm80211/brcmfmac/fwvid.c       | 205 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  47 ++++
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  64 +++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  12 +-
 .../broadcom/brcm80211/brcmfmac/usb.c         |  27 ++-
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile  |  12 +
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/vops.h    |  15 ++
 23 files changed, 678 insertions(+), 61 deletions(-)
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h

--
2.32.0
