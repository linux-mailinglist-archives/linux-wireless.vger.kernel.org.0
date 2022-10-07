Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C055F7B65
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJGQ0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJGQ0n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 12:26:43 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D476C149B
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 09:26:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 81so6321396ybf.7
        for <linux-wireless@vger.kernel.org>; Fri, 07 Oct 2022 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEMvKZP7oPRPKqoB2AkJ6Cu4t4LeBzhkWi0BEPIH/Go=;
        b=Yab3tN96DIelqiQvaKDjf3v2Do8YyqOCuuQFfxe0nE/lKqfZzULkIm0WUkEjFm+WF8
         pW5i0nLrjFtrOb1DAYqxFC74HPAxi/R/L0Etktw6f/Mf/Yrqv2R0HINM85PpS/u1dDpc
         yS4pRyfUt3dXuQpHHbGLUbQvZ3WeOp/Hkl7CGoZ6ox1DwqJB24adSfayqWfIR5Knyp9M
         DROKevaV0YKTbNwR8OmrHCScuxYuRA9ZcI6U4jVggD0X0AIm8DzUG1HJOVT5k8wCa0aG
         W6bg0FElPC3cLc1Bk3RW/GP5rvbJ2Boli1XCTTHqACOamEEtmN0cL4Eqy9bj2DxWABF1
         2LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEMvKZP7oPRPKqoB2AkJ6Cu4t4LeBzhkWi0BEPIH/Go=;
        b=NMiDfAYHd81xgM6DBBiGg8hPdlaDPHix5P5nQ0wKooBM2JtMGWpY6qZe6DRB1zC4d7
         6PbtRen5jhQ4Cehfs4HASXZ0eEJTCRaQuT+rN2NalS6gd6x1fKW7JBGdASVnzfsmh1Oj
         cLzH8605Ci0Fy+QCHsuk8n+v4EmqAb0HoEuy6ezI9zG65VXUp2a5+YoayXpjokd2pCNB
         iY6bp4yaVObR2anACZ5BzcUzTVKPeaELMdBbgvpYfd7KzFb06N80YyJForvcZqsJYXaP
         oGr7P8h/Or5uXQwNfLjdtcTNG/aropxU1CfRtI67kWv6iEibEM0Oim+DM63BU+6sICCD
         Uxwg==
X-Gm-Message-State: ACrzQf1N087vbDauB2SJlPWn9mTdjGbpwUw11erLwAUXgzw6FYqixC6A
        Bkz3mNSpv6D4XPuDVATSqzZiTz7Dwwh6Wjf8iey0iaka
X-Google-Smtp-Source: AMsMyM4rx5RBiAmxMPwsr8NBmpHpGl3/GPysIAG10LbhrH08RhPDiydX1pBg4KkO+4XRJdV7GnEf6+ZATgk3Mk6ia5U=
X-Received: by 2002:a5b:2ce:0:b0:6bb:f524:5122 with SMTP id
 h14-20020a5b02ce000000b006bbf5245122mr5309305ybp.61.1665160001477; Fri, 07
 Oct 2022 09:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHgcA=uXQWbmm+C-Z+HvzRhYr+AfEOyky6ua4MZThO0+voZhtw@mail.gmail.com>
In-Reply-To: <CAHgcA=uXQWbmm+C-Z+HvzRhYr+AfEOyky6ua4MZThO0+voZhtw@mail.gmail.com>
From:   Tony Thuitai <thuitaitony@gmail.com>
Date:   Fri, 7 Oct 2022 19:26:25 +0300
Message-ID: <CAHgcA=tNu2XQmCWQJSnO241VF9Cr6AxCRY+YxVQ-10N-i2aXRg@mail.gmail.com>
Subject: RTL8723DE: System freeze on wake after suspend and Turning off
 airplane mode via keyboard button
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Repository: lwfinger's rtw88
OS: Linux Mint 21
PC: HP notebook 15 series laptop
Wireless module: RTL8723DE

The driver performs better than the inbuilt 5.15 kernel version but it
freezes my PC on wake from suspend or after turning off airplane mode
via keyboard button. During the system freeze no logging occurs. Last
item logged is immediately before the freeze. Workaround for wake
after suspend is to use the suspend script from the repository that
deactivates the driver before suspend and activates it on wake via
modprobe.
