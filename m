Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5149540035
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiFGNhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244845AbiFGNhl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 09:37:41 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F21CB0B
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 06:37:39 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a30so12435785ybj.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jun 2022 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=o4UX/WUxpHT7jP00agHzFVHFRriLTwYMvd/FoHO15e8=;
        b=nlsYxkmlvi77VUgn33Cizc+H+axD7wonKX45yESWBdTuJwFtJzDGn0kytuYWjnNBHC
         Yf0bj5WKujAYZdLg+7sTnA7vq7g2Dmb0uN/j/zcZS5THoDe2ZAbMOiRIYl6U7KPAAPhM
         XehZ7fWuof5K4AKHj89miIBzgaFmTWt3gVhMpKGfzId2H+2Atj3tl2/SRRI3a6TZgdgp
         f883ShrQl14aszsDy2eJUwjbgznv47tB4BoSV5AoqAAKFKK4PZWSlYKh+6rXFesHNJwo
         ZXLeEwdlyy2WxsWW4BTfSPzdjt2crAyTvFY04YRD0PJ4w9b/svPFXr67w1i36IEOkUAr
         Z3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=o4UX/WUxpHT7jP00agHzFVHFRriLTwYMvd/FoHO15e8=;
        b=LGGrKrgvXPPlbq+s0KEnT/U+Y+9Jq3kp3J1xoTsJXtAXn884kLtfIYXrvM8PUGMGsU
         2UryIHTOcH2WXgsEoqZK9wZhDcDJyHarvS0oyDp87veW1ErdEwz4MBWPOcEDqKHJaOix
         BLO5LlOH/sLcWrMA/vwu+/Ij43392JhgaaKF/oJviSiwRkqXIraPlzZCYYeUdQRGxrTs
         O5Q8iDPeCRLKp7B07MfD5WZAINOVl+Jmd5uiRASHsOAjmglqN/VoJ8zGaiAW48qjmyl/
         vccklvsH7fJ1uNUvpYxnt6XC76w4EPJoEaR9fkm7IXbpaYaMb83tjXlFkRCKURDoyiMe
         TRrw==
X-Gm-Message-State: AOAM533sLhyLUgyWLEULSwN/H/8Nh6nZ8Wf5xN7muUFpwFLig3TY15xN
        a1Fmjol19XkPgNEqUvjn4yx3Fx/eQGiUnTsqeF4=
X-Google-Smtp-Source: ABdhPJzUO/goV+butUJmLyVSI1KzP5L/9LHvbarByCxnBoXvsEmQ87p96Ht348U/YtPDgaTMir01K95V9ceNN9DAOyc=
X-Received: by 2002:a25:2a58:0:b0:663:66ae:e4e3 with SMTP id
 q85-20020a252a58000000b0066366aee4e3mr13917171ybq.286.1654609057791; Tue, 07
 Jun 2022 06:37:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5f20:b0:2d6:f421:6cac with HTTP; Tue, 7 Jun 2022
 06:37:37 -0700 (PDT)
Reply-To: lawrencetansanco.y@gmail.com
From:   Lawrence Tansanco <lt01102204@gmail.com>
Date:   Tue, 7 Jun 2022 13:37:37 +0000
Message-ID: <CAFdNJhg5Me=KhKY_xC8Nj9G+rkThA1hfT3WCopyJ__MUY+hW3Q@mail.gmail.com>
Subject: THANKS FOR YOUR RESPONSE AND GOD BLESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good Day,

I will like to disclose something very important to you,
get back for more details please.

Regards.
Mr Lawrence Tansanco Y.
