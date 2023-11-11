Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCECF7E8D2F
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjKKW5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 17:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKW5Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 17:57:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEEA258E
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 14:57:12 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so28898601fa.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 14:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699743429; x=1700348229; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0icd5zAfPzGgksozPWU6ePULbtwxgyVyy/rXlxEJKV0=;
        b=SaR6gZD7iEtACtdQg0HdpRIurHqQLpx/STdOvAWeuLBCSsVmI7yP36Lod4Uq4/a9DE
         yM4u6+U6tmktOacMn5FeBpM+2cqOnnl9N682kMrW6ZZ8fha9ucklRAaVGynHGzONEXBq
         1W/b5BR3iPA/QeA02YoYMwvBNtuR7xjO0skVrMEVFQEMkxraJDIVkvyvvYRJYJ59kWXw
         HrWfnCc4rzxVnao8cUzCMMzX/PCrdbn8R/xTLrW9Yum4+AyoWdJpkDBTdNv3/4BTrP5X
         dnH9VzAxkf3uAwK8A8QzoxxYRWEhn7gR/0+jt8wYPYacsiUwwHuqhvcfjwh0Ft1xvfry
         /0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699743429; x=1700348229;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0icd5zAfPzGgksozPWU6ePULbtwxgyVyy/rXlxEJKV0=;
        b=medk9od80oev3it9Xj3r7nzymeStKps+96SinmHsCzoNaK2uiDGBPl3WWPSrHooN3l
         YodjuDfXbqqvUtHAp8rwkaMOuN2E2g6k4V6BtBkAG919lmALer6fix4lTz+7Aonoylbs
         uSnM7I7sPRXIYZKN14TguqXEJ9QyezXTpy8nuWH6vJgLAy0f8dYt7Z/WT7n5UApI0D0K
         m2JiLZBEClrdTw8T9EA6URx9j0SdtHDa8Gc81o6sFnX8k3dSXCJ78yLVK/BikhAZ7Mqu
         vZ6zuGuzC+wZyxyz8gFHfa1oogOlUbnbQE8rpqYL8lI7q9OdBbxBAIVUDp3sJw+/GZxt
         T6Yg==
X-Gm-Message-State: AOJu0Yz1N+5asBH7E1LBkIOBehumszrqudCikBnhzWgZbOQ623H6LsyS
        oJ2kf9Np+EVw5fUTgeCZ4p3aRKYfNGcF84WcXt9p3esQ2CI=
X-Google-Smtp-Source: AGHT+IFTUyYy4kJigL/FDCCjMXgpS21f31NIeQUcuR1wQvwrnyKaeEHHEY38gnBPS/eWMxR+/2unlgvcaTMB1H0hISQ=
X-Received: by 2002:a2e:5c41:0:b0:2c0:20c4:925a with SMTP id
 q62-20020a2e5c41000000b002c020c4925amr1642372ljb.26.1699743428781; Sat, 11
 Nov 2023 14:57:08 -0800 (PST)
MIME-Version: 1.0
From:   James Dutton <james.dutton@gmail.com>
Date:   Sat, 11 Nov 2023 22:56:32 +0000
Message-ID: <CAAMvbhHaN5tAEZJvWhjTrhLMkw1hsxB2MdfcdQ27t+VK=mca=Q@mail.gmail.com>
Subject: Problems: Mediatek MT7531AE
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a problem with the MT7531AE losing/dropping ARP packets in a
wifi access point.
Can anyone point me to the datasheet/manual on the MT7531AE  so that I
can understand the chip better and therefore track down and fix the
bug.
The chip is in multiple different wifi access points, but as an example:
https://wikidevi.wi-cat.ru/Xiaomi_Mi_Router_Redmi_AX6E_(AX6000)

Kind Regards

James
