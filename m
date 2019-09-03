Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206EDA5EC7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 03:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfICBSi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 21:18:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37857 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfICBSi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 21:18:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id 97so12248233otr.4
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLR478LLqGoNj13u0bbs34zaHf9Vy4KuN85agfzuqXc=;
        b=EtEq4EkqBV8ffECzv1gl2aSz0tfEIRsFS8nNuJfIX2CJ5iv0V/gP+HjqMvKDmsH0VU
         iqLG4DRVrJuVGg2tmpb7zjlcoSyRdrFLG2MWe+AInMy8d3Zvq/KNgAdHTh9E8y9CZdI0
         Ym2p9F8NpyWdjEzRAafRDWR48DrKuiIWaHzfWyNQs6ZLDUw9KYpMw0XlgdksW+x/eDfj
         eCLZNPWYimF4AS3T65xPjwkmjTH7xi+nYRk0L/OuZ88VfWE0lipWtFsjssBVBDkUsyax
         lkj4PA4oBU0znCigorrh6PJq7RMNjLZ08fPfFwDS15rXgjZ5+JO8b0lUf3YRfKMOIE04
         LWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sLR478LLqGoNj13u0bbs34zaHf9Vy4KuN85agfzuqXc=;
        b=r03AiEkZ/+uXJk2oHgNBOzHTXZwtO6toVI7x+wSX6+0+am58hrCamoSm4xm1MV3rmw
         pojR0vIczEs9/+t6VRjUOAx9171YHpzV/Kshft+hFbVWf6pB6fOsvpg7zPnfgtOchUzS
         Im2DxaS0qNxCWL1yhs0uoehYpUBcDKZIcyYjEuYsn2E71QKbHiBYEyxhlKuxbz/z5vzH
         ZxW9RjwElremJ4tIqtVMtNqGTO3LCn4r4UDRDIdm1hl3b8qnulAhc64c98nnt5PIEaXV
         fBb0bzfOJuOrB/U9wZrP1ABVF8rvLYJbSAnqKUqliAxdtLUflfjs3y77hp8tWRw2Og+O
         dvSw==
X-Gm-Message-State: APjAAAUExiaRZiQqgL8MC5zKDebuxoHZykm3oyaFEaA5PZxdCB0KZj0Q
        eeTFDDAvJ3AeLnaEaNFddpM=
X-Google-Smtp-Source: APXvYqyiTTYE6wlAFyeCWqfKP0dT6+9enpGvU9R8w0AhpPDtpHNywb40Baa4SSF+zEwKdW2trLCVGg==
X-Received: by 2002:a9d:6856:: with SMTP id c22mr25939883oto.307.1567473517127;
        Mon, 02 Sep 2019 18:18:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d13sm230244oth.11.2019.09.02.18.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 18:18:36 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/3] rtlwifi: rtl8188ee: Fix incorrect returned values
Date:   Mon,  2 Sep 2019 20:18:12 -0500
Message-Id: <20190903011813.13946-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
References: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit 36eda7568f2e ("rtlwifi: rtl8188ee: Convert macros that set
descriptor"), all the routines that get fields from a descriptor were
changed to return signed integer values. This is incorrect for the
routines that get the entire 32-bit word. In this case, an unsigned
quantity is required.

Fixes: 36eda7568f2e ("rtlwifi: rtl8188ee: Convert macros that set descriptor")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index bd862732d6ae..917729807514 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -244,7 +244,7 @@ static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 8));
 }
@@ -464,22 +464,22 @@ static inline int get_rx_status_desc_magic_match(__le32 *__pdesc)
 	return le32_get_bits(*(__pdesc + 3), BIT(31));
 }
 
-static inline int get_rx_desc_iv1(__le32 *__pdesc)
+static inline u32 get_rx_desc_iv1(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 4));
 }
 
-static inline int get_rx_desc_tsfl(__le32 *__pdesc)
+static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 5));
 }
 
-static inline int get_rx_desc_buff_addr(__le32 *__pdesc)
+static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 6));
 }
 
-static inline int get_rx_desc_buff_addr64(__le32 *__pdesc)
+static inline u32 get_rx_desc_buff_addr64(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 7));
 }
@@ -501,12 +501,12 @@ static inline int get_rx_rpt2_desc_pkt_len(__le32 *__status)
 	return le32_get_bits(*(__status), GENMASK(8, 0));
 }
 
-static inline int get_rx_rpt2_desc_macid_valid_1(__le32 *__status)
+static inline u32 get_rx_rpt2_desc_macid_valid_1(__le32 *__status)
 {
 	return le32_to_cpu(*(__status + 4));
 }
 
-static inline int get_rx_rpt2_desc_macid_valid_2(__le32 *__status)
+static inline u32 get_rx_rpt2_desc_macid_valid_2(__le32 *__status)
 {
 	return le32_to_cpu(*(__status + 5));
 }
-- 
2.16.4

