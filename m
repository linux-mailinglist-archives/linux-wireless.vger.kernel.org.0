Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B26705427
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEPQkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjEPQjw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 12:39:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4B19C
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 09:39:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965c3f9af2aso2205489066b.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684255183; x=1686847183;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTErjYm0YU/D0XaSqiHAs0XifIDzBMEoij1eY6eHmxo=;
        b=GgEW0lp3ZwlmEvRVGAJJxxi2ib2aDMulEPdQ5yPyR8ownpLrIt1L2nycvUNIpfUzV5
         6DaewNVX/nTFtEZIS4FVconnMA7unC7QhbDNM38CGlWpvzjf+uPgnQWGo5LZRE70MCjc
         aiCUMu7hEu2FL0pQgTgqI0wVuM7FLVj8ApoJ55Rx0hiC/C0KBrw1tRB+i6d0iLa/qccM
         VH4gHxpkY9gRsOyXWelkiwm2eRKi7owPzNYx/fKfbBSj+PzhZDiJx1r7V23OFXa77q6K
         IKbV1x9z67/AmR57fD8VkCoPJBgiT1nfUJtPTaYSVQ2zVUZJUE+qqIygog12PP03BTjc
         +ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255183; x=1686847183;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTErjYm0YU/D0XaSqiHAs0XifIDzBMEoij1eY6eHmxo=;
        b=eY+RgRphOEAMLZQiZ4dIBByh3vw1QG0YVowl2V5zx/BJWJsJKuQcwUJ84hHgzgZyl1
         iw0NOZh46Ki9VuX7/BB1ys5HjQy74m82kj1/2qco3+dEjSIuhHa5fn2/rU22cmIPnK2T
         ckBIbmU7vGjEKgDWh1RiagOI7Ez3GVzkxgeXjgm3jQDh4TsuEksXN74IqyfCdSTxEPYJ
         IFy1bWiuNB0uLb4ejxorjcA2YY1G1xQx/z/E0M1E7q80FPm14NwWLnsu0wDDos+VrFq8
         9nsKNlZpboCL7Rz9aCFqM8EjSVdqd4hms74RYCZRRiUdALjABK837g1GMUjlQW3VA0bj
         jIiw==
X-Gm-Message-State: AC+VfDyTpCCcSzzkOf6fkEB7LeEuNDiDiBhgScji+zJEBhvAALfyRvBc
        ulgA+wgZgYP5w3DHdSsBQPDhR+wm3dmfaX8PBj0=
X-Google-Smtp-Source: ACHHUZ6KE3vDBkS6VW69jQzYi/F2uvTObbro3w2ez2bEorun15jGSliPu5XB8J4K8JzlssskEB0ioxmSoD4f53SylJk=
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr27195437ejc.64.1684255182708; Tue, 16
 May 2023 09:39:42 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 18:39:31 +0200
Message-ID: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
Subject: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
To:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>, tony0620emma@gmail.com,
        jernej.skrabec@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke,

as a next step I want to add support for RTW_WCPU_11N SDIO cards to
the rtw88 driver.
Currently only one RTW_WCPU_11N chip is supported: RTL8723D by the
rtw88 (PCIe and USB HCIs).

My first question is very hopefully a simple one:
It seems that RTL8723DS has two SDIO IDs: 0xd723 and 0xd724.
Do these have the same name or is there some kind of "revision" (like
rev 2, revision B, ...) internally?

My second question is more abstract:
Based on my understanding of the vendor drivers for RTL8723BS and
RTL8723DS both seem very close in terms of registers. initialization
sequence, ...
So I am hoping that it's possible to add RTL8723BS support to the rtw88 driver.
There's two main differences that I found so far:
- rtw_dump_hw_feature() doesn't work because REG_C2HEVT has an
incorrect value (C2H_HW_FEATURE_REPORT is expected but it still
contains C2H_HW_FEATURE_DUMP). It seems that this is a firmware issue.
- The whole ltecoex support (my understanding is: this is part of the
Bluetooth 4.2 spec but RTL8723BS was originally developed for the
Bluetooth 4.0 spec) seems missing in terms of all required registers.
I'm not sure if this is a hardware or firmware topic.

Have you considered adding RTW8723B support to the rtw88 driver?
Do you have some initial suggestions on what would be needed to do so
(is my list from above complete, what do do about these points, ...)?

There's a huge number of boards with RTL8723BS out there and I think
they could benefit from the rtw88 driver (and so we can finally get
rid of drivers/staging/rtl8723bs/).


Best regards,
Martin
