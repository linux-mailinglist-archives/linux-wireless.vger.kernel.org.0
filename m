Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC62230FB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGQCC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGQCCp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DBC08C5EF
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t4so6752777oij.9
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44f8E6wCB8JEMNFm0LTXMdOBq43vX6TKUh3VH/PkvpU=;
        b=DIut6y3IW7Bq/kj6dcLAQ16SHQw1S7nYTAOcPhCR3zJg7ECVAj/vJK0TYWrpIbh+xI
         jVDKwiDrgykq3yiqY2qFgzq43ViH8xtQ51yqG/j/2PjECEOXtmhLVU0Oo/qV7tIVTblK
         gNyjm4rhiMpgi+B1/LhBFiHCrhRSXqW3qttWxA5mmzijOI2P/Ephn7TYK+/p6gnAhnav
         AOgyDb56jNXAftex9E2sZmn+nad7Bfq4GGao1qGCSOJpMaBQu2/auiLJJ03xcAf69nSr
         HL4BY6h1b6nWAMl4vf24LHn3BwDAsEh7+arMNhDxs5k2MkKBh1gbbw1g/UryTsdWmzxm
         rEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=44f8E6wCB8JEMNFm0LTXMdOBq43vX6TKUh3VH/PkvpU=;
        b=IXdPm2v20UzjpgCxHkRymClhO5T543bfjZG7PL9PydYvLuA1Qu1aQSVHBHRzWa3YZd
         XLVlkASqZ+P7E8fSTHLXjkgFe+sESbayV7w4BzCg27ScCDE9mql+lQZXv0rHdPAdX8T+
         +H7QthJZcXEiRdggRtu2f8gd1aupLkDoe+hxjkl9kkJXbtHMp/UxBcoS4D8d8BDM2WvQ
         uWvpmcEulFHHlpALID9p4Q4GqYlUEknlgMopNTYn67Dwb8k5jF1u+/pCtdInZSd65GAW
         MXAtMpwjjaXvPZ1akG2cDKjtIkmtBaY4Y6UC2wDj+3QVQcsVxvYyMhkiq6kXUdLWMwJ3
         blNw==
X-Gm-Message-State: AOAM531oZdV/wBhbEc1uRnHXkP2QGEB9ZFz/v4kHIWC9Ekcj8L3wZdG9
        xxfV5Oc46NNgCqVkswWdNGg=
X-Google-Smtp-Source: ABdhPJz2lyBfVxtOpIZByWrArBnHOrj8XOJXB5EC7lLLs9IxmY1tZVhBR3CWGgbP4IzVAfSA8Y41gA==
X-Received: by 2002:a54:4486:: with SMTP id v6mr5681022oiv.138.1594951351881;
        Thu, 16 Jul 2020 19:02:31 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:31 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 12/14] rtlwifi: rtl8723-common: Rename RT_TRACE to RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:59 -0500
Message-Id: <20200717020201.18209-13-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the misleading macro name to one that is more descriptive for
rtl8723-common.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8723com/fw_common.c  | 10 +++++-----
 .../wireless/realtek/rtlwifi/rtl8723com/phy_common.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
index 37036e653e56..797fc4d8c145 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
@@ -41,7 +41,7 @@ void rtl8723_write_fw(struct ieee80211_hw *hw,
 	u32 page_nums, remain_size;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -63,7 +63,7 @@ void rtl8723_write_fw(struct ieee80211_hw *hw,
 		page = page_nums;
 		rtl_fw_page_write(hw, page, (bufferptr + offset), remain_size);
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW write done.\n");
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE, "FW write done.\n");
 }
 EXPORT_SYMBOL_GPL(rtl8723_write_fw);
 
@@ -109,7 +109,7 @@ void rtl8723be_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, (u1b_tmp | BIT(2)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "  _8051Reset8723be(): 8051 reset success .\n");
 }
 EXPORT_SYMBOL_GPL(rtl8723be_firmware_selfreset);
@@ -143,7 +143,7 @@ int rtl8723_fw_free_to_go(struct ieee80211_hw *hw, bool is_8723be,
 	do {
 		value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
 		if (value32 & WINTINI_RDY) {
-			RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 				 "Polling FW ready success!! REG_MCUFWDL:0x%08x .\n",
 				 value32);
 			err = 0;
@@ -188,7 +188,7 @@ int rtl8723_download_fw(struct ieee80211_hw *hw,
 	else
 		max_page = 8;
 	if (rtlpriv->cfg->ops->is_fw_header(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD,
 			 "Firmware Version(%d), Signature(%#x), Size(%d)\n",
 			 pfwheader->version, pfwheader->signature,
 			 (int)sizeof(struct rtlwifi_firmware_header));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
index debecc623a01..fc0a0e1c6e5a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
@@ -14,13 +14,13 @@ u32 rtl8723_phy_query_bb_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
 		 regaddr, originalvalue);
 	return returnvalue;
@@ -33,7 +33,7 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n", regaddr, bitmask,
 		 data);
 
@@ -45,7 +45,7 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 }
@@ -105,7 +105,7 @@ u32 rtl8723_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "RFR-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
@@ -130,7 +130,7 @@ void rtl8723_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "RFW-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf3wire_offset,
 		 data_and_addr);
-- 
2.27.0

