Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54234B3A4F
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Feb 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiBMIua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Feb 2022 03:50:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Feb 2022 03:50:29 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB215EDCD
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 00:50:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so2958441ejc.9
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 00:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=LIwi6WFEql9vBN3l2OhTAlVdibe/YxMg6BQfCavLudFZgG8fYK8+XhrJETeFXTSlkN
         MLX3Yaj5vm3rHhKA7YkqhdqIVMrc92KmBCgg1Vhj/VaMeuD8Jw2+8L2aK5fUPkx+Px6r
         tk9GGUwnZkRL60l/BJ23FGahd+ZyrTd+FB4IbdonYrDGy+3ySZ9zSRNBxB8Yl+0qprve
         gyiCifMe4wcRkzaVSNDamD3ymm+mQq3f3CBUTQz2vAoKjNePLS7EtTrjuFTDTaeyiovX
         y4NIR1xeIq2XJVSX2la0ghGdM9ogamZBgKXeK+5DRs2966Lchr17KzZaOJ2z8uPwI/Ak
         w/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=eWvLeFMygCXEH9kobAbBRP8uuGA7Vr74WUwa/V0iHEAlrKY62CAiyK1U7sjGfrhjqg
         7w7xWrecsJN1jV3cWvERJLY/vj4AzPCwZB1A4EZnM3m6/WrUSzXCDkhPHPoJHFkkAXPx
         vc7AkDIMpiLMwsEmmhwa1z6A7Yg63ToTBofaTLcVg3M1rijikj2WWTjUS7LQ2Bt1+S1O
         EahM1Ya56LkggM52ZFCGXuyRuKf4EVkbDCCtBthaTziRLkil3z3py8iDR0FROqC917a9
         Cpk++krA1W856rmQah1I8RaIcC1z+pTeFQ4b3OgmzM1xQtBT4+3WuL1jW6M9RElkfhdm
         BxoQ==
X-Gm-Message-State: AOAM531i+CqGFozwIPWtVe7hV3Iaw9fSC+CE+k3dAPcT/prU1d9J5yDp
        7HSbKerclMP/XeCwVv1T8EM0KWOi12MM8LzXMEE=
X-Google-Smtp-Source: ABdhPJyqsCMY9aUJKudPBEIPtgnZdbl8IVtBkBt/SBLs/nS1KKQUZ8XfaAoLBfATjW0IRyJhzfm0KFtcEC+axE6o5og=
X-Received: by 2002:a17:906:4786:: with SMTP id cw6mr7285448ejc.69.1644742222863;
 Sun, 13 Feb 2022 00:50:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:42d4:0:0:0:0 with HTTP; Sun, 13 Feb 2022 00:50:22
 -0800 (PST)
From:   Ulrica Mica <ulricamica771@gmail.com>
Date:   Sun, 13 Feb 2022 00:50:22 -0800
Message-ID: <CAHHQOPfPUSmaJAajoMdKWxTPJ1cpivt0=N=fah7g6uJFYY+38w@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
