Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3E74DFF7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGJVEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGJVEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 17:04:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E74DA8
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:04:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so55376165e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023047; x=1691615047;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFAzc1w8baHJrsHv/ZtPxtkuSiUzObgs+BRZ7PhBYlg=;
        b=CrhlGwXi3+l/GF1L+PDfDx8BsyZ34tplTvlzkCRFm6hkWaqerImuMa+tPG9hqeGe8n
         NtlVEdHKKDKjNfCD2J29/sSAkpdrmpB4u0C6Ag4YSsdhIRt0xe56x8D7lALEzaCcpVw+
         J+hZ8kYiPT+13qiQPdnhNjy+ij+2z3DT21ZskWsAXBK2ITtXZYGCzEzyk9xjtkVm32Wt
         h2AjYPXoj1vto4lMMFlUQC04Ecou0U0gVz0184IC7vKKbfBZ48z4KfZYB8hjJ6C2JDT9
         LQx7Q+LrSBDTcXJ5kanQzIbw4cbmgdORlhgqyT1E27zLI3frurYztBOXAz3h6sRfJx9v
         z+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023047; x=1691615047;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFAzc1w8baHJrsHv/ZtPxtkuSiUzObgs+BRZ7PhBYlg=;
        b=IobqXilGkZR4FESEu2GuyFDUocMr85VDu73jT2IcbA04c82oByqBJ4dCAu59BzGIGq
         SpnCWS2uI2KZFqY4SwGUjz/pwdIUo0k8qlKNfmxkRtiJK2lrgNVnMhT2QDnq0Yt3e5/3
         3YrOEeuv5TuSWjtDmXuqHSSnKpjlHzaM+rvmgGypwEgUb7DR5bvmgAwvrfytJFZNkeRA
         akTZXv5LgTPhQ1cuOOi/aqcUIVp8KIh8jQkQUyNrrvGy2AIgfu+56rr7nNdfQIvts140
         qsXH2bX8UO3h1wBcsE3z4gMp2ktNNgCgsgKykpzgywLQ+QL44wCDg3V97JsUWy26S/pl
         so2g==
X-Gm-Message-State: ABy/qLaKijZO/Nr2Nxd/NvOmR9DZlcjRHHGIijPKw0OMqJR0uVuWj3MF
        1dtG3Lx6n6EC90DaX9rMF3gLkr4RK18=
X-Google-Smtp-Source: APBJJlH/685H13s2z54KKhPxM2dALPNvl1wrnMCwQdnwgKF/Pxwxm5SGrlOirV0Nm9WmYS633sTt5A==
X-Received: by 2002:a05:6000:36a:b0:314:4473:5bad with SMTP id f10-20020a056000036a00b0031444735badmr14743614wrf.65.1689023047629;
        Mon, 10 Jul 2023 14:04:07 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d554f000000b0031411e46af3sm363507wrw.97.2023.07.10.14.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 14:04:06 -0700 (PDT)
Message-ID: <ce04a0a1-df72-ea30-f742-8834e01457f5@gmail.com>
Date:   Tue, 11 Jul 2023 00:04:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 2/4] wifi: rtl8xxxu: Enable AP mode for RTL8710BU (RTL8188GU)
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Theoretically this chip can handle 15 clients.

Tested only very briefly but it should work as well as the RTL8188FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index f0d17b75c5f1..871b8cca8a18 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -1875,6 +1875,8 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	 */
 	.ustime_tsf_edca = 0x28,
 	.max_aggr_num = 0x0c14,
+	.supports_ap = 1,
+	.max_macid_num = 16,
 	.adda_1t_init = 0x03c00016,
 	.adda_1t_path_on = 0x03c00016,
 	.trxff_boundary = 0x3f7f,
-- 
2.41.0
