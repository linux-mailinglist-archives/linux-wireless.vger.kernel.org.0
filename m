Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D85432A75
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhJRXwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJRXwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19FF161002;
        Mon, 18 Oct 2021 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601027;
        bh=l1FLSKeZQbDFc5LVLl46Kj+mvckYq9q45LZc+yU5NhM=;
        h=From:To:Cc:Subject:Date:From;
        b=MFWwkE1454vIA+t6I1xNA7gsQnJLi172EX6TQM6JEeYQEhRo+nK1Zly7dLRR9Y+bd
         c6RjtcPbBoxFS8S32fehHYTyZyvAe8CbsS+KXsHrxLQ9QJN+aHw0SSKfPDPTHaWG0L
         HDtzAH+v3znikbHyoaO2nBLqnNkN1FoPEYvJwMme0NhL/YWWziYc/adkSJubNLAjSN
         kElsYHsh9yzNpwISZEwcNJvjh+I7hwtW5Pziir1q5YfDHg40tg4sqlwD0uI6Y3Sb2o
         +RUEypaj2Q27OjbL9xUElFc0wVroFH8ag8SWdAAEUPpzDjsjLdktTPgeviipPf8glo
         kPNFcsF4ch/3w==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 00/15] wireless: don't write to netdev->dev_addr directly
Date:   Mon, 18 Oct 2021 16:50:06 -0700
Message-Id: <20211018235021.1279697-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

This series prepares wireless drivers for the future where
netdev->dev_addr will be constant and all changes will have
to go thru dev_addr_set() and co.

No functional changes intended.

Jakub Kicinski (15):
  wireless: use eth_hw_addr_set()
  wireless: use eth_hw_addr_set() instead of ether_addr_copy()
  wireless: use eth_hw_addr_set() for dev->addr_len cases
  wireless: ath6kl: use eth_hw_addr_set()
  wireless: wil6210: use eth_hw_addr_set()
  wireless: atmel: use eth_hw_addr_set()
  wireless: brcmfmac: prepare for const netdev->dev_addr
  wireless: cisco: use eth_hw_addr_set()
  wireless: ipw2200: prepare for const netdev->dev_addr
  wireless: intersil: use eth_hw_addr_set()
  wireless: mac80211_hwsim: use eth_hw_addr_set()
  wireless: wilc1000: use eth_hw_addr_set()
  wireless: ray_cs: use eth_hw_addr_set()
  wireless: wl3501_cs: use eth_hw_addr_set()
  wireless: zd1201: use eth_hw_addr_set()

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  9 ++++---
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 10 ++++---
 drivers/net/wireless/ath/wil6210/main.c       |  6 ++---
 drivers/net/wireless/ath/wil6210/wil6210.h    |  2 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |  2 +-
 drivers/net/wireless/atmel/atmel.c            | 19 ++++++++-----
 .../broadcom/brcm80211/brcmfmac/core.c        |  6 ++---
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  4 +--
 drivers/net/wireless/cisco/airo.c             | 27 +++++++++----------
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  4 +--
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  | 10 +++----
 drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  2 +-
 .../net/wireless/intersil/hostap/hostap_hw.c  |  5 +++-
 .../wireless/intersil/hostap/hostap_main.c    |  4 +--
 drivers/net/wireless/intersil/orinoco/main.c  |  2 +-
 drivers/net/wireless/mac80211_hwsim.c         |  7 +++--
 drivers/net/wireless/marvell/libertas/cmd.c   |  5 ++--
 drivers/net/wireless/marvell/libertas/main.c  |  4 +--
 drivers/net/wireless/marvell/mwifiex/main.c   |  2 +-
 .../net/wireless/marvell/mwifiex/uap_event.c  |  3 +--
 .../net/wireless/microchip/wilc1000/netdev.c  | 13 ++++++---
 .../net/wireless/microchip/wilc1000/netdev.h  |  3 ++-
 drivers/net/wireless/quantenna/qtnfmac/core.c |  4 +--
 drivers/net/wireless/ray_cs.c                 |  2 +-
 drivers/net/wireless/wl3501_cs.c              |  3 +--
 drivers/net/wireless/zydas/zd1201.c           |  9 ++++---
 26 files changed, 92 insertions(+), 75 deletions(-)

-- 
2.31.1

