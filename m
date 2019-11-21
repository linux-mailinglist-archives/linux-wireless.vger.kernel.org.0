Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15E4105C62
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUVzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34353 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUVzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id w11so4424295ote.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThZIZK0bveD23krnrFt2Kg1A9jjHi+JrVKHaDDEgN8s=;
        b=b1mzT9hYXtkp3m2FVFSkd8r4DO39klvTc8+S7+sLEl/idIc6fiGjTVFC/W75jR15oq
         K9Y+IP2nLjGlIvdnAOcFyW68NC9zEi4PpsiHqbIPa6raEeeg1JBxauMhuuiyuP+t8oxX
         lU4d12Gxgv8tay5JCZrfIpOlecqLKjaN5FueCN+ntJoswDElgB/OvTVfethYuHQZBZAt
         EWVGUe8uM0oOtJuEfAufEV7Smn9wlkcNza4gUS3ZFVw2pRISQzx+yPS2337rsbCDpE5h
         I0N+uoJHXwz2drR4TpKOGi8VHosIkak5l+DpV4/cXsZUAryxnvg4NL/5z9TMIS7hObeW
         KITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ThZIZK0bveD23krnrFt2Kg1A9jjHi+JrVKHaDDEgN8s=;
        b=dccGidUcIbk3RxkSJ7kAaAXi92/SwyMdrTaeBicNWjrpy3iRiinrStwxGr5UnsyIRL
         cMOSFK7u8DyUpn0VOEDk1ErxW0Cxt1J6kDJWMP941KtQcr6j9U0D3mrg22e7quo43iBz
         Sd0vn39QetRfyJXkaIgWweIcuQysOxTieoXw+NRX4rdEKYqBrLoXNJn0pspzfGMrBMrX
         zt7BW+uWJBchRJdwn9KEQDpGsSZkR3PosgMwbypTn3lNxL1CgIeCVdi1blXHlbVBXikK
         biv9AgSpNWUf3ZXj7UOTqBwZ1GaZtXra3uxdolDBSfvq9ilvSOwoAUJVuwr2p7jYJDAJ
         rJHg==
X-Gm-Message-State: APjAAAXkCRRhVOIQNC5VkatpdeL0cRiRoot88R0mQ3TX0yVxLyusApdz
        Jeb/ebejENMIQ1Qeju7H/f4=
X-Google-Smtp-Source: APXvYqycwGQkgIJZYP24F4JN7Lwgb/PMie3lghxixv2PdDlQp5CP1oLX2SQocUzU5U9SLsOrTZuYpg==
X-Received: by 2002:a9d:7744:: with SMTP id t4mr8422676otl.46.1574373322380;
        Thu, 21 Nov 2019 13:55:22 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:21 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/9] rtlwifi: Remove dependence on special bit manipulation macros for common driver
Date:   Thu, 21 Nov 2019 15:55:09 -0600
Message-Id: <20191121215514.5509-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
References: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
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

