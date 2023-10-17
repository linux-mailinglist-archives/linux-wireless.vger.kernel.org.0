Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ECC7CD0C3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjJQXaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQXaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 19:30:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9298
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 16:30:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso69745487b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697585413; x=1698190213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfRl9gdLiuLlyWw/vZZSgX7Jvs7WUrm/HI2L0/7QaRU=;
        b=YXgF/F0pUEfYnE0qUsCpKimlLoKQTxsP2fmTeYa8vA+U3dhXjfNr5qa/CLdRi/qbus
         yTv8hRJyzal+VtTWnQxqqUu9+Io/tCglMa9+lerLa7KzzFfWNGkykWZMrk93KrIKq8hE
         o30TQl7QW9Oq9iDk94dKXDVvu98NdQgO/ka39FYq5fbvDwP2gnkC2xeSMoV5UPhDX7qv
         H2N88zmI5gVTuV6/+WGzUTqucTuc2YWfOZcD7JvVEal8dD7GYCwEX1B1nMSrHNeS0ilJ
         ayRcSD3357fyzqA2OsPht9INCLOrqC35DjnIQFZyPOTylUemtEp54/pqjBdGNh6ayv+w
         3zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585413; x=1698190213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfRl9gdLiuLlyWw/vZZSgX7Jvs7WUrm/HI2L0/7QaRU=;
        b=SL5Rm2FYf+GtxfyW3oPRNimwPEYiZS33OMgutqXNiE99rP9YzriBDF27QaX2E1Cx4f
         0pfj88xMJMiVFDJfTUhO+fbBWlujjd2P0ERY2BgSMeb0Jg7u1H0VnoucXFYIs7BZAVCE
         Q6grRj1CaZGvO2C/FMZGNyExYvjH90/ET7xzoW8uQQz7ZmqBdbRSmmT/R0WV2tPpKT/U
         pKGe0NsM5GzQaPa47ldnIUVvGLOxkr15b2vTexeaApM1OlrynZqBsxXj6nw8qv70LVIr
         NVsf6e23BPbDY8kIb7j+/0n6Re1HnF4rsJMU2uTMw4wg1Ew7Nf+MmdQ+atuBq0+/FXiY
         2WdA==
X-Gm-Message-State: AOJu0YwGnRs9+9HwfubgFXt9LxWkafjsHTHN+Ew56N1o3NLqfxbXWKUq
        Z1HLSrCxdtn49HQrkOif0ND6o79RlNQvDdZPHw==
X-Google-Smtp-Source: AGHT+IE6ZQtX5Ldc/x9FESux7nTruZ6wO2HGman7B2yo19w34p1IqaBxbJWnfoeGUkNMwcFQBuso18p9dkuDHYXOlA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:dfd7:0:b0:589:a855:7af with SMTP
 id i206-20020a0ddfd7000000b00589a85507afmr80857ywe.7.1697585412988; Tue, 17
 Oct 2023 16:30:12 -0700 (PDT)
Date:   Tue, 17 Oct 2023 23:30:12 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAMZL2UC/x3NTQrCQAxA4auUrA00I/7gVcTFNBM1UGNJhlYpv
 buDy2/z3gohrhJw6VZwmTX0bQ2064Cf2R6CWpoh9WlPPZ0wqhtPXyyus3igScVFXUaJwKq4jJQ OhK+shozHIZV8JmHOBVpzcrnr5/+73rbtBwcMRYh/AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697585412; l=2738;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AqmdyFVZ4YanSt7f+CjHTlZXK2ka7rON2H7E68N3cxw=; b=Aq4kwBmeWG58HGcSo2vj6qnbwp5WLd8ALIyOclTan1JcmRhKau2uE5Vw0r5MUvlhKkr7RCgR0
 8d/KJ9efQRGB8moxOq+kM+IxEmSgUukOjQPjH3Bk4rQIKATqGgU6NK/
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-v1-1-3a5c02382e35@google.com>
Subject: [PATCH] wifi: mac80211: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on other assignments of similar fw_version fields we can see that
NUL-termination is required but not NUL-padding:
ethernet/intel/ixgbe/ixgbe_ethtool.c
1111:   strscpy(drvinfo->fw_version, adapter->eeprom_id,
1112:           sizeof(drvinfo->fw_version));

ethernet/intel/igc/igc_ethtool.c
147:    scnprintf(adapter->fw_version,
148:              sizeof(adapter->fw_version),
153:    strscpy(drvinfo->fw_version, adapter->fw_version,
154:            sizeof(drvinfo->fw_version));

wireless/broadcom/brcm80211/brcmfmac/core.c
569:    strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));

wireless/broadcom/brcm80211/brcmsmac/main.c
7867:           snprintf(wlc->wiphy->fw_version,
7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);

wireless/broadcom/b43legacy/main.c
1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/broadcom/b43/main.c
2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/intel/iwlwifi/dvm/main.c
1465:   snprintf(priv->hw->wiphy->fw_version,
1466:            sizeof(priv->hw->wiphy->fw_version),

wireless/intel/ipw2x00/ipw2100.c
5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",

A suitable replacement is `strscpy` due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wl1251/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index eded284af600..cd9a41f59f32 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -404,7 +404,7 @@ static int wl1251_op_start(struct ieee80211_hw *hw)
 
 	/* update hw/fw version info in wiphy struct */
 	wiphy->hw_version = wl->chip_id;
-	strncpy(wiphy->fw_version, wl->fw_ver, sizeof(wiphy->fw_version));
+	strscpy(wiphy->fw_version, wl->fw_ver, sizeof(wiphy->fw_version));
 
 out:
 	if (ret < 0)

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-6b2da81eccad

Best regards,
--
Justin Stitt <justinstitt@google.com>

