Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D671572E4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBJKeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 05:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJKeU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 05:34:20 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521352080C;
        Mon, 10 Feb 2020 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581330860;
        bh=iq/s7ZU08EZ9O1xLJqzdSI+RupWqf3ZRZA+XCjEXXrM=;
        h=From:To:Cc:Subject:Date:From;
        b=mc48/iHD0JpL46Ojxe9F7gQ7sYiV2PHHWNCmcptTa7i/icNKvVoZN0keO7t72pu/z
         cy7sBQpc3NLLxqUcauk0+rgpR1+gvhZai1LHkM7mHurTwu8ev4a81gnk4KTlJfSlar
         EVg8OmK54lWT28XiaYCdejHo8Rv+3Ks3rN8U5McI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt76u: extend RX scatter gather number
Date:   Mon, 10 Feb 2020 11:34:00 +0100
Message-Id: <42e3b88414f473af278b4584b2f1d76b06ddd82a.1581328358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

From: Sean Wang <sean.wang@mediatek.com>

Set RX scatter gather number to 4 in order to extend the maximum AMSDU
size to 11,454.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 73a941a11429..8a4445778ec7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -397,7 +397,7 @@ struct mt76_mcu {
 };
 
 #define MT_TX_SG_MAX_SIZE	8
-#define MT_RX_SG_MAX_SIZE	1
+#define MT_RX_SG_MAX_SIZE	4
 #define MT_NUM_TX_ENTRIES	256
 #define MT_NUM_RX_ENTRIES	128
 #define MCU_RESP_URB_SIZE	1024
-- 
2.24.1

