Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57983BCCF5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhGFLUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 07:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhGFLTP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 07:19:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40EE161C66;
        Tue,  6 Jul 2021 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570197;
        bh=6rF2GL9WIIQWkZO/BED3ShKt4VEZx8DQg4Uu0Zr1E20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br6wPLqKhx3JaF4+UC6rW6ktniRlDNdyMThJaWhomzyUs9z/1M3XJQRFCtvi0T2fZ
         M20I1we2YnTYjyuiRpFGDkqz34h7TFUqsYdCJrgL3JaJYLvZBnvCo6frEaF9wRxEu+
         Sk3teIjFWITZk9ls3HUSqvulqTdquXvANNIWxM5YgtFe06gwVHwzo7E0xXr7rqdaeB
         z6Gfjz8YPGUulZsiIOyN92A9e5aTJ2qv7/xDzSHVYmVKv1SzmV5uJb+pF7hH+M+RgB
         9/uUIMMJErSsvsRWTWXWWU1e3WbTKOwBWPlf36Vb13dX7L+VaexjV4QpfyhZNunnb3
         npSWDkzghoUjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 110/189] cw1200: add missing MODULE_DEVICE_TABLE
Date:   Tue,  6 Jul 2021 07:12:50 -0400
Message-Id: <20210706111409.2058071-110-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit dd778f89225cd258e8f0fed2b7256124982c8bb5 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1620788714-14300-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/st/cw1200/cw1200_sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
index b65ec14136c7..4c30b5772ce0 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
@@ -53,6 +53,7 @@ static const struct sdio_device_id cw1200_sdio_ids[] = {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200) },
 	{ /* end: all zeroes */			},
 };
+MODULE_DEVICE_TABLE(sdio, cw1200_sdio_ids);
 
 /* hwbus_ops implemetation */
 
-- 
2.30.2

