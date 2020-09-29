Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0327D395
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgI2QZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgI2QZx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 12:25:53 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3161C0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hcDTuZ/nMSJuBZEQWbnmm6T33RZUD+LjKUJlR8CtP2M=; b=ictJctOjLSKulal/iVSeVUxUz4
        8MxlWiixnpm3uFFNaCpiZLCWjHC6LtwvSl1AW+o//EVrWcd77suAJzy/txAFpAyHoKXLGqMvAv4jJ
        1rh4L7Dpp4m10hR/6wMo7OET1ElwJoyYq1W6+NQQkYtXslgnI19C3a4E0oeo8SNVY5o0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNIRr-00028J-8z
        for linux-wireless@vger.kernel.org; Tue, 29 Sep 2020 18:25:51 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7915: disable OFDMA/MU-MIMO UL
Date:   Tue, 29 Sep 2020 18:25:50 +0200
Message-Id: <20200929162550.83724-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929162550.83724-1-nbd@nbd.name>
References: <20200929162550.83724-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The feature is not ready in firmware yet, and it leads to hangs

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b50f5b058103..f42a54cd8d45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1552,9 +1552,7 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 
 	muru = (struct sta_rec_muru *)tlv;
 	muru->cfg.ofdma_dl_en = true;
-	muru->cfg.ofdma_ul_en = true;
 	muru->cfg.mimo_dl_en = true;
-	muru->cfg.mimo_ul_en = true;
 
 	muru->ofdma_dl.punc_pream_rx =
 		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
-- 
2.28.0

