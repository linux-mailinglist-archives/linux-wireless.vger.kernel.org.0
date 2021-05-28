Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21906393FF2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhE1JaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhE1JaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 05:30:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC79C061574
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FJl7C8vEi7NangR8E5w2GX30x5jMerMj1qgKkLQpDmE=; b=tEY8fDxE/lcA55PzqaYQuJFrpM
        4Sg3XaTtYOpJfIV3ic9E9bIj37VWcS/So6aCLgDOv9651y8iMZFXtWqxrwxppc8vdnWROsT1ASx1A
        YEFPhLJUNiXUgHdqbS0TTUyu7wEr0uNumeKqq9qXiC8iyQh/wsXgTxufgbTkQnYAMYJ4=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lmYnB-0005Zb-BE
        for linux-wireless@vger.kernel.org; Fri, 28 May 2021 11:28:33 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH RESEND] mt76: connac: add bss color support for sta mode
Date:   Fri, 28 May 2021 11:28:31 +0200
Message-Id: <20210528092831.18896-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <yn.chen@mediatek.com>

Add bss color support for sta mode

Signed-off-by: Jayden.Kuo <jayden.kuo@mediatek.com>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f1feadd2583f..73359defa176 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1309,6 +1309,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				u8 pad[3];
 			} __packed hdr;
 			struct bss_info_uni_he he;
+			struct bss_info_uni_bss_color bss_color;
 		} he_req = {
 			.hdr = {
 				.bss_idx = mvif->idx,
@@ -1317,8 +1318,21 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
 				.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
 			},
+			.bss_color = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_BSS_COLOR),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_bss_color)),
+				.enable = 0,
+				.bss_color = 0,
+			},
 		};
 
+		if (enable) {
+			he_req.bss_color.enable =
+				vif->bss_conf.he_bss_color.enabled;
+			he_req.bss_color.bss_color =
+				vif->bss_conf.he_bss_color.color;
+		}
+
 		mt76_connac_mcu_uni_bss_he_tlv(phy, vif,
 					       (struct tlv *)&he_req.he);
 		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8f4d85b148fb..d64b8058b744 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -575,6 +575,7 @@ enum {
 enum {
 	UNI_BSS_INFO_BASIC = 0,
 	UNI_BSS_INFO_RLM = 2,
+	UNI_BSS_INFO_BSS_COLOR = 4,
 	UNI_BSS_INFO_HE_BASIC = 5,
 	UNI_BSS_INFO_BCN_CONTENT = 7,
 	UNI_BSS_INFO_QBSS = 15,
@@ -789,6 +790,14 @@ struct mt76_connac_sched_scan_done {
 	__le16 pad;
 } __packed;
 
+struct bss_info_uni_bss_color {
+	__le16 tag;
+	__le16 len;
+	u8 enable;
+	u8 bss_color;
+	u8 rsv[2];
+} __packed;
+
 struct bss_info_uni_he {
 	__le16 tag;
 	__le16 len;
-- 
2.30.1

