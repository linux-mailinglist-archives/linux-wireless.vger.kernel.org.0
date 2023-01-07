Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35890660C27
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jan 2023 04:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAGD0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 22:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGD0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 22:26:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B047CBCD
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 19:26:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x37so3375214ljq.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jan 2023 19:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0idPdI9PLBO31vvvrO3UzhchqV8JfFMP/B9EpQ94X4=;
        b=BKsop5Fd9j2waYE+QYe/MTG3xCNzpLA6GxQEImRq55evqkhdueP2mrjpwGEzY1jfd3
         Tcl5rMEeCyTXzbi8UnuxJVqxfJPaQbA5BMRtCWAz3JsnRGxsmlnjuuXZ6w9Dl0+ALMpe
         mJUMzLq44QRNnkRDNn+aZhUrYeRhELduAaoZ/YzQIFyK2hfBeScbF//Vq3oQjZqPnmIT
         2VQqyVnedryEwLGUpY74+VMr3njxAF5oUBsEV2qUndYJRI3kFxFf6+H6pEpXiEJMI5zS
         IJvVeJHBHb0zXGeFgzkxTg5r+9+DY3VklP5opNc+oE3N1ORZeHfBFJlQW1s1AuGmeOju
         gbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0idPdI9PLBO31vvvrO3UzhchqV8JfFMP/B9EpQ94X4=;
        b=uqlFI2M3aWfrhJYCqTP/9LaCI6Uv9vGWq3h8KDEEqRCK74N0yyOCKhEcHqq9tK+cdw
         IHvhTuK9JSxQ+n5nrFW9x1uz1QBnFXG9X6Nh33tDP9DzzzbFP7L21U815DIeo9HtL3AM
         cTwOoJWqEin+filbSNWswJ81x5bH6HKWdxex8GLhvbM2RFsrKi1B5uRKzcUk0Xvmg4iF
         K/yjecGjELzxKWFtk9TO5okcnR7JC/1bZnNRd+joCWKyx7zmRb8nhX4278yBqqFDOds1
         r77jgSMzHEqdujjbattncBb27ngmkz6v43n6pR4xRz95jUCCFWUx7zowDkugkAUZOzUq
         FOLw==
X-Gm-Message-State: AFqh2kpg9TvguIh2aMJ21hVYkHZ8CxUtEIpaSvJNrLQNRP6EfiklObA0
        1J3ggAK+LzSKB3cCzTgVHuCRMV2FGveVDh1tWBQZS/FZLGsyi198puI=
X-Google-Smtp-Source: AMrXdXutk6clWXUDfMElnW4XLfAdGcJI+7wAA9hVnfB2R3IOMtOjMP2Z70lw4idmWeRdOFhwILjdf6nTaEeNE2ChIXU=
X-Received: by 2002:a05:651c:141:b0:27f:b76d:4933 with SMTP id
 c1-20020a05651c014100b0027fb76d4933mr2095750ljd.220.1673061967922; Fri, 06
 Jan 2023 19:26:07 -0800 (PST)
MIME-Version: 1.0
References: <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com> <a223d9ba-2b80-6b6d-dcad-2ca2b170b393@i2se.com>
In-Reply-To: <a223d9ba-2b80-6b6d-dcad-2ca2b170b393@i2se.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 7 Jan 2023 03:25:56 +0000
Message-ID: <CALeDE9Mzhogxm-05k9gk7htTSkOmfyk+N0-AAwVKs2yPOmyYoQ@mail.gmail.com>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
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

Hi Stefan,

> > could you please provide a "bad case" file list of all firmware files
> > for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can
> > reproduce it?
> >
> > Also OpenSuSE seems to be affected [1].
>
> Ivan send out a fix, which should also work for Fedora [2].

Yes, he cc:ed me, thanks for heads up, I tested and confirmed it fixed
the issue.

Peter
