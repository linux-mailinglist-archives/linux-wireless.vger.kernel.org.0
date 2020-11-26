Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AD2C55A9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390319AbgKZNcQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390310AbgKZNcP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3B8C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so2141353wrw.10
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oATorMQPiNVEoXmBjgNPIPCMhMKpxL92yv6qxOrQmpk=;
        b=IbJpdC6i4+GdmwJWSs//6cgsZfjzcpBfm/L8Mjzto4Jo9wyyg4hd19km+JlwJHpINW
         f01TQrqs5iES89DzrbzYY85mFR3nKkhNsHBodFx+Jco8nrRyerd6sov+bZg9r2mlFHug
         IgAAGffYPn7HOkX8bvXFMUfSg87rfEKX+EcWEpydNBniojEX6wWMgDUdCIDAyu7T1nnK
         QsuwkRz+MNIThTRt0pTWKgi4WCYrXyr2s/AcXVl1QbpJmqyAjIenuuAEizVVVNY0+WLf
         +Cf5nadVwB7oYQkGGMCvCmH3pYNMFxbbLrLyxC4qJhpRiRz1UODFcA/iGtN/CwQafyDe
         PGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oATorMQPiNVEoXmBjgNPIPCMhMKpxL92yv6qxOrQmpk=;
        b=eH7LIc1HkZiYo1BqONG+IcDbplp01hX9SURqSBvIyjhZGprxTUKJ3gWTEoOBCVN/g6
         9PkrnSF6iMeLwSqP3TMuTG+Un2kYENaxRsQPmz9Hd2Kv2OrncAtLIMymNrzkLNxNCZ4S
         uWApzMIrQAuA4aVHEce8za+cXp6OdK1JWj0xs+w9urmdFs/zNO8yhbNrOxfaZ0FnI1dB
         8GNY6qtRDi5s48GHmHCddzoOx1cxHZb+4XLQ9uIc/FGYdNjGUJjfOunuUcoyaaOLZqBI
         gF+1Sl2kgvSr84yv3vwRd+afaxB0xkGOWtq2q5mWvGoIMaj9Iod3Kf0zdsWtBjGpfRgS
         lXkA==
X-Gm-Message-State: AOAM531YDOnmGrGLQWMzFIgwrUg7tqaN4ya21PvJem5gT6jj1e5o5RdM
        mOAVDAg2waaNoFx+CnMX3JanxA==
X-Google-Smtp-Source: ABdhPJzar5pL8NJXSGoKYV0wnB0lIWqTVB12EIyFUGuvX5/YQrx4//RE3ORazZXu+kfKxp3kELmzfQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr3926438wro.363.1606397533529;
        Thu, 26 Nov 2020 05:32:13 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 14/17] iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
Date:   Thu, 26 Nov 2020 13:31:49 +0000
Message-Id: <20201126133152.3211309-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c:1932: warning: Function parameter or member 'reg_data' not described in 'iwl_dump_ini_mem'
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c:1932: warning: Excess function parameter 'reg' description in 'iwl_dump_ini_mem'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ab4a8b942c81d..c0a180b496988 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1923,7 +1923,7 @@ struct iwl_dump_ini_mem_ops {
  *
  * @fwrt: fw runtime struct
  * @list: list to add the dump tlv to
- * @reg: memory region
+ * @reg_data: memory region
  * @ops: memory dump operations
  */
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
-- 
2.25.1

