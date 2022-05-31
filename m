Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2F5391D7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbiEaNet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEaNer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 09:34:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111B8FD79
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 06:34:46 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h9-20020a056830400900b0060b03bfe792so9548442ots.12
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mrjOKAEJaGi6hhGNFjyX/K+VD/lkGSXsRcNXAtgz0yc=;
        b=Bs/h1seuPa6kpltd/9lxC5ficlPDk4I1oMz2DUhJ5E36zxrWyHDwVByvZzpcv6at/C
         W1W8PTGVRjNSp5laVeb5bD8xh/tnBrCpd5tue5ixgxU1OgRtU3wd80TgMmHA3E/T15aS
         2wfRoVB2M2PnueCDwseTP422Wib8NCeTNrwHjIk/TTVjGyikpp9OGs226SGwsLwkW4XB
         egfch2JDM664g0xVs4v6PanSJzDpvvrtuxq+9N55HfiCkwgK1d1b0xeKrswtGUJouyGj
         SmHN+i11+ILjzIFPAOeSOtzYujS3cxbvN54jQv8cfuXIu69hiqUeFeLp2hoRcKoSkF/V
         92Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mrjOKAEJaGi6hhGNFjyX/K+VD/lkGSXsRcNXAtgz0yc=;
        b=K/uLHmlkrYg80+TV5WzQLFlwM7Tzs3BYH4MZ+3tVIbnz2QUpuXf6UZSo4AtIA/b4Ok
         M4BE984imwDSHaCV8migPwX2oBbITndJ8i1obG/1pHS58eAl/mKjxoYRdpF/Q/pdWAHA
         fUXeokuPnuKsQTRldiPvuF7Jf5gnc4/FQO/lUkVGi5CTXSFkKacVmOuY5OU5Ws9ruH/3
         SdJb7FsKJvCys3T35zUp25iqQ5G/o6fxpx5O61Hc8qS/GxYKTIjkSv2dFOFmcHW6TZMH
         JlqDkKJM1tkqUyOWvl98l25nJx9JLTeQx4RzddfZ5LRUD1oP1HvU7N41yfeu0+RwNpgc
         fsKw==
X-Gm-Message-State: AOAM5321WVlcszctbdEfHshnS9skD27vT4ZkQ09Z/LeTC0c6OpCt4b9d
        681bA7JqGwm7Gnhhw/GHc2KFE2hKJ4DCEp5HcCA=
X-Google-Smtp-Source: ABdhPJwOKFBwJj3CGUX505yHcYp5503YnMNTzqZPqHXlARyfDVVbcYHudB0qwsg0o2xCRc1ZPsvFhdH5lb6ORpdlejc=
X-Received: by 2002:a9d:2968:0:b0:60a:e34a:a94e with SMTP id
 d95-20020a9d2968000000b0060ae34aa94emr21632562otb.279.1654004084940; Tue, 31
 May 2022 06:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:681:0:0:0:0 with HTTP; Tue, 31 May 2022 06:34:44
 -0700 (PDT)
Reply-To: p.hanigin1@yahoo.com
From:   Pavel Hanigin <vendeur2020@gmail.com>
Date:   Tue, 31 May 2022 15:34:44 +0200
Message-ID: <CANtH5jOQC2TAvmtUoJJkKcJeNsqc25+XLxS7Z4RAy+jzSpC0bQ@mail.gmail.com>
Subject: Urgent Attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:334 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5064]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [vendeur2020[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [p.hanigin1[at]yahoo.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vendeur2020[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Your kind attention is needed.

My name is Pavel Hanigin.=C2=A0 I'm a Russian citizen , but now in a hideou=
t.

I managed to escape due to the fight between my country's army against
the=C2=A0 innocent civilians of Ukraine.

Why I am sending this message to you=C2=A0 is for you to assist me in
receiving the sum of $7.6.million dollars, which i have here with me.

Confirm your position to cooperate with me.

Best regards
Pavel Hanigin
