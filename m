Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00B1813A2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgCKIrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgCKIrU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D8D7AD5C;
        Wed, 11 Mar 2020 08:47:18 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 0/7] wireless: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:06 +0100
Message-Id: <20200311084713.18220-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here is a series of trivial patches just to convert suspicious
snprintf() usages with the more safer one, scnprintf().


Takashi

===

Takashi Iwai (7):
  ath11k: Use scnprintf() for avoiding potential buffer overflow
  ath5k: Use scnprintf() for avoiding potential buffer overflow
  carl9170: Use scnprintf() for avoiding potential buffer overflow
  b43: Use scnprintf() for avoiding potential buffer overflow
  b43legacy: Use scnprintf() for avoiding potential buffer overflow
  ipw2x00: Use scnprintf() for avoiding potential buffer overflow
  prism54: Use scnprintf() for avoiding potential buffer overflow

 drivers/net/wireless/ath/ath11k/debug_htt_stats.c |  12 +-
 drivers/net/wireless/ath/ath5k/debug.c            | 174 +++++++++++-----------
 drivers/net/wireless/ath/carl9170/debug.c         |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c       |   2 +-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c |   2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c      |  16 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c      |  48 +++---
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c    |   4 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c    |   8 +-
 drivers/net/wireless/intersil/prism54/oid_mgt.c   |  34 ++---
 10 files changed, 151 insertions(+), 151 deletions(-)

-- 
2.16.4

