Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0243E9489
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhHKP2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 11:28:48 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46084 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhHKP2r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 11:28:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C534B55E350;
        Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695703; bh=Y4ULleic4sLidZQr1bzS1iGOtw+QruSKGl5LtE0tSF0=;
        h=From:To:Cc:Subject:Date;
        b=Eb/Ulj1viguUt+K4SSc8jdRdpmH76HYb+5yNB/65dr/wFZMD8FAe+t0LDl8F+ePt6
         5UdOUQAwWdKUm4suDCYPAc78FR/YQUOem7s5UOCvmL5MyTS1/N/Q4WAzeV63MjmCDy
         c5G1hHNtS/4ah+e7IOMCODxvabpXpeEzD7Omc0Rc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xQ8an2An3ZS9; Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 0E95D55E344;
        Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695703; bh=Y4ULleic4sLidZQr1bzS1iGOtw+QruSKGl5LtE0tSF0=;
        h=From:To:Cc:Subject:Date;
        b=Eb/Ulj1viguUt+K4SSc8jdRdpmH76HYb+5yNB/65dr/wFZMD8FAe+t0LDl8F+ePt6
         5UdOUQAwWdKUm4suDCYPAc78FR/YQUOem7s5UOCvmL5MyTS1/N/Q4WAzeV63MjmCDy
         c5G1hHNtS/4ah+e7IOMCODxvabpXpeEzD7Omc0Rc=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 0/3] Add BCM43752 chipset support
Date:   Wed, 11 Aug 2021 08:28:01 -0700
Message-Id: <20210811152804.2379405-1-angus@akkea.ca>
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

Changes since v1:

Add bluetooth patchram definition

Angus Ainslie (3):
  brcmfmac: add 43752 device ids
  brcmfmac: add initializers for the 43752
  brcmfmac: add patch ram for bluetooth

 drivers/bluetooth/btbcm.c                                 | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++++--
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 include/linux/mmc/sdio_ids.h                              | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

