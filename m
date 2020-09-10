Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB37263E5B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgIJHSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbgIJG4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB965C0617BA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:55:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so4616050wme.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkJnqXxLKchHWxEQRJwgWXXCncTXSd4DzK09wyk1JRk=;
        b=DYJqd1E6K+y9QXkHGAIL5L1tXb7g2KMB7ljmLob/AWKP/B3CE0VlYJ+ZmLnA1JsU+W
         XzeKdAFsy3l664YPEVaTMsQyAxViTd7y/szoEgOR3KBWpL4pzwKQAlvQV69no2+57iAO
         sBvvSBR2DbNxQ6bNR8Lzl1VEXxN5F6qC0fQHRQ5TFDTnBG5oX1mfdBa2iCtghm17AxG2
         1V8A2AfOYwH8cVYYPvNFSVtl154KCArcSZDn+zizPSCxWsvuJh+9xjvKibqeFwq8iOur
         LZ6006V9Brdrycp32HJO4D2kbIXGA4X8S9D03PGja1KroF6T4l90Ual4A97wbQRlGduW
         3ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkJnqXxLKchHWxEQRJwgWXXCncTXSd4DzK09wyk1JRk=;
        b=Zg7PAPTIK5sGQc3Ioq4K9qUcOUE/Ya4Id0z0X8G4a84Py2NxzV1CEVgSvCt87HbhE7
         g3g1+F1Ze+GOmYqJKmpCSNjL8lwc8pAbwkOqUN10hmF7xvrRCmigI5RjtohvqFGGOdbL
         KalAAGlUmyHu7pNG8cb7M+b11gFZCbd+Ux01u/IgedBVR02pkNcz0X0zmPDD1dhfx05P
         9UactWRcUY4Zb/HC393xvGtAKvA4xviN0Vn4nLnycFGPMGrAqt6Ylv6kH54h8g+PbLml
         4dJ5ZRLthR4YcMn7Nk3CQzzN2tVN3PxRP/OTVc5PYlfz1ftv4kgLzroylY4DMzkzg0TN
         RLlg==
X-Gm-Message-State: AOAM530tDmuwxKL+MaP7S1+z4QcJaENShUMROIXzXb+fQDS6f2XpCB1v
        QpzH8IEGWuX7z7pLEvoNHUbixOq/w01StA==
X-Google-Smtp-Source: ABdhPJyWZsjYvdkZU9EYL+wKFtSQo4POMqm+cW+4REdrJdO0d6J7tVdZDQUtki7PleCf2FTISfGwYQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr7063757wmb.25.1599720902615;
        Wed, 09 Sep 2020 23:55:02 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 08/29] iwlwifi: mvm: ops: Remove unused static struct 'iwl_mvm_debug_names'
Date:   Thu, 10 Sep 2020 07:54:10 +0100
Message-Id: <20200910065431.657636-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Looks as if it's never been used.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/ops.c:466:36: warning: ‘iwl_mvm_debug_names’ defined but not used [-Wunused-const-variable=]

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d095ff847be92..8e1e9ffbbf59a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -460,15 +460,6 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
 };
 
-/* Please keep this array *SORTED* by hex value.
- * Access is done through binary search
- */
-static const struct iwl_hcmd_names iwl_mvm_debug_names[] = {
-	HCMD_NAME(DBGC_SUSPEND_RESUME),
-	HCMD_NAME(BUFFER_ALLOCATION),
-	HCMD_NAME(MFU_ASSERT_DUMP_NTF),
-};
-
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
-- 
2.25.1

