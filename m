Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133764898E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 21:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLIUdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 15:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIUdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 15:33:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B69E453
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 12:33:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso6157035pjh.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Dec 2022 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:to:cc:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfSkCZZTaum/zbIaddE+5uqJoL8f+1OxNZGBKyqDKR0=;
        b=VKqe7/f+FjkXH355c4ggGE5kaPaj9RVXzdyVSP7GMLE2Gl5ZL/5XphgMCzWIP3kjYs
         6ufKJxB2dgQmCfCWq9rSXgU7c9B531lWs6iKYw+nWcZspe3kudjpElI59afDcc2/Nz/o
         QvzPguhMdsvFY6ncQp7O54XFxfhn8M1Q/9BxsyPQyuxVf/JTy7430NAWnm3uv2XRqYdY
         tRsnfETSjueRer2tv0cTznuXDW81f3/DoQTvUR9b+5Ll0PXIHSSq2gpfQ2b5PQ1R7WPv
         u2JVUoMWhQdW8xPO2+W01ONLV2M1yzwPKuZHClQkqGRiZe3Xh6moc/IZsCc7N9EM+6b4
         tgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:cc:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfSkCZZTaum/zbIaddE+5uqJoL8f+1OxNZGBKyqDKR0=;
        b=a6V/z7dx/k1jXoWgA5Yk6R/CKT23gB4IBgVDVs91UOkle8X7275UiOd6zytwqguVbd
         Vztq1BoLqDGHvw3hxadAj8AsarMDsjZ4vHJkSku5TwOkib/mFG0dySBCzSWSvKPmNK6o
         LPhf37utuXVU0NvakzargXo0RAm7JRjmkgcfprAymQnruSgMTvh2n9dJn2GzQ74jz0sX
         5tVL5nQK20ZPfKmireO1jjzbDZghBqehPoRp6aGR8blMQ0stp1JjVdWlOpN/EuGglWEY
         L41vZu7gaCfQQZqtIIyGKTtz432yPhpjXXcgCpz6ZYhcBzJyY0R++WywkNb7EWi4fQr/
         qimA==
X-Gm-Message-State: ANoB5plAAF6BVeWcLbcWmWdYLCzTsnpNbIuM5dACQpbLrxsfJpzWkD7V
        csNt5yK2vwc7GCpHWbeac042NsYdQpk=
X-Google-Smtp-Source: AA0mqf6O41MDv07KApZc3iwgyHuVbODFh9dmWyvJ8MGvaoaDe9GjO3Kfiq9Dbj51AzgvkovenlT/PA==
X-Received: by 2002:a17:90a:4707:b0:213:519d:fe81 with SMTP id h7-20020a17090a470700b00213519dfe81mr7316790pjg.38.1670617998293;
        Fri, 09 Dec 2022 12:33:18 -0800 (PST)
Received: from smtpclient.apple (c-73-63-191-127.hsd1.ca.comcast.net. [73.63.191.127])
        by smtp.gmail.com with ESMTPSA id g19-20020a63fa53000000b0042988a04bfdsm1358372pgk.9.2022.12.09.12.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 12:33:17 -0800 (PST)
From:   Debbie Xu <debbiexu@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: NetLink nl80211 support on Android
Date:   Fri, 9 Dec 2022 12:33:15 -0800
References: <PH7PR21MB3236C644AB5654D166B7F8CEC11C9@PH7PR21MB3236.namprd21.prod.outlook.com>
Cc:     Debbie Xu <debbiexu@microsoft.com>
To:     linux-wireless@vger.kernel.org
Message-Id: <F2004D1B-50D6-4F0E-9162-90FEE1F766E7@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I read from Android developers website recently, it looks like that =
Google is advocating Android developers to switch to AOSP higher-level =
API instead of Netlink sockets with nl80211 commands, to access WiFi =
interface.

Does anybody know whether/when the Netlink + nl80211 support will be =
disabled on AOSP?

Thanks,
Debbie=
