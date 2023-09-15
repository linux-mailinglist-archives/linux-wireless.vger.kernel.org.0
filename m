Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47B7A27A5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjIOUHI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbjIOUGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 16:06:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097AB2D6D
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 13:05:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c364fb8a4cso23478115ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808354; x=1695413154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0Hengu6K84ftLWMR961tNpe8ygiAngUSieA27Tmw8o=;
        b=mTjofa0WWeMwSESHvEFPRZkSP8Ukosg8qDpGwK3km7Yy3O/LY0Mn8iuGPbwmE74reh
         kNstE0TluSB/7eU1th5eB4f1KugMlV3c9MVYincmV0APD2yU6wUtATpQ1ucIr/wrJ++R
         RuyGUqprZY3Voe1hgkbOAizgJ2/D6R9Y6MwBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808354; x=1695413154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0Hengu6K84ftLWMR961tNpe8ygiAngUSieA27Tmw8o=;
        b=R+e79LKouRTqTEzuNPCTVyBg8ES9uqlBIrbifSvoOpMoFc+2yVqvC5hB1vxsD2UkBU
         z77jMkVwtSr2GAkR7MN9TfiptzzAXgbtTa7BeJG4s1TjqLDvUi/Qb36taGsXFSswbCXU
         mYX1KsY1ylfHgENnqbsErSupTBh860XqCD7ZKP1/Ck8KBN9fpl13kCSQiYTb59UvYV9N
         E3u7keKb9vOrVNx1p0fbVAkYi8ddIehTAUbjl0ceXVHBpbD+TkhaxWJo7TixBZzUqDq2
         eOfgt+NZ69k4E3nY/At4AUV0qLsxBNLdnKgTHMp+PFUiSDV6mdstV/Lq8buCF8s8Wb2O
         4gzA==
X-Gm-Message-State: AOJu0YxgYDC7QTmsrS9zo9VKsPb/61zt9gHTaqp+zf3/RYo3JJ/6BOjR
        ateuvktiRfpeeZJzfdyHNjLdiw==
X-Google-Smtp-Source: AGHT+IGq24vrcLOcjpvOgH5ob0qEzwfV+/Rp+So43tNxmidLFVOV8uEa8SaUdpJsq+YRIrMWJWaR2w==
X-Received: by 2002:a17:902:eccd:b0:1c0:ceab:e9bd with SMTP id a13-20020a170902eccd00b001c0ceabe9bdmr2471233plh.25.1694808354539;
        Fri, 15 Sep 2023 13:05:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001b9e9edbf43sm3884947plj.171.2023.09.15.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:05:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hector Martin <marcan@marcan.st>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: firmware: Annotate struct brcmf_fw_request with __counted_by
Date:   Fri, 15 Sep 2023 13:05:52 -0700
Message-Id: <20230915200552.never.642-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=keescook@chromium.org;
 h=from:subject:message-id; bh=weqFhcMmCNEK0MsxB/YQXMpH/1sEF3VWxqr/sIkwvFs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLkgJxO209fAiikOP4NOLZvvkl0taCniJgeTe
 BfOIErtc2+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5IAAKCRCJcvTf3G3A
 JuUUEACZ2zaEA8T4Cn+MXQTZsiQW6ccYb+T67EABtpHMJ4cpCBYnDUFObSJdhqyNgTMRDPYL07d
 6fCfLAJQEBKhzzlKriudyRK7RKpMLFXL1/VZ2VshpPpr1+nih8BvG6G95958M/2KzzNfBnJW1K2
 r8ll18pOYxr53JHtE0afMIbVijjDcCmJ1YBnSdSWF4F0qdJSLYxI7tWXmOcanyNTMgVktHRikWK
 lvUS2q72eqNEAM8NTOBfg8watlPpbDk7Dvooq+jYCZe5qCV7FFQOohK4NFaje1Y/AbRCAYw6ItN
 saFM0iOJNyUWDpt0hsG710nZFYvpoGsFkhHBbzqFoySbVFfqhQD5ubDa48yoN0AD0hWntF5IJrk
 VUiGrKP8rXAHmTO0gqMAKbjlDJr2pZez8QZtkVa2K7hgHpabCN7d60rbWvAyjMaba+QZaMY1oBB
 7tHL/Avo/6NdspsNpPVeiFpRU3mDEhjiB6i7fJqblMFndNBs5gywqAYyLtbmMqGKijzhbW3qC+j
 JYb4HUVvToJO7FD3EzJMQQjuNcxjoc5CmlwNJxMYW1gfIwr/Fv/vSnFOMzB9R0yV8fh2xUHjGeD
 sEHOO1E+G+Le0NLFJBX6tKqb451jPjxpTyT3+IpcOopCKnL60hv8UlEjI2U93m+xzsWhbrL2F94
 WI39utA MSfdKWew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct brcmf_fw_request.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
index 1266cbaee072..4002d326fd21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
@@ -69,7 +69,7 @@ struct brcmf_fw_request {
 	u16 bus_nr;
 	u32 n_items;
 	const char *board_types[BRCMF_FW_MAX_BOARD_TYPES];
-	struct brcmf_fw_item items[];
+	struct brcmf_fw_item items[] __counted_by(n_items);
 };
 
 struct brcmf_fw_name {
-- 
2.34.1

