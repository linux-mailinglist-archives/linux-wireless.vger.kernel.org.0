Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA054811FB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Dec 2021 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbhL2LZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 06:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhL2LZ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 06:25:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A6C061574
        for <linux-wireless@vger.kernel.org>; Wed, 29 Dec 2021 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rVSrSIXxL1Nbv/u1FUheKhX8WzrX396CKWMyPDBoXZw=; b=TP8pHihklcI12PPpARc+uQ8qxD
        QRyt3tBY5fzO+SpMDnGNU6SQ0Kx/3zcQBYlzfzX4syMJWyENsBaA4QnUiYYguW5HPi9ZRyel0YPeK
        k4HRVROLpVAE7qAGCo6Unnk7xeHI50YDEYHYlNNZgB2KS/LlyKVcbHaDG+775LxR6s/M=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n2X5e-00065a-0A
        for linux-wireless@vger.kernel.org; Wed, 29 Dec 2021 12:25:54 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: connac: add support for passing the cipher field in bss_info
Date:   Wed, 29 Dec 2021 12:25:49 +0100
Message-Id: <20211229112551.46142-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize it from a field in struct mt76_vif

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4accfb5d5530..efe167f94c1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -622,6 +622,7 @@ struct mt76_vif {
 	u8 band_idx;
 	u8 wmm_idx;
 	u8 scan_seq_num;
+	enum mt76_cipher_type cipher;
 };
 
 struct mt76_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 1b2340e4ce0c..cdd82a62eeb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2701,6 +2701,7 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
 	bss->wmm_idx = mvif->wmm_idx;
 	bss->active = enable;
+	bss->cipher = mvif->cipher;
 
 	if (vif->type != NL80211_IFTYPE_MONITOR) {
 		struct cfg80211_chan_def *chandef = &phy->chandef;
-- 
2.34.1

