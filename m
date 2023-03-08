Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF26B14BB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCHWEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 17:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCHWEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 17:04:14 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B905B416
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 14:03:58 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so106434otv.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Mar 2023 14:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678313037;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=Ah1RE/vfxphaliNGIdYqSI8i+ZFTgPLq5sZ3ulEj2WgQzycy6xJszApTj2Nd4O9Nzt
         DQOpFAyKgaBgEbRcXhK8GK7DNZzR5JOn7an6Dp7F6iyYqi2giobZ1dyAw9HP5qpBCnk7
         kPhm8IM8wHqlFJNSxuap0jOvjaxMA4nW/Cfk6tVyMrcPXl19votqGsDWSRCYYjAcS7lO
         hWVXZAC2/tgC7Xr1vvOlTDPG/ficvFicIgnob93iEMjq29aIH0U5iWkKs7vfwel1r2d3
         /fhXtU0T+kQVx1uQl+cXKU2+hrCTZGdVXaj8bj+N91Bfbc46j/b1ucZh6pwZHne1xj8y
         7Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313037;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=ZtlQkgL7Sbl5wKoCHyu+A2L+O+ebHcG6dPnP39nK1ydu9YG50STgKNi0Fk++RN6p9H
         RFFhckD/kRCOaugQv71cgbH3X7QEfKFHy6EWrV2HEZvfpSlbY4YImGGs0snh3bMrmvhg
         CV0bXLhyaYS+M0V58b9fA7XHp6w31xIQt3pOy/BkPKI84IlbRqLwPcgs4XtLA+E7kMvf
         oY9O5NAU1qID0P1FPdXz3qsqYCKgVbgvxoYXgnlRCyJVRf8jSxhwpkD46iKH57kNYMSP
         1dzMCFv41ImLPTCnW62T/x0TG+mFRT+mlh1B23ykzyEyKO6S7MUBm9Fe/nwSzmzDI2E2
         f90w==
X-Gm-Message-State: AO0yUKUVoUhPa0674ZIYlxUGDBpBBULS/4YPjWzcmhTXM9VWGv1wk6Tc
        U0JHk8N7A6I8EOSZJ5Vgtmtv3E2J8m9pKu4+nPE=
X-Google-Smtp-Source: AK7set98YNXpTItxcWLLP5GTbkcLkqKDEU0f7xqQ0+p00esUe+FKEfKkTFz9IPmyG8TvPjntpny/cSgjJ+4q2n+Uzz8=
X-Received: by 2002:a9d:6115:0:b0:693:e03f:a027 with SMTP id
 i21-20020a9d6115000000b00693e03fa027mr6145611otj.0.1678313037427; Wed, 08 Mar
 2023 14:03:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6359:a94:b0:eb:271c:6ff1 with HTTP; Wed, 8 Mar 2023
 14:03:57 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <milleym513@gmail.com>
Date:   Wed, 8 Mar 2023 22:03:57 +0000
Message-ID: <CAKgnd7i9U49=WF7rJPkmZf5YJaL6-N2YBi1zfFO5jy9Chn1rZQ@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Dear Friend,

How are you today? I have an important message for you just reply to
me and I will send you more details.

Regards
Mr Thaj Xoa
