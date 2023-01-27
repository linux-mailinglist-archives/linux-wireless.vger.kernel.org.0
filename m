Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01A67E7C2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 15:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjA0OIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 09:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjA0OIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 09:08:41 -0500
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 06:08:39 PST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB2113C0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 06:08:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 324C0100A854F;
        Fri, 27 Jan 2023 15:01:08 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0B5DD602EB97;
        Fri, 27 Jan 2023 15:01:08 +0100 (CET)
X-Mailbox-Line: From 111c7ee895f12d951e95a2edcd06d87ca26a7d0f Mon Sep 17 00:00:00 2001
Message-Id: <cover.1674827105.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 27 Jan 2023 15:00:00 +0100
Subject: [PATCH 0/3] mwifiex material for next
To:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Matt Ranostay <mranostay@ti.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Amend mwifiex with a missing compatible string, add support for
SD8978 chips (aka IW416) and silence a gratuitous message on probe.

The firmware for SD8978 is available at the following URL, I've reached
out to NXP to get it into the linux-firmware repository:

https://github.com/NXP/imx-firmware/raw/lf-5.15.52_2.1.0/nxp/FwImage_IW416_SD/sdiouartiw416_combo_v0.bin

Thanks!

Lukas Wunner (3):
  wifi: mwifiex: Add missing compatible string for SD8787
  wifi: mwifiex: Support SD8978 chipset
  wifi: mwifiex: Support firmware hotfix version in GET_HW_SPEC
    responses

 .../bindings/net/wireless/marvell-8xxx.txt    |  4 ++-
 drivers/net/wireless/marvell/mwifiex/Kconfig  |  5 ++--
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  5 ++++
 drivers/net/wireless/marvell/mwifiex/fw.h     |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 26 +++++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  1 +
 include/linux/mmc/sdio_ids.h                  |  1 +
 7 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.39.1

