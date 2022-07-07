Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70F56AC40
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jul 2022 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiGGTxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jul 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiGGTxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jul 2022 15:53:18 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88776564DB
        for <linux-wireless@vger.kernel.org>; Thu,  7 Jul 2022 12:53:17 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-31c8bb90d09so126777987b3.8
        for <linux-wireless@vger.kernel.org>; Thu, 07 Jul 2022 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4K4mMKpXpf4R41YLhVfBwKVJzk8ioNewf9siCI5kyc8=;
        b=LMrHm3lF7sFi/nzhDadin5Lslrf2qSAchc3kiEe8dDp75oWdnnCkPxJOMOisDCmNUL
         Y+HRtje/d9Abg4TEuynUo+4WS6ziVxIMLuciGe+KeWuKPqUu8gKiglqwsJMUzF6daDY3
         y5i9UwA5fQt8L4cnRXPOTShijNDodpU3l4ZD9IxbWrsAlCJMSSJAN4eE8XhoX515Q3Do
         3xxxslTbqWYIYOGQRXIpP8ihBzYoPzhDIwrGGpGDPV7Wuu8V19sm0S8N1+shDkPSIVQw
         N21a7j5sQj/db45eO0E6JzwWsD/oo9d0U5tD9waI7yuZ/ovbJ1d+wCTD0cGw2VQTYkLG
         q48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4K4mMKpXpf4R41YLhVfBwKVJzk8ioNewf9siCI5kyc8=;
        b=T8dvQnQFoK/dkBu4QJgswzXHh4njfhmdNEWtiuQ369oSHnbPYONEWgZ7ZsAd+4SKAe
         KRapBW+vQVLvrny34+qBpqFs+5T+oXrh+ocnpBH80t/6S5uSJYsYVjw4X2poRoZDdPsW
         YpQoRbSPjJ/8lox+A23awAI+uyekeXpq6izkMDg4YY843C6Gv7uO9aP+VJMBh4QxI8GJ
         TWBk2avZaprcjeYUVqx6vxGxvNqK8tJkQA3Dc+foK7w+ByUbkOQ+nsijTixpWhqHdaGG
         9+Hibf7F2FEDCSrp/xN2P8vES0DIetS+Day9IcDEyv79MBk1BGHh5mJsfWdKM1jr8aHI
         LPrg==
X-Gm-Message-State: AJIora/53v/7qb/4Yw/Bk5bmJ+uOOi5hIzwk6XLl5gp+RpGcJgR5yaGY
        iCM24PGofJK4xMjZunpsVqSnV1NDxT6juVlDZoI=
X-Google-Smtp-Source: AGRyM1uhjJKLwa+w9mD9jJFfYrxGQlqComQx8rBmnNj3u/KUrV+1uTUeC7pfBnwSnJR6Ygnu7RvuufLbNQNuuiL/4W8=
X-Received: by 2002:a81:2301:0:b0:31b:f327:88c0 with SMTP id
 j1-20020a812301000000b0031bf32788c0mr55359984ywj.338.1657223596406; Thu, 07
 Jul 2022 12:53:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:24f7:0:0:0:0 with HTTP; Thu, 7 Jul 2022 12:53:15
 -0700 (PDT)
Reply-To: pstefanopessina80@gmail.com
From:   STEFANO PESSINA <alexmwangi0726112807@gmail.com>
Date:   Thu, 7 Jul 2022 22:53:15 +0300
Message-ID: <CAPRJAyEPv1ADuAtMymYUyoa3pSdCqiZ9PKhxA1GXKUJLPPL0rg@mail.gmail.com>
Subject: =?UTF-8?Q?Herzliche_Gl=C3=BCckw=C3=BCnsche=21?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Herzliche Gl=C3=BCckw=C3=BCnsche!
Die Summe von 1.500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespen=
det.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
pstefanopessina80@gmail.com
