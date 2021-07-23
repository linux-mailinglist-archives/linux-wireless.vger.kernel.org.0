Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423D73D3BF0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhGWOCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhGWOBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 10:01:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5FC061760
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 07:42:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j2so2598890wrx.9
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=W2/BoceWOJN+lUxPj8MwZIqnVeL+AJsUYJ9PcLxlffM=;
        b=vAj5Q4pwIcQKnRafBiJStGzfWUAcSIDU2wC1hUVB0ShM3wzSygn6woSaFXrhBkbsiK
         oYe4X+laDAlwIR56DKKRF8Qzs0/W1U3su/pmTf7HW2JMK82KW0A/wFxMUtOmXlG3qJhr
         Kp7MWX3kflQvMvRR2zBG721KTd0iTbQUapDhkklmMCcBgYWVqZt2KcfX6v7ictwYjq41
         Ve11hqBhjehccANqQayLs5sHlwPak6sCPrCfdbi8JGnBw3wAYqalFSeK9hecXX4h0kOR
         4W6qrqIyZi50aaUZJ9gelPMroLC3u7Pwq5HINPHBL8iMZRb4FsbxT8RQC0Vf8fuFe1t+
         yY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=W2/BoceWOJN+lUxPj8MwZIqnVeL+AJsUYJ9PcLxlffM=;
        b=C5zljt3di2JUK5beFSFRf/hCjQuABp+MQjDcdF8brelRifcuHFhcNtUbsuOOhOhBDd
         92RQSnvjTRFLV44HL4k7z1+Dv1QXvsuvFzG87fpe1eid708nbMM6ksj41ajfoYZcKHQG
         0DNl8ZLnCgckwUdKY6Taq+YsFoZ75tLnl0c2as/Om9IsshhwhlPBRNhsJoFPjeIYBxmH
         FPLxpjbsJzxrmyMfZ3puIwNy9YZ/UCH8KeU4cILMkPX3qK2sfE1EpTEFDyD/WXyUyTMo
         5sLgdpGwbqAez9OQIjiGyLfRXa2LGkKaQ7s2nFtpB+jfs5tK3gw4QxjdzAkh8tTdpGkx
         pPpQ==
X-Gm-Message-State: AOAM5338M2i7+3vwx+ffnN7k4qYBtYmpKfZLirMKkxFUxup2t0z1sHqJ
        jBc9NuXz8d4nLdSpSxMY5+c=
X-Google-Smtp-Source: ABdhPJxpL2ORe752Oe8CpZbuWXy3pLN7zzfpQpXmVKc97ccxpb/MS/DarebSn4pG5TMhNp/QxGch9A==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr5777206wrx.368.1627051346690;
        Fri, 23 Jul 2021 07:42:26 -0700 (PDT)
Received: from ?IPv6:2a02:8084:26e0:1c70:df03:b65e:11f3:a5a4? ([2a02:8084:26e0:1c70:df03:b65e:11f3:a5a4])
        by smtp.gmail.com with ESMTPSA id v30sm35848086wrv.85.2021.07.23.07.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 07:42:26 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
From:   =?UTF-8?Q?Pawe=c5=82_Drewniak?= <czajernia@gmail.com>
Subject: [PATCH] brcmfmac: Add WPA3 Personal with FT to supported cipher
 suites
Message-ID: <d676c466-fb2f-2301-ff5a-9b90141b6df1@gmail.com>
Date:   Fri, 23 Jul 2021 15:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
AP was set to 'sae-mixed' (WPA2/3 Personal).

Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index cedba56fc448..f7b96cd69242 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1829,6 +1829,14 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
                                profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
                        }
                        break;
+               case WLAN_AKM_SUITE_FT_OVER_SAE:
+                       val = WPA3_AUTH_SAE_PSK | WPA2_AUTH_FT;
+                       profile->is_ft = true;
+                       if (sme->crypto.sae_pwd) {
+                               brcmf_dbg(INFO, "using SAE offload\n");
+                               profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
+                       }
+                       break;
                default:
                        bphy_err(drvr, "invalid cipher group (%d)\n",
                                 sme->crypto.cipher_group);
-- 
2.30.2
