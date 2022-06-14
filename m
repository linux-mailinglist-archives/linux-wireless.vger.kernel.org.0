Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9654AF80
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiFNLt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jun 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiFNLt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jun 2022 07:49:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018D340FF
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 04:49:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so11539117pjm.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=N12xQEkPKug8sQLszkT9pe0Y1kn54b97iuT1/HJsrT1Nsj4fuEabwx5aILfZZbKyEZ
         Bz55Y8qvACzGGgA8pBLeeE4tEBhcqPK1sbfgRCPUi2v02TEz9VbfqGFUXEM//CGGlHA7
         yh1zdggwKeNo4YZiRXzkPTgcEUxQ+gyL+hYAlTJleNaC5EpPsWqsIfkycYQmdb9Yi3ru
         claawgZnkTTweU7TR6tMLqOGYzav1TvMwzwjDm3yKam7wUlHQYF1M+/9i9lOAlrc5qHM
         n7b9Cf51yd4lC4nAda7tAbawvGxu3OY6l6CWzA/cmcngl5Py1wrMtURRaneCrcIM898h
         NR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=XrRYJ5dAksyBNLZUoqpsdC8MFq7gMkqGSd14T0Ui0dy3p9GPhcZdxuNj/ay/XyonKX
         W+9mOdP/7vW3c8/aRe7z5++pprsKFWCMpdcoJRVoLBcZyStR8wYytUL4FutpD69xV7NH
         FFcKIIGZnEKPgIabjsZb6eD7I0T80GGGyjNh/+hqNHMgwFuKbWoJo+XT5+yv/lMZPaTC
         evVww13GPxKZ0sCNAdjUUYuFy0AEnXErnwN7ENGxQneA/OHAxeOqbtsTw5ODXVqhUqyb
         q+D3XD7mH62Nd5iItz5F24GY8X4QBK7x31nttdWndL9/cgptdfSH6i8neatxjLuqqzzQ
         Q2Zg==
X-Gm-Message-State: AJIora+VeRwE5Os2958Qyt8xreKXEvzoA0UvJj7bRXOVfFACRyEfoK9U
        eowV1hJ+yCI3lGPR3fTN7YY1xMazBbdBP4owd48=
X-Google-Smtp-Source: AGRyM1sM5usxaxrbwnitlUlNzrGDgShiUQqcackmSVf+oyR4WiXFwJB8Wqk5RyDnpYP6RAl0EkA9SppHugPD0r+zBfg=
X-Received: by 2002:a17:90a:de90:b0:1ea:7efe:e59a with SMTP id
 n16-20020a17090ade9000b001ea7efee59amr4112439pjv.115.1655207367168; Tue, 14
 Jun 2022 04:49:27 -0700 (PDT)
MIME-Version: 1.0
Sender: mohammeddrashok@gmail.com
Received: by 2002:a05:6a10:a488:0:0:0:0 with HTTP; Tue, 14 Jun 2022 04:49:26
 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Tue, 14 Jun 2022 12:49:26 +0100
X-Google-Sender-Auth: pudemO6rRqcdPHXJUdzBBUFfEE0
Message-ID: <CAL=ghb45jDVDhcPO5=YGEy4Ax8jXrFGYKWnPqjjVgfZymLEtwQ@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.5 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FORM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a business proposal to the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
