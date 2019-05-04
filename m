Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6313AF5
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEDP3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfEDP3s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:48 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A755C20644;
        Sat,  4 May 2019 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983787;
        bh=R9qhjjmHV8wchqd5xN6iRy9wTVi/T8hWa1CL/4bCEGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4YMPgZpzzSxtyohSbfFoKgY4eUSqNXG3bkJbgxqXvsOk00fIzEtqlkpha46vN0JC
         3Y2cn+283pavdEGqAEUYYAx3zfiXEdkBa3zyqaf55iD2P//+3TQ0UO3vWMS8zvbkgy
         Sx8AqqZVK9G0TPx8bzNf5e1KlPGCU5xyV0FY3084=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 13/17] mt7615: mcu: remove unused structure in mcu.h
Date:   Sat,  4 May 2019 17:29:05 +0200
Message-Id: <94788a284a514977661e809cbf2bc7c3ae091715.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove following struct no longer used:
- dev_info
- bss_info
- bss_info_tag_handler

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

