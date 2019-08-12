Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC28A707
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2019 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHLT1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Aug 2019 15:27:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46102 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfHLT1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Aug 2019 15:27:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so44797125otk.13
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2019 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ma9oYcjlFNRNUI50KD0U7CugASZsr9TPjWF8u4CxHnI=;
        b=GuIzhf9w6Er3zml4gHXI2m4ffHCI19Uw1vj9huzaHbK9zZKu8xoiqKXoINu0s6WwXb
         611aIgLj8jY/EluD5uL66anMnagwl0dTh8V9RsZwF1RZZ5EVVavmzh+B4QAxIBtwxQd5
         2AtOi2MmUNhHsVhEFHRoAVdUL0GITp2Ix/dMdxlR9MkSlTXzIQh6rlgwXFlnNhhHLnbV
         zqmOw5iF7/A2SvupNeD+qTifz7/I+Fl6AbO0mBO2TjbZ9Kw2gT0gv1p4OSn0CpZSWx6t
         n0Qt3zTMRS2yB5vO43Mb+dgcQ7uhK6oiIFaWbnexZJhQikwY45b9T/KRut+fHvqDFwzd
         NfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ma9oYcjlFNRNUI50KD0U7CugASZsr9TPjWF8u4CxHnI=;
        b=IgGM4QM1FIAiwRry8l6+gOoxZyBfLuRtv1kTLLPSppyUtMj+5DSiPaEAK6b23nY76W
         ZPzlbaRRlw3tCnF9jxTDdpTlj0y7BAOUt0QSs085pVtQItA4OlSO3l4xC59OvgIeBLS5
         g0xIdPqXayIcmgGdAWmP08sXU5sA08BppcgzBGpdWkGjPFxRyqKI76hDH5t61Bo8OXDG
         p7jbg1ZWWEnUhweMbKS+foZGMumz9ANt4cuUepj/W1K4MXXqpafxj1Vts+YJex/9AdzP
         wNtPwSRNmY9vUgLmSUIfe2g0Kb4ez4iLn/BxVxqZ3RA7LGrJl0z7g36Qg9vqgiWNaSxU
         +CLg==
X-Gm-Message-State: APjAAAUlMvejcWS7DgLswGvTF+JpU3mvWSZ/kHOk9NmL8JypMx872ebE
        IkvOQdjPOp8Arf3cGi5dvng=
X-Google-Smtp-Source: APXvYqwNlhPYUOoVt9x8E52pNxbnSm66iAdyPLX7U+QF0KN8uKbw6tWH4ha2s3eqO9yqdb2co3733Q==
X-Received: by 2002:a05:6830:17d6:: with SMTP id p22mr13040666ota.202.1565638067848;
        Mon, 12 Aug 2019 12:27:47 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n22sm1030575otk.28.2019.08.12.12.27.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:27:45 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/5] rtlwifi: rtl8192cu: Fix value set in descriptor
Date:   Mon, 12 Aug 2019 14:27:41 -0500
Message-Id: <20190812192741.14479-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the process of converting the bit manipulation macros were converted
to use GENMASK(), the compiler reported a value too big for the field.
The offending statement was trying to write 0x100 into a 5-bit field.
An accompaning comment says to set bit 3, thus the code is changed
appropriately.

This error has been in the driver since its initial submission.

Fixes: 29d00a3e46bb ("rtlwifi: rtl8192cu: Add routine trx")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 0020adc004a5..9b5c7ec6b6f7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -611,7 +611,7 @@ void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
 		SET_TX_DESC_NAV_USE_HDR(pdesc, 1);
 	} else {
 		SET_TX_DESC_HWSEQ_EN(pdesc, 1); /* Hw set sequence number */
-		SET_TX_DESC_PKT_ID(pdesc, 0x100); /* set bit3 to 1. */
+		SET_TX_DESC_PKT_ID(pdesc, BIT(3)); /* set bit3 to 1. */
 	}
 	SET_TX_DESC_USE_RATE(pdesc, 1); /* use data rate which is set by Sw */
 	SET_TX_DESC_OWN(pdesc, 1);
-- 
2.22.0

