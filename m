Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07E314DA9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhBIK5Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 05:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232144AbhBIKzE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F6E64DC3;
        Tue,  9 Feb 2021 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868063;
        bh=ew1IiFmXF5iXC+PcTP3UBWWnHt0VLa9e330DM0XbHzk=;
        h=From:To:Cc:Subject:Date:From;
        b=mwfDeRLJubv3fb0w8FPGzE2/Tl2SZTY2NCcj5PepVrCQ4WXCn3f5WVncQh4MPz8d9
         2HF+MIK/ZXRlUSnHw3WexV4DfiXr9B4YA8XiINY5RatgzmvGHcsCTMuh4qxJUgrbFJ
         mIWm06PqOHccR0wMoSD96WmYnIgoJ/H89Db9w6j3JKduuRyURVFTKuY2rbX9XgqyG+
         2HR7Kyq9MrE8aYC/U9bfqlXw/I97L5OLGaoRh+gv7XPvoBM16Zb77LRzRq0nAHjcbe
         1SPpE8zAQGljEgw0jPkBZhydpeyivIW7czqVM6WHfUkB3PhZe3BZ5+BuWB2UHAzOFN
         KRqGVsFeTSviQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/6] mt76: mt7921: multiple fixes
Date:   Tue,  9 Feb 2021 11:54:01 +0100
Message-Id: <cover.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Align mt7921 driver to fw APIs available in linux-firmware.
Fix uninitialized pointer access.

Sean Wang (6):
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
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 152 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  13 +-
 8 files changed, 128 insertions(+), 92 deletions(-)

-- 
2.29.2

