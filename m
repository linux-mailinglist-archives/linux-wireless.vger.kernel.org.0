Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E861DE932
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgEVOpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgEVOpR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:17 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9213204EF;
        Fri, 22 May 2020 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158716;
        bh=jgtLSxW/rFemUDRGqeFehVEu0MdxG9OUPhnEvnFbKXo=;
        h=From:To:Cc:Subject:Date:From;
        b=gfg74FKs4mhp0Qzzg9jCxDSD/GyytTIjGv6siWmpqnDJFXa2okumtbOmzNmz+zRIp
         an1ToAw01OIlj3XAV2Q1zZ5lP4RCLYtL7fsG/NRIfagePkLDfPXqlqbeyObxr6V5Bs
         n0bYQOZXUll0jLzVx7TZ012GMiKrng2FUTFfzjPs=
Received: by pali.im (Postfix)
        id DA32B51E; Fri, 22 May 2020 16:45:13 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 00/11] mmc: sdio: Move SDIO IDs from drivers to common include file
Date:   Fri, 22 May 2020 16:44:01 +0200
Message-Id: <20200522144412.19712-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most SDIO IDs are defined in the common include file linux/mmc/sdio_ids.h.
But some drivers define IDs locally or do not use existing macros from the
common include file.

This patch series fixes above inconsistency. It defines missing macro names
and moves all remaining SDIO IDs from drivers to the common include file.
Also some macro names are changed to follow existing naming conventions.

Pali Rohár (11):
  mmc: sdio: Fix macro name for Marvell device with ID 0x9134
  mmc: sdio: Change macro names for Marvell 8688 modules
  mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
  mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
  mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
  mmc: sdio: Move SDIO IDs from smssdio driver to common include file
  mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
  mmc: sdio: Move SDIO IDs from ath10k driver to common include file
  mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
  mmc: sdio: Fix Cypress SDIO IDs macros in common include file
  mmc: sdio: Sort all SDIO IDs in common include file

 drivers/bluetooth/btmrvl_sdio.c               | 18 ++--
 drivers/bluetooth/btmtksdio.c                 |  4 +-
 drivers/media/mmc/siano/smssdio.c             | 10 +-
 drivers/mmc/core/quirks.h                     |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c        | 25 ++---
 drivers/net/wireless/ath/ath10k/sdio.h        |  8 --
 drivers/net/wireless/ath/ath6kl/hif.h         |  6 --
 drivers/net/wireless/ath/ath6kl/sdio.c        | 17 ++--
 drivers/net/wireless/broadcom/b43/sdio.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  6 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  4 +-
 .../net/wireless/marvell/libertas/if_sdio.c   |  2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 38 ++------
 include/linux/mmc/sdio_ids.h                  | 94 ++++++++++++++-----
 14 files changed, 120 insertions(+), 118 deletions(-)

-- 
2.20.1

