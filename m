Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF05AADDF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiIBLsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIBLsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 07:48:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D0B02B6
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 04:48:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id og21so3381121ejc.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=MnPhdizvUWz2crhcnH+uVitf991jw1ElaQE/voAn/h8=;
        b=JuFmbhsHfdDI56fordT9GHy03UcjMf/FgPMbKN1tXqdnbL4cyEx+A/GNwhVP4RtF0c
         5lqXiyCpOkvLXoddhTlFhRJH2yMNCHYP438Nzh/zQeHN2t1yWtchHdgUuCMU8uqUCsrx
         32sX6p7DEmkTOmk2grLrtzdJgYYXag+j6senSPl+PWlgsB72HAuXJB9XvsZ/DAHW1l++
         8nO2WSHefW7PlJywg9ZxpyZ/mkH/O5FrYUz3iD1Rvp9PBErOI4TZkYdjFJ8slRf33Wlt
         Y3w5ybNKtx5p5Fg9RVw1pvNW0IR9FCEqpJXiGuFSz80UTXu9SEn0lcRYh2dqLfryQ1Oj
         Zsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=MnPhdizvUWz2crhcnH+uVitf991jw1ElaQE/voAn/h8=;
        b=5b+fKpK8vVg9lX/RMUgx/CmKkz6WdwqFZnXE/ZPn0XHqXgF1SEgvxNaMeR5dsSUzQK
         A5gEvxZOsgrxWqXvltwDbhf1O5GCPaXbhLpXfPY3o+T5YYmHgwt+42m99Ys3OVnPmT+B
         t1dGhgRHgieK4yeFOxjFDhNtkHohFbdSgEV6pjBdQfMxOl4px6aTQxw/tCrABta81s7m
         90/f//qGsbpE+KGwxYI0P/RyhffAxY94uN90CebxjHBXRLTNmSHDoyb+jnz1dY9AVsmO
         7iyCLmPrKHmNSnkCPS7uo0kjIEAqQ7flOqh5EDO6l0GLST/AP7h3+NeATs529FBLh1lu
         FZ/Q==
X-Gm-Message-State: ACgBeo1aGhwAokIaeBXbTgHln5j3dx0uEsarXu5MZ8SsUiyiWPu38/eS
        w0eyRdeDCvaBMQYM+tvW3lTmWr7eHCFQsQ==
X-Google-Smtp-Source: AA6agR6o9CGKpuapcCTNZ2vr2HAXpEJiEn1MqGcqyqULOV+3A4HNNq7Aft5c8P1GjOaYg1c1S0zCPg==
X-Received: by 2002:a17:907:1609:b0:73d:d2c7:8bc8 with SMTP id hb9-20020a170907160900b0073dd2c78bc8mr24715854ejc.417.1662119313606;
        Fri, 02 Sep 2022 04:48:33 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id mm12-20020a170906cc4c00b007413360a48fsm1147434ejb.50.2022.09.02.04.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 04:48:33 -0700 (PDT)
Message-ID: <30a59f3a-cfa9-8379-7af0-78a8f4c77cfd@gmail.com>
Date:   Fri, 2 Sep 2022 14:48:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: gen2: Fix mistake in path B IQ calibration
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Found by comparing with the vendor driver. Currently this affects
only the RTL8192EU, which is the only gen2 chip with 2 TX paths
supported by this driver. It's unclear what kind of effect the
mistake had in practice, since I don't have any RTL8192EU devices
to test it.

Fixes: e1547c535ede ("rtl8xxxu: First stab at adding IQK calibration for 8723bu parts")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 422b396a1af6..b4e09da1c683 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -2959,12 +2959,12 @@ bool rtl8xxxu_gen2_simularity_compare(struct rtl8xxxu_priv *priv,
 		}
 
 		if (!(simubitmap & 0x30) && priv->tx_paths > 1) {
-			/* path B RX OK */
+			/* path B TX OK */
 			for (i = 4; i < 6; i++)
 				result[3][i] = result[c1][i];
 		}
 
-		if (!(simubitmap & 0x30) && priv->tx_paths > 1) {
+		if (!(simubitmap & 0xc0) && priv->tx_paths > 1) {
 			/* path B RX OK */
 			for (i = 6; i < 8; i++)
 				result[3][i] = result[c1][i];
-- 
2.37.2
