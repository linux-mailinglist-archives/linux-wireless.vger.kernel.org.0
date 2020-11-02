Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8432A2946
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgKBLYm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgKBLYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:37 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEEC061A52
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h22so9150906wmb.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuBtucNK6orquLtJMKORaW0tLzjtm6vr9NLgmkKGSZ4=;
        b=QvlkOlDalMkDg3/bMvwge5T0Ii+8IuTEkO83EKlfjVa/CW7cw8OD3+zV7urVzsZ2MY
         GMsyeneq3/3u+RRHGTUUXtGbQdJYVU5v7TaLQW4D9sWNFLRbbe4pAwoNWKQR/nD/RG35
         ARq5Hy8NdBltEOOHwcy9cRPwm7KhLeKN/i+CBN8MAzuaUk8b++WerxEB6TO4AKomC+Y1
         wDAUtexWJPUD0pJQMpvF3bX2BVnPCGZL5SKXeK9Gy9R5bjbNlvtOPDblxwD34XZ77+xP
         c9hq/5Sml0YI5zxIIgCXApi6TBTnEX9m/skqJNrV1SjcfzUF76ZozMAfv1UH0uyBf4Wg
         EICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuBtucNK6orquLtJMKORaW0tLzjtm6vr9NLgmkKGSZ4=;
        b=ZaV+yzrlWf+IdQ4vLsf0NIBYsa32nwj45etEVmwt78cWeR6EnZHVJki8jDpKoGhYYm
         4tTVg2PzpEYePzFIKaSrnRdSDJjU8KrAYVkITl6sj8X5KKXwxAGkRu25sUVR2LHUKsdi
         omUVsdwqEuKUwc5pEzlxatcl6Ev60M2WXD3OQXzVswyCKlSwyxgFGqeysYF+FaDxZdzp
         kKIhT0Hm5RoDU3cqfZujgZTfgeNlUPKok8yZIgMzUe69EwaQXUogBdYVMThjniIP4uc4
         Z+QLd3svVHWIxJzFLu51GlQ01PBGO0fokRPVu99vJ732mBBfVtrGDg8uX+J5im83F8i4
         MUWA==
X-Gm-Message-State: AOAM532eFvUDRhXI/KpBcFGueLBBelbhDmIwzY/aX6OCsh8gAjO9P5c3
        aN4pu0OqQ9BzVuNQNHwcliPG/Q==
X-Google-Smtp-Source: ABdhPJxl+oUD+eenUUM55ZHK6NU6oy1ZIm6YJN4DNA3V05R69spUoktUQtN9bLIF/DRQiUhiaokCLw==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr16873385wma.43.1604316276365;
        Mon, 02 Nov 2020 03:24:36 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 15/41] iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
Date:   Mon,  2 Nov 2020 11:23:44 +0000
Message-Id: <20201102112410.1049272-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c:347: warning: Function parameter or member 'trans' not described in 'iwl_read_eeprom'
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c:347: warning: Function parameter or member 'eeprom' not described in 'iwl_read_eeprom'
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c:347: warning: Function parameter or member 'eeprom_size' not described in 'iwl_read_eeprom'

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
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index ad6dc4497437e..1b2d9fd82a3de 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -335,7 +335,7 @@ static int iwl_find_otp_image(struct iwl_trans *trans,
 	return -EINVAL;
 }
 
-/**
+/*
  * iwl_read_eeprom - read EEPROM contents
  *
  * Load the EEPROM contents from adapter and return it
-- 
2.25.1

