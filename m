Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2E31FDDA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSR3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSR3o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:29:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC4364E60;
        Fri, 19 Feb 2021 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755744;
        bh=RLxIUgrALxfhdEGPBa0Igym/pyM0M5sKNWfkGeXeaMo=;
        h=From:To:Cc:Subject:Date:From;
        b=L5gZuMrKHhHtHOHP3nPzB0sv0RDiqa6qqm+1aBWFUhHCD0lwbsYhkA0+k5vDwxZM1
         kr0+m+cDG9CB11/i0BLH5qI63u5brWs9JNjIFDeX50s5S2qQ/EZ9UTb6ffEU1XsT13
         PB4aQSDpFhB03fw1Tjv9IY9EpRKBnI/J7Eq2gSe8vaaIjDhVTYxcqXJxbBzdQ3+css
         h5RAh7pdikqUNF+KNz4UwjZETcDy9W5OWbZP8GtUW0MR3e/Aqd1DNkzdWKdzJcJlMc
         X7YxCsg+Hu4CblYnIwbc7G59W4eu6EBgD7D/1PQDBztC/Phu6FxmyVE9xXZNhA8Dq8
         mZahqyx6sbDgA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 0/8] mt76: mt7921: multiple fixes
Date:   Fri, 19 Feb 2021 18:28:43 +0100
Message-Id: <cover.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Align mt7921 driver to fw APIs available in linux-firmware.
Fix uninitialized pointer access.
Fix memory leak in mt7921_coredump_work
Fix suspend/resume sequence.

Changes since v1:
- drop unused variable reading rx stats
- fix suspend/resume sequence patch
- fix memory leak in mt7921_coredump_work patch

Sean Wang (8):
  mt76: mt7921: fix suspend/resume sequence
  mt76: mt7921: fix memory leak in mt7921_coredump_work
  mt76: mt7921: switch to new api for hardware beacon filter
  mt76: connac: fix up the setting for ht40 mode in
    mt76_connac_mcu_uni_add_bss
  mt76: mt7921: fixup rx bitrate statistics
  mt76: mt7921: add flush operation
  mt76: mt7921: fix uninitialized pointer access in mt7921_get_wtbl_info
  mt76: connac: update sched_scan cmd usage

 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   5 -
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   9 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  14 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 161 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  59 +++++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  14 +-
 9 files changed, 172 insertions(+), 118 deletions(-)

-- 
2.29.2

