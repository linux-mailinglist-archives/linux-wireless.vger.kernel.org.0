Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0179C10956B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKYWJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34027 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfKYWJo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so14727251oig.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBKy5QrAmIplwTwgwMhzGcQB97bTVz3luvJS6SNwWmA=;
        b=rZnKVh1yYwtNRT5Ez0XnjY8YHfEsXTW03h6NqNhTxmSwKxnFbmn8uLdcLYWL2cfvQg
         30vbc5lY90jp090NWV84mM6bXlmCnL4tOqFM5w62bKs2lS5yk1nPbCrkaQUdj8NIsNAJ
         0K2w8G/0uDsFtzDd7tBKSq4GuIfdMJS50FZbY3jiLzab1j/mZolxB0sweVZMYvuQDzeS
         cZJAZkMiC6PJYU9DFT9jRkQ5VIBPMRBrpexdC7HlFexmxVhbA87qV3MSMnPp/7yIeChg
         Vt4HjzcstiY4n6coIx9oqV06Q5+lAOzwszIvrQlbqCBnD/oX81ri8Sj4eVBf9q0pOgrA
         U4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LBKy5QrAmIplwTwgwMhzGcQB97bTVz3luvJS6SNwWmA=;
        b=lidWNkG6I1PgZd4y5sllqhcGooC208TQyTeIw+x9GRUCTgVKBP20SByW2wgvC/f+Zk
         6ibKB74pbA6GGfGHYgXUqOkHJMsXAra06cTSWJ5KNR2UaxmDY1iZtzKqJIvHhnzQZTRO
         iVdh7FZD7Htmz5ESDMhHOJtbtAV0gtAFZkvP2cnzhzE873gLg1SmrrvjWG81zwsaFn4K
         ooEw4tBrSY+vDKY35w0+rUQWsZRWnVIxdR1YTICLHHrFp9Yonmv3c9N4ccplbc4jWoCJ
         CIfSSHJsACx2Sr6jzcjHOoE++qT9jn5ds2ZfFnpugbYwufWxfy6QrPrqZkAx/LIt6pyq
         AKYA==
X-Gm-Message-State: APjAAAXw4I7AZq4vhjf4pav4FD8rFG8cbcneRf/BDYnrLk44SagyfMyN
        WrNpeysb6CXxFjYlalUczfo=
X-Google-Smtp-Source: APXvYqx15M5X0VOmMnDktkRi/e96L5e/vmiNstnEMR2PbZXUGxai79qztTpuCHOldeQOENypnKwbsg==
X-Received: by 2002:aca:62c6:: with SMTP id w189mr939781oib.33.1574719783802;
        Mon, 25 Nov 2019 14:09:43 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:43 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 7/9] rtlwifi: rtl8723ae: Remove usage of private bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:32 -0600
Message-Id: <20191125220934.32693-8-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Besides the previously changed macros for the RX and TX descriptors.
the local macros are used in other places. These are replaced with
standard bit manipulation macros.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 .../net/wireless/realtek/rtlwifi/rtl8723ae/fw.h    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
index 5c843736de8d..3f9ed9b4428e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
@@ -18,19 +18,19 @@
 #define pagenum_128(_len)	(u32)(((_len)>>7) + ((_len)&0x7F ? 1 : 0))
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_PWRMODE_PARM_BCN_PASS_TIME(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 
 void rtl8723e_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
 			   u32 cmd_len, u8 *p_cmdbuffer);
-- 
2.24.0

