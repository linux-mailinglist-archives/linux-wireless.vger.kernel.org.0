Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8154C2D78
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiBXNna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 08:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiBXNn3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 08:43:29 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72538189ABE
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZBttjMML2bRS5AuaneloIhtMzr2JlC8uXjp8UFj1SN4=; b=XizE2KGuc70BbRk0c+2Gnj+Xb9
        5kPIIK7C34C3uPSEzo+4tsRGeCAH2liG6PbJRWVU0HuCQJk09VwreqeXf95ShaxRIru3KRCEO1qd9
        g+x+lzrCm13jmDO7cS2qiZH+vQOL1xkmHEpe3OueCUOCuQpRTu02kx7T52yDgKxw0zW8=;
Received: from p200300daa7204f00019652c85c04bce2.dip0.t-ipconnect.de ([2003:da:a720:4f00:196:52c8:5c04:bce2] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nNEOX-0003Ej-T1; Thu, 24 Feb 2022 14:42:57 +0100
Message-ID: <cb7c44ba-3a49-a0fa-b203-e23a8761a3bf@nbd.name>
Date:   Thu, 24 Feb 2022 14:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-02-24
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's a replacement for my second pull request for 5.18.
It fixes the MT7986 include issue and adds a DFS fix

- Felix

The following changes since commit a0061be4e54b52e5e4ff179c3f817107ddbb2830:

    rtw88: change rtw_info() to proper message level (2022-02-22 17:31:13 +0200)

are available in the Git repository at:

    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-02-24

for you to fetch changes up to 00a883e6806e394638d344ba281c2727d6ffcbd4:

    mt76: fix dfs state issue with 160 MHz channels (2022-02-24 14:40:23 +0100)

----------------------------------------------------------------
mt76 patches for 5.18

- bugfixes
- mt7915 thermal management improvements
- SAR support for more mt76 drivers
- mt7986 wmac support on mt7915

----------------------------------------------------------------
Bo Jiao (3):
        mt76: mt7915: Fix channel state update error issue
        mt76: mt7915: add support for MT7986
        mt76: mt7915: introduce band_idx in mt7915_phy

Chad Monroe (1):
        mt76: connac: adjust wlan_idx size from u8 to u16

Changcheng Deng (1):
        mt76: mt7915: use min_t() to make code cleaner

Deren Wu (2):
        mt76: mt7921s: fix missing fc type/sub-type for 802.11 pkts
        mt76: mt7615: fix compiler warning on frame size

Felix Fietkau (2):
        mt76: improve signal strength reporting
        mt76: fix dfs state issue with 160 MHz channels

Johan Almbladh (1):
        mt76: mt7915: fix injected MPDU transmission to not use HW A-MSDU

Lorenzo Bianconi (5):
        mt76: mt7615: introduce SAR support
        mt76: fix endianness errors in reverse_frag0_hdr_trans
        mt76: mt7915: fix endianness warnings in mt7915_debugfs_rx_fw_monitor
        mt76: mt7915: fix endianness warnings in mt7915_mac_tx_free()
        mt76: mt7921: fix injected MPDU transmission to not use HW A-MSDU

MeiChia Chiu (1):
        mt76: mt7915: fix the muru tlv issue

Nicolas Cavallari (3):
        mt76: mt7915e: Fix degraded performance after temporary overheat
        mt76: mt7915e: Add a hwmon attribute to get the actual throttle state.
        mt76: mt7915e: Enable thermal management by default

Peter Chiu (2):
        dt-bindings: net: wireless: mt76: document bindings for MT7986
        mt76: mt7915: initialize smps mode in mt7915_mcu_sta_rate_ctrl_tlv()

Ryder Lee (1):
        mt76: mt7915: check band idx for bcc event

Shayne Chen (1):
        mt76: mt7915: fix potential memory leak of fw monitor packets

Wan Jiabing (1):
        mt76: mt7915: simplify conditional

Yang Li (1):
        mt76: mt7615: Fix assigning negative values to unsigned variable

   Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |   33 +++-
   drivers/net/wireless/mediatek/mt76/mac80211.c                     |   34 +++-
   drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |    5 -
   drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |   14 +-
   drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |   42 +++--
   drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   24 +++
   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |   15 +-
   drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |    5 +
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |    8 +-
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |    2 +-
   drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |    2 -
   drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                 |   10 ++
   drivers/net/wireless/mediatek/mt76/mt7915/Makefile                |    1 +
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |   12 +-
   drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   28 ++--
   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                |   85 +++++++---
   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |   13 ++
   drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  101 +++++++++---
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  273 ++++++++++++++++---------------
   drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   21 +--
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   |  131 +++++++++------
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |    9 +
   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  132 ++++++++++++++-
   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |   43 +++++
   drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |  289 ++++++++++++++++++++++++++++++++-
   drivers/net/wireless/mediatek/mt76/mt7915/soc.c                   | 1210 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |   43 ++---
   drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |   46 ++++--
   drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   |    3 +
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |    8 +-
   drivers/net/wireless/mediatek/mt76/testmode.c                     |    5 +-
   31 files changed, 2271 insertions(+), 376 deletions(-)
   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/soc.c

