Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61F63B23B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiK1T2E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 14:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiK1T2C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 14:28:02 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF751D323
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:28:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vp12so27170868ejc.8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWXcY6gAbmfVg7KCDcfT+9csscwbs+7BfaV1oEKjQLY=;
        b=N4nhKYQwFMQAKSssUvrGAC/i3t29r6D+B2Yy9JZdsZNi4EDmVmwsyo5xafyVewNT+K
         qOlxuDooaE0+shPjP/0Qjx6JRA0Ixz2Kh06dWePC+C+KoyHujAEnHUAeCyQj0TdZW7fz
         QNRkbRgqmsbwI4f3I82EhqHcKsbBzUSJZxcf/kzyA7DwbphJvS4j/JbSSNitwZwcgPgi
         tDSiyXyAUY9f2nmzYGHxbclX6oatjvw3xUcWfMuZIKUYfL9OK9tc7x1yCixHoANuOJwk
         OOnu5Ocg7gDfnFZqS3hxvOzjNZXF7e63bCg6OXZ9lj4YzFCEtKOsO00eArQ+JCvJCQ8+
         Kiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWXcY6gAbmfVg7KCDcfT+9csscwbs+7BfaV1oEKjQLY=;
        b=eZsJi14/2H2otBudJNyLRfSvCk3EuObRSpUCDW+u6Uve58jrlbcJgldaQFJUxhY+j9
         B/63LO/gRY8ko0i6mDnZqotUoDk/asr2p+N7QoqIbjXWk2rXmTQE8rCt1J4BgtZTrEmC
         m85bIvwU0Zm5s/2TSHwvach1M3IpwGy2SlGPmH/ErugCu1/EEfrs6cWzv3Cn05KQUnyS
         fIOEprLarjFQS9tFst1KwsS1eu99ym3CyQjI7UdTqI+9MYVPmNMD69ZDfFFC3lUtNoVn
         4Bf/4q7puGLNV2lS6ioo7PJepN31FEREoEI1oXy5Z0vhRh3A0d6QlJ3rvINJYzKwELbJ
         +gKA==
X-Gm-Message-State: ANoB5pmj1d/UI7OQaPz2yGY/vMgwv8bpBhlESXA6aq97HFxzgXwjxv+y
        Rb7OCKOpxJNkehpLAVKaD+B78w6Bqbg=
X-Google-Smtp-Source: AA0mqf45FHwhwNtnUnFgiV+k5kQyT4jAzp/ERn/3kdow2kHMAFgQ4h9Qt9fm59Ex7ZHRAIoVTlRevg==
X-Received: by 2002:a17:906:5583:b0:78d:b3ef:656c with SMTP id y3-20020a170906558300b0078db3ef656cmr28618024ejp.627.1669663680201;
        Mon, 28 Nov 2022 11:28:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b007bda90a0c99sm3431552eju.58.2022.11.28.11.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:27:59 -0800 (PST)
Message-ID: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
Date:   Mon, 28 Nov 2022 21:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/3] wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h
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
