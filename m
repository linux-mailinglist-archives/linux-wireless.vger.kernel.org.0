Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DA2A2926
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgKBLZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgKBLZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B3C061A53
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so14163055wrl.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oATorMQPiNVEoXmBjgNPIPCMhMKpxL92yv6qxOrQmpk=;
        b=jBHePhYnnP0xuAetGt9Eo3pFc8xqQtQuTC0DcIYmXn9WdkpaTDkYVo1KTjcx1txQK3
         w/BBQ6r4xyCakZNyMSelnh8f0ItIvYAGjnZMJzr+h1ZQtGwIwH7xTLH3rBWqj89rFQfg
         kbhq2qpIuYR88WmpwwNYxo8aa0uoEz0moj7E2Anr1zixnF0HkGvl1lMvYF2q8hAztolE
         9Uc32jXWJraeUHQ4YwinYPw4ZbEGo5n//b4TejRX3Cf9YI1ZpamiWdvQMUJBodh/E8c+
         fbjKnA8xz2H1KFAta1L29egvBdc7bQ9bk6NcK9yMtAkHa75OGm+e8Jf6pSLvcftIC/jE
         7Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oATorMQPiNVEoXmBjgNPIPCMhMKpxL92yv6qxOrQmpk=;
        b=kyt3FY3gkFmPaljhxROsML3MKrzGZqwE6LC4JAH3ZaXokHzsLvaV71jqDKrrXSX520
         pOj/Fjfati4BEvh3JJVdWr8yCmlyE2E2HvjzWu51nrl/0StmdWTpniFes8QkCWNys1ha
         grOcK/8obhlPKSGtYoHSDMHzaDujH2Kr7fX99CQ0TWKp9q/dim4A+1gB1ErsifaVyOD9
         VkILmT8UcYQYeTqUpwhkUMUptARyJtS8bsfgxIZFhJbamDyEZEKGXC4WvJ888cVpL3Vq
         bVGDN0Ve9L/q1iFL2Y+uP5JSX0CPCY08A2LSAf4z1jW8cwxz9DY2HsQm8pNaLTnLfCMV
         HAOg==
X-Gm-Message-State: AOAM533qHEgSXuSJtlgwsqG8YbQQmYIFHfkc4VRXmeb2lRdb+kK/FSQU
        24/e3keeOD/rHZZRLi4XTGi46Q==
X-Google-Smtp-Source: ABdhPJxxJwdd/oQ+fNMOlnIz3kGJlqYpSor60fsw/OcUNRw6rXY3p++l54wc+a28IKDS/2qEvOdhPQ==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr19802904wrm.208.1604316306994;
        Mon, 02 Nov 2020 03:25:06 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 37/41] iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
Date:   Mon,  2 Nov 2020 11:24:06 +0000
Message-Id: <20201102112410.1049272-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
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

