Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A661EA5EC6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfICBSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 21:18:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41547 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICBSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 21:18:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so15068930ota.8
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17EKxzbZ4mVYEmjN9suxyqpGaIxSPUwazBx/Ht6eI+M=;
        b=qdGRaApGMoTLMvAOrdAPxZbZEsTsD/WZAmRyotIhF4npI1i9D707gSwGSI6fvqBk66
         Zo56NzZHQBF7B3O5GgSlL/ckrzQ6XB59eM8qAK8P4hVbqOloyFPcLflikhsYH4/IRPg9
         CBrapjZxZS0q3kxHrZZ5Uly8UhYZMNTgAmBSWcq/X0J/Mp09B/ETNw0ogttxsx7ZrHZ2
         a5JiNzAaGGJSIQ9leXU6ojQBMmcSo+em7HWrvBBySQNYciU6DPlsQZp110ysBBJ9up8j
         PnaJhSsd66xYtIqDCE8fePaAuM8W5WZsw5JG9h4uy6x65V6zLG95qRpQQbmnl9xfAkZ0
         AOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=17EKxzbZ4mVYEmjN9suxyqpGaIxSPUwazBx/Ht6eI+M=;
        b=EJ5YwyiOBGfnmH+F1w/Q7EkTGAkFwgw1kOjScrfpRFG3VcnsaNRLPWQC7tQ3GGl37W
         WGnqljTk0yTaBre89IzQQnCyIRp89mC6+nQODriwiQ4CAMkqrwmq5gbUQ2Gqign7b9Kx
         gDSHycEuVjX4FVpCBcnfsJquSwMwhfxtCXvKWG08tvFmPipG7fd89OXWelyvEQY+irMM
         AzejUKDCxxDny3r18aV0KI9NRoaz3lL23pByRSk17vZzsYSwgryN8ZuqrYvKRnuq9IcQ
         I1secdpb+P0cO2GjA9fe0K+lunE1kpSycoicUX/4uI7p3jidxswhRrORhJRGAYM76MkO
         yq6w==
X-Gm-Message-State: APjAAAU5uYjrZRWmuTSQ1jP+8XYCQeDABg4rrEeArQIpEomB/UZyZNgw
        jmS5k9d8M6qtzikzdMCX2ac=
X-Google-Smtp-Source: APXvYqx6anVXbh23JXu5xdm8nmUhh7EOk7jwP1jaXcSjsUDottpz+WT82rzK2u6AmgjXWafcFQRx4A==
X-Received: by 2002:a05:6830:1bd4:: with SMTP id v20mr17170998ota.159.1567473516414;
        Mon, 02 Sep 2019 18:18:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d13sm230244oth.11.2019.09.02.18.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 18:18:36 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/3] rtlwifi: rtl8821ae: Fix incorrect returned values
Date:   Mon,  2 Sep 2019 20:18:11 -0500
Message-Id: <20190903011813.13946-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
References: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit bd421dab7515 ("rtlwifi: rtl8821ae: Convert macros that set
descriptor"), all the routines that get fields from a descriptor
were changed to return signed integer values. This is incorrect for the
routines that get the entire 32-bit word. In this case, an unsigned
quantity is required.

Fixes: bd421dab7515 ("rtlwifi: rtl8821ae: Convert macros that set descriptor")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index 81951f0c80b6..a9ed6fd41089 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -214,7 +214,7 @@ static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
 	return le32_to_cpu(*(__pdesc + 10));
 }
@@ -324,12 +324,12 @@ static inline int get_rx_desc_bw(__le32 *__pdesc)
 	return le32_get_bits(*(__pdesc + 4), GENMASK(5, 4));
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
@@ -341,12 +341,12 @@ static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
 
 /* TX report 2 format in Rx desc*/
 
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

