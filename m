Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD633109568
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKYWJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43435 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKYWJm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id l14so14037932oti.10
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5bOdWtwtt6k9+aGwVymvfpuRge1pXzt+wdujIeGxiM=;
        b=Pd+WERf1Yhe7pJVwyX2dih6zl/ZN6Rh1y+wo0qUofFAFs833eIs3n3Spe8niD1a5pp
         rEaPzVmaiY/jQj1j3sW0ID+28o9wjQcz6VMlHKWm4aMX7zdEr3Hwqu8x+ewu9/FSthR9
         lnKxSikXdD786ksmXfxdlT3w+mItHN0SrNlND72tMsof0DpDIQhtA5yD3ib+lMEvKE5G
         r8Vw7T2hmM7IeA4MDX/1lSoeVsBSSBsG31MT7eVyJUJgBkmNHVUCnYivR8okaRaSpQKc
         KvbbODHgmq6Khn8hH9w7vGKnhvcLrIVnrOyc7awVp4h8JUAkcn26E8bwQCeoi/1MQfyI
         dP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b5bOdWtwtt6k9+aGwVymvfpuRge1pXzt+wdujIeGxiM=;
        b=pCTfaUceAjr8wovFXy5gm3XnIrjGee8X+arxSoka0jI0D3Pw3uphrj5d5ehYSDYjLU
         yU0mnCtNF4/BYFuo5cRYVm7Q7M5jXJs1iqrXdi+qLWyNBsYx+7ITt8JPd4ydoQnTdz6F
         5DWdkVa0wIuQGpsTlc46bsLP1B+Ui1a2sYDgJysMcrJCjSVaa5WmmfGgYBBZ00SuCees
         AjB4wu9PEFKPfDFTxj+tF6la8yqZuFAf6tSOcwU9G6Le6ZxKVF8Hw9WAyNBqziZ5Sv9u
         ix/F8KUike3KyC2+XJb9mg0WUw8O6k5cQWPAwsGyOyPoesiRPwAYQDI7wBP3Yz/kkmKb
         bnPQ==
X-Gm-Message-State: APjAAAU7e3cR9x+N6DQt5BXjFGkBRGYfd3nzDziyspwpuQczakUFZxeM
        094U6LcmQyXLazGhi+6pYNQ=
X-Google-Smtp-Source: APXvYqzvpobwAiqD/f5IZykU6QRcXm4X91fJ8XxZdrfhb+1llFUVDgDFHqteXXpVXeF8Jz50cHxrCA==
X-Received: by 2002:a9d:67d1:: with SMTP id c17mr21037otn.209.1574719781314;
        Mon, 25 Nov 2019 14:09:41 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:40 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 4/9] rtlwifi: Remove dependence on special bit manipulation macros for common driver
Date:   Mon, 25 Nov 2019 16:09:29 -0600
Message-Id: <20191125220934.32693-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The special macros are used in several places in the base driver.
These are replaced by standard bit manipulation macros or code.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - fixed endian issue in ps.c
---
 drivers/net/wireless/realtek/rtlwifi/base.h |  4 ++--
 drivers/net/wireless/realtek/rtlwifi/ps.c   | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index e4a7e074ae3f..fa92e29fffda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -61,9 +61,9 @@ enum ap_peer {
 	CP_MACADDR((u8 *)(_hdr)+FRAME_OFFSET_ADDRESS3, (u8 *)(_val))
 
 #define SET_TX_DESC_SPE_RPT(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 19, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(19))
 #define SET_TX_DESC_SW_DEFINE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 0, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(11, 0))
 
 int rtl_init_core(struct ieee80211_hw *hw);
 void rtl_deinit_core(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index e5e1ec5a41dc..bc0ac96ee615 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -737,7 +737,7 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 	find_p2p_ie = true;
 	/*to find noa ie*/
 	while (ie + 1 < end) {
-		noa_len = READEF2BYTE((__le16 *)&ie[1]);
+		noa_len = le16_to_cpu(*((__le16 *)&ie[1]));
 		if (ie + 3 + ie[1] > end)
 			return;
 
@@ -766,16 +766,16 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 				index = 5;
 				for (i = 0; i < noa_num; i++) {
 					p2pinfo->noa_count_type[i] =
-							READEF1BYTE(ie+index);
+					 *(u8 *)(ie + index);
 					index += 1;
 					p2pinfo->noa_duration[i] =
-						 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 					p2pinfo->noa_interval[i] =
-						 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 					p2pinfo->noa_start_time[i] =
-						 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 				}
 
@@ -832,7 +832,7 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "action frame find P2P IE.\n");
 	/*to find noa ie*/
 	while (ie + 1 < end) {
-		noa_len = READEF2BYTE((__le16 *)&ie[1]);
+		noa_len = le16_to_cpu(*(__le16 *)&ie[1]);
 		if (ie + 3 + ie[1] > end)
 			return;
 
@@ -861,16 +861,16 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 				index = 5;
 				for (i = 0; i < noa_num; i++) {
 					p2pinfo->noa_count_type[i] =
-							READEF1BYTE(ie+index);
+					 *(u8 *)(ie + index);
 					index += 1;
 					p2pinfo->noa_duration[i] =
-							 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 					p2pinfo->noa_interval[i] =
-							 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 					p2pinfo->noa_start_time[i] =
-							 READEF4BYTE((__le32 *)ie+index);
+					 le32_to_cpu(*(__le32 *)ie + index);
 					index += 4;
 				}
 
-- 
2.24.0

