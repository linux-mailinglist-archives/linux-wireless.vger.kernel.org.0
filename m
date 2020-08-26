Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08205252A62
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHZJi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgHZJer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9570C061796
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so1081010wrt.12
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bx7yNWclgWagoUc19DO980I/LQpudxltdUcBDgMx82s=;
        b=uUJKLbTU9CLl0GGHDJpGfj9qHXqTE3vmdSY72df5VY22nwMKPTB/gJEbRC16KsVj7V
         lqf/Msco72OZwC3/z43E9HJuCf6O4FXc4Ln2h+/SPuM85Apb34/d9LJm1+eeVSKbALFc
         c2rVrF2Sh84an294dpobLgvr2n7+wlJehzkTlL83PcF2HIXgrzahwnvouyL2GQg8BVCy
         YzEczRcmVW4jKWDL4pBiFlrSkNOCzvJm1JnA04lj/UemOevD3v2UMxrTXE53HxYDN0d2
         mIfNdwOUuKYx7/GFEVMKTyGbyVQd+W2euTeJ/u8fddVeUrdSAHX+9rPgTn/5CayY333+
         iGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bx7yNWclgWagoUc19DO980I/LQpudxltdUcBDgMx82s=;
        b=dATsFJFG57/Vwh0uWRkRds3TCFusMHiWv/Gjnc09rx5NSSrHi3jfVm7IADN+tO1bww
         xNRYhk6lrUZJPgDUuxMlz5czL3yujc9IOEgX3HnXZGqsf2LOLEQNCpj16RhE1/QcgQVA
         CW2jOkZScDbFIX6dXpZfoOT2KMquIA7h970v1bskefgh8j59/kjQBFagNoIgZTX8Mdra
         hWaAB73FCJs6OXfZVMWY+o6wC6pYVBByN4hmxqPoAwuboHkxg+iVXpEfyj+vCBMfYWNf
         ASsZ2s1unTV89MSbneDOXYoBVQLf8Ti8pZqKh1+DpXdLBgdCJt7fI4KYzQ25s3h7D31H
         HbuA==
X-Gm-Message-State: AOAM531DQunf3z5F0suEuT+cE3Kc0Dzwj/R00m4gbNeZQU3wkqogjSAP
        SyOIqtxS7XcJKU71mT5bAW0jkA==
X-Google-Smtp-Source: ABdhPJwQFvrvdmFHV9OPBjwjVStS/qGSXw/JVNaDpgJRCYX+jtI39dQIrk6xIFkbAjhbnJEZSJLl9g==
X-Received: by 2002:a5d:4050:: with SMTP id w16mr1517291wrp.412.1598434463554;
        Wed, 26 Aug 2020 02:34:23 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Luciano Coelho <luciano.coelho@nokia.com>
Subject: [PATCH 15/30] wireless: ti: wlcore: debugfs: Remove unused variable 'res'
Date:   Wed, 26 Aug 2020 10:33:46 +0100
Message-Id: <20200826093401.1458456-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Luciano Coelho <luciano.coelho@nokia.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ti/wlcore/debugfs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/debugfs.h b/drivers/net/wireless/ti/wlcore/debugfs.h
index fc3bb0d2ab8da..b143293e694f9 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.h
+++ b/drivers/net/wireless/ti/wlcore/debugfs.h
@@ -78,13 +78,13 @@ static ssize_t sub## _ ##name## _read(struct file *file,		\
 	struct wl1271 *wl = file->private_data;				\
 	struct struct_type *stats = wl->stats.fw_stats;			\
 	char buf[DEBUGFS_FORMAT_BUFFER_SIZE] = "";			\
-	int res, i;							\
+	int i;								\
 									\
 	wl1271_debugfs_update_stats(wl);				\
 									\
 	for (i = 0; i < len; i++)					\
-		res = snprintf(buf, sizeof(buf), "%s[%d] = %d\n",	\
-			       buf, i, stats->sub.name[i]);		\
+		snprintf(buf, sizeof(buf), "%s[%d] = %d\n",		\
+			 buf, i, stats->sub.name[i]);			\
 									\
 	return wl1271_format_buffer(userbuf, count, ppos, "%s", buf);	\
 }									\
-- 
2.25.1

