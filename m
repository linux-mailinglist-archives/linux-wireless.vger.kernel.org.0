Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE251C4939
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDVpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 17:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgEDVpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 17:45:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B1C061A0E
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 14:45:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so6247556pfv.8
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2020 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pSdUQIiDkBuYMEvnAzxNhWNRwyt6JrBctrwvIkEEK+E=;
        b=SupGXcykkeSJajgkz3W/6SGxpcIzpcEbkumq0z+zPt13bXDkrUafxtEdY0xN3MnpuJ
         tFyH/2TJ7M+c8Il4AVk2ns2YY8W2xNZ/45QVTCgfY/tRnnhvOz0L4xuOLCHQk3BLSR9Z
         gpwqJdtalOpZXHgiKra6OkoHv2WRH20/IeM7NHa1zhSiz9gzFSGi97QLPJyC7XERghHf
         DwwO8qLikNp8NwVU/7TCLzHmhYNkP9cmNzNlfXX3jLOHy7kjeAy4AsZkOUVijCs62tML
         cvVufciXLR+oyDVBzG2Y56ecL+rxI0JATIMpPTz1aOOr3CBZ0dcEoQMP+/aZOaORDmL1
         aksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pSdUQIiDkBuYMEvnAzxNhWNRwyt6JrBctrwvIkEEK+E=;
        b=AVI9e+meDC3RtxzvsJcxCZXPaLP7VjfOTUeJ1DR2LUDSmzvfOkjj3g/6597ksLhcEm
         iT5BDDImuAHgRJ6t+v2uyGTJJ8UAZ1BFUCuijQtXYHp9S6cwYs+TbHvhjb1cVLxGkzLM
         A/ObE62vHm7Z9ue0GFcp+5wMslfbg1i2atWzf29EY83rOinIE4yE7wRKOe+uFJdNM11z
         DNXuYdrzcfV26AyrdoBksVCTaTTTsekpeoP6P7g/oOlxmihvXXdXA6m0ruCNfbM2YIcE
         SGSSRvPJ1R/qtIqQgE04cqV9BFhOWkExsgpxM5AnqmnPj6rHyCoSR34+s6UjE/giaBFk
         SHiA==
X-Gm-Message-State: AGi0PubDg9wlNU2/EX0zxQYZNxZ4lb/5LJxSwcm4R3nLs7KtUJOlR2Jl
        c42ZeNDxLekjCNoIzC7NtfmTi5LcEww=
X-Google-Smtp-Source: APiQypKx8BxTW1MJejPyV5ohW523QF0T+soVfhBr8nXI0w20mQCHIofiFPGgoOM1cKFnQ7qFhWbblg==
X-Received: by 2002:a63:190a:: with SMTP id z10mr227757pgl.331.1588628699099;
        Mon, 04 May 2020 14:44:59 -0700 (PDT)
Received: from gtx1600.flets-east.jp ([2409:11:53c0:1f00:ad34:aa33:8105:3cc4])
        by smtp.gmail.com with ESMTPSA id n3sm24749pfa.218.2020.05.04.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:44:58 -0700 (PDT)
From:   Masashi Honma <masashi.honma@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     ath9k-devel@qca.qualcomm.com, pro.denis@protonmail.com,
        Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH] ath9k_htc: Silence undersized packet warnings
Date:   Tue,  5 May 2020 06:44:43 +0900
Message-Id: <20200504214443.4485-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some devices like TP-Link TL-WN722N produces this kind of messages
frequently.

kernel: ath: phy0: Short RX data len, dropping (dlen: 4)

This warning is useful for developers to recognize that the device
(Wi-Fi dongle or USB hub etc) is noisy but not for general users. So
this patch make this warning to debug message.

Reported-By: Denis <pro.denis@protonmail.com>
Ref: https://bugzilla.kernel.org/show_bug.cgi?id=207539
Fixes: cd486e627e67 ("ath9k_htc: Discard undersized packets")
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 9cec5c216e1f..118e5550b10c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -999,9 +999,9 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	 * which are not PHY_ERROR (short radar pulses have a length of 3)
 	 */
 	if (unlikely(!rs_datalen || (rs_datalen < 10 && !is_phyerr))) {
-		ath_warn(common,
-			 "Short RX data len, dropping (dlen: %d)\n",
-			 rs_datalen);
+		ath_dbg(common, ANY,
+			"Short RX data len, dropping (dlen: %d)\n",
+			rs_datalen);
 		goto rx_next;
 	}
 
-- 
2.17.1

