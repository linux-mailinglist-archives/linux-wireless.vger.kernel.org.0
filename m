Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9452FE6B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiEUQtc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiEUQtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 12:49:31 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D72494E
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 09:49:30 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id m188so2216781vsm.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ShtchRrJNjtZtD5SrNU/NQz9xYwc0XGpbnsJa5LG4yI=;
        b=pEBQs+gKbuFxeegpZsNvmiaxDUP7ZYfk7EOVMWGptmSJPj3hEJ9E29SaaJow3eH/KP
         oCKEowe77tIKeR+8CY0VNtPho1839ReyPM0z9SDOYxg6bvFa43plOn71Dl6OjlMoAS5W
         /yXxkzVOD4CtjZTrzIq1Z8NdpKSm44ECr16vYrG1Uih9iWWR6xY5lYDTok1hOjivsUwG
         yTLNT/NA26Qron5uJVhZmoR95LPVKHWEc9RmugJq6GlgwqF/CgelXKKiSgavDazmMhXz
         iYXwDULRf3dBfQ6sIkY35iJFCga9gq/0lQ7ryLIrFTjH4HRwNnjg03ho5T7eQbxrJy/J
         RErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ShtchRrJNjtZtD5SrNU/NQz9xYwc0XGpbnsJa5LG4yI=;
        b=7mOoKCBQmKaNw0CyEUnCqNM/GvpMHNaMnZhJ0/71nXyu0p8ybMsN84PYe+1r/8DbiL
         ZdZ6ClkSEx0K4i2DWtiEhYRJo2CX7LARVhgFm+89GxgE3ciE+oTTd7nntQ2RV7zF2hhk
         dx/7zIS/hXi/eo0byZUQhGzUQ6ffU/JWGuTdsxYyaWYQH8yoN+3PK2P6AR4XQ/7heOqu
         mP3FfDs1iOeIPtgOO8pMIr4xs35Q6ThRcDmhdKICQV8GUMCAokBvYfg4fH0e23NtVV2l
         kQ+SQkYzyOE7qWul5Bj4zhQmHkVjTPGMPd6vQIrTSX4el2Xqw6lJDG4wsYMEEocl7L3X
         5gOA==
X-Gm-Message-State: AOAM53154GhQAryCKAZ9IgjiCjFGd/Af4o9t646sZL1fc+IeXLvyDW4R
        F85j14x7rdFpXtFuErPQQaxkZfHzcSDCWOWJHUw=
X-Google-Smtp-Source: ABdhPJyBOvziq8ggG/ls4ZSK069DZCiJHrr96fQs6fX/7FQIsTWBgPyazUnK3TrCfF8M/ANc+CgMnBogPThgwrykTmU=
X-Received: by 2002:a05:6102:3d83:b0:333:c606:30e6 with SMTP id
 h3-20020a0561023d8300b00333c60630e6mr6435557vsv.23.1653151770002; Sat, 21 May
 2022 09:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bb52:0:b0:2ab:8088:8447 with HTTP; Sat, 21 May 2022
 09:49:29 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <barristermusa32@gmail.com>
Date:   Sat, 21 May 2022 16:49:29 +0000
Message-ID: <CA+gLmc9fVKx2_NpzBx=YwR+GAaO3BZNr+LhgSSQYRvh2P0bZYg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

2YXYsdit2KjZi9inINiMINmK2LHYrNmJINin2YTYudmE2YUg2KPZhiDZh9iw2Kcg2KfZhNio2LHZ
itivINin2YTYpdmE2YPYqtix2YjZhtmKINin2YTYsNmKINmI2LXZhCDYpdmE2Ykg2LXZhtiv2YjZ
giDYp9mE2KjYsdmK2K8NCtin2YTYrtin2LUg2KjZgyDZhNmK2LMg2K7Yt9ijINmI2YTZg9mG2Ycg
2KrZhSDYqtmI2KzZitmH2Ycg2KXZhNmK2YMg2LnZhNmJINmI2KzZhyDYp9mE2KrYrdiv2YrYryDZ
hNmE2YbYuNixINmB2YrZhy4g2YTYr9mKDQrYudix2LYg2KjZhdio2YTYuiAoNy41MDAuMDAwLjAw
INiv2YjZhNin2LEpINiq2LHZg9mHINmF2YjZg9mE2Yog2KfZhNix2KfYrdmEINin2YTZhdmH2YbY
r9izINmD2KfYsdmE2YjYsyDYjCDYp9mE2LDZig0K2LnYp9i0INmI2LnZhdmEINmH2YbYpyDZgdmK
ICjZhNmI2YXZiiDYqtmI2LrZiCkg2YLYqNmEINmI2YHYp9iq2Ycg2KfZhNmF2KPYs9in2YjZitip
INmB2Yog2K3Yp9iv2Ksg2YXZhdmK2Kog2YXYuSDYudin2KbZhNiq2YcNCtiMINij2KrYtdmEINio
2YMg2YPYo9mC2LHYqCDYo9mC2LHYqNin2KEg2YTZgCDYrdiq2Ykg2KrYqtmF2YPZhiDZhdmGINin
2LPYqtmE2KfZhSDYp9mE2KPZhdmI2KfZhCDYudmG2K8g2KfZhNmF2LfYp9mE2KjYp9iqLg0K2LnZ
hNmJINin2LPYqtis2KfYqNiq2YMg2KfZhNiz2LHZiti52Kkg2LPYo9io2YTYutmDINio2KPZhtmF
2KfYtw0K2KrZhtmB2YrYsCDZh9iw2Kcg2KfZhNi52YfYry4g2Iwg2KfYqti12YQg2KjZiiDYudmE
2Ykg2YfYsNmHINin2YTYsdiz2KfYptmEINin2YTYpdmE2YPYqtix2YjZhtmK2KkNCihvcmxhbmRv
bW9yaXM1NkBnbWFpbC5jb20pDQo=
