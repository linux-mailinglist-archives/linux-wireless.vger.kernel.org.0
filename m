Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E425F44A2C9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 02:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhKIBVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 20:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243633AbhKIBTU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 20:19:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A080161AFF;
        Tue,  9 Nov 2021 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636420064;
        bh=pOrxFxrKzxbVL3SNg/nmJ9I+n9m57O5vX32HBO8ZiTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4d7Pg3RZWb6rja1h/wTI21zf0UML8iYCjPFN8f9wqc49MUy0NVnV2tHSKjF0klcA
         52wWjSjIYWAv6nLA9JY/tUqoxP3UX8tKt1p6/wv992rOLtPr6N01PrNly07/PzCmCL
         aPDZ+5/hgYsUOAmm2Nj+nbgHGS0MYVO3kacMhQExR1PPfmKyLTAwgYVeE0YmQ3B3zt
         J0b46OIULPquwayRwpBYaYPs2aOR3dMqkI20e0trTIf34osNwbYBdjJlhCDWdvyUtl
         vZSwrxpyi3bAM23A/Lkh/X6M08SlVjXSnLGkp1jR6f9Ofdoin6UguOF0l6KT2B7HEr
         eAgRtA6XflS8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheyu Ma <zheyuma97@gmail.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, buytenh@wantstofly.org,
        davem@davemloft.net, kuba@kernel.org, keescook@chromium.org,
        wengjianfeng@yulong.com, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, lyl2019@mail.ustc.edu.cn,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/39] mwl8k: Fix use-after-free in mwl8k_fw_state_machine()
Date:   Mon,  8 Nov 2021 20:06:39 -0500
Message-Id: <20211109010649.1191041-29-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109010649.1191041-1-sashal@kernel.org>
References: <20211109010649.1191041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zheyu Ma <zheyuma97@gmail.com>

[ Upstream commit 257051a235c17e33782b6e24a4b17f2d7915aaec ]

When the driver fails to request the firmware, it calls its error
handler. In the error handler, the driver detaches device from driver
first before releasing the firmware, which can cause a use-after-free bug.

Fix this by releasing firmware first.

The following log reveals it:

[    9.007301 ] BUG: KASAN: use-after-free in mwl8k_fw_state_machine+0x320/0xba0
[    9.010143 ] Workqueue: events request_firmware_work_func
[    9.010830 ] Call Trace:
[    9.010830 ]  dump_stack_lvl+0xa8/0xd1
[    9.010830 ]  print_address_description+0x87/0x3b0
[    9.010830 ]  kasan_report+0x172/0x1c0
[    9.010830 ]  ? mutex_unlock+0xd/0x10
[    9.010830 ]  ? mwl8k_fw_state_machine+0x320/0xba0
[    9.010830 ]  ? mwl8k_fw_state_machine+0x320/0xba0
[    9.010830 ]  __asan_report_load8_noabort+0x14/0x20
[    9.010830 ]  mwl8k_fw_state_machine+0x320/0xba0
[    9.010830 ]  ? mwl8k_load_firmware+0x5f0/0x5f0
[    9.010830 ]  request_firmware_work_func+0x172/0x250
[    9.010830 ]  ? read_lock_is_recursive+0x20/0x20
[    9.010830 ]  ? process_one_work+0x7a1/0x1100
[    9.010830 ]  ? request_firmware_nowait+0x460/0x460
[    9.010830 ]  ? __this_cpu_preempt_check+0x13/0x20
[    9.010830 ]  process_one_work+0x9bb/0x1100

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1634356979-6211-1-git-send-email-zheyuma97@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwl8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index e39aaee92addb..d5f766044221a 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5788,8 +5788,8 @@ static void mwl8k_fw_state_machine(const struct firmware *fw, void *context)
 fail:
 	priv->fw_state = FW_STATE_ERROR;
 	complete(&priv->firmware_loading_complete);
-	device_release_driver(&priv->pdev->dev);
 	mwl8k_release_firmware(priv);
+	device_release_driver(&priv->pdev->dev);
 }
 
 #define MAX_RESTART_ATTEMPTS 1
-- 
2.33.0

