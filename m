Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3878347EE5B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbhLXK6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbhLXK6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC89C061401
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 02:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7E216202C
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB417C36AE5;
        Fri, 24 Dec 2021 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343508;
        bh=NvkmWuT2MtREdzzJV+V4f5kWpkEA9d15YkA5TDjg3QQ=;
        h=From:To:Cc:Subject:Date:From;
        b=IgycgbBZyQoj/sQrpPanuqiaPjHTg1fxOubeJKJQAbsQhtzzwcByHLyMHjjNxKzKn
         wMSp1ukLdbfPAK8UMZ1ngzZg6HDpnedusksWOrtI/b/yCC/m8gvmvHuE1rx6ONuSX5
         FwueiqyPOHnW7h4giehWA2vBXGfcD/cC7TdYg+JnyC7sGDnj+2I4xVROiE4auRqTGq
         NC/3kli43bH8V1N5P++yMY9LWoAp/+/XJJl3/TYPqFtMsiEMKlKkJ38BPvdXNT/lm8
         B9YZZim7iHfxvOmD3UljMeCVTHzUIJn86R1MMZ/fvTNv+jAa2Y6gRrJDl+olZBJWsQ
         aM98Z4d1bVW0Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 00/10] move duplicated mt7915 code in mt76-connac
Date:   Fri, 24 Dec 2021 11:58:01 +0100
Message-Id: <cover.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move some more mt7915 code in mt76-connac module.
This series is based on the following one:
https://patchwork.kernel.org/project/linux-wireless/cover/cover.1640260901.git.lorenzo@kernel.org/

Lorenzo Bianconi (10):
  mt76: connac: introduce is_connac_v1 utility routine
  mt76: connac: move mt76_connac_mcu_set_pm in connac module
  mt76: mt7921: get rid of mt7921_mcu_get_eeprom
  mt76: mt7915: rely on mt76_connac_mcu_start_firmware
  mt76: connac: move mt76_connac_mcu_restart in common module
  mt76: mt7915: rely on
    mt76_connac_mcu_patch_sem_ctrl/mt76_connac_mcu_start_patch
  mt76: mt7915: rely on mt76_connac_mcu_init_download
  mt76: connac: move mt76_connac_mcu_gen_dl_mode in mt76-connac module
  mt76: mt7915: rely on mt76_connac_mcu_set_rts_thresh
  mt76: connac: move mt76_connac_mcu_rdd_cmd in mt76-connac module

 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  23 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  81 +------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  21 --
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  23 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  82 +++++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  44 +++-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  23 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  13 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 197 +-----------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  76 +------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 -
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |   2 +-
 14 files changed, 195 insertions(+), 398 deletions(-)

-- 
2.33.1

