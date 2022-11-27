Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0972639BCB
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Nov 2022 17:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK0Qig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Nov 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK0Qif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Nov 2022 11:38:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ADD64CF
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 08:38:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn5so10619106ljb.2
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R0ztbnlEqsovxLoYASQwi8PpP7MOv63WaNyedox2/S8=;
        b=EtHKkX7HJCLqukbsC/UR/VnDrhrJlyUhw1jS9Pj7QTp5dWQlc769kf8XbIr3WBiO07
         T6Vp+IRVauSSNwpKXnDtPUJ6NKm4BPwnFvo38zbEUFhhjc6NKlptNA8Z2QUqyFlk+3Um
         ZFXhVnzAIA4IUswbe4RNzUkYPoFaBmpWDN9myoE+5f2hbhawaNgimLwP16oHUfHJNHJ8
         Thp+pOf3of1Qub50OoaUvmaArVH8qCVGBrvF9gr40FuJOtQlx4L4UWlNnDPx6eMaIJdi
         Pt058ssXgkW508oxF3gYl40119LB5DYf7hJ85IkvUygtrHi9582bkJGqfm3Z5Dq5mfkR
         KFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0ztbnlEqsovxLoYASQwi8PpP7MOv63WaNyedox2/S8=;
        b=azb9K56Ey4UxqDnp+C4QsW/TmEwGlygE1hxmspzyFGzwQOekC9ILQ9fJZ1CLHVuXxU
         OQ5ZnEvnCW3jQUag6cKKaHbovjDJYdn/Agbo76rRCpKDeNIH6ywHt3sDULHGOAakz2wQ
         +R/tyQPTtjpOMYaUc2NqZVCUvWQXSFnn7801cnQkeCR0z+CCoXB9lDZHgXsg2/a3BUlq
         Wq25WChkqSxxt4IqnIzOhizYaA2Ap3KYV0VaqdcD8S3Fo8bh06b8DQ94cfgXPiLGzIWk
         ej0YlIb+no70fuOPfFCcbNXWqGkJ3bTN9Fa9VYIo0Mr0duViuA2Im2TB1t7fv2A/QFIZ
         aIZg==
X-Gm-Message-State: ANoB5pmUUSdBeq7GXGyDe7t9qJjMAmc01UuzQjs6ZyrIKXptQHnVqdh8
        Gbc1KoCJYmKY0rZyVTfPJz5wnVVshX/tuM+7cyt219Q2Lic=
X-Google-Smtp-Source: AA0mqf4NbFeTlovzVOyjya2LYoozyozZkpsEQfJu075xLWqKbaMoq3cQDvmySztSRH+bQX38clpUBMpaxlz8mBjKe6c=
X-Received: by 2002:a2e:97d7:0:b0:278:f437:9c43 with SMTP id
 m23-20020a2e97d7000000b00278f4379c43mr14132860ljj.342.1669567112818; Sun, 27
 Nov 2022 08:38:32 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Sun, 27 Nov 2022 20:38:22 +0200
Message-ID: <CADUzMVbatt5T41VW2WJr6PzXU3Y5Pyp1YvwPqW2QWitWRRQgzQ@mail.gmail.com>
Subject: Re: PRO/Wireless 4965 Intel WPA2,3 SSID connection problem #1
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

Hello Stanislaw,

Thank you for looking into this!

I will try to test it today though I am facing some issues with my
custom 6.0 kernel at Debian 11 last days as it works on my 64bit
compiling PC but it freezes at my 64bit test PC having PCI as soon as
I log into it without leaving any traces while with 5.10 it works
smoothly. Made lots of changes to my custom kernel without finding the
root cause so I switched to MX Linux. I will stick to 6.0 and if it
continues to make problems I will use 5.10 at MX or 5.19 at Ubuntu. As
soon as I have a working kernel, I will reply back here with the
results.

Take care.
