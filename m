Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4D63C01F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiK2MeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 07:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiK2MeI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 07:34:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C75B581
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 04:34:06 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g10so13244955plo.11
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=n21pVu87bZHoHO10JM5H596zi0SVYQp4Atq5NkyFQ0c45MXm7XAHoeU90Qsjf8C3SA
         R78h2FcJkKvCjxS2m51vEGEO2zjb3Psab/doN8Tge3VZa6WmVMFTHfUEmhunDCny8iAw
         2eo6wkODoritJj6+CqJsVC8g9q8hBR6tu9rGwT7hWk/zbZHYYOqVfeDfXIgYug6f74JV
         fbRfKH2/O7D0xX8QDQg43DWCmSgWT88RE5EBE+nktdJ1PdIjHIB9ait5UMCm3zLTW9Dt
         HutXag7nQJMcFB3D23loZ+PMpVWaPWxGZgqYouj9ZOssC8TtP/0vSk9g01SxbAIP8zhA
         8dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=nW66Bhv9c/L+7R+GC0gUrpCopVjveBoSfyImSLzpnH/6O/bb4UcXGtBtG7WUsglGVU
         WVgQE+VX+C/hnPob0STJXTS/iRE4AM6+vbVMjXWCwB+fRZkAPRx7HwCv64cHF+U7IHQC
         Sf8qXyTJHZGAw+aH7IRaB0fRaEaER3hxymxHr+arOQRIAMIKuBngSL0aCHPkGZ13NhvR
         UD/L8H6fqU8BgSpbIjsO/139F2PCUrb0FQPsjiR5Uu20YBsGIHgexyDvHsu4+Z3xjMQ1
         PODLms/GgkgdjKVfqqsulh0VAXM4dNoZ7dkbYZYXZpMkbAjpRrtZ/Kzf6VBYCXTUH3Sg
         4kNg==
X-Gm-Message-State: ANoB5pnP2ncuN9hEURYgmJEIz/UVoIldv7WZJf0//AAnykjpe8LkoiAn
        ADkCCnAzCtgcoCHVexV9tDGHVLb238dWNROThOg=
X-Google-Smtp-Source: AA0mqf5OvNWmj24YP/xzAJ0dH7HDiXlDefyIJzWDINV4kMWohcLZV8Z1TW9+E5MxXOOXM3lBSzrSlB5C9pdxPkkOEYE=
X-Received: by 2002:a17:902:ee89:b0:187:1a3f:d54b with SMTP id
 a9-20020a170902ee8900b001871a3fd54bmr51010053pld.9.1669725246308; Tue, 29 Nov
 2022 04:34:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:af04:b0:358:6b5e:7a6d with HTTP; Tue, 29 Nov 2022
 04:34:05 -0800 (PST)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Tue, 29 Nov 2022 12:34:05 +0000
Message-ID: <CAAnwc9sddRrGfq8JxjGyyV8XhMZm9x4gY97PxS6yXLL=ZWXj6w@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
