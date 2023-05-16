Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A017056BB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEPTHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPTHK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 15:07:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0EF449E
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 12:07:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac826a1572so150714511fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684264027; x=1686856027;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=dXxb80cSvO6x6JLIiHihTW6+sWwuO0JvzaXVWPjxpqfMCld5Qgp10AmkqY+m63iudg
         bS+pb/gs5/iJCS+2vY+V5vH9O1i1f8xQtEF0t3aYmULIij0LIBZlC17dAyj2fFp3hqf0
         2s5WZKZKc26Aoo7I27KXIkN3Q6yXTWueVtdg6gPmDS02a1Lk988hg90fU0pnkoAvdP1S
         BmfKmrHgiK4ZYv6e1AbI8Sost82WOh0ZycO8hlQghWEHY6V/51AxFrnSXI5bvIbXp2Ct
         XwjhOhixKzR+RgQQGGsCt65CbtTgY/higOheKsWyEaMfokOTFFKjS3FHpbtTeJ4Td9js
         KKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684264027; x=1686856027;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=OcQ8nIpfJj7YVKZWhbkuyT1mToDlZVC9cE5lfxKrSByqPrh/P8yAcRScvr89DXrtOj
         ohjyOuFYTjLNNuycPJODz4iCkUGHPJCln0OvxDiqywi0gptmXIu+wqkh8ZBSWcQwtlkb
         ZTvHSEa+KX5irIRfQcswvBI3FHmBecm5uKnaOp3jy5GmaoUvbK5Ht7GR2ht77CPkOXGr
         aYpCxBYauPCxsjVaU1ddiuS8QW6B3JUnye59GiQSZY2c6JOkQMkQ+PzzfpX3naO3AoWk
         ivvHwmx3RNa2s3tqHX7v6icEl4qXdNjwvZ9I4bMEIWt6AEAvgrbqiUd8/A1+lVUiKpJS
         qeyg==
X-Gm-Message-State: AC+VfDwwUuhAogZtc+gCILpKynCfH8WQ1rmIKqz++SvGt3QZPuD5fxRk
        NAbI5XRqsFtIFJsrIvS35AEThP8BwsPi93IkJPY=
X-Google-Smtp-Source: ACHHUZ7dfukgUK8ZqKRaEcnqjvWtlekxniKj4Cgzi3qRP8cjTPrFRkuT6JNsdaKfVXFGK63pXkaKsCR2KQZfSNLNxhs=
X-Received: by 2002:a05:651c:150:b0:2ad:9c26:3638 with SMTP id
 c16-20020a05651c015000b002ad9c263638mr9627558ljd.52.1684264027073; Tue, 16
 May 2023 12:07:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:76c6:0:b0:1be:a2eb:c6d9 with HTTP; Tue, 16 May 2023
 12:07:06 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <shaharshalom507@gmail.com>
Date:   Tue, 16 May 2023 19:07:06 +0000
Message-ID: <CAJCpq9LifY0p6ohrUCLDh3L6hRr-8GZAjh6y4Pdfe-QvgoRAWA@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5rKZ5ZOI5bCU5bmz5a6JDQo=
