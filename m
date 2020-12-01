Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667782CAD23
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgLAUQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgLAUQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 15:16:33 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F3C0613CF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Dec 2020 12:15:53 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f27so2150967qtv.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=u31VnClsYjFhKHogqGu3NwIuN8MkGrZ/TDr1Bs6Vaew=;
        b=M5IDm6lGv0WdU8j9x7/sYlz4WtDNrWrKxv3pj6Gym3vCiLXM/m8G2Wu0SoVSl2AIJC
         12REpJSBLyPUuZpX5CupJkKtPnPWFXLugJ41ofAx++007V4X+5/7AsV0Gx1xjtbsoNrB
         99MaRpi9aSNuhDCFESl7fusno4DP2RMWSUeRjiOtYPp5PafSGEJdvFENvU0kQBBm59m2
         lCb80PyMz9O9vc/UZKgFcnpkkYRcYVeDquupM3w8/GZGUjc3VgveUh4C8kosLmbdHwZ2
         H11/yCqIFBJWqMUmylPxM6hJVv+LgG4gGgXiFjoq/2IxZdAumVy15h1LZUa+DKU8ePNI
         OxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=u31VnClsYjFhKHogqGu3NwIuN8MkGrZ/TDr1Bs6Vaew=;
        b=GrGtqy+ebrYkwCiJEC9DA3xC7h1jXql6R6LVb72kSaMjaAmde6AFiMRY61ecGWGw3/
         SH2LyHIp3cqvVx8vAYivsn6Mqfj1jNwyqH37+eS0JxFMWIvCxpJXi5cKxyyPeo3wwcLu
         ZXO1mq6VP3lm4jR51XpdW7MkTOpwxCNvwjENfvyiVYmJS6LOo2TkXCU6gcP8+RG4kY9t
         2DlhEX/WnfOteTJsTQ3j1YfjVLsWWX3bB1mQmfOEUURIcIt5tcDLsGPOkyXNMbNBbw2U
         ubp/WDmGwI0ZUEsox3Q73rvZwEEIIblNzHIUO3rmegSgXTPa3HqznYTQEzsYXYPQGFps
         ULdQ==
X-Gm-Message-State: AOAM53051oLq6lpSmDMLJ6g7oElZbEDbgVT7Wd5gP8JdAJ+Go/oDunZU
        QHlJuDdV2iBb2vVV+/R6bYF9J8G5yyftTw==
X-Google-Smtp-Source: ABdhPJy4jqT/VyF5C8/a7aLgvE/AncGF4RqoR2KFCPMKGr24l3WvdNb0YgAaXcKf+WP8cJaOkBoMkg==
X-Received: by 2002:ac8:7494:: with SMTP id v20mr4859378qtq.12.1606853752773;
        Tue, 01 Dec 2020 12:15:52 -0800 (PST)
Received: from [192.168.1.7] ([190.239.192.217])
        by smtp.gmail.com with ESMTPSA id g18sm694918qtv.79.2020.12.01.12.15.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:15:51 -0800 (PST)
Message-ID: <db18a90633e0c7149f25f591251df55f0f292a4a.camel@gmail.com>
Subject: RFE4 support for rtw88_8821ce
From:   Luis Ortega Pinillos <lupaorpi22@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 01 Dec 2020 15:15:49 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!
The rtw88_8821ce driver doesn't support the rfe4 variant of this wifi
chip.

[   29.951453] rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
[   30.131013] rtw_8821ce 0000:01:00.0: Firmware version 24.5.0, H2C
version 12
[   30.149773] rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
[   30.149872] rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
[   30.149873] rtw_8821ce 0000:01:00.0: failed to setup chip
information

My laptop is an Asus M509DA. 

Thanks!

Luis Ortega

