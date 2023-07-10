Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535374DFFA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGJVFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 17:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGJVFV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 17:05:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F41A7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:05:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99357737980so647882366b.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023116; x=1691615116;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2QOZ4p9y9licAqcmEwdS8OXFAh7Q+nEgiRJis+2CAw=;
        b=Hto1kQVE0Z/k7NCbb4cZrhvGnw/jJUWTtI9jjSmfDuB5PwPr5tXfZgyL4LsvQ/ncgb
         LvPcCX9abRhrrZbJp0BhlXgwNjd43y26rdYZgOuAoXUZbdcTm835vASZZvUBEMRvTkPj
         QJPHWSG3ts3VCsEx8QdnOABLAiOARxd/swUr/53/sMKIkyPa7t6cPBpPK2bUxFlbUm1m
         Pv5s34AO3u6Yb1nTC8NdFc+so30sRUo32F7eVHxInJFQPGHilnY00r9ixLg8xJkuzTLc
         ow5kEunhiMi7rkKALnchmYOsIkW/QxhIFwrZapy/hs0yknDU1kINMaZmnOFvUYiV524p
         aiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023116; x=1691615116;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2QOZ4p9y9licAqcmEwdS8OXFAh7Q+nEgiRJis+2CAw=;
        b=IMiB2/Tmyzg7NWVqJwZ7o/qYTdNMl0Cbi0FiX6d0u4Q3ElrJDkMRALOvu+b71WoRNE
         uKkaDSq5DAT9Qp7w2MRdTtYa4g5DY/LdaAhbPTTe87XYw5SWKiSfx+njQW3bFH3RRUNz
         5+XAW/xdPD0KlYtZ3hlzSi/SJNq9f3P8IyOEaMzFAw10d3YLIv5eAncgR6EmU+w9Dsqg
         HAAUXC15XMrL1nUmNLQB4OM3H13nr/DcLwpg8xeS1ECM7kaAUmCdG+w9DW8WIb+XsOG+
         hRAT3KhambhCxcmRoIHVCn23H7nHg7OAJa/yHVD+BPOVtY7EH95I5fXqY6dDp8RFu4OG
         zdfA==
X-Gm-Message-State: ABy/qLYOA+GyumfLDpz1tS4t2pLNCLB3wIyzRdpUsNvJZ1B55YgG9x2V
        bjaDSdPlJWTygcwHYaBbGf6tbf1MLlk=
X-Google-Smtp-Source: APBJJlGVHWko7eQfk+azVIZAHzJp/miP6P1HXLCij7AEJ2ExkoJAH9Ara2BI0YfgAXR+C/eHrq5lgQ==
X-Received: by 2002:a17:907:3ad1:b0:982:79fa:4532 with SMTP id fi17-20020a1709073ad100b0098279fa4532mr12561862ejc.53.1689023116449;
        Mon, 10 Jul 2023 14:05:16 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906395700b00992a9bd70dasm228274eje.10.2023.07.10.14.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 14:05:16 -0700 (PDT)
Message-ID: <b2876c56-0ea7-c398-5c9b-635f9f894f2c@gmail.com>
Date:   Tue, 11 Jul 2023 00:05:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 4/4] wifi: rtl8xxxu: Enable AP mode for RTL8723BU
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
In-Reply-To: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Theoretically this chip can handle 127 clients.

Only compile tested but it should work as well as the RTL8188FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 13ad5d5b73f4..954369ed6226 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1742,6 +1742,8 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x0c14,
+	.supports_ap = 1,
+	.max_macid_num = 128,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
-- 
2.41.0
