Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8C6AE524
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCGPoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 10:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCGPoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 10:44:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EA932CE2
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 07:44:11 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bk32so9896231oib.10
        for <linux-wireless@vger.kernel.org>; Tue, 07 Mar 2023 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678203851;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRDTZ4Sr395wV6MvkyP3WZxrhaB6RKx+XFGs1f2OOvE=;
        b=qIex87BSuqtn/pvJVYNyPLqmt4u4enOSp7JYU9RBnJmOTlVX28q0DFP7IT+wAyoLHE
         uvEK6Go/DMl6KajoeucWd7BkCITzlhRaYFS/CcwrGrm/SBoNf9l01ekGpUJgF2kUXg3s
         KzNtBEvVKXOjuBk/sHpyClqtPL2C5Bc/MD7A7We3wRmLe/2TGF8Frtl+jke+wJH2c/EJ
         L04xj94wnPKQ/8ml+OQsBPkJpH2I+ZNxDvOg4xA0pu0VPdnIlp2+DBCCNB9gbjZWBPV8
         kdcAZ6KUKW59On0q5mz5d/QyRvexbL3kbMbx+8Y+0Jyozh+wSVtQ8eFz0vWLrBfU/g5v
         tXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203851;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRDTZ4Sr395wV6MvkyP3WZxrhaB6RKx+XFGs1f2OOvE=;
        b=kHkagxwv06WAUvz/IW7PrOVISMIjiFu1FeAGf8aKWJbx1Zw314sVHvrnxhsEdGR38p
         B/u7Zr3624y8fL9KI9ift7pDnLyBeLCAPpkt3cV5RKKGM0uwJIWZ4WkpaXKEGqiMxnfa
         BiyU2ccRS2L5GN7c9NpfhQPTfQ1qgYi45qbkMyu1ruU9gR/mYFcdLZt/yNAO0jaHseP1
         oRGpOD4whr/czMcv2mfITcdjAMtcI6PKVMm+h0qlY/MXjN8XlojcoIechcMaKv0lgsXW
         U4pGCS1BLd9KKl8Y6MN3n4egDsxGkETv64j5KRO2D0GKey2b75xrH9CerKO1wqP+T03d
         chag==
X-Gm-Message-State: AO0yUKU6YwMfSFCJ6j2z7BGUqn+8cHeGkLU7O1ISAk13+upzKSDI8MuD
        0MhX8UcGW2Q3a7vH24pfwy3N2+Sgy+VmsVWNfSU=
X-Google-Smtp-Source: AK7set9PurHvw7W+vGBwWA0FlgsjNtrRfTb1JZgWm4//Ni1H+JhefDDe1pE6E4y6N4DBYUe1z2jwcYfrUmJwXhswALE=
X-Received: by 2002:a05:6808:2098:b0:383:f981:b1e5 with SMTP id
 s24-20020a056808209800b00383f981b1e5mr8691114oiw.5.1678203850727; Tue, 07 Mar
 2023 07:44:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:4e13:b0:105:63c3:464a with HTTP; Tue, 7 Mar 2023
 07:44:10 -0800 (PST)
From:   James Lazare <shepherdtraders@gmail.com>
Date:   Tue, 7 Mar 2023 16:44:10 +0100
Message-ID: <CAK6Z_umLN0HoOHaf=vs89HxQD5zcao05V1F9bpLj5yYBKuvf8g@mail.gmail.com>
Subject: Hello James Lazare
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I trust you are well. Can I write you here?
