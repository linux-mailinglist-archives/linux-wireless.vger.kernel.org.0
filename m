Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0081835B4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCLQCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgCLQCo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:02:44 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFE8206F1;
        Thu, 12 Mar 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028964;
        bh=euRJn0mOOJd00VYcOTmDdNvfx80mwqpiK69DIWPE0cQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eL+d2HP6nX4FdL+AKV8y5avSbBje25UDT2EPo0ZdW/aZnIZhocsdvPjyZMzJEXVHf
         6hL3mYVRvHMLhxWAwenHgnBuwPhYCi7YvrSinSUZuL33YtWHw0ahUom/TZ3vTJ9gaa
         sA++xRf0xncWYJfZ3tRXUZHiAWn9DqlsE4AzmPpw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 00/25] Introduce mt7663e support to mt7615 driver
Date:   Thu, 12 Mar 2020 17:02:10 +0100
Message-Id: <cover.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663e 802.11ac 2x2:2 chipset to mt7615 driver.
Introduce mt7615e_reg_map and mt7663e_regmap to reuse mt7615 code.
MCU code refactoring.
Introduce UNI MCU commands.

Changes since v2:
- fix nss configuration
- remove mt7615_mcu_uni_set_state routine

Changes since v1:
- MCU code refactoring
- Introduce UNI MCU commands for firmware v3
- add firmware v3 support

Lorenzo Bianconi (25):
  mt76: mt7615: introduce mt7615_mcu_fill_msg
  mt76: mt7615: introduce mt7615_mcu_wait_response
  mt76: mt7615: cleanup fw queue just for mmio devices
  mt76: mt7615: introduce mt7615_init_device routine
  mt76: always init to 0 mcu messages
  mt76: mt7615: introduce mt7615_mcu_send_message routine
  mt76: mt7615: add mt7615_mcu_ops data structure
  mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops
  mt76: mt7615: move mt7615_mcu_set_sta in mt7615_mcu_ops
  mt76: mt7615: rely on skb API for mt7615_mcu_set_eeprom
  mt76: mt7615: rework mt7615_mcu_set_bss_info using skb APIs
  mt76: mt7615: move more mcu commands in mt7615_mcu_ops data structure
  mt76: mt7615: introduce MCU_FW_PREFIX for fw mcu commands
  mt76: mt7615: introduce mt7615_register_map
  mt76: mt7615: add mt7663e support to mt7615_reg_map
  mt76: mt7615: add mt7663e support to mt7615_{driver,firmware}_own
  mt76: mt7615: add mt7663e support to mt7615_mcu_set_eeprom
  mt76: mt7615: introduce mt7615_eeprom_parse_hw_band_cap routine
  mt76: mt7615: introduce mt7615_init_mac_chain routine
  mt76: mt7615: introduce uni cmd command types
  mt76: mt7615: introduce set_bmc and st_sta for uni commands
  mt76: mt7615: add more uni mcu commands
  mt76: mt7615: introduce set_ba uni command
  mt76: mt7615: get rid of sta_rec_wtbl data structure
  mt76: mt7615: introduce mt7663e support

 drivers/net/wireless/mediatek/mt76/mcu.c      |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |    4 +
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |    1 -
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   50 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   66 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |    2 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  157 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   23 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   11 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   36 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 2745 ++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   93 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   67 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   63 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |    8 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   87 +-
 .../net/wireless/mediatek/mt76/mt7615/soc.c   |    2 +-
 17 files changed, 2134 insertions(+), 1287 deletions(-)

-- 
2.24.1

