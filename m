Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B95713488
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjE0LuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjE0LuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 07:50:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31DBB
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 04:50:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2533d3acd5fso1653863a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685188207; x=1687780207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWsjFR94Phpdh+glKNnUus2IdL1kIGvooNAYmU6Uoa8=;
        b=QpuYPhXVosDC/xp2+fJvv9oKv1dkY8A6/4gCj3daNHeQu9oAsNEdHCerOiri8lqRrS
         P7D047ynCUGjgPCoxmmtm/7zCP4yoSMaf6ZzPq4kbSaLD2+/4JqXqsh1kj1/N6TdFRBF
         HeEb1EBOisNwX/cpGOzG7hyNV2FOMJLAuamLtUQvcfNmEsLBiFN0TXBfghjePjhiGONY
         syVmb+bUWijbJxUbqSCk+pUlqcQAno4ogAKm4Zw7IMTKnBlXPTpJQNlP0s7FKWZ7TgkW
         zp31dxN3O9vU3zlEYxDW/LdVL/pzbSbfo50J6KApNFx/pcfAvlJcGrWSIenLzI+uogpQ
         ZwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685188207; x=1687780207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWsjFR94Phpdh+glKNnUus2IdL1kIGvooNAYmU6Uoa8=;
        b=ixdKhk9/sDLAf2dFBYwMdPJUXNQXGzcxLfj0mHTCLJlBDOlvkR4s10DN2A3XnVplH5
         bMwwt9a2zd1qPPEZppp22PYqyCD9qY/d9jJMYfMfXZ4alS+NuQ8eqUJNHflIPKgi1hLQ
         uyeT6ZzIYtQmYjlkW0gIaJtpwmEFiO2IDFIA1OA5ayY6nCUA+TStkfW7UKGz8ftB/n1Q
         kMQwgajg/YBY7SC/NxYI7XlMeAMHOODNc2Bov3tNOlkiEZLSnCe2tPZZZOPWo4jZ7NFu
         EQYEJh1pefqWAK+14gg8f8mBSbEPvboRfFhsMRff50Ap+tPl9u2zRn3PEdtJ6KZ1IMR3
         qZqA==
X-Gm-Message-State: AC+VfDxv588GCEr607zUCcdyTFfrM1quxoNi3d1oDiZQGN8ke02E0XMw
        q5ATYeQrlwDxMtL64xVDh7ybVR/pySKvmg==
X-Google-Smtp-Source: ACHHUZ7BJIF8lt/PzqKaeu1tKAcYNLjiNr+JCJcPSRllJDN641SC7PVfHQP29ul+QzKjybtdTMZmCw==
X-Received: by 2002:a17:902:b284:b0:1ac:4163:317 with SMTP id u4-20020a170902b28400b001ac41630317mr5287168plr.39.1685188207391;
        Sat, 27 May 2023 04:50:07 -0700 (PDT)
Received: from 6-0-u2204.. ([182.209.58.11])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001ac741dfd29sm4723163plo.295.2023.05.27.04.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:50:06 -0700 (PDT)
From:   Juhee Kang <claudiajkang@gmail.com>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Juhee Kang <claudiajkang@gmail.com>
Subject: [PATCH wireless-next 1/2] wifi: rtlwifi: use helper function rtl_get_hdr()
Date:   Sat, 27 May 2023 20:49:53 +0900
Message-Id: <20230527114954.3281-1-claudiajkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Although rtl_get_hdr was added in commit 3dad618b7b92 ("rtlwifi: Change
wifi.h for rtl8192se and rtl8192de"), it is currently not being utilized
in some areas. This commit replaces the open code with the rtl_get_hdr()
function.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c          | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c           | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 9e7e98b55eff..36ae9ba3ac01 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1905,7 +1905,7 @@ EXPORT_SYMBOL(rtl_rx_ampdu_apply);
 void rtl_beacon_statistic(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 
 	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
 		return;
@@ -1991,7 +1991,7 @@ void rtl_scan_list_expire(struct ieee80211_hw *hw)
 void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	unsigned long flags;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index 6e4741e9483f..65ebe52883d3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -674,7 +674,7 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	u8 fw_queue = QSLT_BEACON;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 
 	dma_addr_t mapping = dma_map_single(&rtlpci->pdev->dev, skb->data,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 730c7e939bd2..5376bb34251f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -527,7 +527,7 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	u8 fw_queue = QSLT_BEACON;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 
 	dma_addr_t mapping = dma_map_single(&rtlpci->pdev->dev, skb->data,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index ae3c4f97637e..b70767e72f3d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -394,7 +394,7 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 				 (struct rx_desc_92c *)rxdesc, p_drvinfo);
 	}
 	skb_pull(skb, (drvinfo_len + RTL_RX_DESC_SIZE));
-	hdr = (struct ieee80211_hdr *)(skb->data);
+	hdr = rtl_get_hdr(skb);
 	fc = hdr->frame_control;
 	bv = ieee80211_is_probe_resp(fc);
 	if (bv)
@@ -632,7 +632,7 @@ void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 fw_queue = QSLT_BEACON;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 807b66c16e11..c09c0c312665 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -665,7 +665,7 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u8 fw_queue = QSLT_BEACON;
 
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index 27fddbcade32..7f294e698994 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -528,7 +528,7 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	u8 fw_queue = QSLT_BEACON;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 
 	dma_addr_t mapping = dma_map_single(&rtlpci->pdev->dev, skb->data,
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index a8eebafb9a7e..ab675703eaf5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -433,7 +433,7 @@ static void _rtl_usb_rx_process_agg(struct ieee80211_hw *hw,
 	skb_pull(skb, RTL_RX_DESC_SIZE);
 	rtlpriv->cfg->ops->query_rx_desc(hw, &stats, &rx_status, rxdesc, skb);
 	skb_pull(skb, (stats.rx_drvinfo_size + stats.rx_bufshift));
-	hdr = (struct ieee80211_hdr *)(skb->data);
+	hdr = rtl_get_hdr(skb);
 	fc = hdr->frame_control;
 	if (!stats.crc) {
 		memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
@@ -475,7 +475,7 @@ static void _rtl_usb_rx_process_noagg(struct ieee80211_hw *hw,
 	skb_pull(skb, RTL_RX_DESC_SIZE);
 	rtlpriv->cfg->ops->query_rx_desc(hw, &stats, &rx_status, rxdesc, skb);
 	skb_pull(skb, (stats.rx_drvinfo_size + stats.rx_bufshift));
-	hdr = (struct ieee80211_hdr *)(skb->data);
+	hdr = rtl_get_hdr(skb);
 	fc = hdr->frame_control;
 	if (!stats.crc) {
 		memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
@@ -926,7 +926,7 @@ static void _rtl_usb_tx_preprocess(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct rtl_tx_desc *pdesc = NULL;
 	struct rtl_tcb_desc tcb_desc;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 	u8 *pda_addr = hdr->addr1;
 
@@ -961,7 +961,7 @@ static int rtl_usb_tx(struct ieee80211_hw *hw,
 {
 	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_hdr *hdr = rtl_get_hdr(skb);
 	__le16 fc = hdr->frame_control;
 	u16 hw_queue;
 
-- 
2.34.1

