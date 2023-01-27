Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D467E819
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjA0OVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 09:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjA0OVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 09:21:41 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FD7F32D
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 06:21:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id C0AB6101B3A96;
        Fri, 27 Jan 2023 15:21:37 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 90E746029A9F;
        Fri, 27 Jan 2023 15:21:37 +0100 (CET)
X-Mailbox-Line: From 111c7ee895f12d951e95a2edcd06d87ca26a7d0f Mon Sep 17 00:00:00 2001
Message-Id: <111c7ee895f12d951e95a2edcd06d87ca26a7d0f.1674827105.git.lukas@wunner.de>
In-Reply-To: <cover.1674827105.git.lukas@wunner.de>
References: <cover.1674827105.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 27 Jan 2023 15:03:00 +0100
Subject: [PATCH 3/3] wifi: mwifiex: Support firmware hotfix version in
 GET_HW_SPEC responses
To:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Matt Ranostay <mranostay@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support the firmware hotfix version in GET_HW_SPEC responses to avoid an
irritating "Unknown api_id: 5" message on probe.

Based on this commit in NXP's GPLv2-licensed out-of-tree driver:
https://github.com/nxp-imx/mwifiex/commit/27fd8ecca504

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 5 +++++
 drivers/net/wireless/marvell/mwifiex/fw.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index d3339d67e7a0..3756aa247e77 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -1607,6 +1607,11 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *priv,
 						    api_rev->major_ver,
 						    api_rev->minor_ver);
 					break;
+				case FW_HOTFIX_VER_ID:
+					mwifiex_dbg(adapter, INFO,
+						    "Firmware hotfix version %d\n",
+						    api_rev->major_ver);
+					break;
 				default:
 					mwifiex_dbg(adapter, FATAL,
 						    "Unknown api_id: %d\n",
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index b4f945a549f7..c32478dfe357 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1048,6 +1048,7 @@ enum API_VER_ID {
 	FW_API_VER_ID = 2,
 	UAP_FW_API_VER_ID = 3,
 	CHANRPT_API_VER_ID = 4,
+	FW_HOTFIX_VER_ID = 5,
 };
 
 struct hw_spec_api_rev {
-- 
2.39.1

