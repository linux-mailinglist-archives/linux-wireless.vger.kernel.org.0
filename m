Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292B222B7FD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGWUnB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGWUnA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:43:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C47C0619E3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l63so6171768oih.13
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LS2ztlLM+PAMFDjd6tzK+1mnfJR3bWDPpsaQ6BbYoo=;
        b=szOMxMWVpdoTN6loT7iP7qJVMUoiShJKw/WR9lVbnCu7TFJFH0ZNK5miwAUb7ct+Z7
         s0Lp6fWx+EUJJb//3zdgfV6cBJcKTq6QVyUh8+Gief3g1VNJTYqkJI1oe8rNPIX9ISmc
         qj6uMqhQRW6wuzjdAn0bcYIuZrSXjcWB/n58oj6To8vHyTBfnSfutFTDAlBIqNkEuFkL
         aEUIGL1U9FW/fXOhoLDbsSzoP9lC3/U8LSl3GleR1QVd8i+fQzwNfahZwgruLWZWmykJ
         IMDrBUdbGXo8jim3Bkl1reAlDemfIGUHNJP6F7GadkiiBfCj+4+6H8XiEbFDZFbe/KBX
         zQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9LS2ztlLM+PAMFDjd6tzK+1mnfJR3bWDPpsaQ6BbYoo=;
        b=rFcfaE93/IW4ft5WHTtzoN3RCXUA0tUHyA/gvbK0/Cbt85Xuza8u7ZvhDnIgJRn/NZ
         Pm6mSV9GWQo2qLCdFUu2SWkRSVdqB7xszakUcfPhkFj+WusnRi4AGTML7YH4hFAzGJuL
         WdqefDpl52Cx2KO1MB/2uoFxQh50vnO07i8YH21oWKNfSrK9s/2KyGFo3BcZBNq0BEFF
         5MjzfYYR68WgIy8roSXxVOdEMrvVNxJ8R4OvHlvztCcJbOtldErbkJxoJyON9+f85Q2J
         bwITkDFnEZI8HAZO9W+Q0VfjAvIscFQnyp0Gu995bGePEJRkXyts4ArIV/8xzO/iZmN/
         nOUQ==
X-Gm-Message-State: AOAM531VPXXuqo32l4wXhoNWrkwNHpN//fCV5fvh0vVJU1wA1sgopGtz
        K4YWdZjhKsbt76KBDScPivbDT+rf
X-Google-Smtp-Source: ABdhPJzPQurOgDWkc1AWW68rPE6IhmVkhwwRvz3OEDkuwGI0nd1lIIeD/06thRnRkjiMA+C7HEK6FA==
X-Received: by 2002:a54:4798:: with SMTP id o24mr5333322oic.148.1595536979313;
        Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:58 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 13/15] rtlwifi: rtl8723-common: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:42 -0500
Message-Id: <20200723204244.24457-14-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the misleading macro name to one that is more descriptive for
rtl8723-common. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../realtek/rtlwifi/rtl8723com/fw_common.c    | 22 ++++++------
 .../realtek/rtlwifi/rtl8723com/phy_common.c   | 36 +++++++++----------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
index 37036e653e56..36c00b89ccae 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
@@ -41,7 +41,7 @@ void rtl8723_write_fw(struct ieee80211_hw *hw,
 	u32 page_nums, remain_size;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -63,7 +63,7 @@ void rtl8723_write_fw(struct ieee80211_hw *hw,
 		page = page_nums;
 		rtl_fw_page_write(hw, page, (bufferptr + offset), remain_size);
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW write done.\n");
+	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW write done.\n");
 }
 EXPORT_SYMBOL_GPL(rtl8723_write_fw);
 
@@ -109,8 +109,8 @@ void rtl8723be_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, (u1b_tmp | BIT(2)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "  _8051Reset8723be(): 8051 reset success .\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"_8051Reset8723be(): 8051 reset success .\n");
 }
 EXPORT_SYMBOL_GPL(rtl8723be_firmware_selfreset);
 
@@ -143,9 +143,9 @@ int rtl8723_fw_free_to_go(struct ieee80211_hw *hw, bool is_8723be,
 	do {
 		value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
 		if (value32 & WINTINI_RDY) {
-			RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-				 "Polling FW ready success!! REG_MCUFWDL:0x%08x .\n",
-				 value32);
+			rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+				"Polling FW ready success!! REG_MCUFWDL:0x%08x .\n",
+				value32);
 			err = 0;
 			goto exit;
 		}
@@ -188,10 +188,10 @@ int rtl8723_download_fw(struct ieee80211_hw *hw,
 	else
 		max_page = 8;
 	if (rtlpriv->cfg->ops->is_fw_header(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-			 "Firmware Version(%d), Signature(%#x), Size(%d)\n",
-			 pfwheader->version, pfwheader->signature,
-			 (int)sizeof(struct rtlwifi_firmware_header));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+			"Firmware Version(%d), Signature(%#x), Size(%d)\n",
+			pfwheader->version, pfwheader->signature,
+			(int)sizeof(struct rtlwifi_firmware_header));
 
 		pfwdata = pfwdata + sizeof(struct rtlwifi_firmware_header);
 		fwsize = fwsize - sizeof(struct rtlwifi_firmware_header);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
index debecc623a01..097f21f6d35b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
@@ -14,15 +14,15 @@ u32 rtl8723_phy_query_bb_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
-		 regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
+		regaddr, originalvalue);
 	return returnvalue;
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_query_bb_reg);
@@ -33,9 +33,9 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n", regaddr, bitmask,
-		 data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n", regaddr, bitmask,
+		data);
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
@@ -45,9 +45,9 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_set_bb_reg);
 
@@ -105,9 +105,9 @@ u32 rtl8723_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFR-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf_rb, retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFR-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_rf_serial_read);
@@ -130,10 +130,10 @@ void rtl8723_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFW-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf3wire_offset,
-		 data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset,
+		data_and_addr);
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_rf_serial_write);
 
-- 
2.27.0

