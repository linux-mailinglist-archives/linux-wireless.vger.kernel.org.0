Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5C3EA8D9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhHLQ4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 12:56:06 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46102 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233324AbhHLQ4F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 12:56:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id CEE3E55E350;
        Thu, 12 Aug 2021 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628787339; bh=xIPAfGFx2SjaQx4iX3nKUGtAMlgkPJ0zgt3AlqEbsjk=;
        h=From:To:Cc:Subject:Date;
        b=w4edeZVrQ6jV14XWog6DloSGp6imtLLQtT6md+osDATq+BZ8RS0JxR0LE6BkAi2dD
         MjFfPluoyAOxrv/rVOunsn5L8ZYO9quibmS8iDXNnVsDbk6ZlA2+rMn2cUg+rgdtfJ
         rQD9sINd/f51ZUYIg9PkUpzR1DlzI37Guwp9Fpsg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DBOEpX3PawlW; Thu, 12 Aug 2021 16:55:39 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id A8E5F55E344;
        Thu, 12 Aug 2021 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628787339; bh=xIPAfGFx2SjaQx4iX3nKUGtAMlgkPJ0zgt3AlqEbsjk=;
        h=From:To:Cc:Subject:Date;
        b=w4edeZVrQ6jV14XWog6DloSGp6imtLLQtT6md+osDATq+BZ8RS0JxR0LE6BkAi2dD
         MjFfPluoyAOxrv/rVOunsn5L8ZYO9quibmS8iDXNnVsDbk6ZlA2+rMn2cUg+rgdtfJ
         rQD9sINd/f51ZUYIg9PkUpzR1DlzI37Guwp9Fpsg=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-bluetooth@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v3 0/2] Add BCM43752 chipset support
Date:   Thu, 12 Aug 2021 09:52:16 -0700
Message-Id: <20210812165218.2508258-1-angus@akkea.ca>
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

Changes since v2:

Squashed patches 1 and 2.
Fixed bluetooth patch subject.

Changes since v1:

Add bluetooth patchram definition

Angus Ainslie (2):
  brcmfmac: add 43752 SDIO ids and initialization
  btbcm: add patch ram for bluetooth

 drivers/bluetooth/btbcm.c                                 | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++++--
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 include/linux/mmc/sdio_ids.h                              | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

