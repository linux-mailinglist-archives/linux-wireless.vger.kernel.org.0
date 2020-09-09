Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0906B2630B5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgIIPis (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgIIPgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE65C06134A
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g4so3462061wrs.5
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=oh+Ig/0oFiVrEM89eAzw62FS/G8US3yu3On4UDMdTE3hqwEU6ecAmGjix+AJh3sP8X
         t/IgnZsBUsraKwC5ZKK074Ze43E62JZwAEXILk261HOdaDwpQC6Tj9yntg00lSnlx4fd
         hG/hsMuYK6POV5/dI6L59eDB/N04UlOJpH0lUeXd+clc57fxZWjshtvQ5sxoyxhAc7x/
         9cHA99QvaM6E0cYVj7JJBFRSOO65tnG+RMUB/lkngEVSpu34qXsem6h8gc07Zi3U41O7
         zKMZiPH05F8gScmkmWP0mrvXC7WKyRAH2LTuLnwJeaDxqExHNWAS3crlmOfWQVqNgtgn
         NoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=aYLNlNdnZgi6AIbrhSjEXqBgKYqiQGXq9gQxwYiQeVyh98BaENZSVu1yL2fKGSN1Ve
         59fc4KQaY72eW2I30uMH729TSfbcTNQm31sbxIMIKYlOGY8z6VAVoUHyac7MSYlCYm8d
         fX/mceuiInssVHrX/l336513rG9XBmRmVXV2zPVifAxegUWQeaipMHQGcn27I+jvy73M
         EjVDUd3puvmk/n4m4TQja6m7QQa4jCKfuoJ4CXRtVGPhmEQbifHU0uYq+l2sc/oDUMer
         tXfW7ZMBXY7homE/sAqGLOA2jvoIEjbKUbVs1tDK6ciKr4eZMbjitgBSytMyRMlBwh0O
         PSUg==
X-Gm-Message-State: AOAM5333emBc2aAilzbUqE6Aq0Juua7X96rHLDX/gJIwc8Z0dt7821ie
        EfT23yQQXBP3dOXXob+jxSCLDQ==
X-Google-Smtp-Source: ABdhPJyPicumd4X0LF+oGgNS3/ezc40BruS2GaxspNt3jnrsANfXY0TsODjHCWyjt/7ZUW3vorlG9Q==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr4284377wrt.23.1599665774397;
        Wed, 09 Sep 2020 08:36:14 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 3/5] wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
Date:   Wed,  9 Sep 2020 16:36:58 +0100
Message-Id: <20200909153700.2904977-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
References: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds HW_VALUE_PHY(hw_value) an access macro that will be used to
extract a hardware specific PHY setting for a given channel.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index ebce1ed7adf7..71fa9992b118 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -83,6 +83,8 @@ enum wcn36xx_ampdu_state {
 	WCN36XX_AMPDU_OPERATIONAL,
 };
 
+#define HW_VALUE_PHY_SHIFT 8
+#define HW_VALUE_PHY(hw_value) ((hw_value) >> HW_VALUE_PHY_SHIFT)
 #define HW_VALUE_CHANNEL(hw_value) ((hw_value) & 0xFF)
 #define WCN36XX_HW_CHANNEL(__wcn)\
 	HW_VALUE_CHANNEL(__wcn->hw->conf.chandef.chan->hw_value)
-- 
2.27.0

