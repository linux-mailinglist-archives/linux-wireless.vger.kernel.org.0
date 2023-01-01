Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC365A9DA
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjAALxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAALxe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1426DF
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F5A0B802BD
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC09C433EF;
        Sun,  1 Jan 2023 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574011;
        bh=jEKALqoj+sin182CIv6y/wjdi3d370DSGB4F57KbYmg=;
        h=From:To:Cc:Subject:Date:From;
        b=GhcnHSGgaZSd2TUKNJbBhEHhnyixuUimaT08jKhnlTkKydoznXPTCTO+xLbkWVzeO
         NJmSZDZY+tRAI2q8U/mgZzEStyxHCZBowuasPhWqB1VMPGvPWhUSZXGJXYjVm3DGy9
         Ch1GDhX28F1izEempONkSavB94uhQt40v0KG7fW2ExRJ/IfPO+oaxZySxA4sODgJZl
         HkE8oLuvEwaLO3/nGJth87f1v6S3VjGctZecbydeh7DwZX309/PcbHs8JmfQbBYpM7
         4/cU626rbNyTCOiF6MBl2DnZ4gCPY0J5bI4a2quvsxmvLoXII37AF2HrkpDOCB1/0N
         ZKblGrMJmFcFg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] mt76: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:17 +0100
Message-Id: <cover.1672573894.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid mcu_restart function pointer whenever it is possible.

Lorenzo Bianconi (6):
  wifi: mt76: mt7915: avoid mcu_restart function pointer
  wifi: mt76: mt7603: avoid mcu_restart function pointer
  wifi: mt76: mt7615: avoid mcu_restart function pointer
  wifi: mt76: mt7921: avoid mcu_restart function pointer
  wifi: mt76: mt7996: avoid mcu_restart function pointer
  wifi: mt76: remove __mt76_mcu_restart macro

 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  1 -
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  5 +--
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 45 +++++++++----------
 9 files changed, 26 insertions(+), 35 deletions(-)

-- 
2.38.1

