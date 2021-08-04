Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE87D3E09F8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhHDVVf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 17:21:35 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46080 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhHDVVe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 17:21:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8EE7355E34F;
        Wed,  4 Aug 2021 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628111540; bh=4dE2NGlNch+XUI3o7qPjT+5wP/W535FSe3wPOINJFsk=;
        h=From:To:Cc:Subject:Date;
        b=v9Njar4ydKqSjJbuYDWrEmM3EW41O0BP+IJ8J4GwCCOLaAZVMCdiPYrVM1KT45wb6
         9M1n/OgXCDfUrQIuiyx5j8kikHUoiU8UfBvrMExtkdoVLzCMWDim587QU4MPNUIg8R
         Kae0f6XQBGmJnVFtAkEfznOvlq2TD3sZZ+c9d1xQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qna9pl6cp0Cf; Wed,  4 Aug 2021 21:12:20 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id B379F55E34B;
        Wed,  4 Aug 2021 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628111540; bh=4dE2NGlNch+XUI3o7qPjT+5wP/W535FSe3wPOINJFsk=;
        h=From:To:Cc:Subject:Date;
        b=v9Njar4ydKqSjJbuYDWrEmM3EW41O0BP+IJ8J4GwCCOLaAZVMCdiPYrVM1KT45wb6
         9M1n/OgXCDfUrQIuiyx5j8kikHUoiU8UfBvrMExtkdoVLzCMWDim587QU4MPNUIg8R
         Kae0f6XQBGmJnVFtAkEfznOvlq2TD3sZZ+c9d1xQ=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 0/2] Add BCM43752 chipset support
Date:   Wed,  4 Aug 2021 14:11:09 -0700
Message-Id: <20210804211111.1452779-1-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The SparkLan AP6275 SDIO M.2 card contains a BCM43752 based module and these
patches were tested with that card.

This was tested on the 5.13 kernel with a minor substition BRCMF_FW_DEF for
BRCMF_FW_CLM_DEF.

It should apply and build on the wireless-next branch.

TODO: Get bluetooth support working

Angus Ainslie (2):
  brcmfmac: add 43752 device ids
  brcmfmac: add initializers for the 43752

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++++--
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 include/linux/mmc/sdio_ids.h                              | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

