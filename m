Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532BA2F9599
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 22:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbhAQVrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 16:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbhAQVrr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 16:47:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AD4920791;
        Sun, 17 Jan 2021 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610920023;
        bh=DsImuYJ84kSef06kOjeMCoxSqfX77ZpNBhBovu1VUQk=;
        h=From:To:Cc:Subject:Date:From;
        b=qg+GAWiiN2058uOnmEYwp4QO16n3ujB6c1vUUbTtwtgJSthnWrD3NQuKkzjLvrjmN
         vV3hwX4D0LTodb8oZFEMhRqtHMR7GN0Misj2NEdeKepjEHC3Jnp1BvYUm++uPBk1vZ
         Rue/Q64rwRMoScDFBUQ4p6p8/CDgmORwzpu092YPo6UvLoHYGtsNXaGo53RGBw3q1w
         hv10fBEteJkN9kiAC1tMoO1rrt5GdB2T5EVPa533lp9LjeCVixsq0mjOH8hBkbTIyC
         vfqsUq77aSGdkSo0zY3gSBZcrTUFySH6NtY5AeovUgEGjZ0sUrtGcbvrzTB8gCSj6t
         ka2Zoiol93vIg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, kuba@kernel.org, z.han@gmx.net
Subject: [PATCH] mt7601u: process tx URBs with status EPROTO properly
Date:   Sun, 17 Jan 2021 22:46:56 +0100
Message-Id: <72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to commit '0e40dbd56d67 ("mt7601u: process URBs in status EPROTO
properly")', do not process tx URBs if marked with status set to EPROTO.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 234e5059e5e6..85bda46d4cf9 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -237,6 +237,7 @@ static void mt7601u_complete_tx(struct urb *urb)
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 	case -ENOENT:
+	case -EPROTO:
 		return;
 	default:
 		dev_err_ratelimited(dev->dev, "tx urb failed: %d\n",
-- 
2.29.2

