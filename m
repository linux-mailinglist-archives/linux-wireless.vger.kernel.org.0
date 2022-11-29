Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FD63C7C0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 20:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiK2TE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiK2TEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 14:04:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E228F
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 11:04:53 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z92so10642234ede.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dto71+1AW6DPHc08fRXPWafxvoj/KBDVmSCOIv0eqEE=;
        b=Gp6KT7371ApX7OM8Bj9XYsG2xfNtUFKnZuWAFNG2ZqbyrLFF5WbKALs7jNVsnQPGG0
         uBN5m+cOFF2SBev/8V4qbSmd8svLmFZgTOCsBnCTTr7YIccUvLGviJBX23eTgGfpDNk5
         Ab6ZLJqwyVwQUnfmiQPxu3s7La0AvZRy6IOBlrIX7HAkJSH4nJ1vujxVcX4lcXAC7dDG
         /4zxWLd1pKrG37h5TErd2EJrhixeoMqOk7J9kgmXdlQui4zFnQEHUbHniV4go8djDOcS
         gXnPTZkxZGJbI+2b2dMNe4KX1VMGxjrqqPJdtXYssj0KTY72tjOnlXpkfKefeP2tqGsi
         rcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dto71+1AW6DPHc08fRXPWafxvoj/KBDVmSCOIv0eqEE=;
        b=rkdVsLEn60VPImrqazFL/tPwJgqDEc37asY0+oQ5A+rdmeDFoDQ99z2MomA6DAne0g
         Powd3sUacHW8S9k96TsW42qunbpDrA+zCaUmHdRH6GX2VMnUtzPzOt9dXYoelYVkGcXt
         OBncuCCIUU7J69bW009jLc2h/3Olm4/41fHIPwuw2wti9wDLKZAwzHUK5m6L/I7lPBkO
         7sVmsjZsf7Sb4CpteyOmWfUJCz3HR+vDvc+8k+YC8rmWUpVUq6n8nkjKeiVPK4DpI8Ej
         YdhAv05XbAjbt3g9Y/GrR2bJ4Zr8WluXS7GWjTRshAvT9gwyueCVgiESdWN76bkCKJjh
         6nlw==
X-Gm-Message-State: ANoB5pkuBlsK+gy1vujrJDbT++0Jf6126h2LhdXEC64eH8JhAU0HxGM8
        7i86ON3HqXjMrmXU2rvT3kDDu5dmnoQ=
X-Google-Smtp-Source: AA0mqf4WZx7V1saNaCJCpppto2OXcZy5IprBBJcMIDCtYEou5BpWyYmi4Pv3MTmMMzRu3F9nwvCIQg==
X-Received: by 2002:a50:fc02:0:b0:46b:7ba0:dace with SMTP id i2-20020a50fc02000000b0046b7ba0dacemr4384422edr.243.1669748691585;
        Tue, 29 Nov 2022 11:04:51 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402005300b0046b94e67b4bsm705591edu.86.2022.11.29.11.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:04:51 -0800 (PST)
Message-ID: <ba821a9d-af25-3ade-9fa8-0d3f4b58aec5@gmail.com>
Date:   Tue, 29 Nov 2022 21:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3 1/3] wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h
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
