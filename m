Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E4761E68
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGYQYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGYQYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 12:24:11 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337E910CC
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 09:24:05 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id D324C60046;
        Tue, 25 Jul 2023 19:24:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2ONSKkeDVKo0-AxkVwcmN;
        Tue, 25 Jul 2023 19:24:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690302242;
        bh=6wNDG5qLNi2ci8yLIH3z1ZhsmzAP7ARa4+4mwYTRpuo=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=clI/QKP5v5ZwJiLZxDfxxaSsgn90apqu8Et/PSXG2ghTAt7my1Arr6eYjq47zHi9z
         sew0R2nExQTaOTYt/JNoUjJqOn5/I5zu1ss/T+vZL7FiAU3Zk74S5l8IO7FvesZJqR
         IVU3Sirdu+d5cKkn318Q5DFME2sQGVlN5Qn2nxkg=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: brcmsmac: remove more unused data types
Date:   Tue, 25 Jul 2023 19:23:45 +0300
Message-ID: <20230725162400.192357-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused 'struct brcmu_iovar' and 'struct tx_inst_power'. This
follows commit b2090d93d4b6 ("wifi: brcmsmac: remove unused data type").

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h   | 5 -----
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
index 2e6a3d454ee8..1efc92fd1671 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
@@ -141,11 +141,6 @@ struct tx_power {
 	u8 target[WL_TX_POWER_RATES];
 };
 
-struct tx_inst_power {
-	u8 txpwr_est_Pout[2];   /* Latest estimate for 2.4 and 5 Ghz */
-	u8 txpwr_est_Pout_gofdm;        /* Pwr estimate for 2.4 OFDM */
-};
-
 struct brcms_chanvec {
 	u8 vec[MAXCHANNEL / NBBY];
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
index 2b0df07ced74..12a0df5b4e98 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
@@ -288,15 +288,6 @@ struct tx_status;
 struct d11rxhdr;
 struct txpwr_limits;
 
-/* iovar structure */
-struct brcmu_iovar {
-	const char *name;	/* name for lookup and display */
-	u16 varid;	/* id for switch */
-	u16 flags;	/* driver-specific flag bits */
-	u16 type;	/* base type of argument */
-	u16 minlen;	/* min length for buffer vars */
-};
-
 /* brcm_msg_level is a bit vector with defs in defs.h */
 extern u32 brcm_msg_level;
 
-- 
2.41.0

