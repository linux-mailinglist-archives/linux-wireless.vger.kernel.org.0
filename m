Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA710AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEAQIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfEAQIM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:12 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EB8208C3;
        Wed,  1 May 2019 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726892;
        bh=p0pM4ds5VgHEO7Po2dA2WfcwN77IKFCAw8XlpegZ6gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYdN53u8tW7LIYC3lH4pQ0xhD/VAHm0RMxT2JKxV5odymDRGlmyKOIb2p9sGVNvOw
         eQbHMlxnRnlue46naCjYDNpHE9FT1910dlg/9pUCmcEQHc4kynSrDUIdjTUDXmyPqS
         2OZm6fj+LgpIMoqCXdZeHdm4GJ/dGLBBowBobCPQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 13/17] mt7615: mcu: remove unused structure in mcu.h
Date:   Wed,  1 May 2019 18:07:35 +0200
Message-Id: <acab1e29e880af8d20cc3df3c573ac8a18f507a6.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 9455f8fa475d..2d3f88ed8dc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -131,41 +131,11 @@ enum {
 #define CONN_STATE_CONNECT	1
 #define CONN_STATE_PORT_SECURE	2
 
-struct dev_info {
-	u8 omac_idx;
-	u8 omac_addr[ETH_ALEN];
-	u8 band_idx;
-	u8 enable;
-	u32 feature;
-};
-
 enum {
 	DEV_INFO_ACTIVE,
 	DEV_INFO_MAX_NUM
 };
 
-struct bss_info {
-	u8 bss_idx;
-	u8 bssid[ETH_ALEN];
-	u8 omac_idx;
-	u8 band_idx;
-	u8 bmc_tx_wlan_idx; /* for bmc tx (sta mode use uc entry) */
-	u8 wmm_idx;
-	u32 network_type;
-	u32 conn_type;
-	u16 bcn_interval;
-	u8 dtim_period;
-	u8 enable;
-	u32 feature;
-};
-
-struct bss_info_tag_handler {
-	u32 tag;
-	u32 len;
-	void (*handler)(struct mt7615_dev *dev,
-			struct bss_info *bss_info, struct sk_buff *skb);
-};
-
 struct bss_info_omac {
 	__le16 tag;
 	__le16 len;
-- 
2.20.1

