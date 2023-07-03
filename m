Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805F7461A6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGCR6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCR6D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 13:58:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D7AE66
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 10:58:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so7714207e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jul 2023 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407080; x=1690999080;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=AdNPeAd/j5HKXhj2QJOlsZ5nLrBZR/NfGRhv/kRiuXFFU/qNZTkuWxYU2XP0JXZdI4
         GmJJ06UPc5d4vy94A2m3PiClxllD9UCMFflnRwij87bgeW5bDgbKvZzqt9drkpzcDEov
         eQ1Z9g+X5UCo2AEBPAk6x61D8LJtOMYbOyTVwvV6roS6qwoOzQVVOc6RGg801X8u+k2z
         nx9MLfp4bOsguIA/YzObNGR2gb+GMw4CPkRwcj1rA/mGUQ46Ua4amCG80l2LB/eevI0f
         qfBIABSuHGPxFWtf8WoWHlcWTsnRtFxNX1qdzxJ+FOBKT6tUFF3cCHGtlh9VjoxKAswD
         j/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407080; x=1690999080;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=AHFIjSXb77D8DewSG9G/NB0g2cCBmsSwO3wVKPG19Vi2IG/jEAxIsl5y/6VpQwyUMv
         s3skMY6v5imDn0NAPakZRlGuWkd/cGRfYD3zBc5ITgz/GBtdHCsjeGcVwdt+YS32ESDT
         xFnJqdmASi8RlrJk2TDFZo0M0GCrPOKG/br4YuhFjs1trpn0R8q48tM8ZPYIsWnEYThB
         uo5je5PaQg6LIeBe1vSYqwxNXD5uG+c+ouBO1RpnHb82LY7ykSNOgR4GqEX638PI17bK
         iPAqETdA1QggkCTKTLTVPxnTOhSsdyk4wPQn3FxewCHnpDp4zbBGhdo9EmjrsvlxnSRw
         LHbQ==
X-Gm-Message-State: ABy/qLa4AT7yxRwppCZ9rHdvLviVXGKq+Zl/4jMwPxA6bswiLO0mxXXl
        qVANzToqLHmsIU6SwVAvLAwKmqs+9SC7ErPg578=
X-Google-Smtp-Source: APBJJlFua2loJ0u7Q7q6dFel8+hFDbwLBHidHNLCPJxQWlub+iI3K9ThGJjNLye6MUFgn5XNOacEXqfDXzvkzU8DLLI=
X-Received: by 2002:a05:6512:2007:b0:4f7:604f:f4c8 with SMTP id
 a7-20020a056512200700b004f7604ff4c8mr6936363lfb.18.1688407079902; Mon, 03 Jul
 2023 10:57:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7f06:0:b0:224:152:2993 with HTTP; Mon, 3 Jul 2023
 10:57:59 -0700 (PDT)
Reply-To: elenatudorie987@gmail.com
From:   Elena Tudorie <mrsahemdamal1@gmail.com>
Date:   Mon, 3 Jul 2023 17:57:59 +0000
Message-ID: <CAOCz6JWTre6EAD01J1rCDohPgy8NHb6etkV6+NjZtq6OW9gDyw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

I am Ms Elena Tudorie, I have a important  business  to discuss with you,
Thanks for your time and  Attention.
Regards.
Mrs.Elena Tudorie
