Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25A6552EE0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbiFUJko (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349389AbiFUJkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 05:40:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D727CFF
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 02:39:57 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id u8-20020a4ae688000000b0041b8dab7f71so2594888oot.7
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=NKhg6kSkfnglJlsPDVUWhCY3Iibudx7OhZC5CePFgeNekYJKNrcmU8wB8gkktmjPqY
         f0o4DET3nwW7oGb1WQAmWVCm6yLISrVrQXMY/9qoCppMNLX7K/jA/JZ+JMs1mNT38j+N
         qSlM2vTiSOIkQo5cZ6oY4dkMVda7fWn0vzKRT295Q67AStI8u0BTanvw38uSxo4IMvFm
         mtbeFJOQugEk6bmbrSLJZHxNWvSEoU0AT9TQz59V3jAGDZbWiI6U0Fx8UlroTYMr9wGQ
         +xC78kHT5AZK7k/f6wmWhdDj3ThC5Cy20ctCKCcYvb/idPExEpgvQXB/UX/ziCu3vO07
         Q2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=vOTJf2yZy+Pvn2AaoOzN6MXGgCjxLWSg+bAtqF3iQJ89QiMHZDEDPO6e8fGY7IPa9i
         8Vd2FuEVepGHgXV02etV3VrcH1QXgbxT51VWM/IBrTmE9V3EAqqfoWbHDYFkX4ykSOcc
         wS62/VjhzKsqIOh/zvEHw+/FWs0niaIS23yy1ROi6gC8VajaYDOjXdB3LziiYzY3BbYp
         PhH+TaVW1PSlS3BQFm57g/HzCMOErZ6I1stfL6fadqYetP5EoxkGTR7QV3n+rCvxhBSa
         UeYZA2FDvzrZEgAR5r8KXPN/Hnf6K4XlK74jAeaGTJR4any9ANW7RHWQeVGF3ETz8Kb2
         IizQ==
X-Gm-Message-State: AJIora+t2s+y+PKknsTfmIJB9d6Xzl5c74nzdvSXIoE/lmWBZE7qCcIE
        FBW2lebkHqhDPNdwv11f2higyMp3Sj0PpCb3RAamVBoD0K3C+HLQ
X-Google-Smtp-Source: AGRyM1sTF/SvvxCyraPE52znD36ZX02jNmxmam87lP8bWzXT3yTfChS1a9JgJI9LjBXh9tpS4qLO5E/t+5efudcEruY=
X-Received: by 2002:a0d:d7c7:0:b0:317:bfe8:4f2 with SMTP id
 z190-20020a0dd7c7000000b00317bfe804f2mr12417910ywd.276.1655804384555; Tue, 21
 Jun 2022 02:39:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e10a:b0:2d9:e631:94d0 with HTTP; Tue, 21 Jun 2022
 02:39:44 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <lsbthdwrds@gmail.com>
Date:   Tue, 21 Jun 2022 02:39:44 -0700
Message-ID: <CAGrL05aBO8rbFuij24J-APa+Luis69gEjhj35iv_GZfkHCVYDQ@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lsbthdwrds[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Dear,

My Name is Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining $18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
