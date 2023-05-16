Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C357056B8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjEPTF6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPTF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 15:05:57 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF5197
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 12:05:56 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-199bcf78252so2736652fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263956; x=1686855956;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=d2I16jlzh9qod7a8cEB0SHbweLhgwoLESt1CUoYBOR17JUYYtlEqcHCP00PboNR61d
         UOZMhdwwJEVBGNi+waVKwprf+SKgzzjRq80YwPhhLpWzro0Gz2joZ82nlsyBxI9Ifg17
         pSfU2h9MbvrDMvlRuHvmqiK2cNrPGH5vrImFsDRAyYz25ftvFJF/j//MHXjXl4NKpGsE
         EudPli2IHNZhEDvsuQOMuAxfuwo9ZWmckhxiMveRyR5WehpfOLmJEEgyX5rnpnT0goLX
         AWQcoJplTcwg6M7NgSATO2P9pt2ugYSQk8RZ8l67NuY+oDHp2rJn/EA4a9E7o9QIlhB8
         Nk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263956; x=1686855956;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=EETSZqShDNHwFc87fIEpDuLktluiRM3a4m5YoYQMnx+cpTawgnRSkRnfl9fCS12QST
         CpfBlqipX1u+MbaDN91cM49ILOTf8bGfSxGGtfC7XHAj3L0PgW6I/BqIAoXx1bx9qmqT
         3U+tZut8d7i7AXxFhBHfpP2BzBwCO3GUVSCwFe73iSj763KmaWmNfSlKGLLraRZ0y/Zi
         aHbcnMu2ZUhGiDy39tkSWh227bQw/LCptCwNxnHNOnu8gZyibOwyw/QkFV96q9Ja/u2u
         vNAenqAUf9KfwNnPNTuQhRCHMwgyv95CLa5VdTt2Njfyv5LRHvK9faxkPf2xgWtvVdHl
         4+Vg==
X-Gm-Message-State: AC+VfDx1N+ODnmW1wl0e6QoWhtdRPOevpFh+Ia9Lax0xEVwP07R624ed
        kU9G7I4oO4ZIi032w05OM4MyqWzmsQK5hHAKE/E=
X-Google-Smtp-Source: ACHHUZ7M0rt3somU7rNoNoHn3k3J0ilJwlzaNc0gm4238KfxSdI8mzS3OxhrR3UT6IVQ3D3h86r0LM1F7zYGWBseOcc=
X-Received: by 2002:a05:6808:1999:b0:395:7577:1533 with SMTP id
 bj25-20020a056808199900b0039575771533mr9593138oib.37.1684263956046; Tue, 16
 May 2023 12:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6841:4da3:b0:128e:4a83:b402 with HTTP; Tue, 16 May 2023
 12:05:55 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <shalomshahar47@gmail.com>
Date:   Tue, 16 May 2023 19:05:55 +0000
Message-ID: <CADDwMLJ2taUMeQ8UN5zA4Emaps-C3EKkDZufWPA1jDC3w9FnUQ@mail.gmail.com>
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
