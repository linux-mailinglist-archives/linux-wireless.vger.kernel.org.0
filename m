Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C467DF471
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 15:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjKBOAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjKBOAe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 10:00:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37783
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 07:00:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso895974a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Nov 2023 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933628; x=1699538428; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=i9Pt7t1cqSPlpRkofH00hs1bjhfmNzTFIQsm6ZPZwAloLTa24E/QSYz6qurEX+UgTV
         KCHVnUzJXr0AtfEx3McwESTmisCqsNGCfyINndTRUaubh64P6Vl+U72qk3Z+4qAwTb66
         kJE7w+x9SAueRGgrr20AQAYojK6dEQd8acfsuilhjrX/8WJm3WyNLZa3jR4YETSX91vp
         Cs5m6z5WjnjWxjlXAawAYmRaxXAJdfl8jon2z2emnoYpzcQKXpyNzq2gWugWhBNmK3DW
         qeuMnoOvx3/XkTZBYEPT0wj7ImL8mf1BWFQ8Ef89Yh8JWOvPfpHpxYwZDNi09GVkTqgt
         akaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933628; x=1699538428;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=SkXl2r0VzyMOGaXCGzj2I1uuqjtB6mk/On6+OyID4HWF5c9jOZZJvQVGKpDgwlrEZT
         PH4Ev+s6bn5Os74iO7FIR39y223g/1TGzxvYIbWYstfvHfVxIMaNtGyXvsdITT3WqZZI
         iZpo6H37JkYpBJjBpW/mvanivPqxTSaR5M1nv/gKGjjkAATjgSL5T8NkMZ1g4sBLVrk8
         G6Qd2NCTPEiFAD4JwO/IaD+aclpxy4SwE0V77hVQIb+h82iYiYjBntHQsP3uDCQaWOV3
         pUK9ECd4eI7xKL3kc9EBF42pQ4qvY6HuBzZBc2Qr/enW7Ophsx47nj3PNmlUo69HTrRr
         8B3g==
X-Gm-Message-State: AOJu0YzrOU0dlAei/1I/kTsPVivB7Q1Gd2D0C/6JLOyg9PkC3WpnpXJI
        WiAGmSGfTIWZcYIag1NacxIJx9/iBs0rFbMEwyE=
X-Google-Smtp-Source: AGHT+IEuXK1STSE08VJL3njFXiOmcw1unKGjwO0RHMLYJD+rGUd/eGEL3UW2vFmRMBz7m1PtADoTfQMhrJy2kyKciqA=
X-Received: by 2002:a17:90b:111:b0:27d:c95:b0ad with SMTP id
 p17-20020a17090b011100b0027d0c95b0admr15193196pjz.21.1698933627436; Thu, 02
 Nov 2023 07:00:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:792:b0:51a:59a:4014 with HTTP; Thu, 2 Nov 2023
 07:00:27 -0700 (PDT)
Reply-To: oj616414@gmail.com
From:   johnson pattaego <lenle.goungbiamam@gmail.com>
Date:   Thu, 2 Nov 2023 14:00:27 +0000
Message-ID: <CAL454wBXs1b8PUPjyKRXaaF0NZJ2KFiOdFyUyk7Z_70i2WyCzQ@mail.gmail.com>
Subject: =?UTF-8?B?w5xkdsO2emzDtm0sLy8v?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=C3=9Cdv=C3=B6zl=C3=B6m, van egy v=C3=A1llalkoz=C3=A1som, amelyre =C3=BAgy =
hivatkoztam r=C3=A1d, mint
neked   ugyanaz a vezet=C3=A9kn=C3=A9v, mint a n=C3=A9hai =C3=BCgyfelem, de=
 a r=C3=A9szletek az
al=C3=A1bbiak lesznek =C3=A9rtes=C3=ADtj=C3=BCk =C3=96nt, amikor meger=C5=
=91s=C3=ADti ennek az e-mailnek
a k=C3=A9zhezv=C3=A9tel=C3=A9t. =C3=9Cdv=C3=B6zlettel
