Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76E1EDA35
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 02:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFDA5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 20:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgFDA5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 20:57:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3EC03E96D
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 17:57:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d67so3597564oig.6
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7pjQrShpylTXzcD2vY86c6VQi3CZGhc0MJSglTe/nM=;
        b=NztgXsBWPRrDbr7TZOvMNd7NaKBxbzNBdBLe/dzLVEINoTCQLFflpP3U8beqP9WcEs
         r7FEQXNLWUFor1L0cwvEoDKFPPpc9gYefPSYKEzvonUM85S9aOUqkOwzFZpFisQ+Q5di
         wMz8JEAjUwJFOQIahQfrzma9Hz406fHA8rlfU7lfQBzVeo5aOJ3n9xbWjOVm+Z9kQhbh
         aUYYiHHJlqE71ZCqQJLdxDayZvG8UPzsMYsMenS+vTmN2+nECvx59TSYgUqg6lc7e9J7
         Hlvo3pVA9DGOvKAmsBqmzToYRDXPNtI2oppa6UVZtnR0TSE6YIj6HL7n8/lSFmkAmleg
         N1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y7pjQrShpylTXzcD2vY86c6VQi3CZGhc0MJSglTe/nM=;
        b=diovuv6w97P1wff4jBIVUzr89erw70KiCXnhXz37g3I+YpyTay0UtS5Tux2CgUg5XT
         8X1AUNuJOSzcNwPEzrWZGCoTEhxcQ4R/yScvqLBnl/KyxPxBoaTDTLOUHN534R+ccrCf
         ITTubjAcZN0FxryBSB70vKXl3xXfCjUhFsx7uLo0cblmckwf+mCE76rWYOSamw/56Hvt
         qe3VkFFh5kkTQjEV0xqJ5FUPRZiLr2tj0augAz8Ljde3bWJjJr1CLX3bRQtCWQEIvTpX
         s2vDhLwGgBn0qZ2Bwxf/IBJ7rm8SbM2bsg4ynBmrrZN2AlHErZ56AO0mWnC74ynf3b3C
         nhpA==
X-Gm-Message-State: AOAM530XAL2dMIoaAm0jorU6Cc/mP8jxpmCasMHRzV25t6usGjQ1Lx/x
        TvaPm/lOjsJkFGzERtPawmcg5rZ9
X-Google-Smtp-Source: ABdhPJzYrc8y9+M+N/VQAUQCGTDyTndOi23GbLdTIIvZCLxfJV8DlMQMSxwto7Dr+4xggt3cvAlB6w==
X-Received: by 2002:aca:fc46:: with SMTP id a67mr1562511oii.127.1591232261719;
        Wed, 03 Jun 2020 17:57:41 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u80sm1011300oia.5.2020.06.03.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:57:41 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] rtlwifi: rtl8188ee: Fix endian issue
Date:   Wed,  3 Jun 2020 19:57:33 -0500
Message-Id: <20200604005733.7905-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604005733.7905-1-Larry.Finger@lwfinger.net>
References: <20200604005733.7905-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse reports the following issue:

  CHECK   drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c:500:26: warning: incorrect type in initializer (different base types)
drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c:500:26:    expected restricted __le32 [usertype] *pdesc
drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c:500:26:    got unsigned int [usertype] *

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index aa2e9e88be53..a5d2d6ece8db 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -497,7 +497,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	dma_addr_t mapping;
 	u8 bw_40 = 0;
 	u8 short_gi = 0;
-	__le32 *pdesc = (u32 *)pdesc8;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
 		bw_40 = mac->bw_40;
-- 
2.26.2

