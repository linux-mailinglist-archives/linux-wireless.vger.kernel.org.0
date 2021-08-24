Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3566F3F6B9B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhHXWOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhHXWOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 18:14:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1685C061757
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 15:14:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3241706wmi.5
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m00bb6CQwZ6OzGGYd4DErHHIaz0aC5nr4NAqDuB1ks4=;
        b=ePXLkffOTifHEWs42zZFVb9N6lEgyL5Nr6cm65jTZUs8GxpP9NbpWS2Etiz95ifEaB
         4E4f4xVRjNNwuZtJClXVWacTJoMM35s/k1VwbdvLA8+DydRs2Nm2kNiWMBnAzi9Q1MIF
         WriPn4vBYXrqlVEAPuTN3Rj3vIs4hZbRuqXXCmPXrR1L0XVewGgJXjupQwi5SW0W6E48
         vLhbUbodnQ1Uxb8OuCeqeWZZ2Nho7F17ESX4gJFQBMEVZJBI6yFhzU2NefBL5v7LwPzu
         40YZxeZUoymyDVrdzFO9xgulQYSR4k0UMGdN4l42jMR7ZKXa6h0+g0j34xP5EjFyvCWT
         4Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m00bb6CQwZ6OzGGYd4DErHHIaz0aC5nr4NAqDuB1ks4=;
        b=KyBVFCo5M1/803YnWNqN1UBbVyU9i0ZKvv14JGzMNasnRZbiXkTvqdfDEoXdMcoI6i
         2Aroz029oORlm8By7crYwLQu1OgiJOPQr+TzPR+QF3o3+hh5I/0807iPqnhtMJyWEVsi
         ct/+VOxE7BwWNJTmzZTP96C/bSekCzoxw9WJt5QLP7XKRVrNOfq7UomnNM3NxLm0QZuF
         LhbqfnatmPIpc1HyVX+zzZ8Pjj4sktvnJZR6KA9eqGVTI5cs5BOO58tFYGFduGLNnhZa
         Cz1/bxCFthXXR1zEPYPPYVsm6Z/x88HmqWbEyxH45Z3vSZktwvMTupaAUHSOl63Dc6M7
         8IMw==
X-Gm-Message-State: AOAM533HkOYm7ZWlZs0S1Y79bffPydsZlxUrwqqcT1FYjPMJs5A/dKjs
        XCWnXT8BBsqvk7VgNgR01HKLcVYCOIJ6bw==
X-Google-Smtp-Source: ABdhPJxcq11STjwKVKkEupiH3YbeQvqPOQJXp4RWd7rAf57qzAQWbSoKI0+fFi2X9ZhL16ApSQqNYQ==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr6245376wma.150.1629843240857;
        Tue, 24 Aug 2021 15:14:00 -0700 (PDT)
Received: from localhost ([2a02:8084:26e0:1c70:1d4:73e5:b902:5859])
        by smtp.gmail.com with UTF8SMTPSA id h6sm4042790wmq.5.2021.08.24.15.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 15:14:00 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Drewniak?= <czajernia@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        =?UTF-8?q?Pawe=C5=82=20Drewniak?= <czajernia@gmail.com>
Subject: [PATCH v2] brcmfmac: Add WPA3 Personal with FT to supported cipher suites
Date:   Tue, 24 Aug 2021 23:13:30 +0100
Message-Id: <20210824221330.3847139-1-czajernia@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
AP was set to 'sae-mixed' (WPA2/3 Personal).

Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
---
Changes in v2:
- rebase on top of wireless-drivers-next
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index cedba56fc..f7b96cd69 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1829,6 +1829,14 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 				profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
 			}
 			break;
+		case WLAN_AKM_SUITE_FT_OVER_SAE:
+			val = WPA3_AUTH_SAE_PSK | WPA2_AUTH_FT;
+			profile->is_ft = true;
+			if (sme->crypto.sae_pwd) {
+				brcmf_dbg(INFO, "using SAE offload\n");
+				profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
+			}
+			break;
 		default:
 			bphy_err(drvr, "invalid cipher group (%d)\n",
 				 sme->crypto.cipher_group);
-- 
2.30.2

