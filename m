Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABA85867E3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Aug 2022 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiHALEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiHALEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 07:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13F2B608
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 04:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF29E60C24
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 11:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43F4C433C1
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659351887;
        bh=BHJ/VsPHNxnObMgbm+frtWpE8d59jySRMzsCsLD19CE=;
        h=From:To:Subject:Date:From;
        b=QI3o4Szk+2RpHZzQokzMHAyWcUv1OWjwnXBANjtNF3yCQ1X3F0woctJQqCwcAqYba
         1/i4JJPwIWkHP3p70tw3vHma+WgP/xgXXPDvNA9RvYvLCJtCzfqC9alNDRjWNCv9v2
         T85NyinSDS7vjV7eRxKBZkjnsDDq4b1hKyncBODfOXCvWuygjKJw1MsmT5rUoyzF86
         E8wSLfSmdO7IW0iXNFa3G+Hgijx+wScn3UJGw9epXcbf8WPujhxPEp+mwZKXbE/KiO
         VHoXHZwT3hFE8fDiLaLpcfOKVcFna1Q4p5ddLPwlmDovhRGH39mmWAfby8723JYzmy
         eVs69sXotXO9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: wilc1000: fix spurious inline in wilc_handle_disconnect()
Date:   Mon,  1 Aug 2022 14:04:40 +0300
Message-Id: <20220801110440.13144-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse warns:

drivers/net/wireless/microchip/wilc1000/hif.h:218:35: error: marked inline, but without a definition

Remove the inline, it's not needed.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
 drivers/net/wireless/microchip/wilc1000/hif.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index b89519ab9205..eb1d1ba3a443 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -635,7 +635,7 @@ static inline void host_int_parse_assoc_resp_info(struct wilc_vif *vif,
 	conn_info->req_ies_len = 0;
 }
 
-inline void wilc_handle_disconnect(struct wilc_vif *vif)
+void wilc_handle_disconnect(struct wilc_vif *vif)
 {
 	struct host_if_drv *hif_drv = vif->hif_drv;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 69ba1d469e9f..baa2881f4465 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -215,5 +215,6 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length);
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto);
 int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index);
-inline void wilc_handle_disconnect(struct wilc_vif *vif);
+void wilc_handle_disconnect(struct wilc_vif *vif);
+
 #endif

base-commit: 63757225a93353bc2ce4499af5501eabdbbf23f9
-- 
2.30.2

