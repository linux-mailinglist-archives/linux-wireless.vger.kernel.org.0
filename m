Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1326363F268
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLAOOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 09:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiLAOOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 09:14:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C853DBD89D
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 06:13:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bj12so4451495ejb.13
        for <linux-wireless@vger.kernel.org>; Thu, 01 Dec 2022 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP9wXMR0shhgXMeuLo4ZgWYfP0ciEq02yuGTKP8ReXo=;
        b=Eajf0z2hPEqJ+zN15jWVzf010FduhiZ0wCbmXwGTXicF/sFeygvLB1qq6yZuRffBs0
         wL82qhpYL3Ya0y9M/HbqE1VBqeY4zMxJH0Uj8ArU4DqxRr11nDxF2WH8dGWpfMQWCnJV
         gj3gsVeFeK+68hjMQaNGzd49q9vE/EtEUBd8LTF3vfCrtS8yZCAE4evEhd+6MBrTr1AQ
         GGZ+iJI38Vx1ggLTYDxo0SKdOgG+JspIo2QeSCc7AdmfU/EtTfJSLun3WCcEcPcF5pfs
         NBMctSrryZmUD+dl4NVeRLX0YYFRBV5YxcRryatjRKb4FpaZe51RyA7XcOefo+F50RGc
         aOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gP9wXMR0shhgXMeuLo4ZgWYfP0ciEq02yuGTKP8ReXo=;
        b=PrRZQz3PJAgMoVKme/RAw8XaFJshqB/vcHCo0hw4GYSn8CBr0r6bHKMdlJw5FdFKrZ
         mHNgoxhyJThI6o7pNZLzf6WK1HBcvQXyYMHeky5/DY5obeSlk0DUp+VFd97u4Iu7Lu9k
         zzCFi//fW63vnS+bMhZPX+vg5XB0MpyVYvzxEa0fA+zbMMDMB5VjB3YBfesVixjJ0OH7
         UUjlEIqvEBjds/8buoD+90nsEkfUE6B+ck64lTkHAs0npkStR3ZMbuCOCHxewjN88jNP
         TDVtfeJD6PFCHC+CLTtjQb2kAqTuQ8xytll9boittON53PCs9zvqgywCnYrC5Dl+AQxf
         Rcuw==
X-Gm-Message-State: ANoB5plFALSlJZ3uiO3deOUyiAjaf/0muuuGSgCFOfNWIvolCMoeWexO
        R3ZGS5XzQhg/+f+IA4dG2Zu8Q99bdM8=
X-Google-Smtp-Source: AA0mqf62d240L3Q3vQoueeVntlcKaynDcvO9nJ5mj1fdJBtnsKywlbvveRf7CrB1DxfU/Fo9npXwjg==
X-Received: by 2002:a17:906:5a71:b0:7c0:b882:7ea with SMTP id my49-20020a1709065a7100b007c0b88207eamr1005137ejc.768.1669904038403;
        Thu, 01 Dec 2022 06:13:58 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906264f00b007aa239cf4d9sm1822530ejc.89.2022.12.01.06.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:13:58 -0800 (PST)
Message-ID: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
Date:   Thu, 1 Dec 2022 16:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v4 1/3] wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This struct is used to access a sequence of bytes received from the
wifi chip. It must not have any padding bytes between the members.

This doesn't change anything on my system, possibly because currently
none of the members need more than byte alignment.

Fixes: b2b43b7837ba ("rtl8xxxu: Initial functionality to handle C2H events for 8723bu")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - No change.
 
v3:
 - No change.
 
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 136992f0200c..d26df4095da0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1240,7 +1240,7 @@ struct rtl8723bu_c2h {
 			u8 bw;
 		} __packed ra_report;
 	};
-};
+} __packed;
 
 struct rtl8xxxu_fileops;
 
-- 
2.38.0
